//
//  Arts.swift
//  UIDemo
//
//  Created by 李祎喆 on 2017/9/17.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

struct Arts {
    var image:String
    var name:String
    var creator:String
    var style:String
    var rating = ""
    var areaname = "湖北省武汉市武汉理工大学"
    
    init(image: String, name: String, creator: String, style: String) {
        self.image = image
        self.name = name
        self.creator = creator
        self.style = style
    }
}
