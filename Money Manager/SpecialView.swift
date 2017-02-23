//
//  SpecialView.swift
//  Money Manager
//
//  Created by ThaiDuong on 2/22/17.
//  Copyright © 2017 Thai Duong. All rights reserved.
//

import UIKit
import RealmSwift
class SpecialView: UIView {
    
    var point : CGPoint!
    
    var arr : Array<String>!

    @IBOutlet var titleView: UIView!

    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var closeButton: UIButton!
    
    @IBAction func closeButtonDidTap(_ sender: UIButton) {
        self.close()
    }
    
    func close(){
        self.frame.origin = point
    }
    
    func loadContains(){
        if arr != nil {
            for i in 0...arr.count - 1 {
                let view1 = Bundle.main.loadNibNamed("TypeView", owner: self, options: nil)?[0] as! TypeView
                view1.lblTitle.text = arr[i]
                view1.frame.size = CGSize(width: self.frame.width / 3 , height: 35)
                view1.frame.origin = CGPoint(x: CGFloat(i % 3) * view1.frame.size.width, y: CGFloat(Int(i / 3)) * view1.frame.size.height + self.titleView.frame.size.height)
                view1.normal()
                view1.index = self.lblTitle.text
                self.addSubview(view1)
                let gesture = UITapGestureRecognizer(target: view1, action:  #selector (view1.fillDataAction(_:)))
                view1.addGestureRecognizer(gesture)
            }
        }
    }
    
    
    
}
