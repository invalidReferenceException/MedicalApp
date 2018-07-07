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

class SearchViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
	
	@IBOutlet var header: UIView!
	
	@IBOutlet var tableView: UITableView!
	var searchController = UISearchController(searchResultsController: nil)
	
	var testsToDisplay: [Database.PatientTest] = []
	
	var searchInputText = ""
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		searchController.searchResultsUpdater = self
		searchController.hidesNavigationBarDuringPresentation = false
		searchController.edgesForExtendedLayout = []
		searchController.dimsBackgroundDuringPresentation = false
		searchController.searchBar.sizeToFit()
		self.navigationItem.titleView = searchController.searchBar
		self.definesPresentationContext = true
		
	}
	

	func didPresentSearchController(_ searchController: UISearchController) {
		//TODO: display recent queries
	}
	
	func updateSearchResults(for searchController: UISearchController) {
		
		let count = searchController.searchBar.text?.isEmpty
		if count! {testsToDisplay = []; searchInputText = ""; tableView.tableHeaderView = nil; tableView.reloadData(); return}
		else {self.tableView.tableHeaderView = header}
		
		if let textDidChange = searchController.searchBar.text{
		
			if textDidChange.isEmpty {return}
		
			let tests: [Database.PatientTest] = Database.currentUser!.associatedTests
			
			var queried: [Database.PatientTest] = []
			
			for test in tests {
				
				if test.patientId.contains(textDidChange) || test.patientName.contains(textDidChange){
					queried.append(test)
				}
			}
			
			testsToDisplay = queried
			
			
			searchInputText = textDidChange
			
			self.tableView.reloadData()
	  }
	}
	
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if  searchInputText.isEmpty  {
			
			let cell = tableView.dequeueReusableCell(withIdentifier: "RecentQuery")!
		
			cell.textLabel!.text = Database.currentUser?.recentSearches[indexPath.row]
			cell.textLabel?.textColor = UIColor.black
			
			return cell
		}
		
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
			
		case "Innoculation": cell.currentStatusIcon.image = #imageLiteral(resourceName: "Innoculation")
		case "Gram Stain": cell.currentStatusIcon.image = #imageLiteral(resourceName: "Preliminary-ID")
		case "Preliminary ID": cell.currentStatusIcon.image = #imageLiteral(resourceName: "Gram-Stain")
		case "Final ID": cell.currentStatusIcon.image = #imageLiteral(resourceName: "Final-ID")
		case "Organism AST": cell.currentStatusIcon.image = #imageLiteral(resourceName: "Organism-AST")
			
		default: print("No status icon selected because of unknown status.")
			
		}
		
		if test.patientId.contains(searchInputText) {

			let defaultStyle = cell.dobLabel.attributedText?.attributes(at: 1, effectiveRange: nil)

			//reset the string to the same unhighlighted style as dobLabel in case it's highlighted
			cell.idLabel.attributedText = NSAttributedString(string: cell.idLabel.text!, attributes: defaultStyle)
            cell.nameLabel.attributedText = NSAttributedString(string: cell.nameLabel.text!, attributes: defaultStyle)
			
			let strNumber: NSString = test.patientId as NSString
			let range = (strNumber).range(of: searchInputText)
			let attribute = NSMutableAttributedString.init(string: strNumber as String)
			attribute.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue , range: range)

			//add highlight for queried substring
			cell.idLabel.attributedText = attribute

		} else if test.patientName.contains(searchInputText) {

			let defaultStyle = cell.dobLabel.attributedText?.attributes(at: 1, effectiveRange: nil)

			//reset the string to the same unhighlighted style as dobLabel in case it's highlighted
			cell.nameLabel.attributedText = NSAttributedString(string: cell.nameLabel.text!, attributes: defaultStyle)
			cell.idLabel.attributedText = NSAttributedString(string: cell.idLabel.text!, attributes: defaultStyle)

			let strNumber: NSString = test.patientName as NSString
			let range = (strNumber).range(of: searchInputText)
			let attribute = NSMutableAttributedString.init(string: strNumber as String)
			attribute.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.blue , range: range)

			//add highlight for queried substring
			cell.nameLabel.attributedText = attribute

		}
		
		return cell
		
	}
	
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		//if the user hasn't typed a search, display recent queries instead
		if searchInputText.isEmpty {if let count = Database.currentUser?.recentSearches.count {return count} else {return 0}}
		
		return testsToDisplay.count
		
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let cell = tableView.cellForRow(at: indexPath)
		if cell?.reuseIdentifier == "RecentQuery" {
			
			if let query = cell?.textLabel?.text {
				
				searchInputText = query
				searchController.searchBar.text = query
				
				tableView.reloadData()
			}

		}
		
	}
	
}

