//
//  DetailViewController.swift
//  Money Manager
//
//  Created by Thai Duong on 2/20/17.
//  Copyright © 2017 Thai Duong. All rights reserved.
//

import UIKit
protocol detailVC {
    func reload()
}
class DetailViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource , detailVC{
    internal func reload(){
        dataDay = DB.share().getDay()
        tableDataView.reloadData()
        print(3333)
    }
    @IBOutlet var switchView: UIView!
    
    @IBOutlet var tableDataView: UITableView!
    
    var dataDay = DB.share().getDay()
    
    var arrView = [BaseViewChoose]()
    let arrSwitchView : [String] = ["Daily","Calenda","Weekly","Monly","Total"]
    
    let dayInWeek : Dictionary<Int,String> = [2:"Monday",3:"Tuesday",4:"Wednesday",5:"Thursday",6:"Friday",7:"Saturday",1:"Sunday"]
    
    var defaultView = "Daily"
    override func viewDidLoad() {
        print(dataDay)
        print(DB.share().getRecord())
        super.viewDidLoad()
        
        print(self.getDayOfWeek("2/27/2017")!)
        view.setNeedsLayout()
        view.layoutIfNeeded()
        setupEmptyBackgroundView()
        setupSwitchView()
        createButton()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataDay.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (DB.share().getRecordWithDay(day: dataDay[section].day!).count == 0) {
            tableView.separatorStyle = .none
            tableView.backgroundView?.isHidden = false
        } else {
            tableView.separatorStyle = .singleLine
            tableView.backgroundView?.isHidden = true
        }
        return DB.share().getRecordWithDay(day: dataDay[section].day!).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let arrDay = DB.share().getDay()
        let dataRecord = DB.share().getRecordWithDay(day: arrDay[indexPath.section].day)
        let dataCell = dataRecord[indexPath.row]
        let cell : DetailTableViewCell!
        if dataCell.content == "" {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! DetailTableViewCell
            cell.lblCategory.text = dataCell.category
            cell.lblAccount.text = dataCell.account
            cell.lblMoney.text = dataCell.amount
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! DetailTableViewCell
            cell.lblCategory.text = dataCell.category
            cell.lblAccount.text = dataCell.account
            cell.lblMoney.text = dataCell.amount
            cell.lblContent.text = dataCell.content
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let date = dataDay[section].day!
        
        var day : String!
        var month : String!
        var year : String!
        var index = 0
        for i in 0...date.length-1{
            if date[i] == "/" && index == 0 {
                month = date[0..<i]
                if month.length == 1 {
                    month = "0" + month
                }
                index = i
            } else if date[i] == "/" && index != 0 {
                day = date[index+1..<i]
                year = date[i+1..<date.length]
            }
        }
        let view1 = Bundle.main.loadNibNamed("HeaderSectionView", owner: self, options: nil)?[0] as! HeaderSectionView
        view1.lblDate.text = month + "/" + year
        view1.lblDay.text = day
        view1.lblDayInWeek.text = dayInWeek[self.getDayOfWeek(dataDay[section].day!)!]
        let dataIncome = DB.share().getRecordWithTypeAndDate(type: "Income", date: date)
        let dataExpense = DB.share().getRecordWithTypeAndDate(type: "Expense", date: date)
        var moneyIncome : Float! = 0.00
        var moneyExpense : Float! = 0.00
        for data in dataIncome {
            moneyIncome = moneyIncome + Float(data.amount)!
        }
        for data in dataExpense {
            moneyExpense = moneyExpense + Float(data.amount)!
        }
        view1.lblIncome.text = String(moneyIncome)
        view1.lblExpense.text = String(format:"%2f",moneyExpense)
        view1.frame.origin = CGPoint(x: 0, y: 0)
        //view1.frame.size = CGSize(width: 20, height: 10)
        //print(tableView.estimatedSectionHeaderHeight)
        view1.setup()
        return view1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }
    
    func setupEmptyBackgroundView() {
        let view1 = UIView(frame: tableDataView.frame)
        view1.backgroundColor = UIColor.clear
        let image = UIImageView(image: UIImage(named: "empty_icon.png"))
        let label = UILabel()
        image.frame.size = CGSize(width: 80 , height: 80)
        image.center.x = self.view.frame.size.width / 2
        image.center.y = 90
        label.text = "No data avalable"
        label.font = UIFont(name: "System", size: 17)
        label.sizeToFit()
        label.center.x = image.center.x
        label.center.y = image.center.y + 80
        view1.addSubview(image)
        view1.addSubview(label)
        tableDataView.backgroundView = view1
    }
    
    func setupSwitchView(){
        for title in 0...arrSwitchView.count - 1 {
            let view1 = Bundle.main.loadNibNamed("BaseViewChoose", owner: self, options: nil)?[0] as?
            
            BaseViewChoose
            view1?.frame.size = CGSize(width: switchView.frame.size.width / CGFloat(arrSwitchView.count), height: switchView.frame.size.height)
            view1?.frame.origin = CGPoint(x: CGFloat(title) * (view1?.frame.size.width)!, y: 0)
            view1?.lblTitle.text = arrSwitchView[title]
            view1?.defaultiew()
            arrView.append(view1!)
            
            switchView.addSubview(view1!)
            let gesture = UITapGestureRecognizer(target: view1, action:  #selector (view1?.someAction (_:)))
            view1?.addGestureRecognizer(gesture)
        }
        
        for view in arrView {
            if view.lblTitle.text == defaultView {
                view.setupBeChoose()
            }
        }
    }
    
    func createButton(){
        let button = UIButton(frame: CGRect(x: self.view.frame.size.width - 60, y:self.view.frame.size.height - 60 , width: 50, height: 50))
        button.backgroundColor = UIColor.orange
        button.setImage(UIImage(named:"add.png"), for: .normal)
        button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(DetailViewController.addButtonDidTap(_:)), for: .touchUpInside)
        button.circle()
        self.view.addSubview(button)
    }
    
    func addButtonDidTap(_ sender : UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddVC") as! AddInfoViewController
        vc.delegate = self as! detailVC
        self.present(vc, animated: true, completion: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func getDayOfWeek(_ today:String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
}
