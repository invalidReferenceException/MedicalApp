//
//  TestResultTableCell.swift
//  AppName
//
//  Created by Aglaia on 7/3/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import UIKit

class TestResultTableCell: UITableViewCell {

	@IBOutlet var nameLabel: UILabel!
	@IBOutlet var idLabel: UILabel!
	@IBOutlet var dobLabel: UILabel!
	@IBOutlet var testProtocolLabel: UILabel!
	@IBOutlet var testTypeLabel: UILabel!
	@IBOutlet var currentStatusLabel: UILabel!
	@IBOutlet var currentStatusIcon: UIImageView!
	@IBOutlet var estimatedCompletionLabel: UILabel!
	
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
