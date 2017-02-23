//
//  DetailTableViewCell.swift
//  Money Manager
//
//  Created by ThaiDuong on 2/23/17.
//  Copyright © 2017 Thai Duong. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet var lblCategory: UILabel!
    
    @IBOutlet var lblContent: UILabel!
    
    @IBOutlet var lblAccount: UILabel!
    
    @IBOutlet var lblMoney: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
