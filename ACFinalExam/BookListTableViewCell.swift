//
//  BookListTableViewCell.swift
//  ACFinalExam
//
//  Created by 張智涵 on 2016/7/22.
//  Copyright © 2016年 張智涵 Vincent Chang. All rights reserved.
//

import UIKit

class BookListTableViewCell: UITableViewCell {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
