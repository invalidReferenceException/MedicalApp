//
//  CommentCell.swift
//  AppName
//
//  Created by Aglaia on 7/13/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

	@IBOutlet var commentAvatar: UIImageView!
	@IBOutlet var commentAuthorName: UILabel!
	@IBOutlet var commentAuthorTagline: UILabel!
	@IBOutlet var commentBody: UITextView!
	@IBOutlet var commentDate: UILabel!
	
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
