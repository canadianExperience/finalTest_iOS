//
//  CustomTableViewCell.swift
//  bmi
//
//  Created by Elena Melnikova on 2018-12-13.
//  Copyright © 2018 Centennial College. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    var bmiData: BMIData = BMIData()
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblBmi: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }
}
