//
//  MaterialButton.swift
//  Connect
//
//  Created by Neel Nishant on 21/05/17.
//  Copyright © 2017 Parse. All rights reserved.
//

import UIKit

class MaterialButton: UIButton {
    let SHADOW_COLOR: CGFloat = 157.0 / 255.0

    override func awakeFromNib() {
        layer.cornerRadius = 2.0
        layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).cgColor
        
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    }

}
