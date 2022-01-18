//
//  TabbarCollectionCell.swift
//  PagingTabbar
//
//  Created by 재영신 on 2022/01/18.
//

import Foundation
import UIKit
import SnapKit

class TabbarCollectionCell: UICollectionViewCell {
    static let identifier = "TabbarCollectionCell"
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24,weight: .bold)
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    override var isSelected: Bool {
           didSet {
               titleLabel.textColor = isSelected ? UIColor.black : UIColor.gray
           }
       }

   
    func setTitle(_ title: String) {
        self.titleLabel.text = title
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.contentView.addSubview(titleLabel)
    }
}
