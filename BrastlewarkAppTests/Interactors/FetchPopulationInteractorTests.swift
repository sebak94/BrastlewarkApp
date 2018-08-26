//
//  FetchPopulationInteractorTests.swift
//  BrastlewarkAppTests
//
//  Created by Felipe Ferrari on 26/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//


@testable import BrastlewarkApp

import Foundation
import Quick
import Nimble
import Mockingjay
import RxBlocking
import Alamofire

class FetchPopulationInteractorTests: QuickSpec {
	static let baseURL = "http://api.example.com"

	static let citizen = CitizenFactory.citizen()
	static let citizenDictionary = CitizenFactory.citizen().toDictionary()
	static let getCitizensResponse: [String: [[String: Any]]] =
		["Brastlewark" : [ citizenDictionary ]]

	override func spec() {
		let fetchPopulationURL
			= "\(FetchPopulationInteractorTests.baseURL)/rrafols/mobile_test/master/data.json"
		let api = BrastlewarkApi (baseURL: URL(string: fetchPopulationURL)!)
		let fetchPopulation = FetchPopulationInteractor (api: api)

		context ("with an invalid response") {
			beforeEach {
				self.stub (
					contains(fetchPopulationURL, method: "GET"),
					json([], status: 200)
				)
			}

			it ("throws an error of invalidResponse") {
				let blockObs = fetchPopulation.execute().toBlocking()
				expect { try blockObs.first() }
					.to(throwError(FetchPopulationInteractorError.invalidResponse))
			}
		}

		context("with two valid trips and one invalid") {
			beforeEach {
				self.stub (
					contains(fetchPopulationURL, method: "GET"),
					json(FetchPopulationInteractorTests.getCitizensResponse, status: 200)
				)
			}

			it("returns a valid citizen") {
				let blockObs = fetchPopulation.execute().toBlocking()
				guard
					let response = try? blockObs.first(),
					response?.count == 1
					else { fail(); return }

				expect(response?[0].id) == FetchPopulationInteractorTests.citizen.id
			}
		}
	}


}


