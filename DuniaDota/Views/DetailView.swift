//
//  DetailView.swift
//  DuniaDota
//
//  Created by Stevanus Prasetyo Soemadi on 07/07/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//

import Foundation
import UIKit
import FSPagerView

class DetailViewModel: ViewModel {
	let hero: Hero?
	
	init(hero: Hero?) {
		self.hero = hero
	}
}

class DetailView: UIView, ViewBinding {
	typealias VM = DetailViewModel
	var viewModel: VM?
	
	@IBOutlet weak var pagerView: FSPagerView!
	@IBOutlet weak var pageControl: FSPageControl!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		self.pagerView.dataSource = self
		self.pagerView.delegate = self
	}
	
	func configurePageControl() {
		self.pageControl.numberOfPages = self.viewModel?.hero?.detailImage().count ?? 0
		self.pageControl.contentHorizontalAlignment = .right
		self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
		self.pageControl.hidesForSinglePage = true
		self.pageControl.setStrokeColor(nil, for: .normal)
		self.pageControl.contentHorizontalAlignment = .center
	}
	
	func configureView() {
		self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
		self.pagerView.itemSize = FSPagerView.automaticSize
	}
	
	func bindViewModel(viewModel: VM?) {
		self.viewModel = viewModel
		
		configureView()
		configurePageControl()
	}
}

extension DetailView: FSPagerViewDataSource, FSPagerViewDelegate {
	func numberOfItems(in pagerView: FSPagerView) -> Int {
		return self.viewModel?.hero?.detailImage().count ?? 0
	}
	
	func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
		let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
		
		if let image = self.viewModel?.hero?.detailImage()[index] {
			cell.imageView?.image = UIImage(named: image)
		}
		
		cell.imageView?.contentMode = .scaleToFill
		return cell
	}
	
	func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
		self.pageControl.currentPage = targetIndex
	}
}
