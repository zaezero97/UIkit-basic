//
//  DetailListCell.swift
//  FindCVS
//
//  Created by 재영신 on 2022/01/21.
//

import UIKit
import SnapKit

class DetailListCell: UITableViewCell {
    static let identifier = "DetailListCell"
    let placeNameLabel = UILabel()
    let addressLabel = UILabel()
    let distanceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ data: DetailListCellData) {
        placeNameLabel.text = data.placeName
        addressLabel.text = data.address
        distanceLabel.text = data.distance
    }
    
    private func configure() {
        self.backgroundColor = .white
        placeNameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        addressLabel.font = .systemFont(ofSize: 14)
        addressLabel.textColor = .gray
        
        distanceLabel.font = .systemFont(ofSize: 12, weight: .light)
        distanceLabel.textColor = .darkGray
        
        setConstraints()
    }
    
    private func setConstraints() {
        [placeNameLabel,addressLabel,distanceLabel].forEach {
            contentView.addSubview($0)
        }
        
        placeNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(18)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(placeNameLabel.snp.bottom).offset(3)
            make.leading.equalTo(placeNameLabel)
            make.bottom.equalToSuperview().inset(12)
        }
        
        distanceLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
        }
    }
}
