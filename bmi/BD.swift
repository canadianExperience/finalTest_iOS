//
//  BD.swift
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
        return self.bmi[0]  //Should never be called
    }
}

class BMIData: Codable {
    var date: String = ""   //Date in 'yyyy-MM-dd' format
    var weight: Float = 0   //Weight in kg
    var height: Float = 0   //Height in meters
    var bmi: Float = 0      //BMI
    
    func setDate(date: Date) {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        self.date = df.string(from: date)
    }
    
    func setWeightKG(weight: Float) {
        self.weight = weight
    }
    
    func setWeightLB(weight: Float) {
        self.weight = weight / 0.45359237
    }
    
    func setHeightM(height: Float) {
        self.height = height
    }
    
    func setHeightInch(height: Float) {
        self.height = height / 0.0254
    }
    
    //Calculate BMI in metric
    func calcBMI() {
        bmi = self.weight / ( self.height * self.height )
    }    
}
