//
//  MoreTableViewController.swift
//  UIDemo
//
//  Created by 李祎喆 on 2017/10/10.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit
import SafariServices

class MoreTableViewController: UITableViewController {

    var list1 = ["反馈","学习更多"]
    var list2 = [["错误反馈","给app评分"],["开发者网站","开发者博客"]]
    var network = "www.muziruo.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //去除屏幕下方的多余分割线条
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return list1[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moreCell", for: indexPath)

        cell.textLabel?.text = list2[indexPath.section][indexPath.row]

        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                //在浏览器中打开网页（默认浏览器safari）
                let urlString = "http://www.apple.com/cn/"
                if let url = URL(string: urlString) {
                    UIApplication.shared.open(url)
                }
            } else {
                //利用webview和wkwebview来打开网址
                performSegue(withIdentifier: "ShowWebView", sender: self)
            }
        case 1:
            //let urlString2 = "http://www.muziruo.com"
            //if let url2 = URL(string: urlString2) {
               // UIApplication.shared.open(url2)
            //}
            //利用safari浏览器，和在浏览器中打开不一样
            let urlstring = "http://www.baidu.com/"
            if let url = URL(string: urlstring) {
                let sfvc = SFSafariViewController(url: url)
                present(sfvc, animated: true, completion: nil)
            }
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
