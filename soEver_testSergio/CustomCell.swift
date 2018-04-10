//
//  CustomCell.swift
//  soEver_testSergio
//
//  Created by Ruben Dominguez on 3/4/18.
//  Copyright © 2018 Jorge. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell, ReuseIdentifierInterface {
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImageView : UIImageView!
    @IBOutlet weak var myName : UILabel!
    @IBOutlet weak var myPrice : UILabel!
    @IBOutlet weak var myDate : UILabel!
    @IBOutlet weak var mySummary : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}


