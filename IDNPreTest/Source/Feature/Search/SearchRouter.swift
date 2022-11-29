//
//  SearchRouter.swift
//  IDNPreTest
//
//  Created by Bryan Khufa on 28/11/22.
//  
//

import Foundation
import UIKit

class SearchRouter: PresenterToRouterSearchProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let presenter: ViewToPresenterSearchProtocol & InteractorToPresenterSearchProtocol = SearchPresenter()
        
        let viewController = SearchViewController(presenter: presenter)
       
        viewController.presenter.router = SearchRouter()
        viewController.presenter.view = viewController
        viewController.presenter.interactor = SearchInteractor(service: URLSessionNetworkService())
        viewController.presenter.interactor?.presenter = presenter
        
        return viewController
    }
    
}
