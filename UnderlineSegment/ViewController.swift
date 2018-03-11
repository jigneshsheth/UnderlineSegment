//
//  ViewController.swift
//  UnderlineSegment
//
//  Created by Jigs Sheth on 3/9/18.
//  Copyright © 2018 Jigs Sheth. All rights reserved.
//

import UIKit


let blueVC = "BlueVC"
let redVC = "RedVC"
let greenVC = "GreenVC"

class ViewController: UIViewController {
	
	@IBOutlet weak var containerView: UIView!
	weak var currentViewController: UIViewController?
	
	@IBOutlet weak var segmentedControl: UISegmentedControl!
	override func viewDidLoad() {
		self.currentViewController = self.storyboard?.instantiateViewController(withIdentifier: redVC)
		self.currentViewController!.view.translatesAutoresizingMaskIntoConstraints = false
		self.addChildViewController(self.currentViewController!)
		self.addSubview(subView: self.currentViewController!.view, toView: self.containerView)
		
		segmentedControl.addUnderlineForSelectedSegment()
		super.viewDidLoad()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	fileprivate func showVC(withName name:String) {
		let newViewController = self.storyboard?.instantiateViewController(withIdentifier: name)
		newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
		self.cycleFromViewController(oldViewController: self.currentViewController!, toViewController: newViewController!)
		self.currentViewController = newViewController
	}
	
	@IBAction func showComponent(_ sender: UISegmentedControl) {
		if sender.selectedSegmentIndex == 0 {
			showVC(withName: redVC)
		} else if sender.selectedSegmentIndex == 1 {
			showVC(withName: greenVC)
		}else {
			showVC(withName: blueVC)
		}
		segmentedControl.changeUnderlinePosition()
	}
	
	func cycleFromViewController(oldViewController: UIViewController, toViewController newViewController: UIViewController) {
		oldViewController.willMove(toParentViewController: nil)
		self.addChildViewController(newViewController)
		self.addSubview(subView: newViewController.view, toView:self.containerView!)
		newViewController.view.alpha = 0
		newViewController.view.layoutIfNeeded()
		UIView.animate(withDuration: 0.5, animations: {
			newViewController.view.alpha = 1
			oldViewController.view.alpha = 0
		},
									 completion: { finished in
										oldViewController.view.removeFromSuperview()
										oldViewController.removeFromParentViewController()
										newViewController.didMove(toParentViewController: self)
		})
	}
	
	func addSubview(subView:UIView, toView parentView:UIView) {
		parentView.addSubview(subView)
		
		var viewBindingsDict = [String: AnyObject]()
		viewBindingsDict["subView"] = subView
		parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|",
																														 options: [], metrics: nil, views: viewBindingsDict))
		parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|",
																														 options: [], metrics: nil, views: viewBindingsDict))
	}
}

