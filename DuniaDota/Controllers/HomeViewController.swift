//
//  HomeViewController.swift
//  DuniaDota
//
//  Created by Stevanus Prasetyo Soemadi on 07/07/20.
//  Copyright © 2020 Stevanus Prasetyo Soemadi. All rights reserved.
//

import Foundation
import UIKit
import KeychainSwift

class HomeViewModel: ViewModel {
	let heroArr: [Hero] = [Hero.Lina, Hero.Zeus, Hero.LC]
	var didSelectHandler: ((Hero) -> Void) = {_ in }
	
	init() {}
	
	fileprivate func shouldSelectCell(_ indexPath: IndexPath) {
		let hero = self.heroArr[indexPath.row]
		self.didSelectHandler(hero)
	}
}

extension HomeViewModel: SectionedCollectionSource, SizeCollectionSource, SelectedCollectionSource {
	func cellClassAtIndexPath(indexPath: IndexPath) -> UICollectionViewCell.Type {
		return MainCell.self
	}
	
	func cellSizeAtIndexPath(indexPath: IndexPath, withCell cell: UICollectionViewCell) -> CGSize {
		return cell.viewSize()
	}
	
	func didSelectCellAtIndexPath(collectionView: UICollectionView, indexPath: IndexPath, withCell cell: UICollectionViewCell) {
		shouldSelectCell(indexPath)
	}
	
	func numberOfCollectionCellAtSection(section: Int) -> Int {
		return 3
	}
	
	func collectionCellIdentifierAtIndexPath(indexPath: IndexPath) -> String {
		return MainCell.identifier()
	}
	
	func collectionCellModelAtIndexPath(indexPath: IndexPath) -> ViewModel {
		return MainCellModel(hero: heroArr[indexPath.row])
	}
}

class HomeViewController: UIViewController {
	typealias VM = HomeViewModel
	var viewModel: VM
	
	lazy var collectionViewLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
	lazy var collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: self.collectionViewLayout)
	private var collectionViewBinding: CollectionViewBindingUtil<HomeViewModel>?
	
	init(viewModel: HomeViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .systemPurple
		
		// Do any additional setup after loading the view, typically from a nib.
		self.bindViewModel()
		self.configureCollectionView()
		self.configureNavigation()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		self.navigationController?.setNavigationBarHidden(false, animated: animated)
	}

	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		self.navigationController?.setNavigationBarHidden(false, animated: animated)
	}
	
	fileprivate func bindViewModel() {
		collectionViewBinding = CollectionViewBindingUtil(source: self.viewModel)
		collectionViewBinding?.bindFlowDelegateWithCollectionView(collectionView: collectionView)
		collectionViewBinding?.bindDatasourceWithCollectionView(collectionView: collectionView)
		
		viewModel.didSelectHandler = { [weak self] hero -> Void in
			let viewModel = HomeDetailViewModel(hero: hero)
			let controller = HomeDetailViewController(viewModel: viewModel)
			
			let nav = UINavigationController(rootViewController: controller)
            self?.present(nav, animated: true)
		}
	}
	
	fileprivate func configureCollectionView() {
		view.addSubview(self.collectionView)
		
		let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
		let statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
		let navigationBarHeight = navigationController?.navigationBar.frame.height ?? 0
		let verticalPadding: CGFloat = 16
		
		self.collectionView.backgroundView?.backgroundColor = UIColor.white
		self.collectionView.backgroundColor = UIColor.primaryColor
		self.collectionViewLayout.scrollDirection = .vertical
		self.collectionView.contentInset = UIEdgeInsets(
			top: verticalPadding,
			left: 0,
			bottom: navigationBarHeight + statusBarHeight + verticalPadding,
			right: 0
		)
		
		self.collectionView.scrollIndicatorInsets = self.collectionView.contentInset
		self.collectionView.register(MainCell.nib(), forCellWithReuseIdentifier: MainCell.identifier())
	}
	
	private func configureNavigation() {
		self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOut))
	}
	
	@objc private func signOut() {
		let keychain = KeychainSwift()

        if keychain.getData("token") != nil {
			keychain.delete("token")
			
			let authNav = UINavigationController(rootViewController: HomeAuthViewController())

			if var topController = UIApplication.shared.keyWindow?.rootViewController {
				while let presentedViewController = topController.presentedViewController {
					topController = presentedViewController
				}
				
				authNav.modalPresentationStyle = .fullScreen
				topController.present(authNav, animated: true, completion: nil)
			}
        }
	}
}
