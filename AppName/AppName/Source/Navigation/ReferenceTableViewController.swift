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
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
        // Do any additional setup after loading the view.

    }

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
				
				let label = labelForOrganismMatchWithAntibiotic(organism: match)
				cell.organismCoverageStack.addArrangedSubview(label)
				
				print("positive recognized : " + organism)
				
			} else {
			
			let emptyLabel = UILabel()
			emptyLabel.bounds = CGRect(x: 0, y: 0, width: 40, height: 25)
				// Width constraint
				emptyLabel.addConstraint(NSLayoutConstraint.init(item:emptyLabel,
															attribute:NSLayoutAttribute.width,
															relatedBy:NSLayoutRelation.equal,
															toItem:nil,
															attribute: NSLayoutAttribute.notAnAttribute,
															multiplier:1,
															constant:40))
				//emptyLabel.alpha = 0
				emptyLabel.textAlignment = .center
				emptyLabel.text = "00"
			cell.organismCoverageStack.addArrangedSubview(emptyLabel)
				print("positive blank : " + organism)
			}
			
		}
		
		for organism in bacteriaHeader.negativeBacteria {
			if let match = organisms.first(where: {$0.name == organism})  {
				
				let label = labelForOrganismMatchWithAntibiotic(organism: match)
				cell.organismCoverageStack.addArrangedSubview(label)

				
				print("negative recognized : " + organism)

			} else {

				let emptyLabel = UILabel()
				emptyLabel.bounds = CGRect(x: 0, y: 0, width: 40, height: 25)
				// Width constraint
				emptyLabel.addConstraint(NSLayoutConstraint.init(item:emptyLabel,
															attribute:NSLayoutAttribute.width,
															relatedBy:NSLayoutRelation.equal,
															toItem:nil,
															attribute: NSLayoutAttribute.notAnAttribute,
															multiplier:1,
															constant:40))
				//emptyLabel.alpha = 0
				emptyLabel.textAlignment = .center
				emptyLabel.text = "00"
				cell.organismCoverageStack.addArrangedSubview(emptyLabel)

				print("negative blank : " + organism)
			}

		}
		
		return cell
	}
	
	
	func labelForOrganismMatchWithAntibiotic(organism: Database.Antibiogram.Antibiotic.Organism) -> UILabel{
			
			let score = Int(organism.score)
			var label = UILabel()
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
			
			if organism.score == 0 {
				label = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 25))
				//label.alpha = 0
				label.textAlignment = .center
				label.text = "00"
				
		}
		
		return label
		
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
