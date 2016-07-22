//
//  detailViewController.swift
//  ACFinalExam
//
//  Created by 張智涵 on 2016/7/22.
//  Copyright © 2016年 張智涵 Vincent Chang. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import WebKit

class detailViewController: UIViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var detailAddress: UIButton!
    @IBOutlet weak var detailPhone: UIButton!
    @IBOutlet weak var detailWeb: UIButton!
    @IBOutlet weak var detailIntro: UILabel!
    
    var detailBook: BookList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.detailImage.sd_setImageWithURL(NSURL(string:detailBook.bookImage!))
        self.detailName.text = detailBook.bookName
        self.detailAddress.setTitle(detailBook.bookAddress, forState: UIControlState.Normal)
        self.detailPhone.setTitle(detailBook.bookPhone, forState: UIControlState.Normal)
        self.detailWeb.setTitle(detailBook.bookWeb, forState: UIControlState.Normal)
        self.detailIntro.text = detailBook.bookIntro
        
        
        
        // Do any additional setup after loading the view.
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
    @IBAction func addressMap(sender: AnyObject) {
    }
    @IBAction func phoneAction(sender: AnyObject) {
        let phoneAdd =  NSURL(string: "tel://\(detailBook.bookPhone!)")
        if UIApplication.sharedApplication().canOpenURL(phoneAdd!) {
            UIApplication.sharedApplication().openURL(phoneAdd!)
        } else {
            print("error")
        }
    }
    @IBAction func webAction(sender: AnyObject) {
        let webView = WKWebView(frame:UIScreen.mainScreen().bounds)
        self.view.addSubview(webView)
        let url = NSURL(string: "\(detailBook.bookWeb!)")
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "mapSegue"{
            let destinationViewController = segue.destinationViewController as! MapViewController
            destinationViewController.detailBook = detailBook
        } else if segue.identifier == "bigImageSegue" {
            let destinationViewController = segue.destinationViewController as! enlargeViewController
            destinationViewController.detailBook = detailBook
        }

    }
        
    
}
