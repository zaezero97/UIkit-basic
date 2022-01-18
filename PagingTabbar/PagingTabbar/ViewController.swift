//
//  ViewController.swift
//  PagingTabbar
//
//  Created by 재영신 on 2022/01/18.
//

import UIKit
import SnapKit
class ViewController: UIViewController {
    
    lazy var tabCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TabbarCollectionCell.self, forCellWithReuseIdentifier: TabbarCollectionCell.identifier)
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    lazy var tabPageCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(PageCollectionCell.self, forCellWithReuseIdentifier: PageCollectionCell.identifier)
        return collectionView
    }()
    
    lazy var indicatorView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 10))
        view.backgroundColor = .black
        return view
    }()
    
    var direction = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.navigationItem.title = "abc"
        self.view.addSubview(tabCollectionView)
        self.view.addSubview(tabPageCollectionView)
        self.view.addSubview(indicatorView)
        
        tabCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(100)
        }
        
        tabPageCollectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(tabCollectionView.snp.bottom)
        }
        
        indicatorView.snp.makeConstraints { make in
            make.width.equalTo(self.view.frame.width / 3)
            make.bottom.equalTo(tabCollectionView).offset(-10)
            make.height.equalTo(10)
            make.leading.equalTo(self.view)
        }
        
        let firstIndexPath = IndexPath(item: 0, section: 0)
        tabCollectionView.selectItem(at: firstIndexPath, animated: false, scrollPosition: [])
        tabPageCollectionView.selectItem(at: firstIndexPath, animated: false, scrollPosition: [])
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: tabPageCollectionView.frame.width, height: tabPageCollectionView.frame.height)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        tabPageCollectionView.collectionViewLayout = layout
        
        
        let layout2 = UICollectionViewFlowLayout()
        layout2.scrollDirection = .horizontal
        layout2.itemSize = CGSize(width: self.view.frame.width / 3,height: 50)
        layout2.minimumLineSpacing = 1
        layout2.minimumInteritemSpacing = 1
        tabCollectionView.collectionViewLayout = layout2
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
       
    }
}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tabCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabbarCollectionCell.identifier, for: indexPath) as! TabbarCollectionCell
            cell.setTitle("tabbar\(indexPath.row)")
            cell.titleLabel.textAlignment = .center
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageCollectionCell.identifier, for: indexPath) as! PageCollectionCell
            cell.setTitle(index: indexPath.row)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt",indexPath)
        
        if collectionView == tabCollectionView {
            tabPageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("scroll")
        
        let value = scrollView.contentOffset.x / 3
        indicatorView.snp.updateConstraints { make in
            make.leading.equalTo(value)
        }
        
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let itemAt = Int(targetContentOffset.pointee.x / self.view.frame.width)
        let indexPath = IndexPath(item: itemAt, section: 0)
        tabCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
    
}


