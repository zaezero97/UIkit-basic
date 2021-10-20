//
//  ViewController.swift
//  PhotoGalleryApp
//
//  Created by 재영신 on 2021/10/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Photo Gallery App"
        makeNavigationItem()
        
        photoCollectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 1) / 2, height: 200)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        photoCollectionView.collectionViewLayout = layout
    }
    func makeNavigationItem(){
        let photoItem = UIBarButtonItem(image: UIImage(systemName: "photo.fill"), style: .done, target: self, action: #selector(showGallery))
        photoItem.tintColor = .black.withAlphaComponent(0.7)
        
        self.navigationItem.rightBarButtonItem = photoItem
        
        
        let refreshItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .done, target: self, action: #selector(refresh))
        refreshItem.tintColor = .black.withAlphaComponent(0.7)
        self.navigationItem.leftBarButtonItem = refreshItem
    }
}

// MARK: bar button actions
extension ViewController{
    @objc func showGallery(sender : UIBarButtonItem){
        
    }
    @objc func refresh(sender : UIBarButtonItem){
        
    }
}

// MARK: UICollectionViewDataSource
extension ViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath)
        
        return cell
    }
    
    
}
