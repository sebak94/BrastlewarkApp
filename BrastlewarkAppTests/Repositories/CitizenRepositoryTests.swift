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
		describe("filter by filters") {
			let citizens = [
				CitizenFactory.citizen(name: "Test Name 1",age: 100, hairColor: "pink"),
				CitizenFactory.citizen(name: "Name for test 2", age: 350, hairColor: "pink"),
				CitizenFactory.citizen(name: "Another name", age: 400, hairColor: "white"),
				CitizenFactory.citizen(name: "Any string test", age: 123, hairColor: "black")
			]
			let repository = CitizenRepository(citizens: citizens)

			context("when filtering only by haircolor") {
				it("returns the citizens with that color") {
					let result = repository.filter(by: [Filter.hairColor("pink")])
					expect(result.count) == 2
				}
			}

			context("when filtering by haircolor and name") {
				it("returns only the citizen that satisfies both filters") {
					let result = repository.filter(by: [Filter.name("for"),Filter.hairColor("pink")])
					expect(result.count) == 1
				}
			}

			context("when filtering by haircolor and age") {
				it("returns only the citizen that satisfies both filters") {
					let result = repository.filter(by: [Filter.ageRange([1,200]),Filter.hairColor("pink")])
					expect(result.count) == 1
				}
			}

			context("when filtering with three filters") {
				it("returns only the citizen that satisfies both filters") {
					let result = repository.filter(by: [Filter.name("test"),Filter.ageRange([1,1000]),Filter.hairColor("pink")])
					expect(result.count) == 2
				}
			}
		}

		describe("filter by name") {

			let citizens = [
				CitizenFactory.citizen(name: "Test Name 1"),
				CitizenFactory.citizen(name: "Name for test 2"),
				]
			let repository = CitizenRepository(citizens: citizens)
			
			context("when filter is called with a query contained in one citizen") {
				it("returns only that citizen") {
					let result = repository.filterCitizens(citizens, by: .name("for"))
					expect(result.first!.name) == citizens[1].name
				}
			}

			context("when filter is called with a query contained in none of the citizens") {
				it("returns no citizens") {
					let result = repository.filterCitizens(citizens, by: .name("qwerqwer"))
					expect(result.isEmpty).to(beTrue())
				}
			}

			context("when filter is called with a query contained in both citizens") {
				it("returns both citizens") {
					let result = repository.filterCitizens(citizens, by: .name("Name"))
					expect(result.count) == 2
				}
			}

			context("when filter is called with a query contained in both citizens but with different casing") {
				it("returns both citizens") {
					let result = repository.filterCitizens(citizens, by: .name("test"))
					expect(result.count) == 2
				}
			}

			context("when filter is called with a query contained in both citizens ") {
				it("returns both citizens") {
					let result = repository.filterCitizens(citizens, by: .name(" "))
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
					let result = repository.filterCitizens(citizens, by: .hairColor("for"))
					expect(result.first!.hairColor) == citizens[1].hairColor
				}
			}

			context("when filter is called with a query contained in none of the citizens") {
				it("returns no citizens") {
					let result = repository.filterCitizens(citizens, by: .hairColor("qwerqwer"))
					expect(result.isEmpty).to(beTrue())
				}
			}

			context("when filter is called with a query contained in both citizens") {
				it("returns both citizens") {
					let result = repository.filterCitizens(citizens, by: .hairColor("Name"))
					expect(result.count) == 2
				}
			}

			context("when filter is called with a query contained in both citizens but with different casing") {
				it("returns both citizens") {
					let result = repository.filterCitizens(citizens, by: .hairColor("test"))
					expect(result.count) == 2
				}
			}

			context("when filter is called with a query contained in both citizens ") {
				it("returns both citizens") {
					let result = repository.filterCitizens(citizens, by: .hairColor(" "))
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
					let result = repository.filterCitizens(citizens, by: .ageRange([1,112]))
					expect(result.count) == 1
				}
			}

			context("when filter is called with a query contained in one citizen") {
				it("returns only that citizen") {
					let result = repository.filterCitizens(citizens, by: .ageRange([112,223]))
					expect(result.count) == 1
				}
			}

			context("when filter is called with a query contained in none of the citizens") {
				it("returns no citizens") {
					let result = repository.filterCitizens(citizens, by: .ageRange([1,2]))
					expect(result.count) == 0
				}
			}

			context("when filter is called with a query contained both of the citizens") {
				it("returns both citizens") {
					let result = repository.filterCitizens(citizens, by: .ageRange([1,1000]))
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
					let result = repository.filterCitizens(citizens, by: .weightRange([1.0,112.1]))
					expect(result.count) == 1
				}
			}

			context("when filter is called with a query contained in one citizen") {
				it("returns only that citizen") {
					let result = repository.filterCitizens(citizens, by: .weightRange([112.0,223.0]))
					expect(result.count) == 1
				}
			}

			context("when filter is called with a query contained in both citizens") {
				it("returns one citizens") {
					let result = repository.filterCitizens(citizens, by: .weightRange([111.0,111.2]))
					expect(result.count) == 1
				}
			}

			context("when filter is called with a query contained in none of the citizens") {
				it("returns no citizens") {
					let result = repository.filterCitizens(citizens, by: .weightRange([1.0,2.0]))
					expect(result.count) == 0
				}
			}

			context("when filter is called with a query contained both of the citizens") {
				it("returns both citizens") {
					let result = repository.filterCitizens(citizens, by: .weightRange([1.0,1000.0]))
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
					let result = repository.filterCitizens(citizens, by: .heightRange([1.0,112.1]))
					expect(result.count) == 1
				}
			}

			context("when filter is called with a query contained in one citizen") {
				it("returns only that citizen") {
					let result = repository.filterCitizens(citizens, by: .heightRange([112.0,223.0]))
					expect(result.count) == 1
				}
			}

			context("when filter is called with a query contained in both citizens") {
				it("returns one citizens") {
					let result = repository.filterCitizens(citizens, by: .heightRange([111.0,111.2]))
					expect(result.count) == 1
				}
			}

			context("when filter is called with a query contained in none of the citizens") {
				it("returns no citizens") {
					let result = repository.filterCitizens(citizens, by: .heightRange([1.0,2.0]))
					expect(result.count) == 0
				}
			}

			context("when filter is called with a query contained both of the citizens") {
				it("returns both citizens") {
					let result = repository.filterCitizens(citizens, by: .heightRange([1.0,1000.0]))
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
					let result = repository.filterCitizens(citizens, by: .profession("a"))
					expect(result.count) == 1
				}
			}

			context("when filter is called with a query contained in one citizen") {
				it("returns only that citizen") {
					let result = repository.filterCitizens(citizens, by: .profession("e"))
					expect(result.count) == 1
				}
			}

			context("when filter is called with a query contained in none of the citizens") {
				it("returns no citizens") {
					let result = repository.filterCitizens(citizens, by: .profession("j"))
					expect(result.count) == 0
				}
			}

			context("when filter is called with a query contained both of the citizens") {
				it("returns both citizens") {
					let result = repository.filterCitizens(citizens, by: .profession("c"))
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
					let result = repository.filterCitizens(citizens, by: .friend("a"))
					expect(result.count) == 1
				}
			}

			context("when filter is called with a query contained in one citizen") {
				it("returns only that citizen") {
					let result = repository.filterCitizens(citizens, by: .friend("e"))
					expect(result.count) == 1
				}
			}

			context("when filter is called with a query contained in none of the citizens") {
				it("returns no citizens") {
					let result = repository.filterCitizens(citizens, by: .friend("j"))
					expect(result.count) == 0
				}
			}

			context("when filter is called with a query contained both of the citizens") {
				it("returns both citizens") {
					let result = repository.filterCitizens(citizens, by: .friend("c"))
					expect(result.count) == 2
				}
			}
		}
	}
}


