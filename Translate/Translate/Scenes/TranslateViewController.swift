//
//  TranslateViewController.swift
//  Translate
//
//  Created by 재영신 on 2022/01/21.
//

import UIKit
import SwiftUI
import SnapKit



enum `Type` {
    case source
    case target
    
    var color: UIColor {
        switch self {
        case .source: return .label
        case .target: return .mainTintColor
        }
    }
}


final class TranslateViewController: UIViewController {
    
    private var translatorManager = TranslatorManager()
   
    
    private lazy var sourceLanguageButton: UIButton = {
        let button = UIButton()
        button.setTitle(translatorManager.sourceLanguage.title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 9.0
        button.addTarget(self, action: #selector(didTapSourceLanguageButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var targetLanguageButton: UIButton = {
        let button = UIButton()
        button.setTitle(translatorManager.targetLanguage.title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.addTarget(self, action: #selector(didTapTargetLanguageButton), for: .touchUpInside)
        button.layer.cornerRadius = 9.0
        return button
    }()
    
    
    private lazy var buttonStackView: UIStackView =  {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0
        
        [sourceLanguageButton,targetLanguageButton].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    private lazy var resultBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23, weight: .bold)
        label.textColor = UIColor.mainTintColor
        label.text = "Hello"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.addTarget(self, action: #selector(didTapBookmarkButton), for: .touchUpInside)
        return button
    }()
    
    @objc func didTapBookmarkButton() {
        guard
            let sourceText = sourceLabel.text,
            let translatedText = resultLabel.text,
            bookmarkButton.imageView?.image == UIImage(systemName: "bookmark") //bookmark.fill == 북마크가 클릭된 상태
        else { return }
        
        let currentBookmarks: [Bookmark] = UserDefaults.standard.bookmarks
        let newBookmark = Bookmark(sourceLanguage: translatorManager.sourceLanguage, translatedLanguade: translatorManager.targetLanguage, sourceText: sourceText, tranlatedText: translatedText)
        
        UserDefaults.standard.bookmarks = [newBookmark] + currentBookmarks
        bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
    }
    private lazy var copyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        button.addTarget(self, action: #selector(didTapCopyButton), for: .touchUpInside)
        return button
    }()
    
   
    private lazy var sourceLabelBaseButton: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSourceLabelBaseButton))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    
    private lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Enter_text", comment: "텍스트입려")
        label.textColor = .tertiaryLabel
        // TODO: sourceLabel 에 입력값이 추가되면, placeholde 스타일 해제
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 23.0, weight: .bold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray5
        configureUI()
    }
}


private extension TranslateViewController {
    func configureUI() {
        [sourceLabel].forEach{
            self.sourceLabelBaseButton.addSubview($0)
        }
        [resultLabel,bookmarkButton,copyButton].forEach {
            self.resultBaseView.addSubview($0)
        }
        
        [buttonStackView,resultBaseView,sourceLabelBaseButton].forEach {
            self.view.addSubview($0)
        }
        
        setConstraints()
    }
    
    func setConstraints() {
        let defaultSpacing: CGFloat = 16.0
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(defaultSpacing)
            make.height.equalTo(50)
        }
        
        resultBaseView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(buttonStackView.snp.bottom).offset(defaultSpacing)
            make.bottom.equalTo(bookmarkButton).offset(defaultSpacing)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview().inset(24)
        }
        
        bookmarkButton.snp.makeConstraints { make in
            make.leading.equalTo(resultLabel.snp.leading)
            make.top.equalTo(resultLabel.snp.bottom).offset(24)
            make.width.height.equalTo(40)
        }
        
        copyButton.snp.makeConstraints { make in
            make.leading.equalTo(bookmarkButton.snp.trailing).inset(8)
            make.top.equalTo(bookmarkButton.snp.top)
            make.width.height.equalTo(40)
        }
        
        sourceLabelBaseButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(resultBaseView.snp.bottom).offset(defaultSpacing)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        sourceLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview().inset(24)
            
        }
    }
    @objc func didTapSourceLabelBaseButton() {
        let viewController = SourceTextViewController(delegate: self)
        present(viewController, animated: true, completion: nil)
    }
    @objc func didTapSourceLanguageButton() {
        didTapLanguageButton(type: .source)
    }
    @objc func didTapTargetLanguageButton() {
        didTapLanguageButton(type: .target)
    }

    func didTapLanguageButton(type: Type) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        Language.allCases.forEach {
            language in
            let action = UIAlertAction(title: language.title, style: .default) {
                [weak self] _ in
                switch type {
                case .source:
                    self?.translatorManager.sourceLanguage = language
                    self?.sourceLanguageButton.setTitle(language.title, for: .normal)
                case .target:
                    self?.translatorManager.targetLanguage = language
                    self?.targetLanguageButton.setTitle(language.title, for: .normal)
                }
            }
            
            alertController.addAction(action)
        }
        let cancleAction = UIAlertAction(title: NSLocalizedString("Cancle", comment: "취소"), style: .cancel, handler: nil)
        alertController.addAction(cancleAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func didTapCopyButton() {
        UIPasteboard.general.string = resultLabel.text
    }
}


extension TranslateViewController: SourceTextViewControllerDelegate {
    func didEnterText(_ sourceText: String) {
        if sourceText.isEmpty { return }
        
        sourceLabel.text = sourceText
        sourceLabel.textColor = .label
        
        translatorManager.translate(from: sourceText) { [weak self] translatedText in
            self?.resultLabel.text = translatedText
        }
        bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
    }
}

struct TranslateViewController_Preview : PreviewProvider {
    static var previews: some View {
        Contatiner().edgesIgnoringSafeArea(.all)
    }
    struct Contatiner: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return UINavigationController(rootViewController: TranslateViewController())
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
        typealias UIViewControllerType =  UIViewController
    }
}
