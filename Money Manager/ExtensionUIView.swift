//
//  ExtensionUIView.swift
//  Money Manager
//
//  Created by Thai Duong on 2/21/17.
//  Copyright © 2017 Thai Duong. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    func circle(){
        self.layer.cornerRadius = self.frame.size.width/2
    }
    
    func corner(){
        self.layer.cornerRadius = 5
    }
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
