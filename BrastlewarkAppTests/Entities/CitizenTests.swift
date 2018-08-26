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
			let citizenDictionary: [String: Any] = CitizenFactory.citizen().toDictionary()

			it("creates the citizen with the correct values") {
				let citizen = try! Citizen (fromDictionary: citizenDictionary)

				expect(citizen.id) == 0
				expect(citizen.name) == "Tobus Quickwhistle"
				expect(citizen.age) ==  306
				expect(citizen.weight) == 39.065952
				expect(citizen.height) == 107.75835
				expect(citizen.hairColor) == "Pink"
				expect(citizen.professions) ==  [
					"Metalworker",
					"Woodcarver",
					"Stonecarver",
					" Tinker",
					"Tailor",
					"Potter"
				]
				expect(citizen.friends) ==  [
					"Cogwitz Chillwidget",
					"Tinadette Chillbuster"
				]

				if let imageURLString = citizenDictionary["thumbnail"] as? String,
				let imageURL = URL( string: imageURLString ) {
					expect(citizen.imageURL) == imageURL
				}
			}
		}

		describe("toDictionary") {
			let citizen = CitizenFactory.citizen()

			it ("returns a dictionary with the correct values") {
				let citizenDictionary = citizen.toDictionary()

				expect (citizenDictionary["id"] as? Int) == 0
				expect (citizenDictionary["name"] as? String) == "Tobus Quickwhistle"
				expect (citizenDictionary["age"] as? Int) == 306
				expect (citizenDictionary["weight"] as? Double) == 39.065952
				expect (citizenDictionary["height"] as? Double) == 107.75835
				expect (citizenDictionary["hair_color"] as? String) == "Pink"
				expect (citizenDictionary["professions"] as? [String]) ==  [
					"Metalworker",
					"Woodcarver",
					"Stonecarver",
					" Tinker",
					"Tailor",
					"Potter"
				]
				expect (citizenDictionary["friends"] as? [String]) == [
					"Cogwitz Chillwidget",
					"Tinadette Chillbuster"
				]


			}
		}
	}
}

