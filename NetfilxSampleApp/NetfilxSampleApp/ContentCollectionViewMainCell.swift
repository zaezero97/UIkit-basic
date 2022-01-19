//
//  ContentCollectionViewMainCell.swift
//  NetfilxSampleApp
//
//  Created by 재영신 on 2022/01/19.
//

import UIKit

class ContentCollectionViewMainCell: UICollectionViewCell {
    static let identifier = "ContentCollectionViewMainCell"
    
    let baseStackView = UIStackView()
    let menuStackView = UIStackView()
    
    let tvButton = UIButton()
    let movieButton = UIButton()
    let categoryButton = UIButton()
    
    let imageView = UIImageView()
    let descriptionLabel = UILabel()
    let contentStackView = UIStackView()
    
    let plusButton = UIButton()
    let playButton = UIButton()
    let infoButton = UIButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        [baseStackView,menuStackView].forEach {
            contentView.addSubview($0)
        }
        
        //baseStackView
        baseStackView.axis = .vertical
        baseStackView.alignment = .center
        baseStackView.distribution = .fillProportionally
        baseStackView.spacing = 5
        
        baseStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        [imageView,descriptionLabel,contentStackView].forEach {
            baseStackView.addArrangedSubview($0)
        }
        
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.width.top.leading.trailing.equalToSuperview()
            make.height.equalTo(imageView.snp.width)
        }
        
        descriptionLabel.font = .systemFont(ofSize: 13)
        descriptionLabel.textColor = .white
        descriptionLabel.sizeToFit()
        
        contentStackView.axis = .horizontal
        contentStackView.alignment = .center
        contentStackView.distribution = .equalCentering
        contentStackView.spacing = 20
        contentStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(60)
        }
        
        [plusButton, infoButton].forEach {
            $0.titleLabel?.font = .systemFont(ofSize: 13)
            $0.setTitleColor(.white, for: .normal)
            $0.imageView?.tintColor = .white
            $0.adjustVerticalLayout(5)
        }
        
        plusButton.setTitle("내가 찜한 콘텐츠", for: .normal)
        plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        
        infoButton.setTitle("정보", for: .normal)
        infoButton.setImage(UIImage(systemName: "info.circle"), for: .normal)
        infoButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        
        playButton.setTitle("▶︎ 재생", for: .normal)
        playButton.setTitleColor(.black, for: .normal)
        playButton.backgroundColor = .white
        playButton.layer.cornerRadius = 3
        playButton.snp.makeConstraints { make in
            make.width.equalTo(90)
            make.height.equalTo(30)
        }
        playButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        
        [plusButton,playButton,infoButton].forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        //menuStackView
        menuStackView.axis = .horizontal
        menuStackView.alignment = .center
        menuStackView.distribution = .equalSpacing
        menuStackView.spacing = 20
        
        [tvButton,movieButton,categoryButton].forEach {
            menuStackView.addArrangedSubview($0)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 1
            $0.layer.shadowRadius = 3
        }
        
        tvButton.setTitle("TV 프로그램", for: .normal)
        movieButton.setTitle("영화", for: .normal)
        categoryButton.setTitle("카테고리 *", for: .normal)
        
        tvButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        movieButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        categoryButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        menuStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(baseStackView).inset(30)
        }
        
    }
    
    @objc func didTapButton(_ sender: UIButton) {
        print("TEST:  Button Tapped",sender.description)
    }
}
