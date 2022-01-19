//
//  ContentCollectionViewCell.swift
//  NetfilxSampleApp
//
//  Created by 재영신 on 2022/01/18.
//

import UIKit
import SnapKit

class ContentCollectionViewCell: UICollectionViewCell {
    static let identifier = "ContentCollectionViewCell"
    let imageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 5
        contentView.clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
