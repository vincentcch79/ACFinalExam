//
//  MapViewController.swift
//  ACFinalExam
//
//  Created by 張智涵 on 2016/7/22.
//  Copyright © 2016年 張智涵 Vincent Chang. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var bookMap: MKMapView!
    
    var detailBook: BookList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookMap.delegate = self;
        bookMap.showsCompass = true
        bookMap.showsScale = true
        bookMap.showsTraffic = true
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(detailBook.bookAddress!, completionHandler: {
            placemarks, error in
            if error != nil {
                print(error)
                return
            }
            if let placemarks = placemarks {
                
                let placemark = placemarks[0]
                
                let annotation = MKPointAnnotation()
                annotation.title = self.detailBook.bookName
                
                if let location = placemark.location{
                    annotation.coordinate = location.coordinate
                    
                    self.bookMap.showAnnotations([annotation], animated: true)
                    self.bookMap.selectAnnotation(annotation, animated: true)
                    
                    
                }
            }
            
        })


        // Do any additional setup after loading the view.
    }
    
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        
        if annotation.isKindOfClass(MKUserLocation){
            return nil
        }
        
        var annotationView:MKPinAnnotationView? =
            mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as?
        MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        let leftIconView = UIImageView(frame: CGRectMake(0, 0, 53, 53))
        leftIconView.sd_setImageWithURL(NSURL(string:detailBook.bookImage!))
        annotationView?.leftCalloutAccessoryView = leftIconView
        
        return annotationView
        
        
        
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
