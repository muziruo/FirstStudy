//
//  DiscoverTableViewController.swift
//  UIDemo
//
//  Created by 李祎喆 on 2017/10/19.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit

class DiscoverTableViewController: UITableViewController {

    
    @IBOutlet var spinner: UIActivityIndicatorView!
    //创建数据数组
    var arts : [AVObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //添加转圈菊花
        spinner.center = view.center
        view.addSubview(spinner)
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(self.refreshdata), for: .valueChanged)
        getartsfromcloud()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func refreshdata() {
        getartsfromcloud(needupdata: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showdiscoverdetail" {
            let dest = segue.destination as! DIscoverDetailTableViewController
            dest.getart = arts[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    
    
    //添加右端菜单
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deteleaction = UITableViewRowAction(style: .destructive, title: "删除") { (_, indexPath) in
            let artid = self.arts[indexPath.row].objectId
            //let artid = self.arts[(tableView.indexPathForSelectedRow?.row)!].objectId
            let todo = AVObject(className: "Arts", objectId: artid!)
            
            todo.deleteInBackground({ (result, error) in
                if result {
                    print("云端删除成功")
                }else{
                    print("云端删除时发生未知错误")
                }
            })
            //注意要同时删除UI上的对应行和数据里的对应行
            self.arts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        return [deteleaction]
    }
    
    func getartsfromcloud(needupdata : Bool = false) {
        let quary = AVQuery(className: "Arts")
        
        //按时间降序排列
        quary.order(byDescending: "createdAt")
        
        if needupdata {
            quary.cachePolicy = .ignoreCache
        }else{
            quary.cachePolicy = .cacheElseNetwork
            quary.maxCacheAge = 120
            if quary.hasCachedResult() {
                print("从缓存中获取数据")
            }

        }
        
        
        quary.findObjectsInBackground { (results, error) in
            if let results = results  as? [AVObject] {
                self.arts = results
                
                //刷新UI放入主线程
                OperationQueue.main.addOperation {
                    //结束刷新
                    self.refreshControl?.endRefreshing()
                    self.tableView.reloadData()
                    //转圈菊花停止转动
                    self.spinner.stopAnimating()
                }
            }else {
                print(error ?? "取回数据发生错误")
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "foundcell", for: indexPath) as! DiscoverTableViewCell
        
        let art = arts[indexPath.row]
        cell.artname.text = art["name"] as? String
        cell.artcreator.text = art["creator"] as? String
        //设置占位图片
        cell.bigimg.image = UIImage(named: "timg3")
        if let imgfile = art["image"] as? AVFile {
            imgfile.getDataInBackground({ (data, error) in
                if let data = data {
                    OperationQueue.main.addOperation {
                        cell.bigimg.image = UIImage(data: data)
                    }
                }
            })
        }

        // Configure the cell...

        return cell
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
