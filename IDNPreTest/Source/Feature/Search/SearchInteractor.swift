//
//  SearchInteractor.swift
//  IDNPreTest
//
//  Created by Bryan Khufa on 28/11/22.
//  
//

import Foundation
import RxSwift

class SearchInteractor: PresenterToInteractorSearchProtocol {
    
    // MARK: Properties
    var presenter: InteractorToPresenterSearchProtocol?
    var service: NetworkService
    
    let disposeBag = DisposeBag()
    
    init(service: NetworkService) {
        self.service = service
    }
    
    func fetchSearch(_ query: String) {
        if query.trimmingCharacters(in: .whitespaces).isEmpty {
            return
        }
        let usecase = SearchUseCase(query: query, page: 1)
        service.request(usecase)
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .subscribe(onNext: { [weak self] response in
                print("lala response")
                self?.presenter?.setSearchResult(data: response)
            }, onError: { error in
                print("lala error", error)
            })
            .disposed(by: disposeBag)
        
    }
}
