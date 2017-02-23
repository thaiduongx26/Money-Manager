//
//  BaseViewChoose.swift
//  Money Manager
//
//  Created by Thai Duong on 2/20/17.
//  Copyright © 2017 Thai Duong. All rights reserved.
//

import UIKit

class BaseViewChoose: UIView {

    @IBOutlet var lblTitle: UILabel!
    
    @IBOutlet var lightView: UIView!
    
    func someAction(_ sender : UITapGestureRecognizer){
        self.lblTitle.font = UIFont.systemFont(ofSize: 11, weight: UIFontWeightRegular)
//        self.lblTitle.font.withSize(3)
//        self.lblTitle.sizeToFit()
        self.lightView.backgroundColor = UIColor.white
        let vc = self.parentViewController as! DetailViewController
        for tit in vc.arrView {
            if tit.lblTitle.text != self.lblTitle.text {
                tit.defaultiew()
            }
        }
    }
    
    func defaultiew(){
        self.lblTitle.font = UIFont.systemFont(ofSize: 11, weight: UIFontWeightThin)
        self.lightView.backgroundColor = self.backgroundColor
    }
    
    func setupBeChoose() {
        self.lblTitle.font = UIFont.systemFont(ofSize: 11, weight: UIFontWeightRegular)
        self.lightView.backgroundColor = UIColor.white
    }
    
    
}

