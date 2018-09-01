//
//  CitizenRepository.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 25/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import Foundation

enum Filter {
	case name(_: String)
	case ageRange(_:[Int])
	case hairColor(_:String)
	case weightRange(_:[Double])
	case heightRange(_:[Double])
	case profession(_:String)
	case friend(_:String)
}

struct CitizenRepository {
	var citizens : [Citizen]
}

// I would prefer to do this against a web service, getting the citizens and filtering too.
// This way i could get them paginated, and implement pagination in the collection view to ensure
// its allways scrolling smooth. With the data provided it's still not necessary.
extension CitizenRepository {
	func filter(by filters: [Filter]) -> [Citizen] {
		var result = citizens
		for filter in filters {
			result = self.filterCitizens(result, by: filter)
		}
		return result
	}

	func filterCitizens(_ citizens: [Citizen],by filter: Filter) -> [Citizen] {
		switch filter {
			case .name(let name):
				guard name != "" else { return citizens }
				return citizens.filter({ $0.name.containsIgnoringCase(name) })
			case .ageRange(let range):
				return citizens.filter({
					return (range[0] <= $0.age) && ($0.age <= range[1])
				})
			case .hairColor(let hairColor):
				guard hairColor != "" else { return citizens}
				return citizens.filter({ $0.hairColor.containsIgnoringCase(hairColor) })
			case .weightRange(let range):
				return citizens.filter({
					return (range[0] <= $0.weight) && ($0.weight <= range[1])
				})
			case .heightRange(let range):
				return citizens.filter({
					return (range[0] <= $0.height) && ($0.height <= range[1])
				})
			case .profession(let profession):
				guard profession != "" else { return citizens }
				return citizens.filter({
					$0.professions.filter({ $0.containsIgnoringCase(profession) }).count > 0
				})
			case .friend(let friend):
				guard friend != "" else { return citizens }
				return citizens.filter({
					$0.friends.filter({ $0.containsIgnoringCase(friend) }).count > 0
				})
		}
	}
}
