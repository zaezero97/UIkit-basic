//
//  PhotoCell.swift
//  PhotoGalleryApp
//
//  Created by 재영신 on 2021/10/20.
//

import UIKit
import Photos

class PhotoCell : UICollectionViewCell{
    
    @IBOutlet weak var photoImageView: UIImageView!{
        didSet{
            photoImageView.contentMode = .scaleAspectFill
        }
    }
    
    func loadImage(asset:PHAsset){
        
        let imageManager = PHImageManager()
        let scale = UIScreen.main.scale
        let imageSize = CGSize(width: 150 * scale, height: 150 * scale)
        let options = PHImageRequestOptions()
        options.deliveryMode = .fastFormat
        imageManager.requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFill, options: options) { image, info in
            print(info)
            print(info?[PHImageResultIsDegradedKey] as? Bool)
            if (info?[PHImageResultIsDegradedKey] as? Bool) == true{
                self.photoImageView.image = image //저화질
            }else{
                //고화질
            } //option에서 deliveryMode 를 fastFormat으로 값을 설정하면 info dic에서 PHImageResultIsDegradedKey값이 1일줄 알았는데 0 이 나왔다.
        }
    }
}

