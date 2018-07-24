//
//  AntibioticTableCell.swift
//  AppName
//
//  Created by Aglaia on 7/3/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import UIKit

class AntibioticTableCell: UITableViewCell {

	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var dosageLabel: UILabel!
	@IBOutlet var disclaimerLabel: UILabel!
	@IBOutlet var priceLabel: PriceIndicator!
	@IBOutlet var organismCoverageStack: UIStackView!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func labelForOrganismMatchWithAntibiotic(organism: Database.Antibiogram.Antibiotic.Organism) -> UILabel{
		
		let score = Int(organism.score)
		
		let label = makeLabel()
		label.accessibilityIdentifier = organism.name
		label.text = String(score)
		
		if organism.score < 40 && organism.score > 0
		{
			label.backgroundColor = UIColor(red: 255/255.0, green: 51/255.0, blue: 0/255.0, alpha: 1)
			label.textColor = UIColor.white
		}
		else if organism.score > 60
		{
			label.backgroundColor = UIColor(red: 51/255.0, green: 204/255.0, blue: 153/255.0, alpha: 1)
			label.textColor = UIColor.white
		}
		
		return label
		
	}
	
	func makeLabel() -> UILabel {
		
		let label = UILabel()
		label.textAlignment = NSTextAlignment.center
		label.bounds = CGRect(x: 0, y: 0, width: 40, height: 25)
		
		
		// Width constraint
		label.addConstraint(NSLayoutConstraint.init(item:label,
													attribute:NSLayoutAttribute.width,
													relatedBy:NSLayoutRelation.equal,
													toItem:nil,
													attribute: NSLayoutAttribute.notAnAttribute,
													multiplier:1,
													constant:40))
		
		// Height constraint
		label.addConstraint(NSLayoutConstraint.init(item:label,
													attribute:NSLayoutAttribute.height,
													relatedBy:NSLayoutRelation.equal,
													toItem:nil,
													attribute: NSLayoutAttribute.notAnAttribute,
													multiplier:1,
													constant:27))
		
		label.textColor = UIColor.black
		label.font = UIFont(name: "Helvetica-Medium", size: 14)
		
		//blank label
		label.backgroundColor = UIColor.white
		label.textColor = UIColor.clear
		label.text = "00"
		
		return label
	}
	

}
