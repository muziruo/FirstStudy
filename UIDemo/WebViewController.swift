//
//  WebViewController.swift
//  UIDemo
//
//  Created by 李祎喆 on 2017/10/10.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webview: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        webview.isHidden = true
        
        //使用wkwebview
        let wkwebview = WKWebView(frame: view.frame)
        //wkwebview高度自适应
        wkwebview.autoresizingMask = [.flexibleHeight]
        view.addSubview(wkwebview)
        
        if let url = URL(string: "http://www.baidu.com") {
            let request = URLRequest(url: url)
            wkwebview.load(request)
            //webview.loadRequest(request)
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
