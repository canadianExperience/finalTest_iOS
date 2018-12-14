//
//  ViewController.swift
//  bmi
//
//  Created by Elena Melnikova on 2018-12-13.
//  Copyright © 2018 Centennial College. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var txtAge: UITextField!
    
    @IBOutlet weak var txtGender: UITextField!
    
    @IBOutlet weak var txtWeight: UITextField!
    
    @IBOutlet weak var txtHeight: UITextField!
    
    @IBOutlet weak var txtBmi: UILabel!
    
    
    @IBOutlet weak var txtMessage: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onCalculateBmi(_ sender: UIButton) {
    }
    
    @IBAction func onBmiTrackingScreen(_ sender: UIButton) {
    }
}

