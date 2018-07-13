//
//  TestResultCollectionItem.swift
//  AppName
//
//  Created by Aglaia on 7/6/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import UIKit
import Charts

class TestResultCollectionItem: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
	
	enum DisplayOptions {
		case CHART_TABLEVIEW
		case TABLE_VIEW
	}
	
	@IBOutlet var title: UILabel!
	
	//@IBOutlet var heatmap: LineChartView!
	
	@IBOutlet var chart: Heatmap!
	@IBOutlet var tableView: UITableView!
	
	@IBOutlet var tableViewWidth: NSLayoutConstraint!
	@IBOutlet var scrollView: UIScrollView!
	
	var displayOptions = DisplayOptions.CHART_TABLEVIEW
	var index: Int = 0
	
	
//	required init?(coder aDecoder: NSCoder) {
//		super.init(coder: aDecoder)
//
//	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		if let antibioticCount = Database.currentUser?.associatedTests[Database.currentTestIndex].targetedAntibiogram.antibioticGroups![index].antibiotics.count {
			return antibioticCount
		}
		return 0
	}
	
	override func layoutSubviews() {
		
		let colCount = 21
		tableViewWidth.constant = (CGFloat(colCount) * 50) + 350
		scrollView.contentSize = CGSize(width: (CGFloat(colCount) * 50) + 350, height: scrollView.frame.height)
		
				chart.changeBacteriaData(antibioticGroup: (Database.currentUser?.associatedTests[Database.currentTestIndex].targetedAntibiogram.antibioticGroups![index])!)
		
		tableView.setNeedsLayout()
		tableView.layoutIfNeeded()
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "AntibioticTableCell") as! AntibioticTableCell
		
		
		if let antibiotic = Database.currentUser?.associatedTests[Database.currentTestIndex].targetedAntibiogram.antibioticGroups![index].antibiotics[indexPath.row]{
			
			
			
//			if displayOptions == .TABLE_VIEW {heatmap.isHidden = true}
//			else {heatmap.isHidden = false}
//			
			cell.dosageLabel.isHidden = true
			
			cell.nameLabel.text = antibiotic.name
			
			if let cost = antibiotic.cost {
				
				cell.priceLabel.pricePoint = cost
			}
			
			for organism in antibiotic.organisms! {
				
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
				{   label.backgroundColor = UIColor(red: 255/255.0, green: 51/255.0, blue: 0/255.0, alpha: 1)
					label.textColor = UIColor.white
				}
				else if organism.score > 60
				{   label.backgroundColor = UIColor(red: 51/255.0, green: 204/255.0, blue: 153/255.0, alpha: 1)
					label.textColor = UIColor.white
				}
				
				if organism.score == 0 {label.isHidden = true}
				cell.organismCoverageStack.addArrangedSubview(label)
				}
		
		}
			return cell
		
	}
	
}
