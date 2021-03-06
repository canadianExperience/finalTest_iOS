//
//  DB.swift
//  bmi
//
//  Created by Elena Melnikova on 2018-12-13.
//  Copyright © 2018 Centennial College. All rights reserved.
//

import Foundation
import UIKit

class DB: Codable {
    var name: String = ""
    var age: Int = 0
    var genderMale: Bool = true
    var bmi: [BMIData] = []
    
    func overwrite(bmiData: BMIData) {
        var isFound = false
        for i in 0..<self.bmi.count {
            if bmi[i].date == bmiData.date {
                self.bmi[i] = bmiData
                isFound = true
                break
            }
        }
        
        if !isFound {
            self.bmi.append(bmiData)
        }
    }
    
    func toJson() -> String {
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(self)
            let jsonString = String(data: jsonData, encoding: .utf8)
            print("JSON String : " + jsonString!)
            return jsonString!
        }
        catch {
        }
        return ""
    }
    
    static func fromJson(jsonString: String) -> DB{
        if let jsonData = jsonString.data(using: .utf8)
        {
            let decoder = JSONDecoder()
            
            do {
                let db = try decoder.decode(DB.self, from: jsonData)
                print(db)
                return db
            } catch {
                print(error.localizedDescription)
            }
        }
        return DB()
    }
    
    func getBMIDateByDate(date: String)->BMIData {
        for bmiData in self.bmi {
            if bmiData.date == date {
                return bmiData
            }
        }
        return BMIData()  //Should never be called
    }
    
    static func kgToLb(_ kg: Float) -> Float {
        return kg / 0.45359237
    }
    
    static func lbToKg(_ lb: Float) -> Float {
        return lb * 0.45359237
    }
    
    static func meterToInch(_ meter: Float) -> Float {
        return meter / 0.0254
    }
    
    static func inchToMeter(_ inch: Float) -> Float {
        return inch * 0.0254
    }
    
    public static func dateToString(date: Date)->String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        return df.string(from: date)
    }
}

class BMIData: Codable, Hashable {
    static func == (lhs: BMIData, rhs: BMIData) -> Bool {
        return lhs.date > rhs.date
    }
    
    var date: String = ""   //Date in 'yyyy-MM-dd' format
    var weight: Float = 0   //Weight in kg
    var height: Float = 0   //Height in meters
    var bmi: Float = 0      //BMI
    
    var hashValue: Int {
        return date.hashValue
    }
    
    public func setDate(date: Date) {
        let str = DB.dateToString(date: date)
        self.date = str
    }
    
    func setWeightKG(weight: Float) {
        self.weight = weight
    }
    
    
    func setHeightM(height: Float) {
        self.height = height
    }
    

    //Calculate BMI in metric
    func calcBMI() {
        self.bmi = self.weight / ( self.height * self.height )
    }
    
    func getMsg() -> String {
        if self.bmi < Float(16) {
            return "Severe Thinness"
        } else if self.bmi < Float(17) {
            return "Moderate Thinness"
        } else if self.bmi < Float(18.5) {
            return "Mild Thinness"
        } else if self.bmi < Float(25) {
            return "Normal"
        } else if self.bmi < Float(30) {
            return "Overweight"
        } else if self.bmi < Float(35) {
            return "Obese Class 1"
        } else if self.bmi < Float(40) {
            return "Obese Class 2"
        } else {
            return "Obese Class 3"
        }
    }
    
}

