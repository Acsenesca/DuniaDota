//
//  DetailViewController.swift
//  DuniaDota
//
//  Created by Stevanus Prasetyo Soemadi on 07/07/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//

import Foundation
import UIKit

class HomeDetailViewModel: ViewModel {
	let hero: Hero?
	
	init(hero: Hero?) {
		self.hero = hero
	}
}

class HomeDetailViewController: UIViewController {
	typealias VM = HomeDetailViewModel
	var viewModel: VM
	
	lazy var detailView: DetailView = {
		let viewModel = DetailViewModel(hero: self.viewModel.hero)
		let view = DetailView.viewFromXib()
		view.bindViewModel(viewModel: viewModel)
		
		return view
	}()
	
	init(viewModel: HomeDetailViewModel) {
		self.viewModel = viewModel
		
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		self.navigationController?.setNavigationBarHidden(false, animated: animated)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		self.navigationController?.setNavigationBarHidden(false, animated: animated)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.tabBarController?.navigationItem.title = self.viewModel.hero?.nameValue()
		
		self.configureView()
	}
	
	private func configureView() {
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"ico-close"), style: .plain, target: self, action: #selector(dismissController))
		
		self.detailView.frame = self.view.frame.inset(by: UIEdgeInsets(
			top: 0,
			left: 0,
			bottom: 0,
			right: 0
		))
		
		self.view.addSubview(detailView)
	}
	
	@objc func dismissController() {
		self.dismiss(animated: true, completion: nil)
	}
}
