//
//  MovieCell.swift
//  IDNPreTest
//
//  Created by Bryan Khufa on 28/11/22.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class MovieCell: UICollectionViewCell {
    
    static let identifier: String = "MovieCell"
    
    lazy var moviePoster: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .lightGray.withAlphaComponent(0.4)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 5
        image.layer.masksToBounds = true
        return image
    }()
    
    lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(moviePoster)
        contentView.addSubview(movieTitle)
        movieTitle.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
        moviePoster.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.bottom.equalTo(movieTitle.snp.top).offset(-5)
        }
    }
    
    func bindView(with movie: Movie) {
        guard let imageUrl = URL(string: movie.poster) else { return }
        moviePoster.kf.setImage(with: imageUrl, placeholder: UIImage(named: "placeholder"))
        movieTitle.text = movie.title
    }
}
