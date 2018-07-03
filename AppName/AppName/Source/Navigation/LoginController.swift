//
//  LoginNavigation.swift
//  AppName
//
//  Created by Aglaia on 7/1/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import Foundation
import UIKit

class LoginController : UIViewController {
	
	@IBOutlet var emailField: LoginTextField!
	@IBOutlet var passwordField: LoginTextField!
	
	@IBOutlet var incorrectLoginMessage: UILabel!
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	@IBAction func checkEmailInputFormat(_ sender: UITextField) {
		let email = emailField.text;
		if (!isValidEmail(email: email)) {
			//style for incorrect email
		}
	}
	
	func styleIncorrectLogin() {
		
		let myColor = UIColor.red
		emailField.layer.borderColor = myColor.cgColor
		passwordField.layer.borderColor = myColor.cgColor
		
		emailField.layer.borderWidth = 1.0
		passwordField.layer.borderWidth = 1.0
		
		incorrectLoginMessage.isHidden = false
	}
	
	func styleCorrectLogin() {
		
		emailField.layer.borderWidth = 0.0
		passwordField.layer.borderWidth = 0.0
		
		incorrectLoginMessage.isHidden = true
	}
	
	func isValidEmail(email:String?) -> Bool {
		
		guard email != nil else { return false }
		
		let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
		
		let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
		return pred.evaluate(with: email)
	}
	
	func isValidPassword(testStr:String?) -> Bool {
		
		guard testStr != nil else { return false }
		
		return true
	}
	
	@IBAction func tryToAuthenticateUser(_ sender: Any) {
		
		let email = emailField.text
		let password = passwordField.text
		
		if !isValidEmail(email: email) || !isValidPassword(testStr: password) {
			styleIncorrectLogin()
		} else {
			
			let successfulAuthentication = Database.authenticateUser(email, password)
			if successfulAuthentication {
				styleCorrectLogin()
				performSegue(withIdentifier: "loginToHomepage", sender: sender)
			}
			else {
				styleIncorrectLogin()
			}
			
		}
	}
	@IBAction func forgotPasswordHelp(_ sender: Any) {
		
	}
}
