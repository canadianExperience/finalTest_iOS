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
    // MARK: - Table view data source
    
    
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
        cell.lblWeight.text = String(db.bmi[indexPath.row].weight)
        cell.lblBmi.text = String(db.bmi[indexPath.row].bmi)
        //cell.lblQuantity.text = String(data_products[indexPath.row].quantity)
        //cell.setCategory(category: categoryIn)
        //cell.setStepper(quantity: data_products[indexPath.row].quantity)
        
        return cell
        
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let tableViewCell = sender as! CustomTableViewCell
        
        let index = tableView.indexPathForSelectedRow?.row
        let destination = segue.destination as? UpdateViewController
        let bmi = db.bmi[index!]
        destination?.bmiIn = bmi
    }
    
    
    @IBAction func btnCancel(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
