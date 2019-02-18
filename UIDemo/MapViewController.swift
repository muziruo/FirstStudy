//
//  MapViewController.swift
//  UIDemo
//
//  Created by 李祎喆 on 2017/9/23.
//  Copyright © 2017年 李祎喆. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController , MKMapViewDelegate{
    
    @IBOutlet weak var mapView: MKMapView!
    var area :ArtsMO!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let coder = CLGeocoder()
        coder.geocodeAddressString(area.areaname!) { (placemark, error) in
            //guard进行检测保证placemark是有值的，不然会退出
            guard let placemark = placemark else {
                print(error ?? "未知错误")
                return
            }
            
            let place = placemark.first
            let annotation = MKPointAnnotation()
            annotation.title = self.area.areaname
            annotation.subtitle = self.area.name
            
            if let loc = place?.location {
                annotation.coordinate = loc.coordinate
                self.mapView.showAnnotations([annotation], animated: true)
                self.mapView.selectAnnotation(annotation, animated: true)
            }
            
        }
        // Do any additional setup after loading the view.
    }

    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let id = "myid"
        var mv = mapView.dequeueReusableAnnotationView(withIdentifier: id) as? MKPinAnnotationView
        
        if mv == nil {
            mv = MKPinAnnotationView(annotation: annotation, reuseIdentifier: id)
            mv?.canShowCallout = true
        }
        
        //在左侧添加一张图片表示当前查询的目标
        let lefticonimage = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        lefticonimage.contentMode = .scaleAspectFit
        lefticonimage.image = UIImage(data: area.image! as Data)
        mv?.leftCalloutAccessoryView = lefticonimage
        
        return mv
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
