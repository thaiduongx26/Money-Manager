//
//  DB.swift
//  Money Manager
//
//  Created by Thai Duong on 2/20/17.
//  Copyright © 2017 Thai Duong. All rights reserved.
//

import Foundation
import RealmSwift
class DB {
    
    let realm = try! Realm()
    
    let typeDic : Dictionary<String,[String]> = ["Income":["Date","Account","Category","Amount","Content"],"Expense":["Date","Account","Category","Amount","Content"]]
    
    let account = ["Cash","Account","Card"]
    
    let category : Dictionary<String,[String]> = ["Income":["Allowance","Salary","petty cash","Bonus","Other"],"Expense":["Food","Social Life","Self-development","Transportation","Culture","Household","Apparel","Beauty","Health","Education","Gift","Other"]]
    
    class func share() -> DB{
        let db = DB()
        return db
    }
    
    func parseDataFirstRun(){
        let nameType = Array(typeDic.keys)
        for name in 0...nameType.count-1{
            let type = Type()
            type.typeSub = nameType[name]
            let arr = typeDic[nameType[name]]!
            for i in 0...arr.count - 1{
                let index = Index()
                index.name = arr[i]
                type.listIndex.append(index)
            }
            
            let arrCate = category[nameType[name]]!
            for j in 0...arrCate.count - 1{
                let category = Category()
                category.name = arrCate[j]
                type.listCategory.append(category)
            }
            self.saveType(type: type)
        }
        for acc in 0...account.count-1{
            let account1 = Account()
            account1.name = account[acc]
            self.saveAccount(acc: account1)
        }
    }
    
    func saveAccount(acc : Account) {
        try! realm.write {
            realm.add(acc)
        }
    }
    
    func saveRecord(record : Record){
        try! realm.write {
            realm.add(record)
        }
    }
    
    func saveType(type : Type){
        try! realm.write {
            realm.add(type)
        }
    }
    func saveDay(day : Day){
        try! realm.write {
            realm.add(day)
        }
    }
    
    func getAcc() -> Results<Account>{
        return realm.objects(Account.self)
    }
    
    func getType() -> Results<Type>{
        return realm.objects(Type.self)
    }
    
    func getRecord() -> Results<Record>{
        return realm.objects(Record.self)
    }
    
    func getRecordWithDay(day: String) -> Results<Record>{
        return realm.objects(Record.self).filter("date = %@",day)
    }
    
    func getRecordWithType(type:String) -> Results<Record> {
        return realm.objects(Record.self).filter("name = %@",type)
    }
    
    func getRecordWithTypeAndDate(type : String , date: String) -> Results<Record>{
        return realm.objects(Record.self).filter("name = %@ AND date = %@",type,date)
    }
    
    func getTypeWithName(name:String!) -> Type{
        return realm.objects(Type.self).filter("typeSub = %@",name).first!
    }
    
    func getDay() -> Results<Day> {
        return realm.objects(Day.self)
    }
    
    //func getRecordWithDay(type : String!) -> Re
}
