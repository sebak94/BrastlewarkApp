//
//  DoubleHelper.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 29/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import Foundation

extension Double {

	func description(decimalPlaces: Int) -> String {
		return String(format: "%.\(decimalPlaces)f", self)
	}

}
