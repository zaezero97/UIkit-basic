//
//  DetailListBackgroundView.swift
//  FindCVS
//
//  Created by 재영신 on 2022/01/21.
//


import RxSwift
import RxCocoa
import UIKit


class DetailListBackgroundView: UIView {
    let disposeBag = DisposeBag()
    let statusLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: DetailListBackgroundViewModel) {
        viewModel.isStatusLabelHidden
            .emit(to: statusLabel.rx.isHidden)
            .disposed(by: disposeBag)
    }
    private func configure() {
        self.addSubview(statusLabel)
        backgroundColor = .white
        statusLabel.text = "🧖‍♀️"
        statusLabel.textAlignment = .center
        setConstraints()
    }
    
    private func setConstraints() {
        statusLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
