//
//  JudgeViewController.swift
//  UIDemo
//
//  Created by 李祎喆 on 2017/9/21.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit

class JudgeViewController: UIViewController {

    @IBOutlet weak var ratingstackview: UIStackView!
    @IBOutlet weak var judgeimage: UIImageView!
    
    var rating :String?
    
    @IBAction func getrating(_ sender: UIButton) {
        switch sender.tag {
        case 100:
            rating = "bad"    //未找到图片素材，暂时用一样的图片来代替
        case 101:
            rating = "ok"
        case 102:
            rating = "great"
        default:
            break
        }
        
        performSegue(withIdentifier: "gobacktodetail", sender: sender)
    }
    
    var imagename:ArtsMO!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        judgeimage.image = UIImage(data: imagename.image! as Data)
        
        //背景图片特效化处理
        let effect = UIBlurEffect(style: .light)
        let effectview = UIVisualEffectView(effect: effect)
        effectview.frame = view.frame     //设定大小
        judgeimage.addSubview(effectview)       //将特效图加入到原图片上
        
        //进行动画添加,加入首帧
        ratingstackview.transform = CGAffineTransform(scaleX: 0, y: 0)
        // Do any additional setup after loading the view.
    }

    //动画显示
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5) { 
            self.ratingstackview.transform = CGAffineTransform.identity
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
