//
//  PostCell.swift
//  Poster
//
//  Created by Akif Acar on 21.04.2022.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var bodyLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var postImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //set the postcell backgroundcolor to the backgroundcolor of the main view so that to avoid the color switch to white when the cell is selected.
        contentView.backgroundColor = UIColor(named: "BackgroundDark")!
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
