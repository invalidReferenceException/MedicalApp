//
//  HomepageViewController.swift
//  AppName
//
//  Created by Aglaia on 7/5/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import UIKit

class HomepageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if let target = segue.destination as? BrowserViewController {
		
			switch segue.identifier {
			case "toRecentlyAdded":
				target.openSection = .RECENTLY_VIEWED
			case "toAttending":
				target.openSection = .ATTENDINGS
			case "toOrdered":
				target.openSection = .ORDERED
			case "toAdmitted":
				target.openSection = .ADMITTED
			default:
				return
			}
		}
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
