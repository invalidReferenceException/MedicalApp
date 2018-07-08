//
//  TestResultFooter.swift
//  AppName
//
//  Created by Aglaia on 7/4/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import UIKit

class TestResultFooter: UICollectionReusableView, UITableViewDelegate, UITableViewDataSource{
	
	var bacteriaHeader = BacteriaHeaderView()
	
	@IBOutlet var commentsArea: UIView!
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return Database.referenceTable.antibioticGroups![section].antibiotics.count
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {

		tableView.tableHeaderView = bacteriaHeader
		//tableView.frame.size = CGSize(width: 1000, height: 1000)
		
		return Database.referenceTable.antibioticGroups!.count
	}
	
	override func layoutSubviews() {
		self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: 1500)
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return Database.referenceTable.antibioticGroups![section].name
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let antibiotic = Database.referenceTable.antibioticGroups![indexPath.section].antibiotics[indexPath.row]
	    let cell = tableView.dequeueReusableCell(withIdentifier: "AntibioticTableCell") as! AntibioticTableCell
		
		cell.dosageLabel.isHidden = true
		
		cell.nameLabel.text = antibiotic.name
		
		if let cost = antibiotic.cost {
			
			cell.priceLabel.pricePoint = cost
		}
		
		for organism in antibiotic.organisms! {
			
//			let rightHeader = (organism.gramPositive) ? bacteriaHeader.positiveBacteria : bacteriaHeader.negativeBacteria
//
//			for bacteriaName in rightHeader {
//				if bacteriaName == organism.name {break}
//
//				let emptyLabel = UILabel()
//				emptyLabel.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
//				cell.organismCoverageStack.addArrangedSubview(emptyLabel)
//
//			}
			
			let score = Int(organism.score)
			let label = UILabel()
			label.textAlignment = NSTextAlignment.center
			label.bounds = CGRect(x: 0, y: 0, width: 32, height: 25)
			
			
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
			
			label.text = String(score)
			label.textColor = UIColor.black
			label.font = UIFont(name: "Helvetica-Medium", size: 14)
			label.accessibilityIdentifier = organism.name
			
			if organism.score < 40
			{label.backgroundColor = UIColor(red: 255/255.0, green: 51/255.0, blue: 0/255.0, alpha: 1)
			 label.textColor = UIColor.white
			}
			else if organism.score > 60
			{label.backgroundColor = UIColor(red: 51/255.0, green: 204/255.0, blue: 153/255.0, alpha: 1)
			 label.textColor = UIColor.white
			}
			
			if organism.score == 0 {label.isHidden = true}
			cell.organismCoverageStack.addArrangedSubview(label)
			
		}
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		
//		let lastSection = Database.referenceTable.antibioticGroups!.count - 1
//		let lastRow = Database.referenceTable.antibioticGroups![lastSection].antibiotics.count - 1
//
//		if indexPath.section == lastSection && indexPath.row == lastRow {
//			self.bounds.size.height += tableView.contentSize.height + commentsArea.frame.height
//			self.sizeToFit()
//		}
	}
	
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

//	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//		return UITableViewAutomaticDimension
//	}
//
//	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//		return UITableViewAutomaticDimension
//	}
//
	required init?(coder aDecoder: NSCoder) {
		
		super.init(coder: aDecoder)
	}
	
	


}
