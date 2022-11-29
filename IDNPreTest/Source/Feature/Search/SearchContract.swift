//
//  SearchContract.swift
//  IDNPreTest
//
//  Created by Bryan Khufa on 28/11/22.
//  
//

import Foundation
import RxSwift


// MARK: View Output (Presenter -> View)
protocol PresenterToViewSearchProtocol {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterSearchProtocol: AnyObject {
    
    var view: PresenterToViewSearchProtocol? { get set }
    var interactor: PresenterToInteractorSearchProtocol? { get set }
    var router: PresenterToRouterSearchProtocol? { get set }
    
    var movieData: Observable<[Movie]> { get }
    var resultCount: Observable<String> { get }
    var error: Observable<Error?> { get }
    var randomWords: Observable<[PartOfSpeech:String]> { get }
    
    func setSearchQuery(query: String)
    func displayMoreMovie(displayIndex: Int)
    func fetchRandomWords()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorSearchProtocol {
    
    var presenter: InteractorToPresenterSearchProtocol? { get set }
    
    func fetchSearch(_ query: String, page: Int)
    func fetchRandomWords()
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterSearchProtocol {
    
    func setSearchResult(data: SearchResult)
    func appendSearchResult(data: SearchResult)
    func fetchFailed(error: Error?)
    func appendRandomWords(wordType: PartOfSpeech, word: String?)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterSearchProtocol {
    
}
