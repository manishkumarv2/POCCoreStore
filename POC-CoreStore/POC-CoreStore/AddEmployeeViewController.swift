//
//  AddEmployeeViewController.swift
//  POC-CoreStore
//
//  Created by Manish Kumar on 7/3/17.
//  Copyright © 2017 v2solutions. All rights reserved.
//

import Foundation
import UIKit

class AddEmployeeViewController: UIViewController {
    
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    
    @IBOutlet weak var birthDateTxt: UITextField!
    @IBOutlet weak var genderSwitch: UISwitch!
    @IBOutlet weak var empNumberTxt: UITextField!
    @IBOutlet weak var salaryTxt: UITextField!
    @IBOutlet weak var genderLbl: UILabel!
    
    @IBOutlet weak var departmentTxt: UITextField!
    
    let departments: [String] = ["Mobile","Web","Contant","Server","HR","Admin"]
    
    var gender: Int16 = 1
    var birthDate:NSDate = NSDate()
    
    let maleColor:UIColor = UIColor(red: 37.0/255.0, green: 79.0/255.0, blue: 137.0/255.0, alpha: 1.0)
    let femaleColor:UIColor = UIColor(red: 255.0/255.0, green: 79.0/255.0, blue: 137.0/255.0, alpha: 1.0)
    
    var empDic = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addToolBar ()
    }
    
    @IBAction func createEmployee(_ sender: Any) {
       let uuid = UUID().uuidString
        
        empDic = ["id":uuid,
                 "fName": firstNameTxt.text,
                  "lName": lastNameTxt.text ,
                  "bod": birthDate,
                  "gender": gender,
                  "salary": salaryTxt.text?.hashValue,
                  "empNumber": Int16(empNumberTxt.text!),
                  "department": departmentTxt.text
        ]
        
        AppDataStack.createEmployee(person: empDic)
    }
    
    func addToolBar () {

        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.black
        
        toolBar.tintColor = UIColor.white
        
        toolBar.backgroundColor = UIColor.black
        
        
        let todayBtn = UIBarButtonItem(title: "Today", style: UIBarButtonItemStyle.plain, target: self, action: #selector(AddEmployeeViewController.tappedToolBarBtn))
        
        let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(AddEmployeeViewController.donePressed))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Helvetica", size: 12)
        
        label.backgroundColor = UIColor.clear
        
        label.textColor = UIColor.white
        
        label.text = "Select a Birth date"
        
        label.textAlignment = NSTextAlignment.center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        toolBar.setItems([todayBtn,flexSpace,textBtn,flexSpace,okBarBtn], animated: true)
        
        birthDateTxt.inputAccessoryView = toolBar
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func donePressed(sender: UIBarButtonItem) {
        birthDateTxt.resignFirstResponder()
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func tappedToolBarBtn(sender: UIBarButtonItem) {
        
        let dateformatter = DateFormatter()
        
        dateformatter.dateStyle = DateFormatter.Style.medium
        
        dateformatter.timeStyle = DateFormatter.Style.none
        
        birthDateTxt.text = dateformatter.string(from: NSDate() as Date)
        
        birthDateTxt.resignFirstResponder()
    }

    
    @IBAction func textFieldEditing(sender: UITextField) {
        
        if sender.tag == 10 {
            let datePickerView: UIDatePicker = UIDatePicker()
            datePickerView.datePickerMode = UIDatePickerMode.date
            sender.inputView = datePickerView
            datePickerView.addTarget(self, action: #selector(AddEmployeeViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
        }else if sender.tag == 20 {
            let pickerView: UIPickerView = UIPickerView()
            pickerView.dataSource = self
            pickerView.delegate = self
            sender.inputView = pickerView
        }
        
    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        birthDateTxt.text = dateFormatter.string(from: sender.date)
        
        birthDate = sender.date as NSDate
    }
    
    @IBAction func genderChanged(_ sender: UISwitch, forEvent event: UIEvent) {
        
        if sender.isOn {
            genderLbl.text = "Male"
            gender = 1
        } else {
            genderLbl.text = "Female"
            gender = 0
        }
    }
}

extension AddEmployeeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return departments.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return departments[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        departmentTxt.text = departments[row]
    }
}

