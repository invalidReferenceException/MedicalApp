//
//  AlertsSetupController.swift
//  AppName
//
//  Created by Aglaia on 7/1/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import Foundation
import UIKit

class AlertsSetupController : UITableViewController {
	

	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		if let notificationsCount = Database.currentUser?.notificationAlerts?.count {return notificationsCount}
		
		return 0
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let alertCell = tableView.dequeueReusableCell(withIdentifier: "AlertCell", for: indexPath)
		
		if let notification = Database.currentUser?.notificationAlerts![indexPath.row] {
			
			let message = notification.phase + " completed for: " + notification.test.specimen.type + " for patient: " + notification.test.patientName
			alertCell.textLabel?.text = message
		}
	
		return alertCell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		//find the index for the selected test so its profile can be accessed
		let testIndex =  Database.currentUser?.associatedTests.index(where:{ (x) -> Bool in
			
			if let selectedTest = Database.currentUser?.notificationAlerts![indexPath.row].test {
				
				return x.patientId == selectedTest.patientId && x.finalASTDate == selectedTest.finalASTDate && x.lastUpdate == selectedTest.lastUpdate && x.specimen.testingSpecimenProtocol == selectedTest.specimen.testingSpecimenProtocol && x.specimen.type == selectedTest.specimen.type && x.status == selectedTest.status && x.patientName == selectedTest.patientName
			}

           return false
		})
		
		if testIndex != nil {Database.currentTestIndex = testIndex!}
	}
}
