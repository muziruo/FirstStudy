//
//  DetailViewController.swift
//  UIDemo
//
//  Created by 李祎喆 on 2017/9/18.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    @IBOutlet weak var ratingbutton: UIButton!
    @IBOutlet weak var largeimage: UIImageView!
    @IBOutlet weak var detailtableview: UITableView!
    
    @IBAction func watchlargeimg(_ sender: Any) {
        print("开始转场")
    }
    
    
    var image:ArtsMO!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        largeimage.image = UIImage(data: image.image! as Data)
        //去除底端多余的分割线
        detailtableview.tableFooterView = UIView(frame: CGRect.zero)
        //修改分割线的颜色
        detailtableview.separatorColor = UIColor(white: 0.9, alpha: 1)
        
        //进行行高自动匹配
        detailtableview.estimatedRowHeight = 36
        detailtableview.rowHeight = UITableViewAutomaticDimension
        
        //设定评价按钮的图片
        if let rat = image.rating {
            //ratingbutton.setImage(UIImage(named: rat), for: .normal)
        ratingbutton.setBackgroundImage(UIImage(named: rat), for: .normal)
        }
            /*
        }else{
            ratingbutton.setBackgroundImage(UIImage(named: "evaluation"), for: .normal)
        }
             */
        
        
        self.title = image.name
        // Do any additional setup after loading the view.
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailcell", for: indexPath) as! detailTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.artlabel.text = "名称"
            cell.valuelabel.text = image.name
        case 1:
            cell.artlabel.text = "画师"
            cell.valuelabel.text = image.creator
        case 2:
            cell.artlabel.text = "风格"
            cell.valuelabel.text = image.style
        default:
            break
        }
        
        //设置cell不可点击
        cell.selectionStyle = .none
        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //跳转下一页面之前所做的准备
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotojudge" {
            let dest = segue.destination as! JudgeViewController
            dest.imagename = self.image
        }else if segue.identifier == "showMap" {
            let dest = segue.destination as! MapViewController
            dest.area = self.image
        }else if segue.identifier == "watchlargeimage" {
            let dest = segue.destination as! WatchImageViewController
            //dest.largeimage.image = UIImage(data: image.image! as Data)
            dest.artimg = image
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    //取消返回，将评价结果带回来
    @IBAction func cancel(sugue:UIStoryboardSegue)  {
        let getjudge = sugue.source as! JudgeViewController
        if let rating = getjudge.rating {
            self.image.rating = rating
            //self.ratingbutton.setImage(UIImage(named :rating), for :.normal)
            self.ratingbutton.setBackgroundImage(UIImage(named: rating), for: .normal)
        }
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.saveContext()
    }
    
    //看图片后返回
    @IBAction func getback(segue:UIStoryboardSegue) {
        
    }

}
