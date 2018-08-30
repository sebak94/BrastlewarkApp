//
//  BrastlewarkApi.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 25/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import Foundation

enum ApiInitializationError: Error {
	case currentEnviromentConfigFileMissing
	case currentEnviromentConfigFileInvalid
}

struct ApiSettings {
	let baseURL: URL
}

// Just a particular instance of Api which knows how to instanciate itself with the correct configuration
class BrastlewarkApi: Api {
	static let shared: BrastlewarkApi = try! BrastlewarkApi.forCurrentEnvironment()
}

extension BrastlewarkApi {
	static func forCurrentEnvironment () throws -> BrastlewarkApi {
		let apiSettings = try apiSettingsFromPlist()

		return BrastlewarkApi (baseURL: apiSettings.baseURL)
	}

	fileprivate static func apiSettingsFromPlist () throws -> ApiSettings {
		guard let apiConfigPath = Bundle.main.path(forResource: "BrastlewarkApi", ofType: "plist")  else {
			throw ApiInitializationError.currentEnviromentConfigFileMissing
		}

		guard let apiSettingsDict = NSDictionary(contentsOfFile: apiConfigPath),
			let baseURLString = apiSettingsDict ["ApiBaseURL"] as? String,
			let baseURL = URL(string: baseURLString)
		else
		{
			throw ApiInitializationError.currentEnviromentConfigFileInvalid
		}

		return ApiSettings (baseURL: baseURL)
	}
}
