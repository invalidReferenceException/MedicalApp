//
//  TestResultViewController.swift
//  AppName
//
//  Created by Aglaia on 7/3/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import UIKit
import Charts

private let reuseIdentifier = "Cell"

class TestResultViewController: UICollectionViewController, UITableViewDataSource {

	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }
	

	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3;
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		/*// Create a new cell with the reuse identifier of our prototype cell
		// as our custom table cell class
		let cell = tableView.dequeueReusableCellWithIdentifier("myProtoCell") as! MyTableCell
		// Set the first row text label to the firstRowLabel data in our current array item
		cell.lblFirstRow.text = tableData[indexPath.row].firstRowLabel
		// Set the second row text label to the secondRowLabel data in our current array item
		cell.lblSecondRow.text = tableData[indexPath.row].secondRowLabel
		// Return our new cell for display
		return cell
		
*/
		let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "checkpointDetail")
		//cell.editingStyle = UITableViewCellEditingStyle.none
		cell.accessoryType = UITableViewCellAccessoryType.none
		
		
		if let checkpointDetail = Database.currentUser?.associatedTests[Database.currentTestIndex].statusCheckpoints[indexPath.row] {
			
			cell.textLabel!.text = checkpointDetail.checkpointTitle + ": "
			if let detailExists = checkpointDetail.checkpointValues {
				
//				var firstValue = true
//
//				for value in detailExists {
//
//					if firstValue { firstValue = false}
//					else {cell.textLabel!.text! += ", "}
//
//					cell.textLabel!.text! += value
//				}
				
			}
			
			let date = formatDate(date: checkpointDetail.checkpointDate, format: "yyyy-MM-dd' 'HH:mm:")
			cell.detailTextLabel!.text = date
		}
		
		return cell
		
	}
	
	func formatDate(date: String, format: String) -> String {
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = format
		dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
		let date = dateFormatter.date(from:date)!
		let calendar = Calendar.current
		let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
		let finalDate = calendar.date(from:components)
		
		let stringDate = dateFormatter.string(from: finalDate!)
		//let date: Date = Date(firstCheckpoint!.checkpointDate)
		return stringDate
	}
	
	func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
	{
		let header = view as! UITableViewHeaderFooterView
		//header.textLabel?.font = UIFont(name: "Futura", size: 38)!
		header.textLabel?.textColor = UIColor.green
	    header.detailTextLabel?.textColor = UIColor.lightGray
	}

	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }
	
	
	

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
