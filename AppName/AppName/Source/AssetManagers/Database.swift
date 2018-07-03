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
	
	
	static private(set) internal var currentUser : Physician?;
	static private(set) internal var currentTestIndex : Int = 0;
	static let referenceTable: Antibiogram = retrieveReferenceTable();
	
	struct Physician {
		
		let accountId: Int
		let email: String
		let avatarURL: String
		let firstName: String
		let lastName: String
		
		let associatedTests: [PatientTest]
		
		let recentSearches: [String]
		let attendingCount: Int
		let orderedCount: Int
		let admittedCount: Int
		
		var notificationsCount: Int
		var notifications: [(message: String, test: PatientTest)]?
		
		//TODO:
		func addNotificationForTest(test: PatientTest){}
		func addComment(comment: String, OnTest test: PatientTest){}
		
	}
	
	struct PatientTest {
		
		let patientId: String
		let patientName: String
		let patientBirthDate: String
		let patientLocation: String
		
		let specimen: (type: String, testingProtocol: String, source: String?)
		let status: String
		let statusCheckpoints: [(checkpointTitle: String, checkpointDate: String)]
		let estimatedCompletionDate: String
		
		let lastUpdate: String
		let finalASTDate: String
		
		let attendedBy: Bool
		let orderedBy: Bool
		let admittedBy: Bool
		
		let targetedAntibiogram: Antibiogram
		
		var comments: [(authorName: String, text: String, date: String, thumbnailUrl: String)]
	}
	
	struct Antibiogram {
		
		let antibioticGroup: (name: String, antibiotics: [Antibiotic])
		
		struct Antibiotic {
			let name: String
			let cost: Int
			let organisms: (name: String, gramPositive: bool, score: Int)?
		}
	}
	
	

	static func authenticateUser(email: String, password: String) -> bool {
		
		var successfullAuthentication = false

		currentUser = retrievePhysicianByEmail(email);
		
		if currentUser != nil {successfullAuthentication = true}

		return successfullAuthentication
	}
	
	static func retrievePhysicianByEmail(email : String, password: String) -> Physician? {
		
		var database: JSONDatabase
		
		let filePath = Bundle.main.path(forResource: database.accountFileName, ofType: "json", inDirectory: database.directoryName)
		
		//in practice there would be multiple accounts but the provided file only has one example physician account
		let account : JSONDatabase.Account = JSONDecoder().decode(JSONDatabase.Account.self, from: filePath)

		if account.email == email && account.password == password {
	
			return retrieveExamplePhysician(account)
		}
		
		return nil
	}
	
	static func retrieveExamplePhysician(account: JSONDatabase.Account) -> Physician {
		
		var database: JSONDatabase
		
		let filePath = Bundle.main.path(forResource: database.dashboardFileName, ofType: "json", inDirectory: database.directoryName)
		let dashboard : JSONDatabase.DashBoard = JSONDecoder().decode(JSONDatabase.DashBoard.self, from: filePath)
		
		var physician = Physician( accountId: account.id,
											  email: account.email,
											  avatarURL: account.avatarUrl,
											  firstName: account.firstName,
											  lastName: account.lastName,
											  associatedTests: retrieveExampleTests(),
											  recentSearches: dashboard.recentlyViewed,
											  attendingCount: dashboard.attendingCount,
											  orderedCount: dashboard.orderedCount,
											  admittedCount: dashboard.admittedCount,
											  notificationsCount: dashboard.notificationsCount,
											  notifications: nil
		)
		return physician
	}
	
	static func retrieveExampleTests() -> [PatientTest] {
		
		var database: JSONDatabase
		let filePath = Bundle.main.path(forResource: database.searchResultsFileName, ofType: "json", inDirectory: database.directoryName)
		
		var searchResults : JSONDatabase.SearchResults = JSONDecoder().decode(JSONDatabase.SearchResults.self, from: filePath)
		
		var tests: [PatientTest]
		

		for searchResult in searchResults.items {
			
		   //one test is the summary data of the search results file + the detailed data of a sample order status for the corresponding test status
			var testPhaseFile : String
			switch searchResult.status {
			
			case "Innoculation": testPhaseFile = database.orderStatus1FileName
			case "Gram Stain": testPhaseFile = database.orderStatus2FileName
			case "Preliminary ID": testPhaseFile = database.orderStatus3_1FileName
			case "Final ID": testPhaseFile = database.orderStatus4FileName
			case "Organism AST": testPhaseFile = database.orderStatus5FileName
			default: testPhaseFile = database.orderStatus3_2FileName
			
			}
			
			let filePath = Bundle.main.path(forResource: testPhaseFile, ofType: "json", inDirectory: database.directoryName)
			var phaseInfo: JSONDatabase.OrderStatus = JSONDecoder().decode(JSONDatabase.OrderStatus.self, from: filePath)
			
			let patientTest = PatientTest(patientId: searchResult.id,
										  patientName: searchResult.name,
										  patientBirthDate: searchResult.birthDate,
										  patientLocation: searchResult.location,
										  specimen: searchResult.specimen,
										  status: searchResult.status,
										  statusCheckpoints: phaseInfo.cultureDataResults,
										  estimatedCompletionDate: searchResult.estimatedCompletionDate,
										  lastUpdate: phaseInfo.lastUpdate,
										  fintalASTDate: phaseInfo.finalAstDate,
										  attendedBy: searchResult.attendedBy,
										  orderedBy: searchResult.orderedBy,
										  admittedBy: searchResult.admittedBy
			)
			
			tests += patientTest
		}
		
		return tests;
	}
	
	
	static func retrieveReferenceTable() -> Antibiogram {
		//TODO: figure out exception throwing here
		let database: JSONDatabase
		let filePath = Bundle.main.path(forResource: database.orderStatus2FileName, ofType: "json", inDirectory: database.directoryName)
		let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filePath!), options: .alwaysMapped)
		
		let orderStatus : JSONDatabase.OrderStatus! = try? JSONDecoder().decode(JSONDatabase.OrderStatus.self, from:jsonData!)
		
		return orderStatus.antibiogram!;
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
			              attendedBy: Bool,
			              orderedBy: Bool,
			              admittedBy: Bool,
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
