//
//  Browse.swift
//  AppName
//
//  Created by Aglaia on 7/1/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import Foundation
import UIKit

class BrowserView : UIView {
	
	@IBOutlet var recentlyViewedSelectionUnderline: UILabel!
	@IBOutlet var attendingSelectionUnderline: UILabel!
	@IBOutlet var orderedSelectionUnderline: UILabel!
	@IBOutlet var admittedSelectionUnderline: UILabel!
	
	@IBOutlet var selectedSectionTitle: UILabel!
	@IBOutlet var selectedSectionResultNumber: UILabel!
	
	@IBOutlet var sortingByIndicator: UIButton!
	
}
