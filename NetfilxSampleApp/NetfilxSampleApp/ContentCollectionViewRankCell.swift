//
//  ContentCollectionLankCell.swift
//  NetfilxSampleApp
//
//  Created by 재영신 on 2022/01/19.
//

import UIKit

class ContentCollectionViewRankCell: UICollectionViewCell {
    static let identifier = "ContentCollectionViewRankCell"
    
    let imageView = UIImageView()
    let rankLabel = UILabel()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //contentView
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        //imageView
        imageView.contentMode = .scaleToFill
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
        }
        
        //rankLabel
        rankLabel.font = .systemFont(ofSize: 100, weight: .black)
        rankLabel.textColor = .white
        contentView.addSubview(rankLabel)
        rankLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(25)
        }
    }
}
