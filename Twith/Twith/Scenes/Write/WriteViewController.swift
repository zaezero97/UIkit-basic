//
//  WriteViewController.swift
//  Twith
//
//  Created by 재영신 on 2022/01/24.
//

import UIKit
import SnapKit

final class WriteViewController: UIViewController {
    private lazy var presenter = WritePresenter(vc: self)
    private lazy var leftBarButtonItem: UIBarButtonItem = {
       let barButtonItem = UIBarButtonItem(
        title: "닫기",
        style: .plain,
        target: self,
        action: #selector(didTapLeftBarButtonItem)
       )
        return barButtonItem
    }()
    
    private lazy var rightBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            title: "트윗",
            style: .plain,
            target: self,
            action: #selector(didTapRightBarButtonItem)
        )
        barButtonItem.isEnabled = false
        return barButtonItem
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.text = "텍스트 입력"
        textView.textColor = .secondaryLabel
        textView.font = .systemFont(ofSize: 16.0, weight: .medium)
        return textView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.presenter.viewDidLoad()
    }
    
   
}

extension WriteViewController: WriteProtocol {
    func setupViews() {
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        self.view.addSubview(textView)
        
        textView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(16.0)
            make.height.equalTo(160.0)
        }
    }
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

private extension WriteViewController {
    @objc func didTapLeftBarButtonItem() {
        self.presenter.didTapLeftBarButtonItem()
    }
    @objc func didTapRightBarButtonItem() {
        self.presenter.didTapRightBarButtonItem(text: self.textView.text)
    }

}

extension WriteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .secondaryLabel else { return }
        
        textView.text = nil
        textView.textColor = .label
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard textView.textColor != .secondaryLabel else { return }
        
        rightBarButtonItem.isEnabled = !textView.text.isEmpty
    }
}
