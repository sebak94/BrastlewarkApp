//
//  GetCitizenGenderInteractorTests.swift
//  BrastlewarkAppTests
//
//  Created by Felipe Ferrari on 01/09/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import BrastlewarkApp

class GetCitizenGenderInteractorTests: QuickSpec {

	override func spec() {
		describe("GetCitizenGender") {

			let youngWoman1 = CitizenFactory.citizen(
				name: "young woman 1",
				age: 100,
				weight: 34.0,
				height: 90.0,
				hairColor: "Pink"
			)
			let youngWoman2 = CitizenFactory.citizen(
				name: "young woman 2",
				age: 100,
				weight: 34.0,
				height: 90.0,
				hairColor: "Red"
			)
			let oldWoman1 = CitizenFactory.citizen(
				name: "old woman 1",
				age: 350,
				weight: 34.0,
				height: 90.0,
				hairColor: "Gray"
			)
			let oldMan1 = CitizenFactory.citizen(
				name: "old man 1",
				age: 400,
				weight: 46.0,
				height: 130.0,
				hairColor: "Gray"
			)
			let youngMan1 = CitizenFactory.citizen(
				name: "young man 1",
				age: 123,
				weight: 46.0,
				height: 130.0,
				hairColor: "Black"
			)
			let youngMan2 = CitizenFactory.citizen(
				name: "young man 2",
				age: 123,
				weight: 46.0,
				height: 130.0,
				hairColor: "Green"
			)
			let citizens = [
				youngWoman1,
				youngWoman2,
				oldWoman1,
				oldMan1,
				youngMan1,
				youngMan2
			]
			let repository = CitizenRepository(citizens: citizens)
			let interactor = GetGenderInteractor(citizenRepository: repository)

			context("given a young male") {
				it("returns male") {
					let result = interactor.calculateGender(for: youngMan1)
					expect(result) == CitizenGender.male
				}
			}

			context("given another young male") {
				it("returns male") {
					let result = interactor.calculateGender(for: youngMan2)
					expect(result) == CitizenGender.male
				}
			}

			context("given a young female") {
				it("returns female") {
					let result = interactor.calculateGender(for: youngWoman1)
					expect(result) == CitizenGender.female
				}
			}

			context("given another young female") {
				it("returns female") {
					let result = interactor.calculateGender(for: youngWoman2)
					expect(result) == CitizenGender.female
				}
			}

			context("given an old female") {
				it("returns female") {
					let result = interactor.calculateGender(for: oldWoman1)
					expect(result) == CitizenGender.female
				}
			}

			context("given an old male") {
				it("returns male") {
					let result = interactor.calculateGender(for: oldMan1)
					expect(result) == CitizenGender.male
				}
			}
		}
	}
}
