//
//  MainCell.swift
//  DuniaDota
//
//  Created by Stevanus Prasetyo Soemadi on 07/07/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//

import UIKit

class MainCellModel: ViewModel {
	let hero: Hero
	
	init(hero: Hero) {
		self.hero = hero
	}
}

class MainCell: UICollectionViewCell, ViewBinding {
	typealias VM = MainCellModel
	var viewModel: VM?
	
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var heroImageView: UIImageView!
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
		
	}
	
	override func viewSize() -> CGSize {
		return CGSize(width: UIScreen.main.bounds.width - 32, height: 160)
	}
	
	func bindViewModel(viewModel: VM?) {
		self.viewModel = viewModel
		
		self.configureView()
	}
	
	func configureView() {
		self.layer.cornerRadius = 10
		self.heroImageView.contentMode = .scaleToFill
		
		if let hero = self.viewModel?.hero {
			self.heroImageView.image = UIImage(named: hero.mainImage())
			self.nameLabel.text = hero.nameValue()
		}
	}
}
