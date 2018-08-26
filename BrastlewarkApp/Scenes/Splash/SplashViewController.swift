//
//  SplashViewController.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 25/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import UIKit

class SplashViewController: WireframeViewController {

	weak var eventsHandler : SplashEventsHandler?

	override func viewDidLoad() {
		eventsHandler?.viewDidLoad()
	}
}
