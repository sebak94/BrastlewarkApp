//
//  CitizenRepository.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 25/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import Foundation
import UIKit

enum Filter {
	case name(_: String)
	case ageRange(_:[Int])
	case hairColors(_:[HairColor])
	case weightRange(_:[Double])
	case heightRange(_:[Double])
	case profession(_:String)
	case friend(_:String)
}

enum HairColor {
	case red(_:String, _:UIColor)
	case pink(_:String, _:UIColor)
	case green(_:String, _:UIColor)
	case gray(_:String, _:UIColor)
	case black(_:String, _:UIColor)
	case unknown(_:String, _:UIColor)

	static func from(string: String) -> HairColor {
		switch string {
			case "Pink":
				return HairColor.pink(string, #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1))
			case "Red":
				return  HairColor.red(string, #colorLiteral(red: 0.8635665774, green: 0, blue: 0, alpha: 1))
			case "Green":
				return HairColor.green(string, #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
			case "Black":
				return HairColor.black(string, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
			case "Gray":
				return HairColor.gray(string, #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1))
			default:
				return HairColor.unknown(string, #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
		}
	}

	func string() -> String {
		switch self {
			case .pink(let string, _):
				return string
			case .red(let string, _):
				return string
			case .green(let string, _):
				return string
			case .gray(let string, _):
				return string
			case .black(let string,_ ):
				return string
			case .unknown(let string, _):
				return string
		}
	}

	func color() -> UIColor {
		switch self {
		case .pink(_, let color):
			return color
		case .red(_, let color):
			return color
		case .green(_, let color):
			return color
		case .gray(_, let color):
			return color
		case .black(_, let color):
			return color
		case .unknown(_, let color):
			return color
		}
	}
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
			case .hairColors(let hairColors):
				guard !hairColors.isEmpty else { return citizens}
				return citizens
					.filter({ citizen in
						hairColors.contains(where: { color in
							color.string() == citizen.hairColor
						})
					})
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

	func getAllHairColors() -> [HairColor] {
		return Array(Set(citizens.map({$0.hairColor}))).flatMap({ HairColor.from(string: $0) })
	}
}
