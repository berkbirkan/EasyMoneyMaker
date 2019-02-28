//
//  VideoCell.swift
//  Easy Money Maker
//
//  Created by berk birkan on 16.02.2019.
//  Copyright © 2019 Turansoft. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {
    
    @IBOutlet weak var videolink: UILabel!
    
    @IBOutlet weak var videoimage: UIImageView!
    
    @IBOutlet weak var videoname: UILabel!
    
    
    @IBOutlet weak var videotext: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
