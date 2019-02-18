//
//  ViewController.swift
//  UIDemo
//
//  Created by 李祎喆 on 2017/9/17.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController ,NSFetchedResultsControllerDelegate ,UISearchResultsUpdating{
    
    //@IBOutlet weak var tableview: UITableView!
    
    var artlist :[ArtsMO] = []
    
    var searchresult :[ArtsMO] = []
    
    var fc: NSFetchedResultsController<ArtsMO>!
    
    var sc: UISearchController!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //添加搜索框，初始化搜索框对象
        sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        tableView.tableHeaderView = sc.searchBar
        sc.dimsBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "输入作品名称进行搜索..."
        sc.searchBar.searchBarStyle = .minimal
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        //将返回键上的字消除只留下箭头
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        fetchalldata2()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //每次界面出现都进行一次数据和界面刷新
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //判断引导页是否已经显示过了
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "showguide") {
            return
        }
        //显示引导页
        if let pagevc = storyboard?.instantiateViewController(withIdentifier: "GuideController") as? pageViewController{
            present(pagevc, animated: true, completion: nil)
        }
        //以下方法效率较低
        //fetchalldata()
        //tableview.reloadData()
        
    }
    
    func searchfilter(text :String) {
        searchresult = artlist.filter({ (arts) -> Bool in
            return arts.name!.localizedCaseInsensitiveContains(text)
        })
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        if var text = searchController.searchBar.text {
            text = text.trimmingCharacters(in: .whitespaces)
            searchfilter(text: text)
            tableView.reloadData()
        }
    }
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
    //UI动态刷新
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .automatic)
        default:
            tableView.reloadData()
        }
        
        if let object = controller.fetchedObjects {
            artlist = object as! [ArtsMO]
        }
    }
    
    //将数据变化与界面绑定，不需要每次更新都将整个页面重载
    func fetchalldata2()  {
        
        let request :NSFetchRequest<ArtsMO> = ArtsMO.fetchRequest()
        //排序，讲搜索出来的数据进行排序
        let sd = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sd]
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        fc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fc.delegate = self
        
        do {
            try fc.performFetch()
            //检查是否有数据
            if let object = fc.fetchedObjects {
                artlist = object
            }
        }catch {
            print(error)
        }
    }
    
    
    //获取数据库中的所有条目
    func fetchalldata()  {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        
        do {
            artlist = try appdelegate.persistentContainer.viewContext.fetch(ArtsMO.fetchRequest())
        } catch {
            print(error)
        }
    }
    
    //准备过程，为转入下一界面做准备
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showdetail" {
            let dest = segue.destination as! DetailViewController
            dest.hidesBottomBarWhenPushed = true
            dest.image = sc.isActive ? searchresult[tableView.indexPathForSelectedRow!.row] : artlist[tableView.indexPathForSelectedRow!.row]
        }
    }
    
    //点击后的事件
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        sc.isActive = false
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return  sc.isActive ? searchresult.count : artlist.count
        //return artlist.count
        if sc.isActive {
            return searchresult.count
        }else{
            return artlist.count
        }
    }
    
    //添加数据
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //添加数据
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        let arts = sc.isActive ? searchresult[indexPath.row] : artlist[indexPath.row]
        
        cell.smallimage.image = UIImage(data: arts.image! as Data)
        cell.name.text = arts.name
        cell.creator.text = arts.creator
        cell.describ.text = arts.style
        
        return cell
    }

    //自定义右端菜单
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let actionshare = UITableViewRowAction(style: .normal, title: "分享") { (_, indexPath) in
            let actionsheet = UIAlertController(title: "分享", message: "分享到", preferredStyle: .actionSheet)
            let action1 = UIAlertAction(title: "QQ", style: .default, handler: nil)
            let action2 = UIAlertAction(title: "微信", style: .default, handler: nil)
            let action3 = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            actionsheet.addAction(action1)
            actionsheet.addAction(action2)
            actionsheet.addAction(action3)
            
            //将这个底部菜单显示出来
            self.present(actionsheet, animated: true, completion: nil)
        }
        
        actionshare.backgroundColor = UIColor.orange
        
        let actiondelete = UITableViewRowAction(style: .destructive, title: "删除") { (_, indexPath) in
            //self.artlist.remove(at: indexPath.row)
            
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appdelegate.persistentContainer.viewContext
            
            context.delete(self.fc.object(at: indexPath))
            appdelegate.saveContext()
            
            //tableView.deleteRows(at: [IndexPath], with: .fade)
        }
        
        return [actionshare,actiondelete]
    }
    
    //添加作品返场
    @IBAction func close(sugue: UIStoryboardSegue) {
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return !sc.isActive
    }

    /*数据注释
    Arts(image:"aoi1",name:"猫",creator:"aoi ogata",style:"暗黑系小清新暗黑系小清新暗黑系小清新暗黑系小清新"),
    Arts(image:"aoi2",name:"恶魔面具",creator:"aoi ogata",style:"暗黑系小清新暗黑系小清新暗黑系小清新暗黑系小清新"),
    Arts(image:"aoi3",name:"HATE",creator:"aoi ogata",style:"暗黑系小清新暗黑系小清新暗黑系小清新暗黑系小清新"),
    Arts(image:"aoi4",name:"HATE口罩",creator:"aoi ogata",style:"暗黑系小清新暗黑系小清新暗黑系小清新暗黑系小清新"),
    Arts(image:"aoi5",name:"HATE眼镜",creator:"aoi ogata",style:"暗黑系小清新暗黑系小清新暗黑系小清新暗黑系小清新")
     */
}

