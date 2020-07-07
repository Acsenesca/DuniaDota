//
//  Hero.swift
//  DuniaDota
//
//  Created by Stevanus Prasetyo Soemadi on 07/07/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//

import Foundation

enum Hero: String {
	case Lina
	case Zeus
	case LC
	case Undefined
	
	func mainImage() -> String {
		switch self {
		case .Lina: return "image-lina-main"
		case .Zeus: return "image-zeus-main"
		case .LC: return "image-lc-main"
		case .Undefined: return ""
		}
	}
	
	func detailImage() -> [String] {
		switch self {
		case .Lina: return ["image-lina-detail1", "image-lina-detail2", "image-lina-detail3"]
		case .Zeus: return ["image-zeus-detail1", "image-zeus-detail2", "image-zeus-detail3", "image-zeus-detail4"]
		case .LC: return ["image-lc-detail1", "image-lc-detail2", "image-lc-detail3"]
		case .Undefined: return []
		}
	}
	
	func nameValue() -> String {
		switch self {
		case .Lina: return "Lina"
		case .Zeus: return "Zeus"
		case .LC: return "Legion Commander"
		default:
			return "undefined"
		}
	}
}
