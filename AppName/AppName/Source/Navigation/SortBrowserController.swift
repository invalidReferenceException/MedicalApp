//
//  SortBrowserController.swift
//  AppName
//
//  Created by Aglaia on 7/5/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import UIKit

class SortBrowserController: UITableViewController {


	@IBOutlet var latestUpdated: UITableViewCell!
	@IBOutlet var patientName: UITableViewCell!
	@IBOutlet var dateOfBirth: UITableViewCell!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
		
		for childController in (presentingViewController?.childViewControllers)! {
			
			if let browser = childController as? BrowserViewController {
				
				if latestUpdated.textLabel?.text == browser.currentOrder.rawValue {
					
					latestUpdated.accessoryType = UITableViewCellAccessoryType.checkmark
					latestUpdated.accessoryView?.isHidden = false
					
				} else if patientName.textLabel?.text == browser.currentOrder.rawValue {
					
					patientName.accessoryType = UITableViewCellAccessoryType.checkmark
					patientName.accessoryView?.isHidden = false
					
				} else if dateOfBirth.textLabel?.text == browser.currentOrder.rawValue {
					
					dateOfBirth.accessoryType = UITableViewCellAccessoryType.checkmark
					dateOfBirth.accessoryView?.isHidden = false
				}
			}
				
			}
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

		
        return 3
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		
		latestUpdated.accessoryType = UITableViewCellAccessoryType.none
		patientName.accessoryType = UITableViewCellAccessoryType.none
		dateOfBirth.accessoryType = UITableViewCellAccessoryType.none
		
		let cell = tableView.cellForRow(at: indexPath)
		cell?.accessoryType = UITableViewCellAccessoryType.checkmark
		
		for childController in (presentingViewController?.childViewControllers)! {
			
			if let browser = childController as? BrowserViewController {
				
				if let sortingName = cell?.textLabel?.text{
					
					browser.currentOrder = BrowserViewController.SortingOrder(rawValue: sortingName)!
				}
				
			}
		}
		
	}

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
