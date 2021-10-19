//
//  ViewController.swift
//  OnBoardingViewApp
//
//  Created by 재영신 on 2021/10/19.
//

import UIKit

class ViewController: UIViewController {

    var didShowOnBoardingView = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // self.present(itemVC, animated: true, completion: nil) 여기서 호출하면 오류가 난다
        // 뷰가 다 그려지기 전에 present해서 오류가 난다.
        // viewWillAppear에서도 오류가 난다.
    }
    override func viewDidAppear(_ animated: Bool) {
        if !didShowOnBoardingView{
            didShowOnBoardingView = true
            let pageVC = OnBoardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: .none)
            
            pageVC.modalPresentationStyle = .fullScreen
            self.present(pageVC, animated: true, completion: nil)
        }
        
    }
}

