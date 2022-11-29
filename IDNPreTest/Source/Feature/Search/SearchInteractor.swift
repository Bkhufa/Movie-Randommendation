//
//  SearchInteractor.swift
//  IDNPreTest
//
//  Created by Bryan Khufa on 28/11/22.
//  
//

import Foundation
import RxSwift

final class SearchInteractor: PresenterToInteractorSearchProtocol {
    
    // MARK: Properties
    var presenter: InteractorToPresenterSearchProtocol?
    var service: NetworkService
    
    let disposeBag = DisposeBag()
    
    init(service: NetworkService) {
        self.service = service
    }
    
    func fetchSearch(_ query: String, page: Int = 1) {
        if query.trimmingCharacters(in: .whitespaces).isEmpty {
            return
        }
        let usecase = SearchUseCase(query: query, page: page)
        service.request(usecase)
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .subscribe(onNext: { [weak self] response in
                self?.presenter?.fetchFailed(error: nil)
                if page == 1 {
                    self?.presenter?.setSearchResult(data: response)
                    return
                }
                self?.presenter?.appendSearchResult(data: response)
            }, onError: { [weak self] error in
                self?.presenter?.fetchFailed(error: error)
            })
            .disposed(by: disposeBag)
    }
    
    func fetchRandomWords() {
        let nounUseCase = RandomWordUseCase(pointOfSpeech: .noun)
        let verbUseCase = RandomWordUseCase(pointOfSpeech: .verb)
        let adjUseCase = RandomWordUseCase(pointOfSpeech: .adjective)
        
        service.request(nounUseCase)
            .observe(on: SerialDispatchQueueScheduler(qos: .userInitiated))
            .subscribe(onNext: { [weak self] response in
                self?.presenter?.fetchFailed(error: nil)
                self?.presenter?.appendRandomWords(wordType: .noun, word: response.first?.word)
            }, onError: { [weak self] error in
                self?.presenter?.fetchFailed(error: error)
            })
            .disposed(by: disposeBag)
        
        service.request(verbUseCase)
            .observe(on: SerialDispatchQueueScheduler(qos: .userInitiated))
            .subscribe(onNext: { [weak self] response in
                self?.presenter?.fetchFailed(error: nil)
                self?.presenter?.appendRandomWords(wordType: .verb, word: response.first?.word)
            }, onError: { [weak self] error in
                self?.presenter?.fetchFailed(error: error)
            })
            .disposed(by: disposeBag)
        
        service.request(adjUseCase)
            .observe(on: SerialDispatchQueueScheduler(qos: .userInitiated))
            .subscribe(onNext: { [weak self] response in
                self?.presenter?.fetchFailed(error: nil)
                self?.presenter?.appendRandomWords(wordType: .adjective, word: response.first?.word)
            }, onError: { [weak self] error in
                self?.presenter?.fetchFailed(error: error)
            })
            .disposed(by: disposeBag)
    }
}
