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
		
		let specimen: Specimen
		let status: String
		let statusCheckpoints: [Checkpoint]
		let estimatedCompletionDateByPhase: CompletionDateByPhase
		
		let lastUpdate: String
		let finalASTDate: String
		
		let attendedBy: Bool
		let orderedBy: Bool
		let admittedBy: Bool
		
		let targetedAntibiogram: Antibiogram
		
		var comments: [Comment]?
		
		struct Specimen {
			let type: String
			let testingSpecimenProtocol: String
			let source: String?
		}
		
		
		struct Comment {
			let authorName: String
			let text: String
			let date: String
			let thumbnailUrl: String
		}
		
		
	}
	struct Checkpoint : Decodable {
		let checkpointTitle: String
		let checkpointDate: String
		let checkpointValues: [String]?
		
		private enum CodingKeys: String, CodingKey {case checkpointTitle = "title", checkpointDate = "date", checkpointValues = "values"}
	}
	
	struct CompletionDateByPhase : Decodable {
		let innoculation: String
		let gramStain: String
		let preliminaryID: String
		let finalID: String
		let organismAST: String
		
		private enum CodingKeys: String, CodingKey {case innoculation = "Innoculation", gramStain = "Gram Stain", preliminaryID = "Preliminary ID", finalID = "Final ID", organismAST = "Organism AST"}
	}
	
	struct Antibiogram : Decodable {
		
		let antibioticGroups: [AntibioticGroup]?
		
		
		struct AntibioticGroup : Decodable {
			let name: String
			let antibiotics: [Antibiotic]
			
			private enum CodingKeys: String, CodingKey {case name = "group", antibiotics}
		}
		
		struct Antibiotic : Decodable {
			let name: String
			let cost: Int?
			let organisms: [Organism]?
			
			private enum CodingKeys: String, CodingKey {case name = "antibiotic", cost, organisms}
			
			struct Organism : Decodable {
				let name: String
				let score: Float
				let gramPositive: Bool
				
				private enum CodingKeys: String, CodingKey {case name = "organism", score, gramPositive}
			}
		}
		private enum CodingKeys: String, CodingKey {case antibioticGroups = "antibiogram"}
	}
	
	

	static func authenticateUser(email: String, password: String) -> Bool {
		
		var successfullAuthentication = false

		currentUser = retrievePhysicianByEmail(email:email, password: password);
		
		if currentUser != nil {successfullAuthentication = true}

		return successfullAuthentication
	}
	
	static func retrievePhysicianByEmail(email : String, password: String) -> Physician? {
		
		let filePath = Bundle.main.path(forResource: JSONDatabase.accountFileName, ofType: "json", inDirectory: JSONDatabase.directoryName)
		let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filePath!), options: .alwaysMapped)
		
		//in practice there would be multiple accounts but the provided file only has one example physician account
		let account : JSONDatabase.Account! = try? JSONDecoder().decode(JSONDatabase.Account.self, from: jsonData!)

		if account.email == email && account.password == password {
	
			return retrieveExamplePhysician(account: account)
		}
		
		return nil
	}
	
	fileprivate static func retrieveExamplePhysician(account: JSONDatabase.Account) -> Physician {
		
		let filePath = Bundle.main.path(forResource: JSONDatabase.dashboardFileName, ofType: "json", inDirectory: JSONDatabase.directoryName)
		let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filePath!), options: .alwaysMapped)
		let dashboard : JSONDatabase.DashBoard! = try? JSONDecoder().decode(JSONDatabase.DashBoard.self, from: jsonData!)
		
		let physician = Physician( accountId: account.id,
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

		let filePath = Bundle.main.path(forResource: JSONDatabase.searchResultsFileName, ofType: "json", inDirectory: JSONDatabase.directoryName)
		
		let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filePath!), options: .alwaysMapped)
		let searchResults : JSONDatabase.SearchResults! = try? JSONDecoder().decode(JSONDatabase.SearchResults.self, from: jsonData!)
		
		var tests: [PatientTest] = []
		

		for searchResult in searchResults.items {
			
		   //one test is the summary data of the search results file + the detailed data of a sample order status for the corresponding test status
			var testPhaseFile : String
			switch searchResult.status {
			
			case "Innoculation": testPhaseFile = JSONDatabase.orderStatus1FileName
			case "Gram Stain": testPhaseFile = JSONDatabase.orderStatus2FileName
			case "Preliminary ID": testPhaseFile = JSONDatabase.orderStatus3_1FileName
			case "Final ID": testPhaseFile = JSONDatabase.orderStatus4FileName
			case "Organism AST": testPhaseFile = JSONDatabase.orderStatus5FileName
			default: testPhaseFile = JSONDatabase.orderStatus3_2FileName
			
			}
			
			let filePath = Bundle.main.path(forResource: testPhaseFile, ofType: "json", inDirectory: JSONDatabase.directoryName)
			let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filePath!), options: .alwaysMapped)
			let phaseInfo: JSONDatabase.OrderStatus = try! JSONDecoder().decode(JSONDatabase.OrderStatus.self, from: jsonData!)
			
			let patientTest = PatientTest(patientId: searchResult.id,
										  patientName: searchResult.name,
										  patientBirthDate: searchResult.birthDate,
										  patientLocation: searchResult.location,
										  specimen: PatientTest.Specimen(type:searchResult.specimen.type, testingSpecimenProtocol: searchResult.specimen.specimenProtocol, source: searchResult.specimen.source),
										  status: searchResult.status,
										  statusCheckpoints: phaseInfo.cultureDataResults,
										  estimatedCompletionDateByPhase: phaseInfo.estimatedCompletionDate,
										  lastUpdate: phaseInfo.lastUpdate,
										  finalASTDate: phaseInfo.finalAstDate,
										  attendedBy: (searchResult.attendedBy == 1) ? true : false,
										  orderedBy: (searchResult.orderedBy == 1) ? true : false,
										  admittedBy: (searchResult.admittedBy == 1) ? true : false,
										  targetedAntibiogram: (testPhaseFile == JSONDatabase.orderStatus1FileName) ? referenceTable : Antibiogram(antibioticGroups:phaseInfo.antibiogram),
										  comments: nil
			)
			
			tests.append(patientTest)
		}
		
		return tests;
	}
	
	
	static func retrieveReferenceTable() -> Antibiogram {
	
		let filePath = Bundle.main.path(forResource: JSONDatabase.orderStatus2FileName, ofType: "json", inDirectory: JSONDatabase.directoryName)
		let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filePath!), options: .alwaysMapped)
		
		let orderStatus : JSONDatabase.OrderStatus = try! JSONDecoder().decode(JSONDatabase.OrderStatus.self, from:jsonData!)
		
		print(orderStatus.cultureDataResults[0].checkpointTitle)
		
		
		return Antibiogram(antibioticGroups: orderStatus.antibiogram);
	}
	
	
	fileprivate struct JSONDatabase {
		
		static let directoryName = "JSON"
		
		static let accountFileName = "account"
		static let dashboardFileName = "dashboard"
		static let searchResultsFileName = "searchResults"
		static let orderStatus1FileName = "order_status1"
		static let orderStatus2FileName = "order_status2"
		static let orderStatus3_1FileName = "order_status3.1"
		static let orderStatus3_2FileName = "order_status3.2"
		static let orderStatus4FileName = "order_status4"
		static let orderStatus5FileName = "order_status5"
		
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
			let items : [TestSummary]
			
			struct Specimen: Decodable {
				let type: String
				let specimenProtocol: String
				let source: String?
				
				private enum CodingKeys: String, CodingKey {case type, specimenProtocol =  "protocol", source}
			}
			
			struct TestSummary: Decodable
			{
				let id: String
				let name: String
				let birthDate: String
				let specimen: Specimen
				let status: String
				let estimatedCompletionDate: String
				let attendedBy: Int
				let orderedBy: Int
				let admittedBy: Int
				let location: String
			}
		}
		
		struct OrderStatus : Decodable {
			let patient: String
			let status: String
			let estimatedCompletionDate: CompletionDateByPhase
			let finalAstDate: String
			let lastUpdate: String
			let cultureDataResults: [Checkpoint]
			
			let antibiogram : [Antibiogram.AntibioticGroup]?
			
		}
	}
}
