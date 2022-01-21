//
//  BookmarkViewController.swift
//  Translate
//
//  Created by 재영신 on 2022/01/21.
//

import UIKit
import SwiftUI
import SnapKit

final class BookmarkViewController: UIViewController {
    
    private var bookmark: [Bookmark] = []
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let inset: CGFloat = 16.0
        layout.estimatedItemSize = CGSize(width: view.frame.width - 32.0, height: 100.0)
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layout.minimumLineSpacing = 16.0
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.dataSource = self
        //collectionview.delegate = self
        collectionview.register(BookmarkCollectionViewCell.self, forCellWithReuseIdentifier: BookmarkCollectionViewCell.identifier)
        collectionview.backgroundColor = .secondarySystemBackground
        return collectionview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.bookmark = UserDefaults.standard.bookmarks
        self.collectionView.reloadData()
    }
}

private extension BookmarkViewController {
    func configureUI() {
        self.navigationItem.title = NSLocalizedString("Bookmarks", comment: "즐겨찾기")
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = .systemGray5
        self.view.addSubview(collectionView)
        self.collectionView.backgroundColor = .systemGray5
        self.setConstraints()
    }
    
    func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

extension BookmarkViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.bookmark.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookmarkCollectionViewCell.identifier, for: indexPath) as? BookmarkCollectionViewCell
        let bookmark = bookmark[indexPath.item]
        cell?.configureUI(from: bookmark)
        return cell ?? UICollectionViewCell()
    }
    
    
}
struct BookmarkViewController_Preview : PreviewProvider {
    static var previews: some View {
        Contatiner().edgesIgnoringSafeArea(.all)
    }
    struct Contatiner: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            return UINavigationController(rootViewController: BookmarkViewController())
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
        typealias UIViewControllerType =  UIViewController
    }
}

