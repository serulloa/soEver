//
//  CustomBookCell.swift
//  soEver_testSergio
//
//  Created by Ruben Dominguez on 3/4/18.
//  Copyright © 2018 Jorge. All rights reserved.
//

import UIKit

class CustomBookCell: UITableViewCell, ReuseIdentifierInterface {
    
    //MARK: - IBOutlets
    @IBOutlet weak var myBookImg: UIImageView!
    @IBOutlet weak var myBookTitle: UILabel!
    @IBOutlet weak var myBookAuthor: UILabel!
    @IBOutlet weak var myBookDate: UILabel!
    @IBOutlet weak var myBookGenre: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
