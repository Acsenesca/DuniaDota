//
//  LoginView.swift
//  DuniaDota
//
//  Created by Stevanus Prasetyo Soemadi on 07/07/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//

import Foundation
import UIKit
import KeychainSwift

class LoginView: UIView {
	
	let backgroundImageView = UIImageView()
	@IBOutlet weak var usernameField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	@IBOutlet weak var signInBtn: UIButton!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		self.setBackground()
		self.setupButton()
		self.configureGesture()
		self.configureNotification()
	}
	
	private func setBackground() {
		self.addSubview(self.backgroundImageView)
		self.backgroundImageView.image = UIImage(named: "bg-login-view")
		self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
		self.backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		self.backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
		self.backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
		self.backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
		
		self.sendSubviewToBack(backgroundImageView)
	}
	
	private func configureGesture() {
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
		self.addGestureRecognizer(tap)
		
		self.signInBtn.addTarget(self, action: #selector(signIn), for: .touchUpInside)
	}
	
	private func setupButton() {
		self.signInBtn.backgroundColor = UIColor(red: 0.0/255.0, green: 192.0/255.0, blue: 255.0/255.0, alpha: 1)
		self.signInBtn.titleLabel?.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 22)
		self.signInBtn.layer.cornerRadius  = frame.size.height/2
		self.signInBtn.setTitleColor(.white, for: .normal)
	}
	
	private func configureNotification() {
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
	}
	
	@objc func dismissKeyboard() {
		self.endEditing(true)
	}
	
	@objc func keyboardWillShow(notification: NSNotification) {
		if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
			if self.frame.origin.y == 0 {
				self.frame.origin.y -= keyboardSize.height
			}
		}
	}
	
	@objc func keyboardWillHide(notification: NSNotification) {
		if self.frame.origin.y != 0 {
			self.frame.origin.y = 0
		}
	}
	
	@objc func signIn(sender: UIButton!) {
		let username: String
		let password: String
		
		username = usernameField.text!
		password = passwordField.text!
		
		if username == "administrator" && password == "Password01" {
			let keychain = KeychainSwift()
			keychain.set("\\abcd1234//", forKey: "token")
			
			configureHomeView()
		} else {
			NotificationCenter.default.post(name: .showAlert, object: nil)
		}
	}
	
	private func configureHomeView() {
		let keychain = KeychainSwift()
		let tabBar = UITabBarController()
		let viewModel = HomeViewModel()
		let homeVC = HomeViewController(viewModel: viewModel)
		let profileVC = HomeProfileViewController()
		let controllers = [homeVC, profileVC]
		
		homeVC.tabBarItem = UITabBarItem(title: "Home", image: nil, tag: 0)
		profileVC.tabBarItem = UITabBarItem(title: "Profile", image: nil, tag: 0)
		
		if keychain.get("token") != nil {
			let nav = NavigationController(rootViewController: tabBar)
			tabBar.viewControllers = controllers
			
			window?.rootViewController = nav
		}
	}
}
