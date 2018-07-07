//
//  BrowserViewController.swift
//  AppName
//
//  Created by Aglaia on 7/1/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import Foundation
import UIKit

class BrowserViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet var header: UIView!
	@IBOutlet var browserView: BrowserView!
	@IBOutlet var tableView: UITableView!
	var testsToDisplay: [Database.PatientTest] = []
	
	enum BrowserSection {
		case RECENTLY_VIEWED, ATTENDINGS, ORDERED, ADMITTED
	}
	enum SortingOrder : String{
		case LATEST_UPDATED = "Latest Updated", PATIENT_NAME = "Patient Name", DATE_OF_BIRTH = "Date of Birth"
	}
	
	private var _currentOrder: SortingOrder = .LATEST_UPDATED
	
	var currentOrder: SortingOrder {
		get {return _currentOrder}
		set {
			_currentOrder = newValue
			switch _currentOrder {
				
			case .LATEST_UPDATED:
				testsToDisplay.sort { (x, y) -> Bool in
					
					let date = formatDate(date: x.lastUpdate, format: "yyyy-MM-dd HH:mm")
					let otherDate = formatDate(date: y.lastUpdate, format: "yyyy-MM-dd HH:mm")
					
					return date > otherDate
				}
				
			case .PATIENT_NAME:
				testsToDisplay.sort{ (x, y) -> Bool in
					
					return x.patientName < y.patientName
				}
				
			case .DATE_OF_BIRTH:
				testsToDisplay.sort { (x,y) -> Bool in
					
					let date = formatDate(date: x.patientBirthDate, format: "yyyy-MM-dd")
					let otherDate = formatDate(date: y.patientBirthDate, format: "yyyy-MM-dd")
					
					return date > otherDate
				}
			}
			
			if let button = browserView.sortingByIndicator {button.setTitle(_currentOrder.rawValue, for: UIControlState.normal)}
			if let table = tableView {table.reloadData()}
			
		}
	}
	
	var openSection: BrowserSection = BrowserSection.RECENTLY_VIEWED
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.tableHeaderView = header
		
		switch openSection {
		case BrowserSection.RECENTLY_VIEWED:
			showRecentSearches()
		case BrowserSection.ATTENDINGS:
			showAttendings()
		case BrowserSection.ORDERED:
			showOrdered()
		case BrowserSection.ADMITTED:
			showAdmitted()
		}
      self.tableView.reloadData()
	if let button = browserView.sortingByIndicator {button.titleLabel?.text = _currentOrder.rawValue}
		
	}
	

	@IBAction func recentlyViewedSelected(_ sender: UIButton) {
	
        showRecentSearches()
		
	}
	
	func showRecentSearches() {
		
		let recents = Database.currentUser!.recentSearches
		
		let tests: [Database.PatientTest] = Database.currentUser!.associatedTests
		
		var recentTests: [Database.PatientTest] = []
		
		
		for query in recents {
			
			if let test = tests.first(where: {$0.patientName == query || $0.patientId == query}) {
				
				recentTests.append(test)
			}
		}
		
		testsToDisplay = recentTests
	
		self.tableView.reloadData()
		
		browserView.admittedSelectionUnderline.isHidden = true
		browserView.attendingSelectionUnderline.isHidden = true
		browserView.orderedSelectionUnderline.isHidden = true
		browserView.recentlyViewedSelectionUnderline.isHidden = false
		
		browserView.selectedSectionTitle.text = "Recently Viewed"
		browserView.selectedSectionResultNumber.text = String(testsToDisplay.count)
		
	}
	

	@IBAction func attendingSelected(_ sender: UIButton) {
		showAttendings()
	}
	
	func showAttendings() {
		
		let tests: [Database.PatientTest] = Database.currentUser!.associatedTests
		
		var attendings: [Database.PatientTest] = []
		
		for test in tests {
			
			if test.attendedBy == true {
				
				attendings.append(test)
			}
		}
		
		testsToDisplay = attendings
		
		self.tableView.reloadData()
		
		browserView.admittedSelectionUnderline.isHidden = true
		browserView.orderedSelectionUnderline.isHidden = true
		browserView.recentlyViewedSelectionUnderline.isHidden = true
		browserView.attendingSelectionUnderline.isHidden = false
		
		browserView.selectedSectionTitle.text = "Your Attendings"
		browserView.selectedSectionResultNumber.text = String(testsToDisplay.count)
		
	}
	
	@IBAction func orderedSelected(_ sender: UIButton) {
		showOrdered()
	}
	
	func showOrdered() {
		
		let tests: [Database.PatientTest] = Database.currentUser!.associatedTests
		
		var attendings: [Database.PatientTest] = []
		
		for test in tests {
			
			if test.orderedBy == true {
				
				attendings.append(test)
			}
		}
		
		testsToDisplay = attendings
		
		self.tableView.reloadData()
		
		browserView.admittedSelectionUnderline.isHidden = true
		browserView.recentlyViewedSelectionUnderline.isHidden = true
		browserView.attendingSelectionUnderline.isHidden = true
		browserView.orderedSelectionUnderline.isHidden = false
		
		browserView.selectedSectionTitle.text = "Your Ordered"
		browserView.selectedSectionResultNumber.text = String(testsToDisplay.count)
	}
	
	@IBAction func admittedSelected(_ sender: UIButton) {
		showAdmitted()
	}
	
	func showAdmitted(){
		
		let tests: [Database.PatientTest] = Database.currentUser!.associatedTests
		
		var attendings: [Database.PatientTest] = []
		
		for test in tests {
			
			if test.admittedBy == true {
				
				attendings.append(test)
			}
		}
		
		testsToDisplay = attendings
		
		self.tableView.reloadData()
		
		browserView.recentlyViewedSelectionUnderline.isHidden = true
		browserView.attendingSelectionUnderline.isHidden = true
		browserView.orderedSelectionUnderline.isHidden = true
		browserView.admittedSelectionUnderline.isHidden = false
		
		browserView.selectedSectionTitle.text = "Your Admitted"
		browserView.selectedSectionResultNumber.text = String(testsToDisplay.count)
	}
	
	func formatDate(date: String, format: String) -> Date {
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = format
		dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
		let date = dateFormatter.date(from:date)!
		let calendar = Calendar.current
		let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
		let finalDate = calendar.date(from:components)

		return finalDate!
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
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
		
		return cell
	}
	
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return testsToDisplay.count
		
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		

		let testIndex =  Database.currentUser?.associatedTests.index(where:{ (x) -> Bool in
			
			let selectedTest = testsToDisplay[indexPath.row]
			
			return x.patientId == selectedTest.patientId && x.finalASTDate == selectedTest.finalASTDate && x.lastUpdate == selectedTest.lastUpdate && x.specimen.testingSpecimenProtocol == selectedTest.specimen.testingSpecimenProtocol && x.specimen.type == selectedTest.specimen.type && x.status == selectedTest.status && x.patientName == selectedTest.patientName
			
		})
		
		if testIndex != nil {Database.currentTestIndex = testIndex!}
		
		print("Test index: %d", testIndex!)
		
		
	}
	
		
	
	
	
	
}
