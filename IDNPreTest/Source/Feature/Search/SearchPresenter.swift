//
//  SearchPresenter.swift
//  IDNPreTest
//
//  Created by Bryan Khufa on 28/11/22.
//  
//

import Foundation
import RxSwift

class SearchPresenter: ViewToPresenterSearchProtocol {

    // MARK: Properties
    var view: PresenterToViewSearchProtocol?
    var interactor: PresenterToInteractorSearchProtocol?
    var router: PresenterToRouterSearchProtocol?
    
    var movieData: Observable<[Movie]> = Observable.just([
        Movie(title: "asdf", year: "2022", imdbID: "fff", type: .movie, poster: "asdf"),
        Movie(title: "asdf", year: "2022", imdbID: "fff", type: .movie, poster: "asdf"),
        Movie(title: "asdf", year: "2022", imdbID: "fff", type: .movie, poster: "asdf"),
        Movie(title: "asdf", year: "2022", imdbID: "fff", type: .movie, poster: "asdf"),
        Movie(title: "asdf", year: "2022", imdbID: "fff", type: .movie, poster: "asdf"),
        Movie(title: "asdf", year: "2022", imdbID: "fff", type: .movie, poster: "asdf"),
        Movie(title: "asdf", year: "2022", imdbID: "fff", type: .movie, poster: "asdf"),
        Movie(title: "asdf", year: "2022", imdbID: "fff", type: .movie, poster: "asdf"),
        Movie(title: "asdf", year: "2022", imdbID: "fff", type: .movie, poster: "asdf"),
    ])
    
    init() {
        
    }
}

extension SearchPresenter: InteractorToPresenterSearchProtocol {
    
}
