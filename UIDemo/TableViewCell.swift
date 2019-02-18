//
//  TableViewCell.swift
//  UIDemo
//
//  Created by 李祎喆 on 2017/9/17.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var smallimage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var creator: UILabel!
    @IBOutlet weak var describ: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        smallimage.layer.cornerRadius = 35
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
