//
//  GeneralViewController.swift
//  Setting Clone App
//
//  Created by 재영신 on 2021/10/19.
//

import UIKit

class GeneralCell: UITableViewCell{
    
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    {
        didSet{
            rightImageView.image = UIImage(systemName: "chevron.right")
        }
    }
}// 종속적이고 다른 곳에서 사용할 일 없는 cell이라면 이렇게 사용하는 방밥 도 있다는 것을 한번 연습삼아 코딩
struct GeneralModel{
    var leftTitle = ""
}

class GeneralViewController: UIViewController {
    
    var model = [[GeneralModel]]()
    
    @IBOutlet weak var generalTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        generalTableView.delegate = self
        generalTableView.dataSource = self
        
        self.navigationItem.title = "General"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        makeData()
    }
}

extension GeneralViewController {
    func makeData(){
        model.append([GeneralModel(leftTitle: "About")])
        
        model.append([GeneralModel(leftTitle: "Keyboard"),
                      GeneralModel(leftTitle: "Game Controller"),
                      GeneralModel(leftTitle: "Fonts"),
                      GeneralModel(leftTitle: "Language & Region"),
                      GeneralModel(leftTitle: "Dictionary")])
        
        model.append([GeneralModel(leftTitle: "Reset")])
    }
}
extension GeneralViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return model.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GeneralCell", for: indexPath) as! GeneralCell
        cell.leftLabel.text = model[indexPath.section][indexPath.row].leftTitle
        return cell
    }
}
extension GeneralViewController : UITableViewDelegate{
    
}

