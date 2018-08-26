//
//  StubHelper.swift
//  BrastlewarkAppTests
//
//  Created by Felipe Ferrari on 26/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import Foundation

func contains (_ partial: String, method expectedMethod: String) -> (URLRequest) -> Bool {
	return { request in
		guard let url = request.url?.absoluteString, let method = request.httpMethod else { return false }
		return method == expectedMethod && url.contains(partial)
	}
}
