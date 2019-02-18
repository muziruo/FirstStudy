//
//  WatchImageViewController.swift
//  UIDemo
//
//  Created by 李祎喆 on 2017/10/21.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit

class WatchImageViewController: UIViewController {

    @IBOutlet weak var largeimage: UIImageView!
    
    
    var artimg : ArtsMO!
    override func viewDidLoad() {
        super.viewDidLoad()
        largeimage.image = UIImage(data: artimg.image! as Data)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
