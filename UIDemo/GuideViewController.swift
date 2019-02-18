//
//  GuideViewController.swift
//  UIDemo
//
//  Created by 李祎喆 on 2017/9/28.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController {

    
    @IBOutlet weak var headlabel: UILabel!
    @IBOutlet weak var bottomlabel: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var pagecontroller: UIPageControl!
    @IBOutlet weak var openbut: UIButton!
    
    @IBAction func opentheapp(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "showguide")
    }
    var index = 0
    var imagename :String = ""
    var headtext :String = ""
    var bottomtext :String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pagecontroller.currentPage = index
        headlabel.text = headtext
        bottomlabel.text = bottomtext
        imageview.image = UIImage(named: imagename)
        openbut.isHidden = (index != 2)
        
        //添加动画首帧
        openbut.transform = CGAffineTransform(scaleX: 1, y: 1)
        //开始按钮自定义
        
        openbut.backgroundColor = UIColor(red: 89/255, green: 201/255, blue: 186/255, alpha: 1)
        openbut.layer.cornerRadius = 5
        //加上阴影
        openbut.layer.shadowColor = UIColor.black.cgColor
        openbut.layer.shadowOffset = CGSize(width: 1, height: 1)
        openbut.layer.shadowRadius = 2
        openbut.layer.shadowOpacity = 0.6
        
        openbut.addTarget(self, action: #selector(pressanimation1(sender:)), for: .touchDown)
        openbut.addTarget(self, action: #selector(pressanimation2(sender:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }

    //以下两个方法为按钮动画改变，分别定义尾帧
    func pressanimation1(sender : UIButton?) {
        UIView.animate(withDuration: 0.15) { 
            self.openbut.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    func pressanimation2(sender : UIButton?) {
        UIView.animate(withDuration: 0.15) { 
            self.openbut.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
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
