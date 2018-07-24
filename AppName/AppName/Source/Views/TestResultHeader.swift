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
			setupAlarmForStatus(Icon: organismASTIcon, For: .ORGANISM_AST)
			
			if currentPhase != .FINAL_ID {
				
				setupAlarmForStatus(Icon: finalIDStatusIcon, For: .FINAL_ID)

				if currentPhase != .PRELIMINARY_ID {
					
					setupAlarmForStatus(Icon: preliminaryIDStatusIcon, For: .PRELIMINARY_ID)
					
					if currentPhase != .GRAM_STAIN {
						
					  setupAlarmForStatus(Icon: gramStainStatusIcon, For: .GRAM_STAIN)
						
						if currentPhase != .INNOCULATION {
							
							setupAlarmForStatus(Icon: innoculationStatusIcon, For: .INNOCULATION)
						}
					}
				}
			}
		}
	}
	
	func setupAlarmForStatus(Icon icon: UIImageView, For phase: TestPhase) {
		
		if icon.isHighlighted {let alarm = icon.subviews.first { (x) -> Bool in
			if x is AlarmButton {return true}
			return false
			}
			
			alarm?.removeFromSuperview()
			icon.isHighlighted = false
			
		} else {
			
			let button = makeAlarmButton(For: phase)
			icon.isUserInteractionEnabled = true
			icon.addSubview(button)
			icon.isHighlighted = true
		}
	}
	
	func makeAlarmButton(For phase: TestPhase) -> AlarmButton {
		
		let alarm = AlarmButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
		alarm.currentPhase = phase
		
		return alarm
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
			
			if let testSource =  test.specimen.source {
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
