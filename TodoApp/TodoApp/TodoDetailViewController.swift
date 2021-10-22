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
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    var priority : PriorityLevel?
    weak var delegate : TodoDetailViewControllerDelegate?
    let coreDataManager = CoreDataManager.shared
    
    var selectedTodoList : TodoList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        guard let selectedTodoList = selectedTodoList else {
            deleteButton.isHidden = true
            saveButton.setTitle("Save", for: .normal)
            return}
        titleTextField.text = selectedTodoList.title
        priority = PriorityLevel(rawValue: selectedTodoList.priorityLevel)
        makePriorityButtonDesign()
        deleteButton.isHidden = false
        saveButton.setTitle("Update", for: .normal)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lowButton.layer.cornerRadius = lowButton.bounds.height / 2
        normalButton.layer.cornerRadius = normalButton.bounds.height / 2
        highButton.layer.cornerRadius = highButton.bounds.height / 2
    }
    @IBAction func setPriority(_ sender: UIButton) {
        switch sender.tag
        {
        case 1:
            priority = .level1
        case 2:
            priority = .level2
        case 3:
            priority = .level3
        default:
            break
        }
        makePriorityButtonDesign()
    }
    func makePriorityButtonDesign(){
        lowButton.backgroundColor = .clear
        normalButton.backgroundColor = .clear
        highButton.backgroundColor = .clear
        
        switch priority{
        case .level1:
            lowButton.backgroundColor = priority?.color
        case .level2:
            normalButton.backgroundColor = priority?.color
        case .level3:
            highButton.backgroundColor = priority?.color
        default:
            break
        }
    }
    @IBAction func saveTodo(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty else {
            let alert = UIAlertController(title: "제목을 입력해주세요.", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        if selectedTodoList == nil{
            CoreDataManager.shared.savaTodo(title: title, date: Date(), Priority: priority)
        }else{
            CoreDataManager.shared.updateTodo(uuid:selectedTodoList?.uuid,title: title, date: Date(), Priority: priority)
        }
        
        delegate?.didFinishSaveData()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteTodo(_ sender: Any) {
        coreDataManager.deleteTodo(uuid: selectedTodoList?.uuid)
        delegate?.didFinishSaveData()
        self.dismiss(animated: true, completion: nil)
    }
}
