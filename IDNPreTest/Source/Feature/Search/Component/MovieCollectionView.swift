//
//  CollectionViewComponent.swift
//  IDNPreTest
//
//  Created by Bryan Khufa on 28/11/22.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class MovieCollectionViewComponent<T: Sequence>: UIView, UICollectionViewDelegate {
    
    private let disposeBag = DisposeBag()
    private let data: Observable<T>
    
    private var didSelectCell: ((IndexPath) -> Void)?
    private var willDisplayCell: ((IndexPath) -> Void)?
    
    lazy var collectionView: UICollectionView = {
        let width = UIScreen.main.bounds.width / 2 - 15
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 2
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 5, right: 10)
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()
    
    init(data: Observable<T>) {
        self.data = data
        super.init(frame: .zero)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        setupCollectionViewData()
        setupCollectionViewUI()
    }
    
    private func setupCollectionViewUI() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupCollectionViewData() {
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        data.bind(to: collectionView.rx.items(cellIdentifier: MovieCell.identifier, cellType: MovieCell.self)) { indexPath, item, cell in
            //                cell.bindView(with: cat)
        }
        .disposed(by: disposeBag)
    }
    
    func setDidSelectCell(action: @escaping ((IndexPath) -> Void)) {
        didSelectCell = action
    }
    
    func setWillDisplayCell(action: @escaping ((IndexPath) -> Void)) {
        willDisplayCell = action
    }
    
    //MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectCell?(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        willDisplayCell?(indexPath)
        
        //        if indexPath.row == viewModel.catDataCount - 2 {
        //            viewModel.fetchMoreCat(limit: 10)
        //        }
    }
}
