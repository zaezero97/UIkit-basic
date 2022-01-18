//
//  PageCollectionCell.swift
//  
//
//  Created by 재영신 on 2022/01/18.
//

import Foundation
import UIKit

class PageCollectionCell: UICollectionViewCell {
    static let identifier = "PageCollectionCell"
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 24,weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    func setTitle(index: Int) {
        self.titleLabel.text = "\(index)번째"
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLabel)
        self.backgroundColor = .gray
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        print("init frame call !!!")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("init coder call!!!")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        print("awakeFromNib call!!")
    }
}
