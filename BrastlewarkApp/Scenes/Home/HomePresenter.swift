//
//  HomePresenter.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 26/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import Foundation
import RxSwift

class HomePresenter: ObserverPresenter {
	weak var navigation : HomeNavigation?
	let state : AppState

	init( state: AppState ) {
		self.state = state
	}

	override func subscribeToViewEvents() {
		
	}
}
