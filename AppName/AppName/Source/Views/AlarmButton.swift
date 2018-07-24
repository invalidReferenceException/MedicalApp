//
//  AlarmButton.swift
//  AppName
//
//  Created by Aglaia on 7/22/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import UIKit

class AlarmButton: RoundButton {
	
	
	typealias TestPhase = TestResultHeader.TestPhase
	
	var currentPhase : TestPhase?  {
		get {
			return TestPhase(rawValue: self.accessibilityIdentifier ?? "")
		}
		set {			
			if let phase = newValue {
				self.accessibilityIdentifier = phase.rawValue
				if checkNotificationSubscription(For: phase) {self.isSelected = true}
			}
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		sharedInit()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		sharedInit()
	}
	
	private func sharedInit() {
		self.addTarget(self, action: #selector(alarmButtonAction), for: .touchUpInside)
		
		cornerRadius = 20
		backgroundColor = .white
		isSelected = false
		isEnabled = true
		isUserInteractionEnabled = true

		setBackgroundImage(#imageLiteral(resourceName: "font-awesome_30.png") , for: .selected)
		setBackgroundImage(#imageLiteral(resourceName: "font-awesome__bell-slash_25.png") , for: .normal)
		
	}
	
	@objc func alarmButtonAction() {
		
		if self.isSelected {
			
			self.isSelected = false
			deleteNotification(For: TestPhase(rawValue: self.accessibilityIdentifier!)!)
			
		} else {
			
			self.isSelected = true
			saveNotification(For: TestPhase(rawValue: self.accessibilityIdentifier!)!)
		}
	}
	
	func saveNotification(For phase: TestPhase) {
		
		
		let testIndex = Database.currentTestIndex
		Database.currentUser?.notificationSubscriptions?.append((test: (Database.currentUser?.associatedTests[testIndex])! , phase: phase.rawValue))
		
		
		//in order to save a notification I need: the test associated with the notification, the test phase, and a message for the notification(or I can compose that when I unwrap the value)
		//when a button is pressed I get the test phase, and the test itself is the current test in the database. The message is composed from those two values. Should I save the test or should I save the index of the test? Either way in order to check the test change I would need to get the index.
		//I think I should just save the test id. There is a difference between notification subscriptions and notifications that have come to fruition.
		
		//so the subscriptions should only have the test phase and test itself/id.
		//the notifications which have come to fruitions are a string message already composed, plus the test to which they belong. Or it's just the same tuple and then the message is made on the fly.
		
		// notificationSubscriptions
		// notificationAlerts
		
		//who owns what? subscriptions are owned by the user/physician and so are the alerts.
		//alerts are owned by the user/physician as well.
		//who moves things between the two? some status checker which checks if phases have changed in the database. But we won't care about that right now because this is front end. So we'll just have a bunch of things in one array and a bunch of things in the other and we won't change them.
	}
	
	func deleteNotification(For phase: TestPhase) {
		
		let subscriptionIndex = Database.currentUser?.notificationSubscriptions?.index(where: { (test, subPhase) -> Bool in
			
			if subPhase == phase.rawValue {
				
				if let selectedTest = Database.currentUser?.associatedTests[Database.currentTestIndex] {
					
					return test.patientId == selectedTest.patientId && test.finalASTDate == selectedTest.finalASTDate && test.lastUpdate == selectedTest.lastUpdate && test.specimen.testingSpecimenProtocol == selectedTest.specimen.testingSpecimenProtocol && test.specimen.type == selectedTest.specimen.type && test.status == selectedTest.status && test.patientName == selectedTest.patientName
				}
			}
			
			return false
		})
		
		if let index = subscriptionIndex {
			
			Database.currentUser?.notificationSubscriptions?.remove(at: index)
		}
	}

	
	func checkNotificationSubscription(For phase: TestPhase) -> Bool {
		
		var isSubscribed = false

		
		let subscriptionIndex = Database.currentUser?.notificationSubscriptions?.index(where: { (test, subPhase) -> Bool in
			
			if subPhase == phase.rawValue {
				
				if let selectedTest = Database.currentUser?.associatedTests[Database.currentTestIndex] {
					
					return test.patientId == selectedTest.patientId && test.finalASTDate == selectedTest.finalASTDate && test.lastUpdate == selectedTest.lastUpdate && test.specimen.testingSpecimenProtocol == selectedTest.specimen.testingSpecimenProtocol && test.specimen.type == selectedTest.specimen.type && test.status == selectedTest.status && test.patientName == selectedTest.patientName
				}
			}
			
			return false
		})
		
		if subscriptionIndex != nil {
			
			isSubscribed = true
		}
		
		return isSubscribed
	}

}
