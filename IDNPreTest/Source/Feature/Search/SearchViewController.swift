//
//  SearchViewController.swift
//  IDNPreTest
//
//  Created by Bryan Khufa on 28/11/22.
//  
//

import UIKit
import SnapKit
import RxSwift

final class SearchViewController: UIViewController {
    
    // MARK: - Properties
    unowned var presenter: ViewToPresenterSearchProtocol
    private let searchController: UISearchController
    
    lazy var nounButton: WordButton = {
        let button = WordButton(wordType: "Noun") {
            print("lalalala")
        }
        return button
    }()
    
    
    lazy var verbButton: WordButton = {
        let button = WordButton(wordType: "Verb") {
            print("lalalala")
        }
        return button
    }()
    
    lazy var adjectiveButton: WordButton = {
        let button = WordButton(wordType: "Adjective") {
            print("lalalala")
        }
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [
            nounButton,
            verbButton,
            adjectiveButton,
        ])
        view.axis = .vertical
        return view
    }()
    
    lazy var instructionLabel: UILabel = {
        let label = UILabel()
        label.text = "We have provided you 3 randomized words below. Try tapping them to instantly search new movies with those title!"
        label.numberOfLines = 0
        return label
    }()
    
    init(presenter: ViewToPresenterSearchProtocol) {
        self.presenter = presenter
        searchController = UISearchController(searchResultsController: SearchResultViewController(presenter: presenter))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewUI()
        setupSearch()
        searchController.searchBar.text = "Transformers"
    }
    
    private func setupViewUI() {
        title = "Search Movies"
        
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(instructionLabel)
        view.addSubview(stackView)
        
        instructionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(180)
            make.horizontalEdges.equalToSuperview().inset(20)
            
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(instructionLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.bottom.greaterThanOrEqualToSuperview().inset(100)
        }
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
