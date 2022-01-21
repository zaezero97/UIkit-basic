//
//  BookmarkCollectionViewCell.swift
//  Translate
//
//  Created by 재영신 on 2022/01/21.
//

import UIKit
import SnapKit

final class BookmarkCollectionViewCell: UICollectionViewCell {
    static let identifier = "BookmarkCollectionViewCell"
    
    private var sourceBookmarkTextStackView: BookmarkTextStackView!
    private var targetBookmarkTextStackView: BookmarkTextStackView!
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 16.0
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        
        return stackView
    }()
    func configureUI(from bookmark: Bookmark) {
     
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = 12.0
        
        sourceBookmarkTextStackView = BookmarkTextStackView(language: bookmark.sourceLanguage, text: bookmark.sourceText, type: .source)
        targetBookmarkTextStackView = BookmarkTextStackView(language: bookmark.translatedLanguade, text: bookmark.tranlatedText, type: .target)
        
        stackView.subviews.forEach { $0.removeFromSuperview() }
        [sourceBookmarkTextStackView, targetBookmarkTextStackView].forEach {
            stackView.addArrangedSubview($0)
        }
        self.addSubview(stackView) 
        self.setConstraints()
    }
    
    private func setConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width - 32.0)
        }
        
        layoutIfNeeded()
    }
}
