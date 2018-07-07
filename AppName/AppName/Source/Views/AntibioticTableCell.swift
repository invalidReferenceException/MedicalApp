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

}
