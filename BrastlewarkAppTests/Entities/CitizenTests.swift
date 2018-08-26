//
//  CitizenTests.swift
//  BrastlewarkAppTests
//
//  Created by Felipe Ferrari on 26/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import BrastlewarkApp

class CitizenTests: QuickSpec {
	override func spec() {
		describe("init from dictionary") {
			let userDictionary: [String: Any] = [
				"id": 1,
				"name": "Test",
				"thumbnail": "http://www.publicdomainpictures.net/pictures/10000/nahled/thinking-monkey-11282237747K8xB.jpg",
				"age": 100,
				"weight": 10.0,
				"height": 20.0,
				"hair_color": "aColor",
				"professions": ["1","2"],
				"friends" : ["friend","foe"]

			]

			it("creates the citizen with the correct values") {
				let citizen = try! Citizen (fromDictionary: userDictionary)

				expect(citizen.id) == 1
				expect(citizen.name) == "Test"
				expect(citizen.age) == 100
				expect(citizen.weight) == 10.0
				expect(citizen.height) == 20.0
				expect(citizen.hairColor) == "aColor"
				expect(citizen.professions) == ["1","2"]
				expect(citizen.friends) == ["friend","foe"]

				if let imageURL = try? userDictionary.urlValueOf("http://www.publicdomainpictures.net/pictures/10000/nahled/thinking-monkey-11282237747K8xB.jpg") {
					expect(citizen.imageURL) == imageURL
				}
			}
		}
	}
}

