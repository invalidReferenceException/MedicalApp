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
//
//class HeatmapPopoverController: UIViewController {
//
//
//	var chartView : ScatterChartView
//
//	override func viewDidLoad() {
//
//		super.viewDidLoad()
//
//		chartView = ScatterChartView(frame: self.view.frame)
//
//		self.view.addSubview(chartView)
//
//		self.title = "Scatter Bar Chart"
//		char.options = [.toggleValues,
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
//
//	func getBacteriaData(test : Database.PatientTest, antibioticGroup: String) -> (positive: [String : Int], negative: [String : Int]){
//
//		var gramPositive : [String : Int] = Dictionary()
//		var gramNegative : [String : Int] = Dictionary()
//
//		if let group =  test.targetedAntibiogram.antibioticGroups!.first(where: {$0.name == antibioticGroup}) {
//
//			for antibiotic in group.antibiotics {
//
//				for organism in antibiotic.organisms! {
//
//					if organism.gramPositive {
//						gramPositive.updateValue(Int(organism.score), forKey: organism.name)
//					} else {
//						gramNegative.updateValue(Int(organism.score), forKey: organism.name)
//					}
//				}
//			}
//		}
//
//		return (gramPositive, gramNegative)
//	}
//
//
//
//	func inputDatainScatterChart(data: (positive: [String:Int], negative: [String:Int])) {
//
//
//		let positiveValuesArray = data.positive.values
//		let negativeValuesArray = data.negative.values
//
//		var yValue = 1
//		let positiveChartValues = positiveValuesArray.map{(i) -> ChartDataEntry in
//
//			let entry = ChartDataEntry(x: Double(i), y: Double(yValue))
//
//			yValue += 1
//
//			return entry
//		}
//
//		yValue = -1
//		let negativeChartValues = negativeValuesArray.map{(i) -> ChartDataEntry in
//
//			let entry = ChartDataEntry(x: Double(i), y: Double(yValue))
//
//			yValue -= 1
//
//			return entry
//		}
//
//
//		let positiveScatter = ScatterChartDataSet(values: positiveChartValues, label: "Gram Positive")
//		positiveScatter.setScatterShape(.circle)
//		positiveScatter.setColor(NSUIColor.blue, alpha: 0.6)
//		positiveScatter.scatterShapeSize = 2
//
//		let negativeScatter = ScatterChartDataSet(values: negativeChartValues, label: "Gram Negative")
//		negativeScatter.setScatterShape(.circle)
//		negativeScatter.setColor(NSUIColor.magenta, alpha: 0.6)
//		negativeScatter.scatterShapeSize = 2
//
//
//		let inputData = ScatterChartData(dataSets: [positiveScatter, negativeScatter])
//		inputData.setValueFont(.systemFont(ofSize: 5, weight: .light))
//
//		chartView.data = inputData
//	}
//
//
//
//
//}
