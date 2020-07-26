//
//  FeedTableViewCell.swift
//  FeedsApp
//
//  Created by Vishal on 20/06/20.
//  Copyright © 2020 Vishal. All rights reserved.
//

import UIKit
import Kingfisher

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var labelUserName: UILabel!
    
    @IBOutlet weak var labelDesignation: UILabel!
    
    @IBOutlet weak var labelTimeCreated: UILabel!
    
    @IBOutlet weak var imageUser: UIImageView!
    
    @IBOutlet weak var imageArticle: UIImageView!
    
    @IBOutlet weak var labelArticleContent: UILabel!
    
    @IBOutlet weak var labelLikes: UILabel!
    
    @IBOutlet weak var labelComments: UILabel!
    
    @IBOutlet weak var layoutHeightConstant: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK:- ViewModel Object set data to UI object using ViewModel
    var dataInfoModel: FeedsModel? {
        didSet{
            labelUserName.text = ("\(dataInfoModel?.name ?? "") \(dataInfoModel?.lastName ?? "")")
            labelDesignation.text = ("\(dataInfoModel?.designation ?? "")")
            labelArticleContent.text = dataInfoModel?.content
            let strLikes = "\(dataInfoModel?.likes ?? "0") likes"
            labelLikes.text = ("\(strLikes)")
            let strComments = "\(dataInfoModel?.comments ?? "0") comments"
            labelComments.text = ("\(strComments)")
            labelTimeCreated.text = ("\(dataInfoModel?.createdAt ?? "")")
            
            if let userUrl = dataInfoModel?.avatar{
                imageUser.layer.cornerRadius = imageUser.frame.height/2
                imageUser.clipsToBounds = true
                guard let url = URL(string: userUrl) else { return }
                let imgUser = ImageResource(downloadURL: url)
                imageUser.kf.setImage(with: imgUser, placeholder: nil, options: nil, progressBlock: nil) { (result) in
                }
            }
            
            if let mediaUrl = dataInfoModel?.image{
                if mediaUrl.count > 0{
                    layoutHeightConstant.constant = 162.0
                    guard let url = URL(string: mediaUrl) else { return }
                    let imgArticle = ImageResource(downloadURL: url)
                    imageArticle.kf.setImage(with: imgArticle, placeholder: nil, options: nil, progressBlock: nil) { (result) in
                    }
                }else{
                    layoutHeightConstant.constant = 0.0
                    imageArticle.image = nil
                }
            }
        }
    }
}
