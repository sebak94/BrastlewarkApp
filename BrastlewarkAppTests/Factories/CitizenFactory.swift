//
//  CitizenFactory.swift
//  BrastlewarkAppTests
//
//  Created by Felipe Ferrari on 26/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import Foundation

@testable import BrastlewarkApp

class CitizenFactory {
	static func citizen (
		id: Int = 0,
		name: String = "Tobus Quickwhistle",
		imageURL: URL =  URL(string: "http://www.publicdomainpictures.net/pictures/10000/nahled/thinking-monkey-11282237747K8xB.jpg")!,
		age: Int = 306,
		weight: Double = 39.065952,
		height: Double = 107.75835,
		hairColor: String = "Pink",
		professions: [String] = [
			"Metalworker",
			"Woodcarver",
			"Stonecarver",
			" Tinker",
			"Tailor",
			"Potter"
		],
		friends: [String] = [
			"Cogwitz Chillwidget",
			"Tinadette Chillbuster"
		]
	) -> Citizen {
		return Citizen(
			id: id,
			name: name,
			imageURL: imageURL,
			age: age,
			weight: weight,
			height: height,
			hairColor: hairColor,
			professions:professions,
			friends: friends
		)
	}
}
