//
//  Heatmap.swift
//  AppName
//
//  Created by Aglaia on 7/10/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import UIKit
import Charts

class Heatmap: ScatterChartView, ChartViewDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

	
	func getValuesAt(x: Int) -> String {
		
		if let listOfAntibioticsThatMatch = antibiotics[x]?.description{
			
			var formattedResult = listOfAntibioticsThatMatch.replacingOccurrences(of: "\"", with: " ")
			formattedResult = formattedResult.replacingOccurrences(of: "[", with: "")
			formattedResult = formattedResult.replacingOccurrences(of: "]", with: "")
			
			 return formattedResult
		}
		
		return "No matches."
	}
	
	private var antibiotics: [Int : Set<String>] = Dictionary()
	
	required init?(coder aDecoder: NSCoder) {
		
		super.init(coder: aDecoder)

		
		//self.options = [.toggleValues,
//						.toggleHighlight,
//						.animateX,
//						.animateY,
//						.animateXY,
//						.saveToGallery,
//						.togglePinchZoom,
//						.toggleAutoScaleMinMax,
//						.toggleData]
		
	
		
		self.delegate = self
		
		self.chartDescription?.enabled = false
		self.legend.enabled = false
		self.dragEnabled = false
		self.setScaleEnabled(false)
		self.maxVisibleCount = 1000
		self.pinchZoomEnabled = false
		
		
		
		
		let leftAxis = self.leftAxis
		//leftAxis.drawTopYLabelEntryEnabled = false
		//leftAxis.drawBottomYLabelEntryEnabled = false
		leftAxis.drawLabelsEnabled = true
		leftAxis.drawAxisLineEnabled = false
		leftAxis.drawGridLinesEnabled = false
		leftAxis.drawZeroLineEnabled = true
		leftAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
		
		
		let formatLeft = IndexAxisValueFormatter(values: ["0","0", "0", "0", "0", "0"])
		leftAxis.valueFormatter = formatLeft
		//leftAxis.setLabelCount(3, force: true)
		
		leftAxis.axisMinimum = -21.0
		leftAxis.axisMaximum = +21.0
		
		self.rightAxis.enabled = true
		rightAxis.drawZeroLineEnabled = true
		rightAxis.drawLabelsEnabled = true
		rightAxis.drawGridLinesEnabled = false
		rightAxis.drawAxisLineEnabled = false
		
		rightAxis.axisMinimum = -21.0
		rightAxis.axisMaximum = +21.0
		
		let formatRight = IndexAxisValueFormatter(values: ["100","100", "100", "100", "100", "100"])
		rightAxis.valueFormatter = formatRight
		
		let xAxis = self.xAxis
		xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
		//xAxis.axisMaxLabels = 2
		xAxis.drawLabelsEnabled = false
		xAxis.drawGridLinesEnabled = false
		xAxis.drawAxisLineEnabled = false
		
		let marker: BalloonMarker = BalloonMarker(color: UIColor.white, font: UIFont(name: "Helvetica-Bold", size: 12)!, textColor: UIColor.darkGray, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 7.0, right: 7.0), scatterView: self)
		marker.minimumSize = CGSize(width: 75.0,height: 35.0)
		self.marker = marker

	}
	
	func changeBacteriaData(antibioticGroup: Database.Antibiogram.AntibioticGroup) {
		
		var gramPositive : [String : Int] = Dictionary()
		var gramNegative : [String : Int] = Dictionary()
			
		for antibiotic in antibioticGroup.antibiotics {
			
			
			for organism in antibiotic.organisms! {
				
				if organism.gramPositive {
					
					gramPositive.updateValue(Int(organism.score), forKey: organism.name)
				} else {
					
					gramNegative.updateValue(Int(organism.score), forKey: organism.name)
				}
				
				if var values = antibiotics[Int(organism.score)] {
					values.update(with: antibiotic.name)
					print("values: " + values.description)
					antibiotics[Int(organism.score)] = values
				} else {
					antibiotics.updateValue([antibiotic.name], forKey: Int(organism.score))
				}
				
		
			}
		}
		
		inputDatainScatterChart(data: (gramPositive, gramNegative))

	}
	
	
	private func inputDatainScatterChart(data: (positive: [String:Int], negative: [String:Int])) {
		
		
		let positiveValuesArray = data.positive.values
		let negativeValuesArray = data.negative.values
		
		var yValue = 1
		let positiveChartValues = positiveValuesArray.map{(i) -> ChartDataEntry in
			
			let entry = ChartDataEntry(x: Double(i), y: Double(yValue))
			
			yValue += 1
			
			return entry
		}
		
		yValue = -1
		let negativeChartValues = negativeValuesArray.map{(i) -> ChartDataEntry in
			
			let entry = ChartDataEntry(x: Double(i), y: Double(yValue))
			
			yValue -= 1
			
			return entry
		}
		
		
		let positiveScatter = ScatterChartDataSet(values: positiveChartValues)
		positiveScatter.setScatterShape(.circle)
		positiveScatter.setColor(NSUIColor.blue, alpha: 0.3)
		positiveScatter.scatterShapeSize = 10
		
		let negativeScatter = ScatterChartDataSet(values: negativeChartValues)
		negativeScatter.setScatterShape(.circle)
		negativeScatter.setColor(NSUIColor.magenta, alpha: 0.3)
		negativeScatter.scatterShapeSize = 10
		
		
		let inputData = ScatterChartData(dataSets: [positiveScatter, negativeScatter])
		inputData.setDrawValues(false)
		
		self.data = inputData
	}
}
