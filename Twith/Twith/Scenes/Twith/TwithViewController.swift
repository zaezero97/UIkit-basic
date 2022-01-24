//
//  TwithViewController.swift
//  Twith
//
//  Created by 재영신 on 2022/01/24.
//

import UIKit
import SnapKit

final class TwithViewController: UIViewController {
    private var presenter: TwithPresenter!
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 30.0
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        return label
    }()
    
    private lazy var userAccountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13.0, weight: .bold)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var contentsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16.0, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var isLikedButton: UIButton = {
        let button = UIButton()
        button.setImage(Icon.like.image, for: .normal)
        button.tintColor = .secondaryLabel
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setImage(Icon.share.image, for: .normal)
        button.tintColor = .secondaryLabel
        return button
    }()
    
    private lazy var userInfoStackView: UIStackView = {
        let stackView = UIStackView()
        [
            userNameLabel,
            userAccountLabel
        ].forEach{
            stackView.addArrangedSubview($0)
        }
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 4.0
        return stackView
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        [
            isLikedButton,
            shareButton
        ].forEach {
            stackView.addArrangedSubview($0)
        }
        stackView.distribution = .fillEqually
        stackView.spacing = 4.0
        return stackView
    }()
    init(twith: Twith) {
        super.init(nibName: nil, bundle: nil)
        self.presenter = TwithPresenter(vc: self, twith: twith)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension TwithViewController: TwithProtocol {
    func setViews(twith: Twith) {
        userNameLabel.text = twith.user.name
        userAccountLabel.text = "@\(twith.user.account)"
        contentsLabel.text = twith.content
    }
    func setupViews() {
        [
            profileImageView,
            userInfoStackView,
            contentsLabel,
            buttonStackView
        ].forEach {
            self.view.addSubview($0)
        }
        
        let superViewMargin: CGFloat = 16.0
        
        profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(superViewMargin)
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(superViewMargin)
            make.width.height.equalTo(60.0)
        }
        
        userInfoStackView.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(8.0)
            make.trailing.equalToSuperview().inset(superViewMargin)
            make.centerY.equalTo(profileImageView.snp.centerY)
        }
        
        contentsLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.leading)
            make.trailing.equalTo(userInfoStackView.snp.trailing)
            make.top.equalTo(profileImageView.snp.bottom).offset(8.0)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView)
            make.trailing.equalTo(userInfoStackView)
            make.top.equalTo(contentsLabel.snp.bottom).offset(superViewMargin)
        }
    }
}
