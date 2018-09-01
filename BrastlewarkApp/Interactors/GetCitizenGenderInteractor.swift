//
//  GetCitizenGenderInteractor.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 01/09/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import Foundation

enum CitizenGender: String {
	case male = "male"
	case female = "female"
}

struct GetGenderInteractor {
	var citizenRepository : CitizenRepository

	// Don't take this seriously LOL
	func calculateGender( for citizen: Citizen ) -> CitizenGender {
		let bmi = calculateBMI(citizen)
		let medianBMI = getMedianBMI()
		if (citizen.hairColor == "Gray") && (citizen.age > 300) {
			if (bmi <= medianBMI) {
				return .female
			} else {
				return .male
			}
		} else if (bmi <= medianBMI) && (["Pink", "Red"].contains(citizen.hairColor)) {
			return .female
		}
		return .male
	}

	private func calculateBMI(_ citizen: Citizen) -> Double {
		return  calculateBMI(weight: citizen.weight, height: citizen.height)
	}

	private func getMedianBMI() -> Double {
		// Things get slooow here, this is not performant at all, as all the repository queries.
		// But in a real environment all this data would be retrieved from the web service at launch.
		guard let maximumWeight = citizenRepository.citizens.map({$0.weight}).max(),
				let maximumHeight = citizenRepository.citizens.map({$0.height}).max(),
				let minimumWeight = citizenRepository.citizens.map({$0.weight}).min(),
				let minimumHeight = citizenRepository.citizens.map({$0.height}).min()
			else { return 0.0 }

		return calculateBMI(
			weight: minimumWeight + ((maximumWeight - minimumWeight) / 2),
			height: minimumHeight + ((maximumHeight - minimumHeight) / 2)
		)
	}

	// This formula has no scientific background at all, not even taking into account orc fitness
	private func calculateBMI(weight: Double, height: Double ) -> Double {
		return (height/weight) * 10
	}
}

