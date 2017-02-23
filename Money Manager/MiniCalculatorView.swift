//
//  MiniCalculatorView.swift
//  Money Manager
//
//  Created by Thai Duong on 2/22/17.
//  Copyright © 2017 Thai Duong. All rights reserved.
//

import UIKit

class MiniCalculatorView: UIView {
    
    var point : CGPoint!
    
    var lblText : UILabel!
    
    @IBOutlet var lblTitle: UILabel!
   
    @IBAction func closeButtonDidTap(_ sender: UIButton) {
        self.close()
    }
    
    func close(){
        self.frame.origin = point
        
    }
    @IBAction func dotDidTap(_ sender: UIButton) {
        var text = lblText.text!
        var boo = true
        for i in 0...text.length-1{
            if text[i] == "." {
                boo = false
            }
        }
        if boo {
            text = text + "."
        }
        lblText.text = text
    }
    @IBAction func deleteOneWord(_ sender: UIButton) {
        var text = lblText.text!
        if text.length != 0 {
            text = text[0..<text.length-1]
        }
        lblText.text = text
    }
    
    @IBAction func numberDidTap(_ sender: UIButton) {
        var text = lblText.text!
        if text[text.length-3] == "." {
            text = text[0..<text.length-1] + (sender.titleLabel?.text)!
        } else {
            text = text + (sender.titleLabel?.text)!
        }
        lblText.text = text
    }
    @IBAction func subtractionDidTap(_ sender: UIButton) {
        var text = lblText.text!
        if text[0] == "-" {
            text = text[1..<text.length]
        } else {
            text = "-" + text
        }
        lblText.text = text
    }
    
    @IBAction func doneDidTap(_ sender: UIButton) {
        let vc = self.parentViewController as! AddInfoViewController
        vc.continueForm()
    }
    
}
