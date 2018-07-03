//
//  JSONLoader.swift
//  AppName
//
//  Created by Aglaia on 7/1/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import Foundation


class Database {
	
	
	var currentUser : Physician;
	
	struct Physician {
		let id: Int;
		let email: String;
		let avatarURL: String;
		let firstName: String;
		let lastName: String;
		
		let associatedTests: [Test];
		
		let recentSearches: [String];
		let attendingCount: Int;
		let orderedCount: Int;
		let admittedCount: Int;
		var notificationsCount: Int;
		
		func testsByPatientName(name: String) -> [Test];
		func testsByPatientID(id: String) -> [Test];
		func testsfoAttendings() -> [Test];
		func testsOrdered() -> [Test];
		func testsforAdmitted() -> [Test];
		
		func recentQueries() -> [String];
		func notifications() -> [(message: String, test: Test)];
		
		func addNotificationForTest(test: Test);
		func addComment(comment: String);
		
	}
	
	struct Test {
		
		let patientId: String;
		let patientName: String;
		let patientBirthDate: String;
		let patientLocation: String;
		
		let specimen: (type: String, protocol: String, source: String);
		let status: String;
		let estimatedCompletionDate: String;
		
		let attendedBy: boolean;
		let orderedBy: boolean;
		let admittedBy: boolean;
		
	}
	
	struct TestResult {
		
	}
	
	let referenceTable: (antibioticGroup: String, antibiotic: String)
	
	private var recentQueries;
	private var tests;
	private var testPhase1;
	private var testPhase2;
	private var testPhase3;
	private var testPhase4;
	private var testPhase5;
	

	
	func encodeDataToJSON (data: String) {
		
	}
	

	
	
	func authenticateUser(email: String, password: String) -> bool {
		
		if (userExists(email)) {
		
			if (isUserPassword(password, email)) {
				
				currentUser = retrievePhysicianByEmail(email);
				return true;
			}
		}
		
		return false ;
	};
	
	func retrievePhysicianByEmail(email : String) -> Physician {
		
		//JSON decoding;jmgtgh
	};
	
	func isUserPassword(password: String, ForEmail email: String) -> bool {
		
		if (isDummyPasswordOnPlist(password) || isDummyPasswordInJSONFoEmail(password)) {return true;}
		
		return false;
	};
	
	func userExists(email: String) -> bool {};
	
	func isDummyPasswordOnPlist(password : String) -> bool {};
	
	func isDummyPasswordInJSONFoEmail(email:String) -> bool {};
	
	
	
	func isValidEmail(email:String?) -> Bool {
		
		guard email != nil else { return false }
		
		let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
		
		let pred = NSPredicate(format:"SELF MATCHES %@", regEx)
		return pred.evaluate(with: email)
	}
	
	func isValidPassword(testStr:String?) -> Bool {
		guard testStr != nil else { return false }
		
		// at least one uppercase,
		// at least one digit
		// at least one lowercase
		// 8 characters total
		let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
		return passwordTest.evaluate(with: testStr)
	}
	
	
}
