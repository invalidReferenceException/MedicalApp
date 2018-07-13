//
//  CircularStatusIndicator.swift
//  AppName
//
//  Created by Aglaia on 7/9/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import UIKit

@IBDesignable class CircularStatusIndicator: UIView {

	 private var _progressLineWidth : Float = 1.0
	 private var _trackLineWidth : Float = 2.0
	
	 private var _trackColor: UIColor = UIColor.lightGray
	 private var _progressColor: UIColor = UIColor.green
	
	 private var _progressStatus: Int = 360

    override func draw(_ rect: CGRect) {
        // Drawing code
		let radius = Float(rect.width/2.0)
		
		let arcRadius = max(radius - _trackLineWidth , radius - _progressLineWidth)
		
		let context = UIGraphicsGetCurrentContext()!
		
		context.addArc(center: CGPoint(x: rect.width / 2.0, y: rect.height / 2.0), radius: CGFloat(arcRadius), startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: false)
		
		
		context.setStrokeColor(_trackColor.cgColor)
		context.setFillColor(UIColor.clear.cgColor)
		context.setLineWidth(CGFloat(_trackLineWidth))
		context.setLineCap(CGLineCap.butt)
		context.drawPath(using: .fillStroke)
		
		let progressStatusRadians = CGFloat(_progressStatus) * ((CGFloat.pi * 2) / 360)
		
		context.addArc(center: CGPoint(x: rect.width / 2.0, y: rect.height / 2.0), radius: CGFloat(arcRadius), startAngle: 0, endAngle: progressStatusRadians, clockwise: false)

		context.setStrokeColor(_progressColor.cgColor)
		context.setFillColor(UIColor.clear.cgColor)
		context.setLineWidth(CGFloat(_progressLineWidth))
		context.setLineCap(CGLineCap.butt)
		context.drawPath(using: .fillStroke)
		
    }
	
	@IBInspectable var progressLineWidth: Float = 1 {
		didSet{
			_progressLineWidth = progressLineWidth
			self.setNeedsDisplay()
		}
	}
	
	@IBInspectable var trackLineWidth: Float = 2{
		didSet{
			_trackLineWidth = trackLineWidth
			self.setNeedsDisplay()
		}
	}
	
	@IBInspectable var progressColor: UIColor = UIColor.green{
		didSet{
			_progressColor = progressColor
			self.setNeedsDisplay()
		}
	}
	
	@IBInspectable var trackColor: UIColor = UIColor.lightGray{
		didSet{
			_trackColor = trackColor
			self.setNeedsDisplay()
		}
	}

	@IBInspectable var progressStatus: Int = 360{
		didSet{
			_progressStatus = progressStatus
			self.setNeedsDisplay()
		}
	}

}
