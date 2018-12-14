//
//  ViewController.swift
//  bmi
//
//  Created by Elena Melnikova on 2018-12-13.
//  Copyright © 2018 Centennial College. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var switchMetric: UISwitch!
    @IBOutlet weak var txtWeight: UITextField!
    @IBOutlet weak var txtHeight: UITextField!
    @IBOutlet weak var txtMessage: UILabel!
    @IBOutlet weak var txtBmi: UILabel!
    var db: DB = DB()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        let savedDB = defaults.string(forKey: "db") ?? ""

        switchMetric.setOn(true, animated: true)
        if !savedDB.isEmpty {
            db = DB.fromJson(jsonString: savedDB)
            txtName.text = db.name
            txtAge.text = String(db.age)
            txtGender.text = db.genderMale ? "male" : "female"
            
            let lastIndex = db.bmi.count - 1
            if lastIndex >= 0 {
                txtWeight.text = String(db.bmi[lastIndex].weight)
                txtHeight.text = String(db.bmi[lastIndex].height)
                txtBmi.text = String(db.bmi[lastIndex].bmi)
            }
            
            
            let UOM = UserDefaults.standard.string(forKey: "UOM") ?? ""
            if UOM.isEmpty {
                switchMetric.setOn(true, animated: true)
            } else {
                if UOM == "imperial" {
                    switchMetric.setOn(false, animated: true)
                }
            }
        }

    }
    
    @IBAction func btnCalculate(_ sender: UIButton) {
        //Date
        let date = datePicker.date
        
        //Name
        let name = txtName.text ?? ""
        if name.isEmpty {
            txtMessage.text = "Name should not be empty"
            return
        }
        
        //Age
        let age = txtAge.text ?? ""
        var ageInt: Int
        if age.isEmpty {
            txtMessage.text = "Name should not be empty"
            return
        }
        do {
            try ageInt = Int(age)!
        } catch {
            txtMessage.text = "Age should be numeric"
            return
        }
        
        //Gender
        let gender = txtGender.text ?? ""
        if gender.isEmpty {
            txtMessage.text = "Gender should not be empty"
            return
        }
        if gender != "male" && gender != "female" {
            txtMessage.text = "Gender should be either 'male' or 'felmale'"
            return
        }
        
        //Weight
        let weight = txtWeight.text ?? ""
        var weightFloat: Float
        if weight.isEmpty {
            txtMessage.text = "Weight should not be empty"
            return
        }
        do {
            try weightFloat = Float(weight)!
        } catch {
            txtMessage.text = "Weight should be numeric"
            return
        }
        
        //Height
        let height = txtHeight.text ?? ""
        var heightFloat: Float
        if height.isEmpty {
            txtMessage.text = "Height should not be empty"
            return
        }
        do {
            try heightFloat = Float(height)!
        } catch {
            txtMessage.text = "Height should be numeric"
            return
        }
        
        //Data collected, populate object
        db.name = name
        db.age = ageInt
        db.genderMale = gender == "male"
        
        //Populate bmi
        var bmi = BMIData()
        bmi.setDate(date: date)
        if switchMetric.isOn {
            bmi.setHeightM(height: heightFloat)
            bmi.setWeightKG(weight: weightFloat)
        } else {
            bmi.setHeightInch(height: heightFloat)
            bmi.setWeightLB(weight: weightFloat)
        }
        bmi.calcBMI()
        txtMessage.text = bmi.getMsg()
        
        //Save data
        //db.bmi.append(bmi)
        db.overwrite(bmiData: bmi)
        let json = db.toJson()
        let defaults = UserDefaults.standard
        defaults.set(json, forKey: "db")

    }
    

    

    @IBAction func cangeUOM(_ sender: UISwitch) {
        let defaults = UserDefaults.standard
        if switchMetric.isOn {
            defaults.set("metric", forKey: "UOM")
        } else {
            defaults.set("imperial", forKey: "UOM")
        }
    }
    
    @IBAction func btnNext(_ sender: UIButton) {
    }
}

