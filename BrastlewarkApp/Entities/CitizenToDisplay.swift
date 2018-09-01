//
//  CitizenToDisplay.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 01/09/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import Foundation
import UIKit

struct CitizenToDisplay {
	let id: Int
	let hairColor: UIColor
	let age: String
	let name: String
	let imageURL: URL
	let weight: String
	let height: String
	let professions: String
	let friends: String
	var gender: CitizenGender? {
		didSet {
			genderDescription = gender?.rawValue ?? "Unknown"
		}
	}
	var genderDescription : String?
}

extension CitizenToDisplay {

	init (citizen: Citizen) {
		self.id = citizen.id
		self.hairColor = CitizenToDisplay.hairColorForCitizen(citizen)
		self.age = citizen.age.description
		self.name = citizen.name
		self.imageURL = citizen.imageURL
		self.weight = citizen.weight.description(decimalPlaces: 2)
		self.height = citizen.height.description(decimalPlaces: 2)
		self.friends = citizen.friends.joined(separator: " | ")
		self.professions = citizen.professions.joined(separator: " | ")
	}

	static func hairColorForCitizen (_ citizen: Citizen) -> UIColor {
		let hairColors = [
			"Red"	: #colorLiteral(red: 0.9137254902, green: 0.07843137255, blue: 0.1450980392, alpha: 1),
			"Pink"	: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1),
			"Green"	: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),
			"Gray"	: #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1),
			"Black"	: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
		]

		return hairColors [citizen.hairColor] ?? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
	}
}

extension Array where Element == Citizen {
	func toDisplay() -> [CitizenToDisplay] {
		return self.map({
			return CitizenToDisplay(citizen: $0)
		})
	}
}
