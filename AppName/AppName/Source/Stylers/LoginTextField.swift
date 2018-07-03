//
//  LoginTextField.swift
//  AppName
//
//  Created by Aglaia on 7/2/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class LoginTextField : UITextField {
	
	// Provides left padding for images
	override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
		var textRect = super.leftViewRect(forBounds: bounds)
		textRect.origin.x += leftPadding
		return textRect
	}
	
	@IBInspectable var leftImage: UIImage? {
		didSet {
			updateView()
		}
	}
	
	@IBInspectable var leftPadding: CGFloat = 0
	
	@IBInspectable var color: UIColor = UIColor.lightGray {
		didSet {
			updateView()
		}
	}
	
	func updateView() {
		if let image = leftImage {
			leftViewMode = UITextFieldViewMode.always
			let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
			imageView.contentMode = .scaleAspectFit
			imageView.image = image
			// Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
			imageView.tintColor = color
			leftView = imageView
		} else {
			leftViewMode = UITextFieldViewMode.never
			leftView = nil
		}
		
		// Placeholder text color
		attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedStringKey.foregroundColor: color])
	}
}