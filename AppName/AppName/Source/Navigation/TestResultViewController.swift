//
//  TestResultViewController.swift
//  AppName
//
//  Created by Aglaia on 7/3/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import UIKit
//import Charts

private let reuseIdentifier = "CollectionCell"

class TestResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

	@IBOutlet var collectionView: UICollectionView!
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
       // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
		return CGSize(width: 0, height: 0)
	}

	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

		switch kind {
		case UICollectionElementKindSectionHeader:

			let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionHeader", for: indexPath as IndexPath)

			return headerView

		case UICollectionElementKindSectionFooter:
			 
			let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionFooter", for: indexPath as IndexPath)

			return footerView

		default:
			
			assert(false, "Unexpected element kind")
		}

	
		
	}
//	override func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
//
//
//	}
	
//
//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//
//	}
//
	
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//			bacteriaSecondaryView.setNeedsLayout()
		
		return  (Database.currentUser?.associatedTests[Database.currentTestIndex].statusCheckpoints.count)!
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


		let chechkpoints = Database.currentUser?.associatedTests[Database.currentTestIndex].statusCheckpoints
		if  (chechkpoints?.count)! >= indexPath.row {
			
			let checkpointDetail = chechkpoints![indexPath.row]

			cell.detailTextLabel?.font = cell.detailTextLabel?.font.withSize(14)
			cell.textLabel?.font = cell.textLabel?.font.withSize(14)
			
			cell.textLabel!.text = "• " + checkpointDetail.checkpointTitle + ": "
			if let detailExists = checkpointDetail.checkpointValues {

				var firstValue = true

				for value in detailExists {

					if firstValue { firstValue = false}
					else {cell.textLabel!.text! += ", "}

					cell.textLabel!.text! += value
				}
			}
			let date = checkpointDetail.checkpointDate
			cell.detailTextLabel!.text = date
			
			let strNumber: NSString = cell.textLabel!.text! as NSString
			let range = (strNumber).range(of:"•")
			let attribute = NSMutableAttributedString.init(string: strNumber as String)
			attribute.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.green , range: range)
			
			
			cell.textLabel?.attributedText = attribute
		}

		return cell

	}

//
//	func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
//	{
//		let header = view as! UITableViewHeaderFooterView
//		//header.textLabel?.font = UIFont(name: "Futura", size: 38)!
//		header.textLabel?.textColor = UIColor.green
//	    header.detailTextLabel?.textColor = UIColor.lightGray
//	}
//
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
		
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

		if let numberOfTargetedAntibiotics = (Database.currentUser?.associatedTests[Database.currentTestIndex].targetedAntibiogram.antibioticGroups?.count) {
			return numberOfTargetedAntibiotics
		}
		
		return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TestResultCollectionItem
    
        // Configure the cell
		if let antibioticGroupName = Database.currentUser?.associatedTests[Database.currentTestIndex].targetedAntibiogram.antibioticGroups![indexPath.row].name {
			
			cell.title.text = antibioticGroupName
			cell.index = indexPath.row
			cell.displayOptions = .TABLE_VIEW
		}
		
        return cell
    }
	
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		let cellsPerRow: Int = 2
		let inset: Int = 20
		let minimumInteritemSpacing = 15
		
		let safeAreaInset = 30
		//collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right
		let marginsAndInsets = (inset * 2) + (safeAreaInset) + (minimumInteritemSpacing * (cellsPerRow) - 1)
		
		let itemWidth = ((collectionView.bounds.size.width - CGFloat(marginsAndInsets)) / CGFloat(cellsPerRow)).rounded(.down)
		
		return CGSize(width: itemWidth, height: itemWidth)
	}

//	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//		return CGSize(width: 220, height: 220)
//	}

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
