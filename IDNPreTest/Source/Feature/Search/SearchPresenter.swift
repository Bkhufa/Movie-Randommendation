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
        _searchResult.map { searchResult in
            searchResult.movies
        }
    }
    
    var resultCount: Observable<String> {
        _searchResult.map { searchResult in
            searchResult.totalResults
        }
    }
    
    private let disposeBag = DisposeBag()
    private let _searchQuery: PublishRelay<String> = .init()
    private let _searchResult: PublishRelay<SearchResult> = .init()
    
    init() {
        setupRx()
    }
    
    func setSearchQuery(query: String) {
        _searchQuery.accept(query)
    }
    
    private func setupRx() {
        _searchQuery
            .distinctUntilChanged()
            .skip(1)
            .throttle(.milliseconds(500), scheduler: MainScheduler.asyncInstance)
            .subscribe { [weak self] query in
                self?.interactor?.fetchSearch(query)
            }
            .disposed(by: disposeBag)

    }
}

extension SearchPresenter: InteractorToPresenterSearchProtocol {
    
    func setSearchResult(data: SearchResult) {
        _searchResult.accept(data)
    }
}
