//
//  AddInfoViewController.swift
//  Money Manager
//
//  Created by Thai Duong on 2/21/17.
//  Copyright © 2017 Thai Duong. All rights reserved.
//

import UIKit

protocol addInfo {
    func sendType(type: String)
    func sendData(name: String, index: String)
}

class AddInfoViewController: UIViewController , UITextViewDelegate , addInfo{
    internal func sendData(name: String,index : String) {
        if index == "Account" {
            arrFormView[1].lblTitle.text = name
        } else if index == "Category" {
            arrFormView[2].lblTitle.text = name
        }
    }

    
    internal func sendType(type: String) {
        self.lblTitle.text = type
        self.fillDataIndex(name: type)
    }
    
    @IBOutlet var contactTextField: MultiAutoCompleteTextField!
    
    @IBOutlet weak var memoTextView: UITextView!
    
    @IBOutlet var formView: UIView!
    
    @IBOutlet var titleView: UIView!
   
    @IBOutlet var typeView: UIView!
    
    @IBOutlet var lblTitle: UILabel!
    
    var delegate : detailVC? = nil
    
    var accountDB = DB.share().getAcc()
    
    let color = ["Income":"246EA8","Expense":"CA5548"]
    
    let type = ["Income","Expense"]
    
    let defaultView = "Expense"
    
    var arrFormView = [TypeView]()
    
    var arrViewType = [TypeView]()
    
    var arrIndex = [TypeView]()
    
    var accountView : SpecialView!
    
    var categoryIncomeView : SpecialView!
    
    var categoryExpenseView : SpecialView!
    
    var amountView : MiniCalculatorView!
    
    let currentDateTime = Date()
    
    // get the user's calendar
    let userCalendar = Calendar.current
    
    // choose which date and time components are needed
    let requestedComponents: Set<Calendar.Component> = [
        .year,
        .month,
        .day,
        .hour,
        .minute,
        .second
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setNeedsDisplay()
        self.setupBase()
        self.setupViewToShow()
        self.memoTextView.textColor = UIColor.gray
        self.contactTextField.textColor = UIColor.gray
        self.memoTextView.font = UIFont.systemFont(ofSize: 11)
        self.contactTextField.font = UIFont.systemFont(ofSize: 11)
        self.continueForm()
        let word = DB.share().getContent()
        contactTextField.autoCompleteStrings = word
        // Do any additional setup after loading the view.
    }
    
    func dismissAllFormView(){
        self.accountView.close()
        self.categoryExpenseView.close()
        self.categoryIncomeView.close()
        self.amountView.close()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupBase(){
        lblTitle.text = defaultView
        for index in 0...type.count - 1 {
            let view = Bundle.main.loadNibNamed("TypeView", owner: self, options: nil)?[0] as! TypeView
            view.frame.size = CGSize(width: self.typeView.frame.size.width / CGFloat(type.count), height: self.typeView.frame.size.height)
            view.frame.origin = CGPoint(x: CGFloat(index) * view.frame.size.width, y: 0)
            self.typeView.addSubview(view)
            view.lblTitle.text = type[index]
            view.delegate = self
            view.defaultView()
            arrViewType.append(view)
        }
        for view in arrViewType {
            let gesture = UITapGestureRecognizer(target: view, action:  #selector (view.someAction (_:)))
            view.addGestureRecognizer(gesture)
        }
        setupIndexView(name: self.defaultView)
    }
    
    func fillDataIndex(name:String){
        let typeName = DB.share().getTypeWithName(name:name)
        let tit = typeName.listIndex
        print("tit : \(arrIndex.count)")
        for i in 0...tit.count - 1 {
            arrIndex[i].lblTitle.text = tit[i].name!
        }
        arrFormView[2].type = name
        
        arrFormView[2].lblTitle.text = ""
        
    }
    
    func setupIndexView(name:String){
        let typeName = DB.share().getTypeWithName(name:name)
        let tit = typeName.listIndex
        for index in 0...tit.count - 1 {
            let view1 = Bundle.main.loadNibNamed("TypeView", owner: self, options: nil)?[0] as! TypeView
            view1.frame = CGRect(x: 0, y: CGFloat(index) * self.titleView.frame.size.height / CGFloat(tit.count), width: self.titleView.frame.size.width, height: self.titleView.frame.size.height / CGFloat(tit.count))
            view1.lblTitle.text = tit[index].name
            view1.lblTitle.font = UIFont.systemFont(ofSize: 11, weight: UIFontWeightThin)
            view1.lblTitle.textColor = UIColor.gray
            self.titleView.addSubview(view1)
            self.arrIndex.append(view1)
            switch tit[index].name {
            case "Date":
                let view2 = Bundle.main.loadNibNamed("FormView", owner: self, options: nil)?[0] as! TypeView
                view2.frame = CGRect(x: 0, y: CGFloat(index) * self.formView.frame.size.height / CGFloat(tit.count), width: self.formView.frame.size.width, height: self.formView.frame.size.height / CGFloat(tit.count))
                view2.lblTitle.text = self.getDate()
                view2.normal()
                view2.type = name
                view2.index = "Date"
                self.formView.addSubview(view2)
                self.arrFormView.append(view2)
                break
            
            case "Account":
                let view2 = Bundle.main.loadNibNamed("FormView", owner: self, options: nil)?[0] as! TypeView
                view2.frame = CGRect(x: 0, y: CGFloat(index) * self.formView.frame.size.height / CGFloat(tit.count), width: self.formView.frame.size.width, height: self.formView.frame.size.height / CGFloat(tit.count))
                view2.lblTitle.text = ""
                view2.normal()
                view2.type = name
                view2.index = "Account"
                self.formView.addSubview(view2)
                let gesture = UITapGestureRecognizer(target: view2, action:  #selector (view2.tapAction(_:)))
                view2.addGestureRecognizer(gesture)
                self.arrFormView.append(view2)
                break
            case "Category" :
                let view2 = Bundle.main.loadNibNamed("FormView", owner: self, options: nil)?[0] as! TypeView
                view2.frame = CGRect(x: 0, y: CGFloat(index) * self.formView.frame.size.height / CGFloat(tit.count), width: self.formView.frame.size.width, height: self.formView.frame.size.height / CGFloat(tit.count))
                view2.lblTitle.text = ""
                view2.normal()
                view2.type = name
                view2.index = "Category"
                self.formView.addSubview(view2)
                let gesture = UITapGestureRecognizer(target: view2, action:  #selector (view2.tapAction(_:)))
                view2.addGestureRecognizer(gesture)
                self.arrFormView.append(view2)
                break
            case "Amount" :
                let view2 = Bundle.main.loadNibNamed("FormView", owner: self, options: nil)?[0] as! TypeView
                view2.frame = CGRect(x: 0, y: CGFloat(index) * self.formView.frame.size.height / CGFloat(tit.count), width: self.formView.frame.size.width, height: self.formView.frame.size.height / CGFloat(tit.count))
                view2.lblTitle.text = ""
                view2.normal()
                view2.type = name
                view2.index = "Amount"
                self.formView.addSubview(view2)
                let gesture = UITapGestureRecognizer(target: view2, action:  #selector (view2.tapAction(_:)))
                view2.addGestureRecognizer(gesture)
                self.arrFormView.append(view2)
                break
            default: break
                
            }
            
        }
        print("count : \(self.arrIndex.count)")
    }
    
    
    func setupViewToShow() {
        self.accountView = Bundle.main.loadNibNamed("SpecialView", owner: self, options: nil)?[0] as! SpecialView
        self.accountView.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.height / 3)
        self.accountView.lblTitle.text = "Account"
        self.accountView.point = self.accountView.frame.origin
        
        var arrAcc : Array<String> = []
        for acc in accountDB {
            arrAcc.append(acc.name)
        }
        self.accountView.arr = arrAcc
        self.accountView.loadContains()
        self.view.addSubview(self.accountView)
        
        
        self.categoryIncomeView = Bundle.main.loadNibNamed("SpecialView", owner: self, options: nil)?[0] as! SpecialView
        self.categoryIncomeView.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.height / 3)
        self.categoryIncomeView.lblTitle.text = "Category"
        self.categoryIncomeView.point = self.categoryIncomeView.frame.origin
        
        let typeIncome = DB.share().getTypeWithName(name: "Income")
        
        var arrIncome : Array<String> = []
        for acc in typeIncome.listCategory {
            arrIncome.append(acc.name)
        }
        self.categoryIncomeView.arr = arrIncome
        self.categoryIncomeView.loadContains()
        self.view.addSubview(self.categoryIncomeView)
        
        self.categoryExpenseView = Bundle.main.loadNibNamed("SpecialView", owner: self, options: nil)?[0] as! SpecialView
        self.categoryExpenseView.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.height / 3)
        self.categoryExpenseView.lblTitle.text = "Category"
        self.categoryExpenseView.point = self.categoryExpenseView.frame.origin
        
        let typeExpense = DB.share().getTypeWithName(name: "Expense")
        
        var arrExpense : Array<String> = []
        for acc in typeExpense.listCategory {
            arrExpense.append(acc.name)
        }
        self.categoryExpenseView.arr = arrExpense
        self.categoryExpenseView.loadContains()
        self.view.addSubview(self.categoryExpenseView)
        
        self.amountView = Bundle.main.loadNibNamed("MiniCalculatorView", owner: self, options: nil)?[0] as! MiniCalculatorView
        self.amountView.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.height / 3)
        self.amountView.lblTitle.text = "Amount"
        self.amountView.point = self.amountView.frame.origin
        self.view.addSubview(self.amountView)
        self.amountView.lblText = self.arrFormView[3].lblTitle
    }
    
    @IBAction func backButtonDidTap(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getDate() -> String {
        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        
        print(dateTimeComponents.year!)
        print(dateTimeComponents.month!)
        print(dateTimeComponents.day!)
        
        return String(dateTimeComponents.month!) + "/" + String(dateTimeComponents.day!) + "/" + String(dateTimeComponents.year!)
    }
    
    
    @IBAction func saveButtonDidTap(_ sender: UIButton) {
        var text = arrFormView[3].lblTitle.text!
        if (text[text.length-3] != "." && text[text.length-2] != "." && text[text.length-1] != ".") {
            text = text + ".00"
        } else if text[text.length-1] == "."{
            text = text + "00"
        } else if text[text.length-2] == "."{
            text = text + "0"
        }
        arrFormView[3].lblTitle.text! = text
        
        
        if check() {
            var boo = true
            let arrDay = DB.share().getDay()
            for day in arrDay {
                if arrFormView[0].lblTitle.text == day.day {
                    boo = false
                }
            }
            if boo {
                let day = Day()
                day.day = arrFormView[0].lblTitle.text!
                DB.share().saveDay(day:day)
            }
            let record = Record()
            record.name = self.lblTitle.text!
            record.date = arrFormView[0].lblTitle.text!
            record.account = arrFormView[1].lblTitle.text!
            record.category = arrFormView[2].lblTitle.text!
            record.amount = arrFormView[3].lblTitle.text!
            record.content = self.contactTextField.text!
            if self.contactTextField.text != "" {
                let content = Content()
                content.content = self.contactTextField.text
                DB.share().saveContent(content: content)
            }
            record.memo = self.memoTextView.text!
            DB.share().saveRecord(record: record)
            delegate?.reload()
            self.dismiss(animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: "Ops!!", message: "Thiếu rồi !", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func continueButtonDidTap(_ sender: UIButton) {
        self.continueForm()
    }
    
    
    func continueForm(){
        self.dismissKeyboard()
        print(arrFormView.count)
        var boo = true
        for i in 1...arrFormView.count - 1 {
            if arrFormView[i].lblTitle.text == "" {
                arrFormView[i].actionForTap()
                boo = false
                break
            }
        }
        if boo {
            if self.contactTextField.text == "" {
                self.contactTextField.becomeFirstResponder()
                self.dismissAllFormView()
            } else if self.memoTextView.text == "" {
                self.memoTextView.becomeFirstResponder()
                self.dismissAllFormView()
            } else {
                self.dismissAllFormView()
                self.dismissKeyboard()
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.dismissAllFormView()
        print(contactTextField.text!)
    }
    
    
    func check() -> Bool{
        var boo = true
        for i in arrFormView {
            if i.lblTitle.text == ""{
                boo = false
            }
        }
        return boo
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
