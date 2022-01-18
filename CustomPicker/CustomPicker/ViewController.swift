//
//  ViewController.swift
//  CustomPicker
//
//  Created by 재영신 on 2022/01/17.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let availableTime = ["01","02","03","04"]
    private let allMinit = ["05","10","15","20","25"]
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
//        pickerView.layer.borderWidth = 2
//        pickerView.layer.borderColor = UIColor.purple.cgColor
       
        return pickerView
    }()
    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 25
        button.backgroundColor = .purple
        return button
    }()
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "마음이 편안해지고 싶은 시간을 선택하세요."
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .bold)
//        label.layer.borderWidth = 2
//        label.layer.borderColor = UIColor.purple.cgColor
        return label
    }()
    
    override func viewWillLayoutSubviews() {
      
       
      
    }
    override func viewDidLayoutSubviews() {
        let upLine = UIView(frame: CGRect(x:15, y: 0, width: view.frame.width, height: 0.8))
        let underLine = UIView(frame: CGRect(x:15, y: 60, width: view.frame.width, height: 0.8))
        
        upLine.backgroundColor = .purple
        underLine.backgroundColor = .purple
        let iconView = UIView(frame: CGRect(x: 0, y: 20, width: 20, height: 20))
        iconView.backgroundColor = .purple
        iconView.layer.cornerRadius = 10
        pickerView.subviews[1].addSubview(upLine)
        pickerView.subviews[1].addSubview(underLine)
        print(pickerView.frame,self.view.frame)
        print("test")
        let label = UILabel()
        label.text = "시"
        let label2 = UILabel()
        label2.text = "분"
        pickerView.setPickerLabels(labels: [0:label,1:label2],spacing: 30)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(pickerView)
        self.view.addSubview(confirmButton)
        self.view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(30)
            make.top.equalTo(self.view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(100)
            
        }
        pickerView.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.bottom.equalTo(self.confirmButton.snp.top)
            make.leading.trailing.equalToSuperview().inset(30)
        }

        confirmButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(50)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
   
       
    }
    
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 60
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
                case 0:
                    return 2
                case 1:
                    return availableTime.count /// 연도의 아이템 개수
                case 2:
                    return allMinit.count /// 월의 아이템 개수
                default:
                    return 0
                }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            switch component {
//            case 0:
//                return row == 0 ? "오전":"오후"
            case 0:
                return   "\(availableTime[row])"
            case 1:
                return "\(allMinit[row])"
            default:
                return ""
            }
        }
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        let view = UIView()
//        view.layer.borderWidth = 2
//        view.layer.borderColor = UIColor.purple.cgColor
//
//        let label = UILabel()
//        view.addSubview(label)
//        label.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        switch component {
//        case 0:
//            label.text = row == 0 ? "오전":"오후"
//        case 1:
//            label.text = "\(availableTime[row])"
//        case 2:
//            label.text = "\(allMinit[row])"
//        default:
//            label.text = ""
//        }
//        return view
//
//    }
}
extension UIPickerView {
    func setPickerLabels(labels: [Int:UILabel], spacing: CGFloat) { // [component number:label]
        
        let fontSize:CGFloat = 20
        let labelWidth:CGFloat = self.frame.size.width / CGFloat(self.numberOfComponents)
        let x:CGFloat = self.frame.origin.x
        let y:CGFloat = (self.frame.size.height / 2) - (fontSize / 2)

        for i in 0...self.numberOfComponents {
            
            if let label = labels[i] {
                label.frame = CGRect(x: labelWidth * CGFloat(i) + spacing, y: y, width: labelWidth, height: fontSize)
                label.font = UIFont.systemFont(ofSize: fontSize, weight: .light)
                label.backgroundColor = .clear
                label.textAlignment = NSTextAlignment.center
                self.addSubview(label)
            }
        }
    }
}
