//
//  SearchPresenter.swift
//  IDNPreTest
//
//  Created by Bryan Khufa on 28/11/22.
//  
//

import Foundation
import RxSwift
import RxRelay

class SearchPresenter: ViewToPresenterSearchProtocol {

    // MARK: Properties
    var view: PresenterToViewSearchProtocol?
    var interactor: PresenterToInteractorSearchProtocol?
    var router: PresenterToRouterSearchProtocol?
    
    var movieData: Observable<[Movie]> {
        _movieData.asObservable()
    }
    
    private let disposeBag = DisposeBag()
    private let _movieData: BehaviorRelay<[Movie]> = .init(value: [])
    private let _searchQuery: PublishRelay<String> = .init()
    
    init() {
        _searchQuery
            .distinctUntilChanged()
            .throttle(.milliseconds(500), scheduler: MainScheduler.asyncInstance)
            .subscribe { [weak self] query in
                self?.interactor?.fetchSearch(query)
            }
            .disposed(by: disposeBag)
    }
    
    func setSearchQuery(query: String) {
        _searchQuery.accept(query)
    }
}

extension SearchPresenter: InteractorToPresenterSearchProtocol {
    
    func setSearchResult(data: SearchResult) {
        _movieData.accept(data.movies)
    }
}
