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
			
			gramPositiveHeader.safelyRemoveArrangedSubviews()
			gramNegativeHeader.safelyRemoveArrangedSubviews()
			
		for bacteria in positiveBacteria {

			let label = bacteriaLabel(With: bacteria)
			gramPositiveHeader.addArrangedSubview(label)
		}

		for bacteria in negativeBacteria {

			let label = bacteriaLabel(With: bacteria)
			gramNegativeHeader.addArrangedSubview(label)
		}
	}
  }

	
	func bacteriaLabel(With text: String) -> UIView {
		
		let labelView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 150))
		labelView.clipsToBounds = false
		labelView.backgroundColor = .clear
		
		// Width constraint
		labelView.addConstraint(NSLayoutConstraint.init(item:labelView,
														attribute:NSLayoutAttribute.width,
														relatedBy:NSLayoutRelation.equal,
														toItem:nil,
														attribute: NSLayoutAttribute.notAnAttribute,
														multiplier:1,
														constant:40))
		
		
		let label = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 150))
		
		
		label.font = UIFont(name: "Helvetica", size: 11)
		label.textAlignment = .right
		label.textColor = UIColor.lightGray
		label.text = text
		
		label.transform = CGAffineTransform(rotationAngle: CGFloat(-45 * Double.pi / 180));
		
		label.sizeToFit()

		labelView.translatesAutoresizingMaskIntoConstraints = false
		labelView.addConstraint(NSLayoutConstraint.init(item:label,
														attribute:NSLayoutAttribute.bottom,
														relatedBy:NSLayoutRelation.equal,
														toItem:labelView,
														attribute: NSLayoutAttribute.bottom,
														multiplier:1,
														constant:-150))
		
		labelView.addConstraint(NSLayoutConstraint.init(item:label,
														attribute:NSLayoutAttribute.leading,
														relatedBy:NSLayoutRelation.equal,
														toItem:labelView,
														attribute: NSLayoutAttribute.leading,
														multiplier:1,
														constant:0))
		
		labelView.addSubview(label)
		
		return labelView
	}

}
