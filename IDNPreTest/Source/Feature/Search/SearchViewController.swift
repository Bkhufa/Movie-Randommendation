//
//  SearchViewController.swift
//  IDNPreTest
//
//  Created by Bryan Khufa on 28/11/22.
//  
//

import UIKit
import RxSwift

class SearchViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewUI()
        setupSearch()
    }

    // MARK: - Properties
    unowned var presenter: ViewToPresenterSearchProtocol
    private let searchController: UISearchController
    
    init(presenter: ViewToPresenterSearchProtocol) {
        self.presenter = presenter
        searchController = UISearchController(searchResultsController: SearchResultViewController(presenter: presenter))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewUI() {
        title = "Search Movies"

        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupSearch() {
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
}

extension SearchViewController: PresenterToViewSearchProtocol{
    // TODO: Implement View Output Methods
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else { return }
        presenter.setSearchQuery(query: query)
    }
}
