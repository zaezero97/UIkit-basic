//
//  ViewController.swift
//  Setting Clone App
//
//  Created by 재영신 on 2021/10/18.
//

import UIKit

class ViewController: UIViewController {
    
    var settingModel = [[SettingModel]]()
    @IBOutlet weak var settingTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier:"ProfileCell")
        settingTableView.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier:"MenuCell") // 컴파일(빌드?)시 xib파일이 nib파일로 변경되기 때문에 xib파일 이름을 적어도 되는거 같다.
        settingTableView.dataSource = self
        settingTableView.delegate = self
        
        self.navigationItem.title = "Settings"
        self.view.backgroundColor = .systemGray6
        
        makeData()
    }
    override func loadView() {
        super.loadView()
        print("load")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}
extension ViewController {
    func makeData(){
        settingModel.append([
            SettingModel(leftImageName: "person.circle", menuTitle: "Sign in to your iPhone", subTitle: "Set up iCloud, the App Store, and more.", rightImageName: nil)
        ])
        settingModel.append(
            [
                SettingModel(leftImageName: "gear", menuTitle: "General", subTitle: nil, rightImageName: "chevron.right"),
                SettingModel(leftImageName: "person.fill", menuTitle: "Accessibility", subTitle: nil, rightImageName: "chevron.right"),
                SettingModel(leftImageName: "hand.raised.fill", menuTitle: "Privacy", subTitle: nil, rightImageName: "chevron.right")
            ])
        
    }
}
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingModel[section].count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
            
            cell.topTitle.text = settingModel[indexPath.section][indexPath.row].menuTitle
            cell.profileImageView.image = UIImage(systemName: settingModel[indexPath.section][indexPath.row].leftImageName)
            cell.bottomDescription.text = settingModel[indexPath.section][indexPath.row].subTitle
            
            return cell
            
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        
        cell.leftImageView.image = UIImage(systemName: settingModel[indexPath.section][indexPath.row].leftImageName)
        cell.middleTitle.text = settingModel[indexPath.section][indexPath.row].menuTitle
        cell.rightImageView.image =  UIImage(systemName: settingModel[indexPath.section][indexPath.row].rightImageName ?? " ")
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return UITableView.automaticDimension // row 내용에 맞게 유동적으로 높이 지정
        }
        return 60
    }
}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true) // cell select 취소 메소드
        if indexPath.section == 0 && indexPath.row == 0 {
            let midVC = MyIDViewController(nibName: "MyIDViewController", bundle: nil)
            self.present(midVC,animated: true,completion: nil)
        }
        if indexPath.section == 1 && indexPath.row == 0{
            if let generalVC = UIStoryboard(name: "GeneralViewController", bundle: nil).instantiateViewController(withIdentifier: "GeneralViewController") as? GeneralViewController
            {
                self.navigationController?.pushViewController(generalVC, animated: true)
            }
        }
        
    }
}
