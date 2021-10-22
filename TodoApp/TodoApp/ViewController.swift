//
//  ViewController.swift
//  TodoApp
//
//  Created by 재영신 on 2021/10/22.
//

import UIKit


enum PriorityLevel : Int64{
    case level1
    case level2
    case level3
}
extension PriorityLevel{
    var color : UIColor{
        switch self{
        case .level1:
            return .green
        case .level2:
            return .orange
        case .level3:
            return .red
        }
    }
}
class ViewController: UIViewController {
    
    @IBOutlet weak var todoTableView: UITableView!
    let coreDataManager = CoreDataManager.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        
        todoTableView.dataSource = self
        todoTableView.delegate = self
        
        coreDataManager.fetchData()
        todoTableView.reloadData()
    }
}

// MARK: - navigation bar func
extension ViewController {
    func setNavigationBar(){
        self.title = "To Do List"
        let rightItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTodo))
        rightItem.tintColor = .red
        self.navigationItem.rightBarButtonItem = rightItem
        
        let barAppearance = UINavigationBarAppearance()
        barAppearance.backgroundColor = .blue
        self.navigationController?.navigationBar.standardAppearance = barAppearance
        
        
    }
    @objc func addNewTodo(){
        let detailVC = TodoDetailViewController(nibName: "TodoDetailViewController", bundle: nil)
        detailVC.delegate = self
        self.present(detailVC, animated: true, completion: nil)
    }
}

// MARK: - Table Viefw DataSource,Deletgete
extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coreDataManager.todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
        cell.topTitleLabel.text = coreDataManager.todoList[indexPath.row].title
        if let hasDate = coreDataManager.todoList[indexPath.row].date{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
            let formatedDate = dateFormatter.string(from: hasDate)
            cell.dateLabel.text = formatedDate
        }else{
            cell.dateLabel.text = ""
        }
        let priority = coreDataManager.todoList[indexPath.row].priorityLevel
        cell.priorityView.backgroundColor = PriorityLevel(rawValue: priority)?.color
        cell.priorityView.layer.cornerRadius = cell.priorityView.bounds.height / 2
        return cell
    }
    
}
extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = TodoDetailViewController(nibName: "TodoDetailViewController", bundle: nil)
        detailVC.delegate = self
        detailVC.selectedTodoList = coreDataManager.todoList[indexPath.row]
        present(detailVC, animated: true, completion: nil)
    }
}

// MARK: - TodoDetailViewControllver Delegate
extension ViewController : TodoDetailViewControllerDelegate{
    func didFinishSaveData() {
        coreDataManager.fetchData()
        self.todoTableView.reloadData()
    }
}
