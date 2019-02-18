//
//  pageViewController.swift
//  UIDemo
//
//  Created by 李祎喆 on 2017/9/28.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit

class pageViewController: UIPageViewController ,UIPageViewControllerDataSource{

    var head = ["画师绘","画师绘","画师绘"]
    var picture = ["aoi10","aoi7","aoi11"]
    var bottom = ["突然有了好创意？","在这里与他人分享","搜罗所有的新鲜创意"]
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! GuideViewController).index
        index -= 1
        return vc(atIndex: index)
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! GuideViewController).index
        index += 1
        return vc(atIndex: index)
    }
    
    func vc(atIndex: Int) -> GuideViewController? {
        if case 0..<head.count = atIndex{
            if let contentvc = storyboard?.instantiateViewController(withIdentifier: "Contentview") as? GuideViewController{
                contentvc.headtext = head[atIndex]
                contentvc.bottomtext = bottom[atIndex]
                contentvc.imagename = picture[atIndex]
                contentvc.index = atIndex
                
                return contentvc
            }
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        if let startvc = vc(atIndex: 0){
            setViewControllers([startvc], direction: .forward, animated: true, completion: nil)
        }
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
