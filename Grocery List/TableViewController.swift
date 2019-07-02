//
//  TableViewController.swift
//  Grocery List
//
//  Created by Pazhg on 4/11/1398 AP.
//  Copyright © 1398 Pazhg. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    //var items : [String] = []
    var items : [NSManagedObject] = []
    
    var container : NSPersistentContainer!
    var context : NSManagedObjectContext!
    
    //MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Access to AppDelegate to set properties
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        container = appDelegate.persistentContainer
        context = container.viewContext
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadDataOfTableView()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "List of items"
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // Configure the cell...
        //cell.textLabel!.text = items [ indexPath.row ]
        let item = items [ indexPath.row]
        cell.textLabel!.text =  item.value(forKey: "title") as? String
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            items.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
    

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK: - Buttons
    @IBAction func barItem(_ sender: UIBarButtonItem) {
        let alert = UIAlertController.init(title: "New Item", message: "Enter new item", preferredStyle: UIAlertController.Style.alert)
        alert.addTextField { (textField : UITextField) in
            textField.placeholder = "Title"
        }
        let actionStore = UIAlertAction.init(title: "Store", style: UIAlertAction.Style.default) { (UIAlertAction) in
            if let text = alert.textFields?.first?.text {
                //self.items.append(text)
                //self.tableView.reloadData()
                let entity : NSEntityDescription = NSEntityDescription.entity(forEntityName: "List", in: self.context)!
                let object : NSManagedObject = NSManagedObject(entity: entity, insertInto: self.context)
                
                object.setValue(text , forKey: "title")
                
                do {
                    try self.context.save()
                } catch {
                    fatalError ("Data can't save into CoreData")
                }
                
                self.reloadDataOfTableView()
            }
        }
        let actionCancel = UIAlertAction.init(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(actionStore)
        alert.addAction(actionCancel)
        
        self.present(alert, animated: true) {
            print("Alert")
        }
    }
    
    
    //MARK: - Functions
    func reloadDataOfTableView () {
        // Needs FetchRequest
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "List")
        do {
            let result = try  context.fetch(request)
            items = result as! [NSManagedObject]
            self.tableView.reloadData()
        } catch {
            fatalError("Retrieve data is failed!")
        }
    } // End of Func
}
