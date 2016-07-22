//
//  AddNewBookViewController.swift
//  ACFinalExam
//
//  Created by 張智涵 on 2016/7/22.
//  Copyright © 2016年 張智涵 Vincent Chang. All rights reserved.
//

import UIKit
import Firebase

class AddNewBookViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var imageField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var bookField: UITextField!
    @IBOutlet weak var introField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addNewBookButton(sender: AnyObject) {
        let refData = FIRDatabase.database().reference()
        let postRef = refData.child("bookLists").childByAutoId()
        postRef.setValue(["bookName": nameField.text!, "bookImage": imageField.text!, "bookAddress": addressField.text!, "bookPhone": phoneField.text!, "bookWeb": bookField.text!, "bookIntro": introField.text!])
        nameField.text = ""
        imageField.text = ""
        addressField.text = ""
        phoneField.text = ""
        bookField.text = ""
        introField.text = ""
    }


   
}
