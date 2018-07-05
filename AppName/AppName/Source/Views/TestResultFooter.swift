//
//  TestResultFooter.swift
//  AppName
//
//  Created by Aglaia on 7/4/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import UIKit

class TestResultFooter: UIView{

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
	
	@IBOutlet var gramPositiveBacteriaHeader: UIStackView!
	@IBOutlet var gramNegativeBacteriaHeader: UIStackView!
	
	required init?(coder aDecoder: NSCoder) {
		
		super.init(coder: aDecoder)
		
		var positiveBacteria = Set<String>()
		var negativeBacteria = Set<String>()
		
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
		
		for bacteria in positiveBacteria {
			
			let label = UILabel()
			label.text = bacteria
			label.transform = CGAffineTransform(rotationAngle: CGFloat(45 * Double.pi / 180));
			
		gramPositiveBacteriaHeader.addSubview(label)
		}
		
		for bacteria in negativeBacteria {
			
			let label = UILabel()
			label.text = bacteria
			label.transform = CGAffineTransform(rotationAngle: CGFloat(45 * Double.pi / 180));
			
			gramNegativeBacteriaHeader.addSubview(label)
		}
	}

}
