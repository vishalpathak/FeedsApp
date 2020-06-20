//
//  FeedTableViewCell.swift
//  FeedsApp
//
//  Created by Vishal on 20/06/20.
//  Copyright © 2020 Vishal. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var labelUserName: UILabel!
    
    @IBOutlet weak var labelDesignation: UILabel!
    
    @IBOutlet weak var labelTimeCreated: UILabel!
    
    @IBOutlet weak var imageUser: UIImageView!
    
    @IBOutlet weak var imageArticle: UIImageView!
    
    @IBOutlet weak var labelArticleContent: UILabel!
    
    @IBOutlet weak var labelLikes: UILabel!
    
    @IBOutlet weak var labelComments: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
