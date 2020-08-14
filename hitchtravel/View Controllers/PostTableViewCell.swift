//
//  PostTableViewCell.swift
//  hitchtravel
//
//  Created by Macbook Pro on 2020-08-06.
//  Copyright © 2020 Tomas Sinkevicius. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var endPointLabel: UILabel!
    @IBOutlet weak var startPointLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
        profileImageView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(post: Post){
        print("its working")
        let username = post.author.firstName + " " + post.author.lastName
        usernameLabel.text = username
        startPointLabel.text = post.startPoint
        endPointLabel.text = post.endPoint
        timeLabel.text = post.time
    }
    
}
