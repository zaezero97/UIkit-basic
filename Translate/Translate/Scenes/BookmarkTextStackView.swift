//
//  BookmarkText.swift
//  Translate
//
//  Created by 재영신 on 2022/01/21.
//

import Foundation
import UIKit

final class BookmarkTextStackView: UIStackView {
    private let type: Type
    private let language: Language
    private let text: String
    private lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13.0, weight: .medium)
        label.textColor = type.color
        label.text = language.title
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        label.textColor = type.color
        label.text = text
        label.numberOfLines = 0
        return label
    }()
    
    init(language: Language, text: String, type: Type) {
        self.language = language
        self.text = text
        self.type = type
        
        super.init(frame: .zero)
        self.configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.axis = .vertical
        self.distribution = .equalSpacing
        self.spacing = 16.0
        [languageLabel, textLabel].forEach {
            self.addArrangedSubview($0)
        }
    }
}
