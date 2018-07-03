//
//  JSONLoader.swift
//  AppName
//
//  Created by Aglaia on 7/1/18.
//  Copyright © 2018 Aglaia Feli. All rights reserved.
//

import Foundation

/*
   This class accesses and restructures the example data of the provided JSON files into appropriate example test results associated to an example physician account and is in charge of keeping  record of the current user/physician, their tests and the antibiotic reference table.
*/
class Database {
	
	
	private(set) internal var currentUser : Physician?;
	let referenceTable: Antibiogram;
	
	struct Physician {
		
		let id: Int
		let email: String
		let avatarURL: String
		let firstName: String
		let lastName: String
		
		let associatedTests: [Test]
		
		let recentSearches: [String]
		let attendingCount: Int
		let orderedCount: Int
		let admittedCount: Int
		
		var notificationsCount: Int
		var notifications: [(message: String, test: Test)]?
		
		func addNotificationForTest(test: Test)
		func addComment(comment: String, OnTest test: Test)
		
	}
	
	struct Test {
		
		let patientId: String
		let patientName: String
		let patientBirthDate: String
		let patientLocation: String
		
		let specimen: (type: String, protocol: String, source: String)
		let status: String
		let statusCheckpoints: [(checkpointTitle: String, checkpointDate: String)]
		let estimatedCompletionDate: String
		
		let lastUpdate: String
		let finalASTDate: String
		
		let attendedBy: boolean
		let orderedBy: boolean
		let admittedBy: boolean
		
		let targetedAntibiogram: Antibiogram
		
	}
	
	struct Antibiogram {
		
		let antibioticGroup: (name: String, antibiotics: [Antibiotic])
		
		struct Antibiotic {
			let name: String
			let cost: Int
			let organisms: (name: String, gramPositive: bool, score: Int)?
		}
	}
	
	
	func authenticateUser(email: String, password: String) -> bool {
		
		var successfullAuthentication = false

		currentUser = retrievePhysicianByEmail(email);
		
		if currentUser != nil {successfullAuthentication = true}

		return successfullAuthentication
	};
	
	func retrievePhysicianByEmail(email : String, password: String) -> Physician? {
		
		var database: JSONDatabase
		
		let filePath = Bundle.main.path(forResource: database.accountFileName, ofType: "json", inDirectory: database.directoryName)
		
		//in practice there would be multiple accounts but the provided file only has one example physician account
		let account : JSONDatabase.Account = JSONDecoder().decode(JSONDatabase.Account.self, from: filePath)

		if account.email == email && account.password == password {
	
			return retrieveExamplePhysician()
		}
		
		return nil;
	};
	
	func retrieveExamplePhysician() -> Physician {
		
		var physician = Physician();
		//TODO:
		return physician
		
	}
	
	func assembleTestDummies() -> [Test] {
		//TODO:
	};
	
	func assembleReferenceTable() -> [Antibiogram] {
		//TODO:
	};
	
	
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
	
	fileprivate struct JSONDatabase {
		
		let directoryName = "JSON"
		
		let accountFileName = "account"
		let dashboardFileName = "dashboard"
		let searchResultsFileName = "searchResults"
		let orderStatus1FileName = "order_status1"
		let orderStatus2FileName = "order_status2"
		let orderStatus3_1FileName = "order_status3.1."
		let orderStatus3_2FileName = "order_status3.2"
		let orderStatus4FileName = "order_status4"
		let orderStatus5FileName = "order_status5"
		
		struct Account : Decodable {
			let id: Int
			let email: String
			let password: String
			let avatarUrl: String
			let firstName: String
			let lastName: String
		}
		
		struct DashBoard : Decodable {
			let recentlyViewed: [String]
			let recentlyViewedCount: Int
			let attendingCount: Int
			let orderedCount: Int
			let admittedCount: Int
			let notificationsCount: Int
		}
		
		struct SearchResults : Decodable {
			let items : [(id: String,
						  name: String,
						  birthDate: String,
			              specimen: (type: String,
					                 protocol: String,
					                 source: String?
			                         ),
						  status: String,
			              estimatedCompletionDate: String,
			              attendedBy: bool,
			              orderedBy: bool,
			              admittedBy: bool,
			              location: String
					   )]
		}
		
		struct OrderStatus : Decodable {
			let patient: String
			let status: String
			let estimatedCompletionDate: CompletionDateByPhase
			let finalAstDate: String
			let lastUpdate: String
			let cultureDataResults: [(title: String, date: String)]
			
			let antibiogram : Antibiogram?
		}
		
		struct CompletionDateByPhase : Decodable {
			let innoculation: String
			let gramStain: String
			let preliminaryID: String
			let finalID: String
			let organismAST: String
			
			private enum CodingKeys: String, CodingKey {case innoculation, gramStain = "Gram Stain", preliminaryID = "Preliminary ID", finalID = "Final ID", organismAST = "Organism AST"}
		}
	}
}
