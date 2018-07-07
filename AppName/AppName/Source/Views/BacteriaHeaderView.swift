//
//  BacteriaHeaderView.swift
//  AppName
//
//  Created by Aglaia on 7/7/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import UIKit

class BacteriaHeaderView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

	@IBOutlet var gramPositiveHeader: UIStackView!
	@IBOutlet var gramNegativeHeader: UIStackView!
	
	var positiveBacteria = Set<String>()
	var negativeBacteria = Set<String>()
	
	required init?(coder aDecoder: NSCoder) {
		
		super.init(coder: aDecoder)
		sharedInit()
		
	}
	
	override init(frame: CGRect) {
		
		super.init(frame: frame)
		sharedInit()
		
	}
	
	func sharedInit() {
		
		for antibioticGroup in Database.referenceTable.antibioticGroups! {
			
			for antibiotic in antibioticGroup.antibiotics {
				
				for organism in antibiotic.organisms! {
					
					if organism.gramPositive {
						
						positiveBacteria.insert(organism.name)
						
					} else {
						
						negativeBacteria.insert(organism.name)
					}
				}
			}
		}
		
	}

	override func layoutSubviews() {


		if gramNegativeHeader != nil && gramPositiveHeader != nil {
			
			
		for bacteria in positiveBacteria {

			let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
			label.font = UIFont(name: "Helvetica", size: 11)
			label.text = bacteria
			label.textColor = UIColor.lightGray
			label.transform = CGAffineTransform(rotationAngle: CGFloat(45 * Double.pi / 180));

			//gramPositiveHeader.addSubview(label)
			gramNegativeHeader.addArrangedSubview(label)
		}

		for bacteria in negativeBacteria {

			let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
			label.font = UIFont(name: "Helvetica", size: 11)
			label.text = bacteria
			label.textColor = UIColor.lightGray
			label.transform = CGAffineTransform(rotationAngle: CGFloat(45 * Double.pi / 180));

			//gramNegativeHeader.addSubview(label)
			gramNegativeHeader.addArrangedSubview(label)
		}
	}
  }
}
