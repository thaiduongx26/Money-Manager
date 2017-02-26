//
//  TypeView.swift
//  Money Manager
//
//  Created by Thai Duong on 2/21/17.
//  Copyright © 2017 Thai Duong. All rights reserved.
//

import UIKit

class TypeView: UIView {

    @IBOutlet var lblTitle: UILabel!
    
    var type : String? = nil
    
    var index : String? = nil
    
    var delegate : addInfo? = nil
    
    
    func someAction(_ sender: UITapGestureRecognizer){
        let vc = self.parentViewController as! AddInfoViewController
        var color : String!
        vc.categoryIncomeView.close()
        vc.accountView.close()
        vc.categoryExpenseView.close()
        vc.amountView.close()
        for type in vc.type {
            if lblTitle.text == type {
                color = vc.color[type]!
            }
        }
        choose(color: color)
        self.delegate?.sendType(type: self.lblTitle.text!)
        for view in vc.arrViewType {
            if view.lblTitle.text != self.lblTitle.text{
                view.normal()
            }
        }
        vc.continueForm()
    }
    
    func tapAction(_ sender:UITapGestureRecognizer){
            self.actionForTap()
    }
    
    func actionForTap(){
        let vc = self.parentViewController as! AddInfoViewController
        vc.dismissKeyboard()
        if index == "Account"{
            vc.accountView.frame.origin.y = vc.view.frame.size.height * 2 / 3
            vc.categoryExpenseView.close()
            vc.categoryIncomeView.close()
            vc.amountView.close()
        } else {
            if type == "Income" && index == "Category" {
                vc.categoryIncomeView.frame.origin.y = vc.view.frame.size.height * 2 / 3
                vc.accountView.close()
                vc.categoryExpenseView.close()
                vc.amountView.close()
            } else if type == "Expense" && index == "Category"{
                vc.categoryExpenseView.frame.origin.y = vc.view.frame.size.height * 2 / 3
                vc.accountView.close()
                vc.categoryIncomeView.close()
                vc.amountView.close()
            } else if index == "Amount" {
                vc.amountView.frame.origin.y = vc.view.frame.size.height * 2 / 3
                vc.accountView.close()
                vc.categoryExpenseView.close()
                vc.categoryIncomeView.close()
            }
        }

    }
    
    func fillDataAction(_ sender : UITapGestureRecognizer){
        self.delegate = self.parentViewController as! addInfo?
        self.delegate?.sendData(name: self.lblTitle.text!, index: self.index!)
        let vc = self.parentViewController as! AddInfoViewController
        vc.continueForm()
    }
    
    func defaultView(){
        let vc = self.parentViewController as! AddInfoViewController
        if self.lblTitle.text == vc.defaultView {
            choose(color: vc.color[vc.defaultView]!)
        }else{
            normal()
        }
    }

    func normal(){
        self.lblTitle.textColor = UIColor.gray
        self.backgroundColor = UIColor.white
    }
    
    func choose(color : String){
        self.lblTitle.textColor = UIColor.white
        self.backgroundColor = UIColor.hexStringToUIColor(hex:color)
        
    }
    
}
