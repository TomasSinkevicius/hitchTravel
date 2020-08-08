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
    @IBOutlet weak var destinationEndLabel: UILabel!
    @IBOutlet weak var destinationStartLabel: UILabel!
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
        usernameLabel.text = post.author
        destinationStartLabel.text = post.startDestination
        destinationEndLabel.text = post.endDestination
        timeLabel.text = post.time
    }
    
}
