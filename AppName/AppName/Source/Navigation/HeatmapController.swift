//
//  HeatmapController.swift
//  AppName
//
//  Created by Aglaia on 7/1/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import UIKit
import Charts


class HeatmapController {
	
	//TODO: in truth the API I chose has included sliders and popovers in the standard chart implementation, so I might have to rename these classes
}

class HeatmapPopoverController: UIViewController {
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		
//		var chartView = ScatterChartView(frame: self.view.frame)
//
//		self.view.addSubview(chartView)
//
//		self.title = "Scatter Bar Chart"
//		self.options = [.toggleValues,
//						.toggleHighlight,
//						.animateX,
//						.animateY,
//						.animateXY,
//						.saveToGallery,
//						.togglePinchZoom,
//						.toggleAutoScaleMinMax,
//						.toggleData]
//
//		chartView.delegate = self
//
//		chartView.chartDescription?.enabled = false
//
//		chartView.dragEnabled = true
//		chartView.setScaleEnabled(true)
//		chartView.maxVisibleCount = 200
//		chartView.pinchZoomEnabled = true
//
//		let l = chartView.legend
//		l.horizontalAlignment = .right
//		l.verticalAlignment = .top
//		l.orientation = .vertical
//		l.drawInside = false
//		l.font = .systemFont(ofSize: 10, weight: .light)
//		l.xOffset = 5
//
//		let leftAxis = chartView.leftAxis
//		leftAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
//		leftAxis.axisMinimum = 0
//
//		chartView.rightAxis.enabled = false
//
//
//		let xAxis = chartView.xAxis
//		xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
//
//		sliderX.value = 45
//		sliderY.value = 100
//		slidersValueChanged(nil)
//	}
//
//	func setDataCount(_ count: Int, range: UInt32) {
//		let values1 = (0..<count).map { (i) -> ChartDataEntry in
//			let val = Double(arc4random_uniform(range) + 3)
//			return ChartDataEntry(x: Double(i), y: val)
//		}
//		let values2 = (0..<count).map { (i) -> ChartDataEntry in
//			let val = Double(arc4random_uniform(range) + 3)
//			return ChartDataEntry(x: Double(i) + 0.33, y: val)
//		}
//		let values3 = (0..<count).map { (i) -> ChartDataEntry in
//			let val = Double(arc4random_uniform(range) + 3)
//			return ChartDataEntry(x: Double(i) + 0.66, y: val)
//		}
//
//
//		let set1 = ScatterChartDataSet(values: values1, label: "DS 1")
//		set1.setScatterShape(.square)
//		set1.setColor(ChartColorTemplates.colorful()[0])
//		set1.scatterShapeSize = 8
//
//		let set2 = ScatterChartDataSet(values: values2, label: "DS 2")
//		set2.setScatterShape(.circle)
//		set2.scatterShapeHoleColor = ChartColorTemplates.colorful()[3]
//		set2.scatterShapeHoleRadius = 3.5
//		set2.setColor(ChartColorTemplates.colorful()[1])
//		set2.scatterShapeSize = 8
	}
	
}
