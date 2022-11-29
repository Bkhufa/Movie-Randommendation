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
    
    private let _movieData: BehaviorRelay<[Movie]> = .init(value: [])
    
    func search(with query: String) {
        interactor?.fetchSearch(query)
    }
}

extension SearchPresenter: InteractorToPresenterSearchProtocol {
    
    func setSearchResult(data: SearchResult) {
        _movieData.accept(data.movies)
    }
}
