//
//  enlargeViewController.swift
//  ACFinalExam
//
//  Created by 張智涵 on 2016/7/22.
//  Copyright © 2016年 張智涵 Vincent Chang. All rights reserved.
//

import UIKit
import SDWebImage

class enlargeViewController: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet weak var enlargeImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var detailBook: BookList!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    
        self.scrollView.delegate = self
        self.scrollView.maximumZoomScale = 2.0
        self.scrollView.minimumZoomScale = 0.5
        self.enlargeImage.sd_setImageWithURL(NSURL(string:detailBook.bookImage!))
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.enlargeImage
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
