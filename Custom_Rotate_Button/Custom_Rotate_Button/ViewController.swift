//
//  ViewController.swift
//  Custom_Rotate_Button
//
//  Created by 재영신 on 2021/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var customButton: RotateButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customButton.selectedCallback = {
            upDownType in
            print(upDownType)
            if upDownType == .up{
                print("여기서 해야할 일")
            }
        }
        // Do any additional setup after loading the view.
//
//        let myButton = RotateButton()
//        self.view.addSubview(myButton)
//
//
//
//        myButton.translatesAutoresizingMaskIntoConstraints = false
//        myButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        myButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//
//        myButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        myButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
//
//        myButton.backgroundColor = .orange
//        myButton.setTitle("my Custom button", for: .normal)
//        myButton.setImage(UIImage(systemName: "arrowtriangle.down"), for: .normal)
//
    }
}


