//
//  LeftMenuCell.swift
//  Easy Money Maker
//
//  Created by berk birkan on 17.02.2019.
//  Copyright © 2019 Turansoft. All rights reserved.
//

import UIKit

class LeftMenuCell: UITableViewCell {
    
    
    @IBOutlet weak var menuimage: UIImageView!
    
    
    @IBOutlet weak var menutext: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
