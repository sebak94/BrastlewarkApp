//
//  CitizenRepository.swift
//  BrastlewarkApp
//
//  Created by Felipe Ferrari on 25/08/2018.
//  Copyright © 2018 Felipe Ferrari. All rights reserved.
//

import Foundation

enum Filter {
	case name
	case age
	case hairColor
	case weight
	case height
	case professions
	case friends
}

struct CitizenRepository {
	var citizens : [Citizen]
}

extension CitizenRepository {
	func filter(by filter: Filter, withQuery query: Any) -> [Citizen] {
		switch filter {
			case .name:
				return citizens.filter({ $0.name.containsIgnoringCase(query as! String) })
			case .age:
				return citizens.filter({
					let range = query as! [Int]
					return (range[0] < $0.age) && ($0.age < range[1])
				})
			case .hairColor:
				return citizens.filter({ $0.hairColor.containsIgnoringCase(query as! String) })
			case .weight:
				return citizens.filter({
					let range = query as! [Double]
					return (range[0] < $0.weight) && ($0.weight < range[1])
				})
			case .height:
				return citizens.filter({
					let range = query as! [Double]
					return (range[0] < $0.height) && ($0.height < range[1])
				})
			case .professions:
				return citizens.filter({
					$0.professions.filter({ $0.containsIgnoringCase(query as! String) }).count > 0
				})
			case .friends:
				return citizens.filter({
					$0.friends.filter({ $0.containsIgnoringCase(query as! String) }).count > 0
				})
		}
	}
}
