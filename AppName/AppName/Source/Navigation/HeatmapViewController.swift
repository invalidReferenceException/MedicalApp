//
//  HeatmapViewController.swift
//  AppName
//
//  Created by Aglaia on 7/8/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import UIKit

class HeatmapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
//    */
//	
//	@IBOutlet var chartView: ScatterChartView!
//	@IBOutlet var sliderX: UISlider!
//	@IBOutlet var sliderY: UISlider!
//	@IBOutlet var sliderTextX: UITextField!
//	@IBOutlet var sliderTextY: UITextField!
//	
//	override func viewDidLoad() {
//		super.viewDidLoad()
//		
//		// Do any additional setup after loading the view.
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
//	func updateChartData() {
//		if self.shouldHideData {
//			chartView.data = nil
//			return2
//		}
//		
//		self.setDataCount(Int(sliderX.value + 1), range: UInt32(sliderY.value))
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
//		
//		let set3 = ScatterChartDataSet(values: values3, label: "DS 3")
//		set3.setScatterShape(.cross)
//		set3.setColor(ChartColorTemplates.colorful()[2])
//		set3.scatterShapeSize = 8
//		
//		let data = ScatterChartData(dataSets: [set1, set2, set3])
//		data.setValueFont(.systemFont(ofSize: 7, weight: .light))
//		
//		chartView.data = data
//	}
//	
//	override func optionTapped(_ option: Option) {
//		super.handleOption(option, forChartView: chartView)
//	}
//	
//	@IBAction func slidersValueChanged(_ sender: Any?) {
//		sliderTextX.text = "\(Int(sliderX.value))"
//		sliderTextY.text = "\(Int(sliderY.value))"
//		
//		self.updateChartData()
//	}
//}
//
}
