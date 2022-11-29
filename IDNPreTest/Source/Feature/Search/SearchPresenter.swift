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

final class SearchPresenter: ViewToPresenterSearchProtocol {

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
    
    private let _searchQuery: BehaviorRelay<String> = .init(value: "")
    private let _searchResult: BehaviorRelay<SearchResult> = .init(value: SearchResult(movies: [], totalResults: "0"))
    private let disposeBag = DisposeBag()
    private var currentPage: Int = 1
    
    init() {
        subscribeToSearchQuery()
    }
    
    func setSearchQuery(query: String) {
        _searchQuery.accept(query)
    }
    
    func displayMoreMovie(displayIndex: Int) {
        if displayIndex == _searchResult.value.movies.count - 2 {
            interactor?.fetchSearch(_searchQuery.value, page: currentPage)
            currentPage += 1
        }
    }
    
    private func subscribeToSearchQuery() {
        _searchQuery
            .distinctUntilChanged()
            .skip(1)
            .throttle(.milliseconds(500), scheduler: MainScheduler.asyncInstance)
            .subscribe { [weak self] query in
                self?.interactor?.fetchSearch(query, page: 1)
            }
            .disposed(by: disposeBag)
    }
}

extension SearchPresenter: InteractorToPresenterSearchProtocol {
    
    func setSearchResult(data: SearchResult) {
        _searchResult.accept(data)
    }
    
    func appendSearchResult(data: SearchResult) {
        let appendedMovies = _searchResult.value.movies + data.movies
        let searchResult = SearchResult(movies: appendedMovies, totalResults: _searchResult.value.totalResults)
        _searchResult.accept(searchResult)
    }
}
