//
//  SourceTextViewController.swift
//  Translate
//
//  Created by 재영신 on 2022/01/21.
//

import UIKit
import SnapKit

protocol SourceTextViewControllerDelegate: AnyObject {
    func didEnterText(_ sourceText: String)
}
final class SourceTextViewController: UIViewController {
    private let placeholderText = NSLocalizedString("Enter_text", comment: "텍스트입려")
    private weak var delegate: SourceTextViewControllerDelegate?
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.text = placeholderText
        textView.textColor = .secondaryLabel
        textView.font = .systemFont(ofSize: 18, weight: .semibold)
        textView.returnKeyType = .done
        textView.delegate = self
        return textView
    }()
    
    init(delegate: SourceTextViewControllerDelegate?) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray5
        self.view.addSubview(textView)
        
        self.textView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
}

extension SourceTextViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .secondaryLabel else { return }
        
        textView.text = nil
        textView.textColor = .label
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard text == "\n" else { return true }
        dismiss(animated: true, completion: nil)
        delegate?.didEnterText(textView.text)
        return true
    }
}
