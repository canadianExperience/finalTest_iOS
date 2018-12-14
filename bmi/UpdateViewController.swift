//
//  UpdateViewController.swift
//  bmi
//
//  Created by Elena Melnikova on 2018-12-14.
//  Copyright © 2018 Centennial College. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController {
    
    @IBOutlet weak var lblWeight: UITextField!
    
    var bmiIn: BMIData = BMIData()
    var uomMetricIn: Bool = true
    var db: DB = DB()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        let savedDB = defaults.string(forKey: "db") ?? ""
        db = DB.fromJson(jsonString: savedDB)
        var weight = bmiIn.weight
        if !uomMetricIn {
            weight = DB.kgToLb(weight)
        }
        lblWeight.text = String(weight)
    }
    
    @IBAction func btnUpdate(_ sender: UIButton) {
        for bmi in db.bmi {
            if bmi.date == bmiIn.date {
                let weight = Float(lblWeight.text!)!
                if !uomMetricIn {
                    bmi.weight = DB.lbToKg(weight)
                } else {
                    bmi.weight = weight
                }

                bmi.calcBMI()
                
                let defaults = UserDefaults.standard
                let json = db.toJson()
                defaults.set(json, forKey: "db")
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
