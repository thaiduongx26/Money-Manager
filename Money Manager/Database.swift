//
//  Database.swift
//  Money Manager
//
//  Created by Thai Duong on 2/20/17.
//  Copyright © 2017 Thai Duong. All rights reserved.
//

import Foundation
import RealmSwift

class Record : Object {
    dynamic var name : String!
    dynamic var date : String!
    dynamic var account : String!
    dynamic var category : String!
    dynamic var amount : String!
    dynamic var content : String! = ""
    dynamic var memo : String! = ""
}

class Day: Object {
    dynamic var day : String!
}

class Type : Object {
    dynamic var typeSub : String = ""
    let listIndex = List<Index>()
    let listCategory = List<Category>()
}


class Index : Object {
    dynamic var name :String!
}

class Account:Object {
    dynamic var name :String!
}

class Category: Object {
    dynamic var name :String!
}

class Content: Object {
    dynamic var content : String!
}

class Memo: Object {
    dynamic var memo : String!
}
