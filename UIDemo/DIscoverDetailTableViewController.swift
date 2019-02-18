//
//  DIscoverDetailTableViewController.swift
//  UIDemo
//
//  Created by 李祎喆 on 2017/10/19.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit

class DIscoverDetailTableViewController: UITableViewController {

    @IBOutlet weak var largeimg: UIImageView!
    
    @IBAction func gettheart(_ sender: UIButton) {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        getartintocoredata = ArtsMO(context: appdelegate.persistentContainer.viewContext)
        
        getartintocoredata?.areaname = getart?["areaname"] as? String
        getartintocoredata?.creator = getart?["creator"] as? String
        getartintocoredata?.name = getart?["name"] as? String
        getartintocoredata?.style = getart?["style"] as? String
        let img = getart?["image"] as? AVFile
        let imgdata = img?.getData()
        getartintocoredata?.image = NSData(data: imgdata!)
        
        print("正在保存到本地")
        appdelegate.saveContext()

        
        let arltcontrallor = UIAlertController(title: "下载成功", message: "您需要的作品已经下载到本地啦", preferredStyle: .alert)
        let okaction = UIAlertAction(title: "好的", style: .default, handler: nil)
        arltcontrallor.addAction(okaction)
        self.present(arltcontrallor, animated: true, completion: nil)
        
    }
    var getart : AVObject?
    var getartintocoredata : ArtsMO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imagefile = getart?["image"] as? AVFile
        
        largeimg.image = UIImage(data: (imagefile?.getData())!)
        
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
        return 1
    }
     

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "discoverdetailcell", for: indexPath) as! DiscoverDetailTableViewCell
        
        switch indexPath.row {
        case 0:
            cell.titlename.text = "名称"
            cell.value.text = getart?["name"] as? String
        case 1:
            cell.titlename.text = "画师"
            cell.value.text = getart?["creator"] as? String
        case 2:
            cell.titlename.text = "风格"
            cell.value.text = getart?["style"] as? String
        default:
            break
        }
        // Configure the cell...

        cell.selectionStyle = .none
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
