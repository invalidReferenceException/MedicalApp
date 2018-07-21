//
//  TestResultHeader.swift
//  AppName
//
//  Created by Aglaia on 7/4/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import UIKit

class TestResultHeader: UICollectionReusableView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
	
	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var testProtocolLabel: UILabel!
	@IBOutlet var idLabel: UILabel!
	@IBOutlet var testTypeLabel: UILabel!
	@IBOutlet var patientLocationLabel: UILabel!
	@IBOutlet var specimenSourceLabel: UILabel!
	@IBOutlet var dateOfBirthLabel: UILabel!
	
	
	@IBOutlet var innoculationStatusIcon: UIImageView!
	@IBOutlet var gramStainStatusIcon: UIImageView!
	@IBOutlet var preliminaryIDStatusIcon: UIImageView!
	@IBOutlet var finalIDStatusIcon: UIImageView!
	@IBOutlet var organismASTIcon: UIImageView!
	
	@IBOutlet var innoculationDateLabel: UILabel!
	@IBOutlet var gramStainDateLabel: UILabel!
	@IBOutlet var preliminaryIDDateLabel: UILabel!
	@IBOutlet var finalIDDateLabel: UILabel!
	@IBOutlet var organismASTDateLabel: UILabel!
	
	enum TestPhase : String {
		case INNOCULATION = "Innoculation", GRAM_STAIN = "Gram Stain", PRELIMINARY_ID = "Preliminary ID", FINAL_ID = "Final ID", ORGANISM_AST = "Organism AST"
	}
	
	var currentPhase : TestPhase = .INNOCULATION
	
	@IBAction func setupAlerts(_ sender: Any) {
		
		if currentPhase != .ORGANISM_AST
		{
			let button = makeAlarmButton()
			button.accessibilityIdentifier = TestPhase.ORGANISM_AST.rawValue
			organismASTIcon.isUserInteractionEnabled = true
			organismASTIcon.addSubview(button)
			organismASTIcon.isUserInteractionEnabled = true
			
			if currentPhase != .FINAL_ID {
				
				let button = makeAlarmButton()
				button.accessibilityIdentifier = TestPhase.FINAL_ID.rawValue
				finalIDStatusIcon.isUserInteractionEnabled = true
				finalIDStatusIcon.addSubview(button)
				
				if currentPhase != .PRELIMINARY_ID {
					
					let button = makeAlarmButton()
					button.accessibilityIdentifier = TestPhase.PRELIMINARY_ID.rawValue
					preliminaryIDStatusIcon.isUserInteractionEnabled = true
					preliminaryIDStatusIcon.addSubview(button)
					
					if currentPhase != .GRAM_STAIN {
						
						let button = makeAlarmButton()
						button.accessibilityIdentifier = TestPhase.GRAM_STAIN.rawValue
						gramStainStatusIcon.isUserInteractionEnabled = true
						gramStainStatusIcon.addSubview(button)
						
						if currentPhase != .INNOCULATION {
							
							let button = makeAlarmButton()
							button.accessibilityIdentifier = TestPhase.INNOCULATION.rawValue
							innoculationStatusIcon.isUserInteractionEnabled = true
							innoculationStatusIcon.addSubview(button)
						}
					}
				}
			}
		}
	}
	
	func makeAlarmButton() -> UIButton {
		
		let alarm = RoundButton(frame: CGRect(x: 10, y: 10, width: 20, height: 20))
		alarm.cornerRadius = 20
		alarm.backgroundColor = .white
		alarm.isSelected = false
		alarm.isEnabled = true
		alarm.isUserInteractionEnabled = true
		alarm.setBackgroundImage(#imageLiteral(resourceName: "font-awesome_30.png") , for: .selected)
		alarm.setBackgroundImage(#imageLiteral(resourceName: "font-awesome__bell-slash_25.png") , for: .normal)
		alarm.addTarget(self, action: #selector(alarmButtonPressed(sender:)), for: .touchDown)
		
		return alarm
	}
	
	
	@objc func alarmButtonPressed (sender: UIButton) {
		
		if sender.state == .selected {
			
			sender.isSelected = false
			TestResultHeader.saveNotification(For: TestPhase(rawValue: sender.accessibilityIdentifier!)!)
			
		} else if sender.state == .normal {
			
			sender.isSelected = true
			TestResultHeader.deleteNotification(For: TestPhase(rawValue: sender.accessibilityIdentifier!)!)
		}
	}
	
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override func layoutSubviews() {
		setupData()
	}
	
	func setupData (){
		let index = Database.currentTestIndex
		let tests =	Database.currentUser?.associatedTests
		if let test = tests?[index] {
			
			nameLabel.text = test.patientName
			idLabel.text = test.patientId
			
			patientLocationLabel.text = test.patientLocation
			dateOfBirthLabel.text = test.patientBirthDate
			
			testProtocolLabel.text = test.specimen.testingSpecimenProtocol
			testTypeLabel.text = test.specimen.type
			
			if let testSource =  test.specimen.source{
				specimenSourceLabel.text = testSource
			}
			else {
				specimenSourceLabel.text = ""
			}
			
			var date = formatDate(date: test.estimatedCompletionDateByPhase.innoculation, format: "yyyy-MM-dd' 'HH:mm:")
			innoculationDateLabel.text = date
			
			date = formatDate(date: test.estimatedCompletionDateByPhase.gramStain, format: "yyyy-MM-dd' 'HH:mm:")
			gramStainDateLabel.text = date
			
			date = formatDate(date: test.estimatedCompletionDateByPhase.preliminaryID, format: "yyyy-MM-dd' 'HH:mm:")
			preliminaryIDDateLabel.text = date
			
			date = formatDate(date: test.estimatedCompletionDateByPhase.finalID, format: "yyyy-MM-dd' 'HH:mm:")
			finalIDDateLabel.text = date
			
			date = formatDate(date: test.estimatedCompletionDateByPhase.organismAST, format: "yyyy-MM-dd' 'HH:mm:")
			organismASTDateLabel.text = date
			
		}
	}
	
	static func saveNotification(For phase: TestPhase) {
		
		
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
	
	static func deleteNotification(For phase: TestPhase) {
		
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
	
}
