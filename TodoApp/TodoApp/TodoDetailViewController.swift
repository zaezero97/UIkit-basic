//
//  TodoDetailViewController.swift
//  TodoApp
//
//  Created by 재영신 on 2021/10/22.
//

import UIKit
import CoreData


protocol TodoDetailViewControllerDelegate : AnyObject{
    func didFinishSaveData()
}
class TodoDetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var lowButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var highButton: UIButton!
    weak var delegate : TodoDetailViewControllerDelegate?
    let coreDataManager = CoreDataManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func setPriority(_ sender: UIButton) {
        switch sender.tag
        {
        case 1:
            break
        case 2:
            break
        case 3:
            break
        default:
            break
        }
    }
    @IBAction func saveTodo(_ sender: Any) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "TodoList", in: coreDataManager.context) else { return }
        
        guard let object = NSManagedObject(entity: entityDescription, insertInto: coreDataManager.context) as? TodoList else {return}
        object.title = titleTextField.text
        object.date = Date()
        object.uuid = UUID()
        
        coreDataManager.saveContext()
        delegate?.didFinishSaveData()
        self.dismiss(animated: true, completion: nil)
    }
}
