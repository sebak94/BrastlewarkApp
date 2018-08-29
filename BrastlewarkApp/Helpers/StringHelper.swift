//
//  StringHelper.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 28/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import Foundation

extension String {
	func containsIgnoringCase(_ string: String) -> Bool{
		return self.range(of: string, options: .caseInsensitive) != nil
	}
}
