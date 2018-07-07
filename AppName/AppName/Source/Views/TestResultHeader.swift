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
