//
//  DraggbleView.swift
//  PanGestureApp
//
//  Created by 재영신 on 2021/10/20.
//

import UIKit
class DraggbleView: UIView {
    var dragType = DragType.none
    init(){
        super.init(frame: CGRect.zero)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(dragging))
        self.addGestureRecognizer(pan)
    }// init(frame:) 은 코드로 uiview를 구현 할 때 호출하는 initializer
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //fatalError("init(coder:) has not been implemented")
        let pan = UIPanGestureRecognizer(target: self, action: #selector(dragging))
        self.addGestureRecognizer(pan)
    }// interface builder로 uiview를 구현할 때 호출되는 initializer
}


extension DraggbleView{
    @objc func dragging(pan: UIPanGestureRecognizer)
    {
        switch pan.state{
        case .began:
            print("began")
        case .changed:
            let delta = pan.translation(in: self.superview)
            var myPosition = self.center //절대 좌표
            
            if dragType == .dragX{
                myPosition.x += delta.x
            }else if dragType == .dragY{
                myPosition.y += delta.y
            }else{
                myPosition.x += delta.x
                myPosition.y += delta.y
            }
            
            
            self.center = myPosition
            pan.setTranslation(CGPoint.zero, in: self.superview)
            
        case .ended , .cancelled:
            if self.frame.minX < 0 {
                self.frame.origin.x = 0
            }
            if let SuperView = self.superview{
                if self.frame.maxX > SuperView.frame.maxX{
                    self.frame.origin.x = SuperView.frame.maxX - self.bounds.width
                }
            }
            
        default:
            break
        }
    }
}
