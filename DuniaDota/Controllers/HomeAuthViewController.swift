//
//  HomeAuthViewController.swift
//  DuniaDota
//
//  Created by Stevanus Prasetyo Soemadi on 07/07/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//

import Foundation
import UIKit

class HomeAuthViewController: UIViewController {
	lazy var loginView: LoginView = {
		let view = LoginView.viewFromXib()
		
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
		self.configureNotification()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: animated)
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.setNavigationBarHidden(false, animated: animated)
	}

	private func configureView() {
		self.loginView.frame = self.view.frame.inset(by: UIEdgeInsets(
			top: 0,
			left: 0,
			bottom: 0,
			right: 0
		))
		
		self.view.addSubview(loginView)
	}
	
	private func configureNotification() {
		NotificationCenter.default.addObserver(forName: .showAlert, object: nil, queue: nil, using: {[weak self] (notification) -> Void in
			self?.showAlert()
		})
	}

	private func showAlert() {
		let alert = UIAlertController(title: "Wrong Password", message: "Oops, it seems you entered the wrong password. Please try again.", preferredStyle: .alert)

		alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
		self.present(alert, animated: true)
	}
}
