//
//  FetchPopulationInteractor.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 25/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//


import UIKit
import RxSwift

protocol FetchPopulation: class {
	func execute() -> Observable<[Citizen]>
}

enum FetchPopulationInteractorError: Error {
	case invalidResponse
}

class FetchPopulationInteractor: FetchPopulation {

	static var withDefaultApi: FetchPopulationInteractor {
		return FetchPopulationInteractor (api: BrastlewarkApi.shared)
	}

	let api: BrastlewarkApi

	init(api: BrastlewarkApi) {
		self.api = api
	}

	func execute() -> Observable<[Citizen]> {
		return api.rx
			.get(
				"rrafols/mobile_test/master/data.json"
			).map({ data -> [Citizen] in
				guard
					let json = data as? [String: Any],
					let citizensJSON = json["Brastlewark"] as? [[String: Any]]
				else {
					throw FetchPopulationInteractorError.invalidResponse
				}
				return citizensJSON.flatMap ({ try? Citizen(fromDictionary: $0) })
			})
	}
}

