//
//  ReferenceTableViewController.swift
//  AppName
//
//  Created by Aglaia on 7/8/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import UIKit

extension UIStackView {
	
	func safelyRemoveArrangedSubviews() {
		
		// Remove all the arranged subviews and save them to an array
		let removedSubviews = arrangedSubviews.reduce([]) { (sum, next) -> [UIView] in
			self.removeArrangedSubview(next)
			return sum + [next]
		}
		
		// Deactive all constraints at once
		NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
		
		// Remove the views from self
		removedSubviews.forEach({ $0.removeFromSuperview() })
	}
}

class ReferenceTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	
	@IBOutlet var commentsArea: UIView!
	@IBOutlet var scrollView: UIScrollView!
	@IBOutlet var bacteriaHeader: BacteriaHeaderView!	
	@IBOutlet var tableView: UITableView!
	@IBOutlet weak var tableVIewWidth: NSLayoutConstraint!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	
	override func viewDidAppear(_ animated: Bool) {

		let colCount = bacteriaHeader.positiveBacteria.count + bacteriaHeader.negativeBacteria.count
		tableVIewWidth.constant = (CGFloat(colCount) * 50) + 350
		scrollView.contentSize = CGSize(width: (CGFloat(colCount) * 50) + 350, height: scrollView.frame.height)

		tableView.setNeedsLayout()
		tableView.layoutIfNeeded()
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return Database.referenceTable.antibioticGroups![section].antibiotics.count
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		
		tableView.tableHeaderView = bacteriaHeader
		tableView.tableFooterView = commentsArea
		//tableView.frame.size = CGSize(width: 1500, height: 1000)
		
		return Database.referenceTable.antibioticGroups!.count
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
		
		cell.organismCoverageStack.safelyRemoveArrangedSubviews()
	
		let organisms = antibiotic.organisms!
		
		for organism in bacteriaHeader.positiveBacteria {
			if let match = organisms.first(where: {$0.name == organism}) {
				
				let label = cell.labelForOrganismMatchWithAntibiotic(organism: match)
				cell.organismCoverageStack.addArrangedSubview(label)
				
			} else {
			
			    let emptyLabel = cell.makeLabel()
				cell.organismCoverageStack.addArrangedSubview(emptyLabel)
			}
		}
		
		for organism in bacteriaHeader.negativeBacteria {
			if let match = organisms.first(where: {$0.name == organism})  {
				
				let label = cell.labelForOrganismMatchWithAntibiotic(organism: match)
				cell.organismCoverageStack.addArrangedSubview(label)

			} else {

				let emptyLabel = cell.makeLabel()
				cell.organismCoverageStack.addArrangedSubview(emptyLabel)
			}
		}
		
		return cell
	}
	
	/*
	// Only override draw() if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func draw(_ rect: CGRect) {
	// Drawing code
	}
	*/

}
