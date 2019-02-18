//
//  detailTableViewCell.swift
//  UIDemo
//
//  Created by 李祎喆 on 2017/9/19.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit

class detailTableViewCell: UITableViewCell {

    @IBOutlet weak var artlabel: UILabel!
    @IBOutlet weak var valuelabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
