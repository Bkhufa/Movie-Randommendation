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

final class CollectionViewComponent<T>: UIView, UICollectionViewDelegate {
    
    let disposeBag = DisposeBag()
    private var didSelectCell: ((T) -> Void)?
//    private let cell: CustomCollectionViewCell
//    private let cellIdentifier: String
//    private let data: Observable<T>
    
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
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
//        viewModel.fetchMoreCat(limit: 10)
        setupCollectionView()
    }
    
    func setupCollectionView() {
//        collectionView.register(CatCardCell.self, forCellWithReuseIdentifier: CatCardCell.identifier)
//        collectionView.register(cell.self, forCellWithReuseIdentifier: cell.identifier)
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
//        viewModel.catData
//            .bind(to: collectionView.rx.items(cellIdentifier: CatCardCell.identifier, cellType: CatCardCell.self)) { indexPath, cat, cell in
//                cell.bindView(with: cat)
//            }
//            .disposed(by: disposeBag)
        

        addSubview(collectionView)
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 1),
//            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
//        ])
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setDidSelectCell(action: @escaping ((T) -> Void)) {
        didSelectCell = action
    }
    
    //MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        didSelectCat?(cat)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if indexPath.row == viewModel.catDataCount - 2 {
//            viewModel.fetchMoreCat(limit: 10)
//        }
    }
}

class CustomCollectionViewCell: UICollectionViewCell {
    
    let identifier: String
    
    init(identifier: String) {
        self.identifier = identifier
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
