//
//  ViewController.swift
//  PanGestureApp
//
//  Created by 재영신 on 2021/10/20.
//

import UIKit

enum DragType{
    case dragX
    case dragY
    case none
}
class ViewController: UIViewController {
    
    var dragType = DragType.none
    let myView  = DraggbleView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myView.center = self.view.center
        myView.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        myView.backgroundColor = .red
        self.view.addSubview(myView)
        myView.dragType = DragType.dragX
        print(type(of: dragType))
    }
    
    
    @IBAction func selectPanType(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex{
        case 0:
            dragType = .dragX
        case 1:
            dragType = .dragY
        case 2:
            dragType = .none
        default:
            break;
        }
        myView.dragType = self.dragType
    }
}

