//
//  SearchAndBrowseController.swift
//  AppName
//
//  Created by Aglaia on 7/1/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import Foundation
import UIKit

class SearchFilterController : UISearchController {
	
}

class SearchViewController : UITableViewController, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
	
	
	var searchController = UISearchController()
	
	var testsToDisplay: [Database.PatientTest] = []
	
	var searchInputText = ""
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationItem.titleView = searchController.searchBar
		self.definesPresentationContext = true
	}
	

	func didPresentSearchController(_ searchController: UISearchController) {
		//TODO: display recent queries
	}
	
	func updateSearchResults(for searchController: UISearchController) {
		
		if let textDidChange = searchController.searchBar.text{
		
			if textDidChange.isEmpty {return}
		
			let tests: [Database.PatientTest] = Database.currentUser!.associatedTests
			
			var queried: [Database.PatientTest] = []
			
			for test in tests {
				
				if test.patientId == textDidChange || test.patientName == textDidChange{
					queried.append(test)
				}
			}
			
			testsToDisplay = queried
			
			searchInputText = textDidChange
			self.tableView.reloadData()
	  }
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let test = testsToDisplay[indexPath.row]
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "TestResultTableCell") as! TestResultTableCell
		
		cell.nameLabel.text = test.patientName
		cell.idLabel.text = test.patientId
		cell.dobLabel.text = test.patientBirthDate
		cell.testTypeLabel.text = test.specimen.type
		cell.testProtocolLabel.text = test.specimen.testingSpecimenProtocol
		cell.estimatedCompletionLabel.text = test.finalASTDate
		cell.currentStatusLabel.text = test.status
		
		switch test.status {
			
		case "Innoculation": cell.currentStatusIcon.image = #imageLiteral(resourceName: "2774752-32.png")
		case "Gram Stain": cell.currentStatusIcon.image = #imageLiteral(resourceName: "2774750-32.png")
		case "Preliminary ID": cell.currentStatusIcon.image = #imageLiteral(resourceName: "2774754-32.png")
		case "Final ID": cell.currentStatusIcon.image = #imageLiteral(resourceName: "2774747-32.png")
		case "Organism AST": cell.currentStatusIcon.image = #imageLiteral(resourceName: "2774741-32.png")
			
		default: print("No status icon selected because of unknown status.")
			
		}
		
		if test.patientId.contains(searchInputText) {
			
			
			let defaultStyle = cell.dobLabel.attributedText?.attributes(at: 1, effectiveRange: nil)
			
			//reset the string to the same unhighlighted style as dobLabel in case it's highlighted
			cell.idLabel.attributedText = NSAttributedString(string: cell.idLabel.text!, attributes: defaultStyle)
			
			let strNumber: NSString = test.patientId as NSString // you must set your
			let range = (strNumber).range(of: searchInputText)
			let attribute = NSMutableAttributedString.init(string: strNumber as String)
			attribute.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue , range: range)
			
			//add highlight for queried substring
			cell.idLabel.attributedText = attribute
			
		} else if test.patientName.contains(searchInputText) {
			
			
			let defaultStyle = cell.dobLabel.attributedText?.attributes(at: 1, effectiveRange: nil)
			
			//reset the string to the same unhighlighted style as dobLabel in case it's highlighted
			cell.nameLabel.attributedText = NSAttributedString(string: cell.nameLabel.text!, attributes: defaultStyle)
			
			let strNumber: NSString = test.patientName as NSString // you must set your
			let range = (strNumber).range(of: searchInputText)
			let attribute = NSMutableAttributedString.init(string: strNumber as String)
			attribute.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue , range: range)
			
			//add highlight for queried substring
			cell.nameLabel.attributedText = attribute
			
		}
		
		return cell
		
	}
	
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return testsToDisplay.count
		
	}

	
	
	
}

