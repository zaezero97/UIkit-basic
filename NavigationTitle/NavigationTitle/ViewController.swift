//
//  ViewController.swift
//  NavigationTitle
//
//  Created by 재영신 on 2021/10/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationItem.title = "메인 화면"
        
//        let logo = UIImageView(image: UIImage(named: "bg103.jpg"))
//
//        logo.contentMode = .scaleAspectFit
//        logo.widthAnchor.constraint(equalToConstant: 120).isActive = true
//        logo.heightAnchor.constraint(equalToConstant: 50).isActive = true
//
//        navigationItem.titleView = logo
        let btn = UIButton()
       // btn.backgroundColor = .orange
        btn.setTitle("custom button", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.widthAnchor.constraint(equalToConstant:120).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        btn.addTarget(self, action: #selector(testAction), for: .touchUpInside)
        self.navigationItem.titleView = btn
    }
    
    @objc func testAction(){
        print("test action")
    }
}

