//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Maxim Yakhin on 11.12.2020.
//  Copyright © 2020 Max Yakhin. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var pic: UIImageView!
    
    var urlString: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
