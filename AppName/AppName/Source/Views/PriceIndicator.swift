//
//  PriceIndicator.swift
//  AppName
//
//  Created by Aglaia on 7/7/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import UIKit

@IBDesignable class PriceIndicator: UIView {


	
	private var yellowLingots: Int = 1
	
	private let yellowLingotColor: UIColor = UIColor(red: 255/255.0, green: 222/255.0, blue: 0, alpha: 1)
	private let inactiveLingotColor: UIColor = UIColor(red: 192/255.0, green: 192/255.0, blue: 192/255.0, alpha: 1)
	
	func setLingots(_ lingotAmount: Int) {
		
		var activeLingots = lingotAmount
		
		if lingotAmount > 4 {activeLingots = 4}
		if lingotAmount < 1 {activeLingots = 1}
		
		yellowLingots = activeLingots
		
		self.setNeedsDisplay()
	}
	
	
	override func draw(_ rect: CGRect) {
		
		let context = UIGraphicsGetCurrentContext()!
		
		let spaceBetweenLingots = rect.height/15
		let lingotHeight = (rect.height/4) - spaceBetweenLingots
		let lingotWidth = rect.width
		let lingotSize = CGSize(width: lingotWidth, height: lingotHeight)
		
		let firstOrigin = CGPoint(x: 0, y: 0)
		let secondOrigin = CGPoint(x: 0, y: lingotHeight + spaceBetweenLingots)
		let thirdOrigin = CGPoint(x: 0, y: (lingotHeight * 2) + (spaceBetweenLingots * 2))
		let fourthOrigin = CGPoint(x: 0, y: (lingotHeight * 3) + (spaceBetweenLingots * 3))
		
		context.setFillColor(yellowLingotColor.cgColor)
		context.fill(CGRect(origin: fourthOrigin, size: lingotSize))

		context.setFillColor((yellowLingots < 2) ? inactiveLingotColor.cgColor : yellowLingotColor.cgColor)
		context.fill(CGRect(origin: thirdOrigin, size: lingotSize))

		context.setFillColor((yellowLingots < 3) ? inactiveLingotColor.cgColor : yellowLingotColor.cgColor)
		context.fill(CGRect(origin: secondOrigin, size: lingotSize))
		
		context.setFillColor((yellowLingots < 4) ? inactiveLingotColor.cgColor : yellowLingotColor.cgColor)
		context.fill(CGRect(origin: firstOrigin, size: lingotSize))
		
	}
	
	override func layoutSubviews() {
		
		let label = UILabel(frame: self.bounds)
		label.text = "$"
		label.adjustsFontSizeToFitWidth = true
		label.adjustsFontForContentSizeCategory = true
		label.font = UIFont(name: "Helvetica-Bold", size: 18)
		label.textAlignment = NSTextAlignment.center
		self.addSubview(label)
		
	}
	
	
	@IBInspectable var pricePoint: Int = 1 {
		didSet{
			setLingots(pricePoint)
		}
	}

}
