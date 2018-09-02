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
	let hairColor: HairColor
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
		self.hairColor = HairColor.from(string: citizen.hairColor)
		self.age = citizen.age.description
		self.name = citizen.name
		self.imageURL = citizen.imageURL
		self.weight = citizen.weight.description(decimalPlaces: 2)
		self.height = citizen.height.description(decimalPlaces: 2)
		self.friends = citizen.friends.joined(separator: " | ")
		self.professions = citizen.professions.joined(separator: " | ")
	}
}

extension Array where Element == Citizen {
	func toDisplay() -> [CitizenToDisplay] {
		return self.map({
			return CitizenToDisplay(citizen: $0)
		})
	}
}
