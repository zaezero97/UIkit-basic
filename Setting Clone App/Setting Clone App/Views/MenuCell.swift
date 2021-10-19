//
//  MenuCell.swift
//  Setting Clone App
//
//  Created by 재영신 on 2021/10/18.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var middleTitle: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
