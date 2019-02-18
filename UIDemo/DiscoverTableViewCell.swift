//
//  DiscoverTableViewCell.swift
//  UIDemo
//
//  Created by 李祎喆 on 2017/10/16.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit

class DiscoverTableViewCell: UITableViewCell {

    
    @IBOutlet weak var bigimg: UIImageView!
    @IBOutlet weak var artname: UILabel!
    @IBOutlet weak var artcreator: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
