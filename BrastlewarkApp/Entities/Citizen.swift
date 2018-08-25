//
//  Citizen.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 25/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import Foundation

enum CitizenParseError: Error {
	case invalidDictionary
}

struct Citizen {
	let id: Int
	let name: String
	let imageURL: URL
	let age: Int
	let weight: Double
	let height: Double
	let hairColor: String
	let professions: [String]
	let friends: [String]
}

extension Citizen {
	init(fromDictionary dictionary: [String : Any]) throws {
		guard let id = try? dictionary.valueOf("id") as Int,
				let name = try? dictionary.valueOf("name") as String,
				let imageURL = try? dictionary.urlValueOf("thumbnail"),
				let age = try? dictionary.valueOf("age") as Int,
				let weight = try? dictionary.doubleOf(key: "weight"),
				let height = try? dictionary.doubleOf(key: "height"),
				let hairColor = try? dictionary.valueOf("hair_color") as String,
				let professions = try? dictionary.valueOf("professions") as [String],
				let friends = try? dictionary.valueOf("friends") as [String]
		else { throw CitizenParseError.invalidDictionary }
		self.id = id
		self.name = name
		self.age = age
		self.imageURL = imageURL
		self.weight = weight
		self.height = height
		self.hairColor = hairColor
		self.professions = professions
		self.friends = friends
	}
}
