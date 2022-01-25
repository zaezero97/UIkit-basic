//
//  FeedTableViewCell.swift
//  Twith
//
//  Created by 재영신 on 2022/01/24.
//

import UIKit
import SnapKit


final class FeedTableViewCell: UITableViewCell {
    static let identifier = "FeedTableViewCell"
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 21.0
        return imageView
    }()
    
    private lazy var writterNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        return label
    }()
    
    private lazy var writterAccountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var contentsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(Icon.like.image, for: .normal)
        button.tintColor = .secondaryLabel
        return button
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton()
        button.setImage(Icon.comment.image, for: .normal)
        button.tintColor = .secondaryLabel
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(Icon.share.image, for: .normal)
        button.tintColor = .secondaryLabel
        return button
    }()
    
    func setup(twith: Twith) {
        setupLayout()
        
        self.selectionStyle = .none
        writterNameLabel.text = twith.user.name
        writterAccountLabel.text = "@\(twith.user.account)"
        contentsLabel.text = twith.content
    }
}

private extension FeedTableViewCell {
    func setupLayout() {
        let buttonStackView = UIStackView(
            arrangedSubviews: [
                likeButton,
                commentButton,
                shareButton
            ]
        )
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        
        [
            profileImageView,
            writterNameLabel,
            writterAccountLabel,
            contentsLabel,
            buttonStackView
        ].forEach{ self.addSubview($0) }
        
        let superviewMargin: CGFloat = 16.0
        
        profileImageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(superviewMargin)
            make.width.height.equalTo(40.0)
        }
        
        writterNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(superviewMargin)
            make.top.equalTo(profileImageView)
        }
        
        writterAccountLabel.snp.makeConstraints { make in
            make.leading.equalTo(writterNameLabel.snp.trailing).offset(2.0)
            make.bottom.equalTo(writterNameLabel)
        }
        
        contentsLabel.snp.makeConstraints { make in
            make.leading.equalTo(writterNameLabel)
            make.top.equalTo(writterNameLabel.snp.bottom).offset(4.0)
            make.trailing.equalToSuperview().inset(superviewMargin)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.leading.equalTo(writterNameLabel)
            make.trailing.equalTo(contentsLabel)
            make.top.equalTo(contentsLabel.snp.bottom).offset(12.0)
            make.bottom.equalToSuperview().inset(superviewMargin)
        }
    }
}
