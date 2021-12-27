//
//  MyIDViewController.swift
//  Setting Clone App
//
//  Created by 재영신 on 2021/10/19.
//

import UIKit

class MyIDViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!{
        didSet{
            nextButton.isEnabled = false
        }
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        //addtarget == IB에서 drag로 iBAction으로 설정하는 것과 같은 기능
        //UIControl.Event 타입의 이벤트가 발생하면 sender는 target객체 에게 action message를 보내고 응답으로 action으로 지정한 메소드를 호출한다.
    }
   
    @IBAction func doCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension MyIDViewController{
    @objc func textFieldDidChange(sender: UITextField){
        if sender.text?.isEmpty == true {
            nextButton.isEnabled = false
        }else{
            nextButton.isEnabled = true
        }
    }
}
