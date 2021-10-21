//
//  ViewController.swift
//  PhotoGalleryApp
//
//  Created by 재영신 on 2021/10/20.
//

import UIKit
import PhotosUI

class ViewController: UIViewController {
    
    var fetchResults: PHFetchResult<PHAsset>?
    @IBOutlet weak var photoCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let photoItem = UIBarButtonItem(image: UIImage(systemName: "photo.fill"), style: .done, target: self, action: #selector(checkPermission))
        photoItem.tintColor = .black.withAlphaComponent(0.7)
        
        self.navigationItem.rightBarButtonItem = photoItem
        
        
        let refreshItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .done, target: self, action: #selector(refresh))
        refreshItem.tintColor = .black.withAlphaComponent(0.7)
        self.navigationItem.leftBarButtonItem = refreshItem
    }
}

// MARK: - bar button actions
extension ViewController{
    @objc func checkPermission(){
        if PHPhotoLibrary.authorizationStatus() == .authorized || PHPhotoLibrary.authorizationStatus() == .limited{ // authorized -> 사용자가 명시적으로 권한 부여 , limited -> 사용자가 이 앱에 제한된 권한을 승인 (선택한 몇개 만 사용 하겠다)
            DispatchQueue.main.async {
                self.showGallery()
            }
        }else if PHPhotoLibrary.authorizationStatus() == .denied{ //승인 거절 했을 경우
            DispatchQueue.main.async {
                self.showAuthorizationDeniedAlert()
            }
        }else if PHPhotoLibrary.authorizationStatus() == .notDetermined{ // 사용자가 앱의 인증상태를 설정하지 않은 경우 ex) 앱을 설치하고 처음 실행
            PHPhotoLibrary.requestAuthorization { status in
                self.checkPermission()
            }
        }
    }
    func showGallery(){
        let library = PHPhotoLibrary.shared() //singleton pattern
        var configuration = PHPickerConfiguration(photoLibrary: library)
        configuration.selectionLimit = 10
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    func showAuthorizationDeniedAlert(){
        let alert = UIAlertController(title: "포토라이브러리의 접근 권환을 활성화 해주세요.", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "설정으로 가기", style: .default, handler: { action in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url, options: [:],completionHandler: nil)
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    @objc func refresh(sender : UIBarButtonItem){
        self.photoCollectionView.reloadData()
    }
}

// MARK: - UICollectionView DataSource
extension ViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResults?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        if let asset = self.fetchResults?[indexPath.row]{
            cell.loadImage(asset: asset)
        }
        
        return cell
    }
}

// MARK: - PHPicker delegate
extension ViewController : PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        let identifiers = results.map{ $0.assetIdentifier ?? ""}
        self.fetchResults = PHAsset.fetchAssets(withLocalIdentifiers: identifiers, options: nil)
        self.photoCollectionView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
}


