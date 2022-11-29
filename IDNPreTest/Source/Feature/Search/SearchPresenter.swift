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
        Movie(title: "asdf", year: "2022", imdbID: "fff", type: .movie, poster: "https://m.media-amazon.com/images/M/MV5BOGQyZTMzMWEtZjEyOS00NTMzLWFlYzctYjAzNzk2ZGFmNzk3XkEyXkFqcGdeQXVyMDM3MzU0Ng@@._V1_SX300.jpg"),
        Movie(title: "asdf", year: "2022", imdbID: "fff", type: .movie, poster: "https://m.media-amazon.com/images/M/MV5BOGQyZTMzMWEtZjEyOS00NTMzLWFlYzctYjAzNzk2ZGFmNzk3XkEyXkFqcGdeQXVyMDM3MzU0Ng@@._V1_SX300.jpg"),
        Movie(title: "asdf", year: "2022", imdbID: "fff", type: .movie, poster: "https://m.media-amazon.com/images/M/MV5BOGQyZTMzMWEtZjEyOS00NTMzLWFlYzctYjAzNzk2ZGFmNzk3XkEyXkFqcGdeQXVyMDM3MzU0Ng@@._V1_SX300.jpg"),
        Movie(title: "asdf", year: "2022", imdbID: "fff", type: .movie, poster: "https://m.media-amazon.com/images/M/MV5BOGQyZTMzMWEtZjEyOS00NTMzLWFlYzctYjAzNzk2ZGFmNzk3XkEyXkFqcGdeQXVyMDM3MzU0Ng@@._V1_SX300.jpg"),
        Movie(title: "asdf", year: "2022", imdbID: "fff", type: .movie, poster: "https://m.media-amazon.com/images/M/MV5BOGQyZTMzMWEtZjEyOS00NTMzLWFlYzctYjAzNzk2ZGFmNzk3XkEyXkFqcGdeQXVyMDM3MzU0Ng@@._V1_SX300.jpg"),
        Movie(title: "asdf", year: "2022", imdbID: "fff", type: .movie, poster: "https://m.media-amazon.com/images/M/MV5BOGQyZTMzMWEtZjEyOS00NTMzLWFlYzctYjAzNzk2ZGFmNzk3XkEyXkFqcGdeQXVyMDM3MzU0Ng@@._V1_SX300.jpg"),
        Movie(title: "asdf", year: "2022", imdbID: "fff", type: .movie, poster: "https://m.media-amazon.com/images/M/MV5BOGQyZTMzMWEtZjEyOS00NTMzLWFlYzctYjAzNzk2ZGFmNzk3XkEyXkFqcGdeQXVyMDM3MzU0Ng@@._V1_SX300.jpg"),
        Movie(title: "asdf", year: "2022", imdbID: "fff", type: .movie, poster: "https://m.media-amazon.com/images/M/MV5BOGQyZTMzMWEtZjEyOS00NTMzLWFlYzctYjAzNzk2ZGFmNzk3XkEyXkFqcGdeQXVyMDM3MzU0Ng@@._V1_SX300.jpg"),
        Movie(title: "asdf", year: "2022", imdbID: "fff", type: .movie, poster: "https://m.media-amazon.com/images/M/MV5BOGQyZTMzMWEtZjEyOS00NTMzLWFlYzctYjAzNzk2ZGFmNzk3XkEyXkFqcGdeQXVyMDM3MzU0Ng@@._V1_SX300.jpg"),
    ])
    
    init() {
        
    }
}

extension SearchPresenter: InteractorToPresenterSearchProtocol {
    
}
