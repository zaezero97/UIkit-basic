//
//  TodoDetailViewController.swift
//  TodoApp
//
//  Created by 재영신 on 2021/10/22.
//

import UIKit

class TodoDetailViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var lowButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var highButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func setPriority(_ sender: UIButton) {
        switch sender.tag
        {
            
        }
    }
}
