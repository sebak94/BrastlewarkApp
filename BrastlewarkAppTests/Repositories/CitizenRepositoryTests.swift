//
//  CitizenRepositoryTests.swift
//  BrastlewarkAppTests
//
//  Created by Felipe Ferrari on 28/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//


import Foundation
import Quick
import Nimble
@testable import BrastlewarkApp

class CitizenRepositoryTests: QuickSpec {

	override func spec() {
		describe("filter by name") {

			let citizens = [
				CitizenFactory.citizen(name: "Test Name 1"),
				CitizenFactory.citizen(name: "Name for test 2"),
				]
			let repository = CitizenRepository(citizens: citizens)
			
			context("when filter is called with a query contained in one citizen") {
				it("returns only that citizen") {
					let result = repository.filter(by: .name, withQuery: "for")
					expect(result.first!.name) == citizens[1].name
				}
			}

			context("when filter is called with a query contained in none of the citizens") {
				it("returns no citizens") {
					let result = repository.filter(by: .name, withQuery: "qwerqwer")
					expect(result.isEmpty).to(beTrue())
				}
			}

			context("when filter is called with a query contained in both citizens") {
				it("returns both citizens") {
					let result = repository.filter(by: .name, withQuery: "Name")
					expect(result.count) == 2
				}
			}

			context("when filter is called with a query contained in both citizens but with different casing") {
				it("returns both citizens") {
					let result = repository.filter(by: .name, withQuery: "test")
					expect(result.count) == 2
				}
			}

			context("when filter is called with a query contained in both citizens ") {
				it("returns both citizens") {
					let result = repository.filter(by: .name, withQuery: " ")
					expect(result.count) == 2
				}
			}
		}

		describe("filter by name") {

			let citizens = [
				CitizenFactory.citizen(hairColor: "Test Name 1"),
				CitizenFactory.citizen(hairColor: "Name for test 2"),
				]
			let repository = CitizenRepository(citizens: citizens)

			context("when filter is called with a query contained in one citizen") {
				it("returns only that citizen") {
					let result = repository.filter(by: .hairColor, withQuery: "for")
					expect(result.first!.hairColor) == citizens[1].hairColor
				}
			}

			context("when filter is called with a query contained in none of the citizens") {
				it("returns no citizens") {
					let result = repository.filter(by: .hairColor, withQuery: "qwerqwer")
					expect(result.isEmpty).to(beTrue())
				}
			}

			context("when filter is called with a query contained in both citizens") {
				it("returns both citizens") {
					let result = repository.filter(by: .hairColor, withQuery: "Name")
					expect(result.count) == 2
				}
			}

			context("when filter is called with a query contained in both citizens but with different casing") {
				it("returns both citizens") {
					let result = repository.filter(by: .hairColor, withQuery: "test")
					expect(result.count) == 2
				}
			}

			context("when filter is called with a query contained in both citizens ") {
				it("returns both citizens") {
					let result = repository.filter(by: .hairColor, withQuery: " ")
					expect(result.count) == 2
				}
			}
		}

		describe("filter by age") {

			let citizens = [
				CitizenFactory.citizen(age: 111),
				CitizenFactory.citizen(age: 222),
				]
			let repository = CitizenRepository(citizens: citizens)

			context("when filter is called with a query contained in one citizen") {
				it("returns only that citizen") {
					let result = repository.filter(by: .age, withQuery: [1,112])
					expect(result.count) == 1
				}
			}

			context("when filter is called with a query contained in one citizen") {
				it("returns only that citizen") {
					let result = repository.filter(by: .age, withQuery: [112,223])
					expect(result.count) == 1
				}
			}

			context("when filter is called with a query contained in none of the citizens") {
				it("returns no citizens") {
					let result = repository.filter(by: .age, withQuery: [1,2])
					expect(result.count) == 0
				}
			}

			context("when filter is called with a query contained both of the citizens") {
				it("returns both citizens") {
					let result = repository.filter(by: .age, withQuery: [1,1000])
					expect(result.count) == 2
				}
			}
		}

		describe("filter by weight") {

			let citizens = [
				CitizenFactory.citizen(weight: 111.1),
				CitizenFactory.citizen(weight: 222.2),
				]
			let repository = CitizenRepository(citizens: citizens)

			context("when filter is called with a query contained in one citizen") {
				it("returns only that citizen") {
					let result = repository.filter(by: .weight, withQuery: [1.0,112.1])
					expect(result.count) == 1
				}
			}

			context("when filter is called with a query contained in one citizen") {
				it("returns only that citizen") {
					let result = repository.filter(by: .weight, withQuery: [112.0,223.0])
					expect(result.count) == 1
				}
			}

			context("when filter is called with a query contained in both citizens") {
				it("returns one citizens") {
					let result = repository.filter(by: .weight, withQuery: [111.0,111.2])
					expect(result.count) == 1
				}
			}

			context("when filter is called with a query contained in none of the citizens") {
				it("returns no citizens") {
					let result = repository.filter(by: .weight, withQuery: [1.0,2.0])
					expect(result.count) == 0
				}
			}

			context("when filter is called with a query contained both of the citizens") {
				it("returns both citizens") {
					let result = repository.filter(by: .weight, withQuery: [1.0,1000.0])
					expect(result.count) == 2
				}
			}
		}

		describe("filter by weight") {

			let citizens = [
				CitizenFactory.citizen(height: 111.1),
				CitizenFactory.citizen(height: 222.2),
				]
			let repository = CitizenRepository(citizens: citizens)

			context("when filter is called with a query contained in one citizen") {
				it("returns only that citizen") {
					let result = repository.filter(by: .height, withQuery: [1.0,112.1])
					expect(result.count) == 1
				}
			}

			context("when filter is called with a query contained in one citizen") {
				it("returns only that citizen") {
					let result = repository.filter(by: .height, withQuery: [112.0,223.0])
					expect(result.count) == 1
				}
			}

			context("when filter is called with a query contained in both citizens") {
				it("returns one citizens") {
					let result = repository.filter(by: .height, withQuery: [111.0,111.2])
					expect(result.count) == 1
				}
			}

			context("when filter is called with a query contained in none of the citizens") {
				it("returns no citizens") {
					let result = repository.filter(by: .height, withQuery: [1.0,2.0])
					expect(result.count) == 0
				}
			}

			context("when filter is called with a query contained both of the citizens") {
				it("returns both citizens") {
					let result = repository.filter(by: .height, withQuery: [1.0,1000.0])
					expect(result.count) == 2
				}
			}
		}

		describe("filter by professions") {

			let citizens = [
				CitizenFactory.citizen(professions: ["a","b","c"]),
				CitizenFactory.citizen(professions: ["d","e","c"]),
				]
			let repository = CitizenRepository(citizens: citizens)

			context("when filter is called with a query contained in one citizen") {
				it("returns only that citizen") {
					let result = repository.filter(by: .professions, withQuery: "a")
					expect(result.count) == 1
				}
			}

			context("when filter is called with a query contained in one citizen") {
				it("returns only that citizen") {
					let result = repository.filter(by: .professions, withQuery: "e")
					expect(result.count) == 1
				}
			}

			context("when filter is called with a query contained in none of the citizens") {
				it("returns no citizens") {
					let result = repository.filter(by: .professions, withQuery: "j")
					expect(result.count) == 0
				}
			}

			context("when filter is called with a query contained both of the citizens") {
				it("returns both citizens") {
					let result = repository.filter(by: .professions, withQuery: "c")
					expect(result.count) == 2
				}
			}
		}

		describe("filter by friends") {

			let citizens = [
				CitizenFactory.citizen(friends: ["a","b","c"]),
				CitizenFactory.citizen(friends: ["d","e","c"]),
				]
			let repository = CitizenRepository(citizens: citizens)

			context("when filter is called with a query contained in one citizen") {
				it("returns only that citizen") {
					let result = repository.filter(by: .friends, withQuery: "a")
					expect(result.count) == 1
				}
			}

			context("when filter is called with a query contained in one citizen") {
				it("returns only that citizen") {
					let result = repository.filter(by: .friends, withQuery: "e")
					expect(result.count) == 1
				}
			}

			context("when filter is called with a query contained in none of the citizens") {
				it("returns no citizens") {
					let result = repository.filter(by: .friends, withQuery: "j")
					expect(result.count) == 0
				}
			}

			context("when filter is called with a query contained both of the citizens") {
				it("returns both citizens") {
					let result = repository.filter(by: .friends, withQuery: "c")
					expect(result.count) == 2
				}
			}
		}
	}
}


