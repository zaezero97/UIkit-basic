//
//  ProfileCell.swift
//  Setting Clone App
//
//  Created by 재영신 on 2021/10/18.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var bottomDescription: UILabel!
    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        let profileHeight: CGFloat = 60
        profileImageView.layer.cornerRadius = profileHeight / 2
        topTitle.textColor = .blue
        topTitle.font = UIFont.systemFont(ofSize:  20)
        
        bottomDescription.textColor = .darkGray
        bottomDescription.font = UIFont.systemFont(ofSize:  16)
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
