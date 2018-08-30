//
//  ObserverPresenter.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 25/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import Foundation

// As a viewObserver, Observer presenter is notified when the view has finished loading
// so it can subscribe to its reactive events as well as pass information.
class ObserverPresenter: ViewObserver {
	func subscribeToViewEvents() {
		fatalError ("Must be implemented in subclass")
	}
}
