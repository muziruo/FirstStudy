//
//  AddArtController.swift
//  UIDemo
//
//  Created by 李祎喆 on 2017/9/23.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class AddArtController: UITableViewController ,UIImagePickerControllerDelegate , UINavigationControllerDelegate,
    CLLocationManagerDelegate{

    var art :ArtsMO!
    let localmanager = CLLocationManager()
    var userlocation :String = ""
    
    @IBOutlet weak var artname: UITextField!
    @IBOutlet weak var largeimage: UIImageView!
    @IBOutlet weak var artstyle: UITextField!
    @IBOutlet weak var artcreator: UITextField!
    @IBOutlet weak var localname: UITextField!
    //进行自动定位
    @IBAction func getlocal(_ sender: UIButton) {
        if userlocation == "" {
            localmanager.delegate = self
            localmanager.requestAlwaysAuthorization()
            localmanager.requestWhenInUseAuthorization()
            localmanager.desiredAccuracy = kCLLocationAccuracyBest
            localmanager.startUpdatingLocation()
        }else{
            localname.text = userlocation
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //取最后一个
        let newlocation = locations.last
        let geocoder = CLGeocoder.init()
        
        geocoder.reverseGeocodeLocation(newlocation!) { (placemarks, error) in
            //self.localname.text = placemarks?.first?.name
            self.userlocation = (placemarks?.first?.country)! + (placemarks?.first?.subLocality)!  + (placemarks?.first?.locality)! + (placemarks?.first?.name)!
            self.localname.text = self.userlocation
        }
        //结束定位
        localmanager.stopUpdatingHeading()
    }
    
    //点击保存后的保存操作
    @IBAction func savethisart(_ sender: UIBarButtonItem) {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        
        art = ArtsMO(context: appdelegate.persistentContainer.viewContext)
        art.name = artname.text
        art.creator = artcreator.text
        art.style = artstyle.text
        art.areaname = localname.text
        art.rating = "evaluation"
        //转换图片
        if let imagedata = UIImageJPEGRepresentation(largeimage.image!, 0.8){
            art.image = NSData(data :imagedata)
        }
        print("正在保存...")
        appdelegate.saveContext()
        
        saveincloud(arts: art)
        
        performSegue(withIdentifier: "unwindtohomelist", sender: sender)
    }
    
    //利用leancloud进行云端存储
    func saveincloud(arts: ArtsMO) {
        let cloudobject = AVObject(className: "Arts")
        cloudobject["name"] = arts.name!
        cloudobject["creator"] = arts.creator!
        cloudobject["style"] = arts.style!
        cloudobject["areaname"] = arts.areaname!
        //对图片进行压缩
        let originimage = UIImage(data: arts.image! as Data)!
        
        let factor = (originimage.size.width > 1024) ? (1024 / originimage.size.width) : 1
        
        let scaledimg = UIImage(data: arts.image! as Data, scale: factor)!
        
        let imgfile = AVFile(name: "\(arts.name!).jpg", data: UIImageJPEGRepresentation(scaledimg, 0.7)!)
        
        cloudobject["image"] = imgfile
        
        cloudobject.saveInBackground { (succeed, error) in
            if succeed {
                print("云端保存成功")
            } else {
                print(error ?? "云端保存错误")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                print("相册不可用，请在设置中开启相册访问权限")
                return
            }
            
            let picker = UIImagePickerController()
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //选择照片
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        largeimage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        largeimage.contentMode = .scaleAspectFit
        largeimage.clipsToBounds = true
        dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    //静态的tableviewcell，不需要下面两项，动态的才需要
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
     */

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
