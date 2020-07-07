//
//  HomeProfileViewController.swift
//  DuniaDota
//
//  Created by Stevanus Prasetyo Soemadi on 07/07/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//

import Foundation
import UIKit

class HomeProfileViewController: UIViewController {
	lazy var profileView: ProfileView = {
		let view = ProfileView.viewFromXib()
		
		return view
	}()
	
	init() {
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.configureView()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		navigationController?.setNavigationBarHidden(false, animated: animated)
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		navigationController?.setNavigationBarHidden(false, animated: animated)
	}
	
	private func configureView() {
		self.view.backgroundColor = .primaryColor
		self.profileView.layer.cornerRadius = 4
		
		let padding: CGFloat = 16
		let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
		let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
		let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
		
		self.profileView.frame = self.view.frame.inset(by: UIEdgeInsets(
			top: padding * 2,
			left: padding,
			bottom: UIScreen.main.bounds.height - (self.profileView.frame.height + navigationBarHeight + statusBarHeight + (padding * 2)),
			right: padding
		))

		self.view.addSubview(profileView)
	}
}
