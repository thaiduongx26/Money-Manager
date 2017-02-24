//
//  HeaderSectionView.swift
//  Money Manager
//
//  Created by ThaiDuong on 2/23/17.
//  Copyright © 2017 Thai Duong. All rights reserved.
//

import UIKit

class HeaderSectionView: UIView {

    @IBOutlet var lblDay: UILabel!
    
    @IBOutlet var lblDate: UILabel!

    @IBOutlet var lblDayInWeek: UILabel!
    
    @IBOutlet var lblExpense: UILabel!
    
    @IBOutlet var lblIncome: UILabel!
    
    func setup(){
        lblDate.textColor = UIColor.gray
    }
    
    
    
}
