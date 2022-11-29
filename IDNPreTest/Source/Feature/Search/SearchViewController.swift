//
//  SearchViewController.swift
//  IDNPreTest
//
//  Created by Bryan Khufa on 28/11/22.
//  
//

import UIKit

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


class SearchResultViewController: UIViewController {
    
    unowned var presenter: ViewToPresenterSearchProtocol
    
    lazy var movieCollectionView: MovieCollectionViewComponent = {
        let view = MovieCollectionViewComponent(data: presenter.movieData)
        return view
    }()
    
    lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Result"
        return label
    }()
    
    lazy var resultCount: UILabel = {
        let label = UILabel()
        label.text = "0"
        return label
    }()
    
    init(presenter: ViewToPresenterSearchProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(movieCollectionView)
        view.addSubview(resultLabel)
        view.addSubview(resultCount)
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.leading.equalToSuperview().inset(10)
        }
        resultCount.snp.makeConstraints { make in
            make.centerY.equalTo(resultLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(10)
        }
        movieCollectionView.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalToSuperview()
            make.top.equalTo(resultLabel.snp.bottom).offset(10)
        }
    }
}
