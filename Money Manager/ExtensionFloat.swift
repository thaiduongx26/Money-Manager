//
//  ExtensionFloat.swift
//  Money Manager
//
//  Created by ThaiDuong on 2/24/17.
//  Copyright © 2017 Thai Duong. All rights reserved.
//

import Foundation
extension Float{
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
