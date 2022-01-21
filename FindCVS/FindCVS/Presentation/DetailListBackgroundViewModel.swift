//
//  DetailListBackgroundViewModel.swift
//  FindCVS
//
//  Created by 재영신 on 2022/01/21.
//


import Foundation
import RxSwift
import RxCocoa

struct DetailListBackgroundViewModel {
    
    //output
    let isStatusLabelHidden: Signal<Bool>
    
    //input
    let shouldHideStatusLabel = PublishRelay<Bool>()
     
    init() {
        isStatusLabelHidden = shouldHideStatusLabel
            .asSignal(onErrorJustReturn: true)
    }
}
