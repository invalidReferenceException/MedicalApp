//
//  TestResultsView.swift
//  AppName
//
//  Created by Aglaia on 7/1/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import Foundation

import UIKit

class TestResultView : UICollectionView {
	
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
	
	@IBOutlet var statusDetailTextLabel: UILabel!
	@IBOutlet var statusDetailDateLabel: UILabel!
	
	@IBOutlet var gramPositiveBacteriaHeader: UIStackView!
	@IBOutlet var gramNegativeBacteriaHeader: UIStackView!
	
	
}
