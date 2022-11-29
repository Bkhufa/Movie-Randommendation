//
//  SearchResultViewController.swift
//  IDNPreTest
//
//  Created by Bryan Khufa on 30/11/22.
//

import Foundation
import UIKit
import RxSwift

class SearchResultViewController: UIViewController {
    
    unowned var presenter: ViewToPresenterSearchProtocol
    let disposeBag = DisposeBag()
    
    lazy var movieCollectionView: MovieCollectionViewComponent = {
        let view = MovieCollectionViewComponent(data: presenter.movieData)
        view.setWillDisplayCell { [weak self] indexPath in
            self?.presenter.displayMoreMovie(displayIndex: indexPath.row)
        }
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
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.numberOfLines = 0
        label.textAlignment = .center
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
        setupRx()
    }
    
    private func setupUI() {
        view.addSubview(movieCollectionView)
        view.addSubview(resultLabel)
        view.addSubview(resultCount)
        view.addSubview(errorLabel)
        
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
        errorLabel.snp.makeConstraints { make in
            make.edges.equalTo(movieCollectionView.snp.edges)
        }
    }
    
    private func setupRx() {
        presenter.resultCount
            .bind(to: resultCount.rx.text)
            .disposed(by: disposeBag)
        
        presenter.error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                if error != nil {
                    self?.movieCollectionView.isHidden = true
                    self?.errorLabel.isHidden = false
                    self?.resultCount.text = "0"
                    
                    guard let error = error as? MovieError else {
                        self?.errorLabel.text = error?.localizedDescription
                        return
                    }
                    self?.errorLabel.text = error.error
                    return
                }
                self?.movieCollectionView.isHidden = false
                self?.errorLabel.isHidden = true
            })
            .disposed(by: disposeBag)
    }
}
