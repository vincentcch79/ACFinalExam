//
//  BookListViewController.swift
//  ACFinalExam
//
//  Created by 張智涵 on 2016/7/22.
//  Copyright © 2016年 張智涵 Vincent Chang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SDWebImage

class BookListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var bookListTable: UITableView!
    
    var contentArray: [FIRDataSnapshot] = []
    var bookLists = [BookList]()
    var refreshControl: UIRefreshControl!
    
    let customCellIdentifier = "BookListTableViewCell"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookListTable.delegate = self
        bookListTable.dataSource = self
        bookListTable.estimatedRowHeight = 180
        bookListTable.rowHeight = UITableViewAutomaticDimension
        bookListTable.registerNib(UINib(nibName: "BookListTableViewCell", bundle: nil), forCellReuseIdentifier: customCellIdentifier)
        
        fetchBook()
        
        
        refreshControl = UIRefreshControl()
        bookListTable.addSubview(refreshControl)
        
        
    }
    override func viewWillAppear(animated: Bool) {
        
        self.bookListTable.reloadData()

    }
    
    
    func fetchBook(){
        let ref = FIRDatabase.database().reference()
        let postRef = ref.child("bookLists")
        postRef.observeEventType(.ChildAdded, withBlock: { (snapshot) in
            
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let bookList = BookList()
                bookList.setValuesForKeysWithDictionary(dictionary)
                self.bookLists.append(bookList)
                
                dispatch_async(dispatch_get_main_queue(), {
                    
                    self.bookListTable.reloadData()
                })
                
            }

            
            }, withCancelBlock: nil)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookLists.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BookListTableViewCell", forIndexPath: indexPath) as! BookListTableViewCell
        

        cell.bookName.text = bookLists[indexPath.row].bookName
        cell.bookImage.sd_setImageWithURL(NSURL(string:bookLists[indexPath.row].bookImage!))

        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "detailSegue"{
            
            if let indexPath = bookListTable.indexPathForSelectedRow{
                let destinationViewController = segue.destinationViewController as! detailViewController
                destinationViewController.detailBook = bookLists[indexPath.row]
            }
        }
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("detailSegue", sender: bookLists[indexPath.row])
    
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            self.delete(deleteIndexPath: indexPath)
            
            bookListTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    func delete(deleteIndexPath indexPath: NSIndexPath) {
        
        let ref = FIRDatabase.database().reference()
        let postRef = ref.child("bookLists").childByAutoId()
        postRef.removeValue()
        bookLists.removeAtIndex(indexPath.row)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if refreshControl.refreshing {
            refreshControl.endRefreshing()
            }
        }
    
    
    
    
    @IBAction func addBookAction(sender: AnyObject) {
        
    }


   
}
