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
                if page == 1 {
                    self?.presenter?.setSearchResult(data: response)
                    return
                }
                self?.presenter?.appendSearchResult(data: response)
            }, onError: { error in
                print("lala error", error)
            })
            .disposed(by: disposeBag)
        
    }
}
