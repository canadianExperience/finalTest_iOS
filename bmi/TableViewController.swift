//
//  TableViewController.swift
//  bmi
//
//  Created by Elena Melnikova on 2018-12-13.
//  Copyright © 2018 Centennial College. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    private static let cellIdentifier = "custom"
    var uomMetricIn: Bool = true
    var db: DB = DB()
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        update()
        tableView.reloadData()
    }
    
    func update(){
        let defaults = UserDefaults.standard
        let savedDB = defaults.string(forKey: "db") ?? ""
        db = DB.fromJson(jsonString: savedDB)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return db.bmi.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let cell: CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: TableViewController.cellIdentifier, for: indexPath) as! CustomTableViewCell
        
        // Set text for table cell
        cell.lblDate.text = db.bmi[indexPath.row].date
        if uomMetricIn {
            cell.lblWeight.text = String(db.bmi[indexPath.row].weight)
        } else {
            let kg = db.bmi[indexPath.row].weight
            let lb = DB.kgToLb(kg)
            cell.lblWeight.text = String(lb)
        }
        
        cell.lblBmi.text = String(db.bmi[indexPath.row].bmi)
        return cell
        
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let tableViewCell = sender as! CustomTableViewCell
        let index = tableView.indexPathForSelectedRow?.row
        let destination = segue.destination as? UpdateViewController
        let bmi = db.bmi[index!]
        destination?.bmiIn = bmi
        destination?.uomMetricIn = uomMetricIn
    }
    
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
