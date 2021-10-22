//
//  RotateButton.swift
//  Custom_Rotate_Button
//
//  Created by 재영신 on 2021/10/22.
//

import UIKit
enum RotateType {
    case up
    case down
}
class RotateButton: UIButton {

    var isUp = RotateType.down{
        didSet{
            changeDesign()
        }
    }
    
    init() {
        super.init(frame: CGRect.zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure(){
        self.addTarget(self, action: #selector(selectButton), for: .touchUpInside)
    }
     
    @objc private func selectButton(){
        if isUp == .up{
            isUp = .down
        }else{
            isUp = .up
        }
    }
    
    private func changeDesign(){
        if isUp == .down{
            self.imageView?.transform = CGAffineTransform(rotationAngle: .pi)
            self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.3)
        }else{
            self.imageView?.transform = .identity
            self.backgroundColor = self.backgroundColor?.withAlphaComponent(1)
        }
    }
}
