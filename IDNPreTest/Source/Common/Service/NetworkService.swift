//
//  NetworkService.swift
//  IDNPreTest
//
//  Created by Bryan Khufa on 28/11/22.
//

import Foundation

import Foundation
import RxSwift

protocol NetworkService {
    func request<U: UseCase>(_ usecase: U) -> Observable<U.Response>
}

final class URLSessionNetworkService: NetworkService {
    
    private let session: URLSession
    
    init(session: URLSession = .init(configuration: .default)){
        self.session = session
    }
    
    func request<U: UseCase>(_ usecase: U) -> Observable<U.Response> {
        return Observable.create { [weak self] observer in
            guard let self = self, let urlRequest = self.makeRequest(usecase) else {
                observer.onError(ErrorResponse.invalidEndpoint)
                return Disposables.create()
            }
            
            let task = self.session.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    return observer.onError(error)
                }
                
                guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                    return observer.onError(ErrorResponse.invalidResponse)
                }
                
                print(response.url)
                
                guard let data = data else {
                    return observer.onError(ErrorResponse.noData)
                }
                
                do {
                    let response = try usecase.map(data)
                    observer.onNext(response)
                    observer.onCompleted()
                } catch {
                    observer.onError(ErrorResponse.serializationError)
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    private func makeRequest<U: UseCase>(_ usecase: U) -> URLRequest? {
        guard var urlComponent = URLComponents(string: usecase.apiHost + usecase.endpoint) else {
            return nil
        }
        
        var queryItems: [URLQueryItem] = []
        
        usecase.queryItems.forEach {
            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
            queryItems.append(urlQueryItem)
        }
        
        urlComponent.queryItems = queryItems
        
        guard let url = urlComponent.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = usecase.method.rawValue
        urlRequest.allHTTPHeaderFields = usecase.headers
        if let token = UserDefaults.standard.value(forKey: "accessToken") as? String {
            urlRequest.addValue(token, forHTTPHeaderField: "Authorization")
        }
        return urlRequest
    }
}

