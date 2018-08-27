//
//  SplashEventsHandler.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 25/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import RxSwift

class SplashEventsHandler {
	weak var navigation : SplashNavigation?
	private let disposeBag: DisposeBag = DisposeBag ()
	let fetchPopulation: FetchPopulation

	init (
		fetchPopulation: FetchPopulation
	) {
		self.fetchPopulation = fetchPopulation
	}

	func viewDidLoad() {
		performPopulationFetch()
	}

	func performPopulationFetch() {
		fetchPopulation
			.execute()
			.subscribe(
				onNext: {[weak self] citizens in
					guard let state = self?.createState(withCitizens: citizens) else { return }
					self?.navigation?.presentHome(for: state)
				},
				onError: { [weak self] _ in
					self?.navigation?.presentInformationPopup(
						title: "Ups!",
						message: "There was an error loading Brastlewark population. \n Press OK to try again!",
						animated: true,
						action: {
							self?.performPopulationFetch()
						}
					)
			}
			).disposed(by: disposeBag)
	}

	func createState(withCitizens citizens: [Citizen]) -> AppState {
		let citizenRepository = CitizenRepository(citizens: citizens)
		return AppState( citizenRepository: citizenRepository)
	}
}
