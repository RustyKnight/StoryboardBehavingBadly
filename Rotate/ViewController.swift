//
//  ViewController.swift
//  Rotate
//
//  Created by Shane Whitehead on 3/7/21.
//

import UIKit

	class ViewController: UIViewController {

		@IBOutlet var landscapeConstraints: [NSLayoutConstraint]!
		@IBOutlet var portraitConstraints: [NSLayoutConstraint]!

		override func viewDidLoad() {
			super.viewDidLoad()
		}
		
		enum Orientation {
			case landscape
			case portrait
			case unknown
		}
		
		fileprivate var lastOrientation: Orientation = .unknown
		
		override func viewDidLayoutSubviews() {
			super.viewDidLayoutSubviews()
			updateCurrentConstraints(toSize: view.bounds.size)
		}

		override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
			super.viewWillTransition(to: size, with: coordinator)
			coordinator.animate { (ctx) in
				self.updateCurrentConstraints(toSize: size)
			} completion: { (ctx) in
			}
		}
		
		func updateCurrentConstraints(toSize size: CGSize) {
			var orientation: Orientation = .portrait
			
			if size.width > size.height {
				orientation = .landscape
			}
			
			guard orientation != lastOrientation else { return }
			lastOrientation = orientation

			guard let portraitConstraints = portraitConstraints, let landscapeConstraints = landscapeConstraints else {
				print("No constraits")
				return
			}
			
			var activeConstraints = portraitConstraints
			var inactiveConstraints = landscapeConstraints

			if orientation == .landscape {
				activeConstraints = landscapeConstraints
				inactiveConstraints = portraitConstraints
			}

			for constraint in inactiveConstraints {
				constraint.isActive = false
			}
			for constraint in activeConstraints {
				constraint.isActive = true
			}
			self.view.setNeedsLayout()
			self.view.layoutIfNeeded()
		}
	}

