//
//  PageViewController.swift
//  AppName
//
//  Created by Aglaia on 7/8/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

	
	var testResult : TestResultViewController!
	var referenceTable : ReferenceTableViewController!

	required init?(coder: NSCoder) {
		
		super.init(coder: coder)
		
		self.delegate = self
		self.dataSource = self	
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		testResult =  storyboard?.instantiateViewController(withIdentifier: "TestResultViewController") as! TestResultViewController
		referenceTable = storyboard?.instantiateViewController(withIdentifier: "ReferenceTableViewController") as! ReferenceTableViewController

		setViewControllers([testResult], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController)-> UIViewController? {
		
		// if you prefer to NOT scroll circularly, simply add here:
		if viewController is TestResultViewController{ return nil }
		
		return testResult
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController)-> UIViewController? {
		
		if viewController is ReferenceTableViewController {return nil}
		
		return referenceTable
	}
	
	func presentationIndex(for pageViewController: UIPageViewController)-> Int {
		
		if pageViewController == testResult {return 1}
		return 2
	}

	func presentationCount(for pageViewController: UIPageViewController) -> Int {
		return 2
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
