//
//  RoundButton.swift
//  AppName
//
//  Created by Aglaia on 7/6/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import UIKit

@IBDesignable class RoundButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		sharedInit()
	}

	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		sharedInit()
	}
	
	
	override func prepareForInterfaceBuilder() {
		sharedInit()
	}
	
	func sharedInit(){
		refreshCorners(value: cornerRadius)
		refreshColor(color: backgroundImageColor)
	}
	
	func refreshCorners(value: CGFloat) {
		layer.cornerRadius = value
	}
	
	@IBInspectable var cornerRadius: CGFloat = 15 {
		didSet{
			refreshCorners(value: cornerRadius)
		}
	}
	
	func makeImage(color: UIColor) -> UIImage {
		UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), true, 0.0)
		color.setFill()
		UIRectFill(CGRect(x: 0, y: 0, width: 1, height: 1))
		let image = UIGraphicsGetImageFromCurrentImageContext()!
		return image
		
	}
	
	func refreshColor(color: UIColor) {
		let image = makeImage(color: color)
		setBackgroundImage(image, for: UIControlState.normal)
		clipsToBounds = true
		
	}
	
	@IBInspectable var backgroundImageColor: UIColor = UIColor.init(red: 0, green: 122/255.0, blue: 255/255.0, alpha: 1)  {
		didSet {
			refreshColor(color: backgroundImageColor)
		}
	}
	
}
