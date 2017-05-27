//
//  FeedCell.swift
//  Connect
//
//  Created by Neel Nishant on 22/05/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func draw(_ rect: CGRect) {
        postImg.layer.cornerRadius = 20.0
        postImg.clipsToBounds = true
        
    }
}
