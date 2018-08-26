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
	static func citizen () -> Citizen {
		return Citizen(
			id: 0,
			name: "Tobus Quickwhistle",
			imageURL: URL(string: "http://www.publicdomainpictures.net/pictures/10000/nahled/thinking-monkey-11282237747K8xB.jpg")!,
			age: 306,
			weight: 39.065952,
			height: 107.75835,
			hairColor: "Pink",
			professions: [
				"Metalworker",
				"Woodcarver",
				"Stonecarver",
				" Tinker",
				"Tailor",
				"Potter"
			],
			friends:  [
				"Cogwitz Chillwidget",
				"Tinadette Chillbuster"
			]
		)
	}
}
