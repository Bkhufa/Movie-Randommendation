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
    
    func search(with query: String)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorSearchProtocol {
    
    var presenter: InteractorToPresenterSearchProtocol? { get set }
    func fetchSearch(_ query: String)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterSearchProtocol {
    func setSearchResult(data: SearchResult)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterSearchProtocol {
    
}
