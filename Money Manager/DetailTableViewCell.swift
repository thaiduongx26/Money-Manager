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
    func setup1(){
        self.lblCategory.textColor = UIColor.gray
        self.lblContent.textColor = UIColor.black
        self.lblMoney.textColor = UIColor.gray
        self.lblAccount.textColor = UIColor.gray
    }
    func setup2(){
        self.lblCategory.textColor = UIColor.gray
        self.lblMoney.textColor = UIColor.gray
        self.lblAccount.textColor = UIColor.gray
    }
}
