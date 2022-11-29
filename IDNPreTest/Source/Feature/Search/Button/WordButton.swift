//
//  WordButton.swift
//  IDNPreTest
//
//  Created by Bryan Khufa on 30/11/22.
//

import Foundation
import UIKit
import SnapKit

final class WordButton: UIView {
    
    let action: (() -> Void)?
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Noun"
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        
        button.addTarget(self, action: #selector(onButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    init(wordType: String, action: (() -> Void)?) {
        self.action = action
        super.init(frame: .zero)
        label.text = wordType
        setupView()
    }
    
    private func setupView() {
        addSubview(label)
        addSubview(button)
        
        snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(10)
        }
        
        button.snp.makeConstraints { make in
            make.leading.equalTo(label.snp.leading)
            make.trailing.equalToSuperview().inset(10)
            make.top.equalTo(label.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setWord(word: String) {
        button.setTitle(word, for: .normal)
    }
    
    @objc private func onButtonTapped() {
        button.isSelected.toggle()
        print(button.state)
        action?()
    }
}
