//
//  Extension.swift
//  UnderlineSegment
//
//  Created by Jigs Sheth on 3/9/18.
//  Copyright © 2018 Jigs Sheth. All rights reserved.
//

import Foundation
import UIKit

extension UISegmentedControl{
	
	func removeBorder(){
		let backgroundImage = UIImage.getColoredRectImageWith(color: UIColor.white.cgColor, andSize: self.bounds.size)
		self.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
		self.setBackgroundImage(backgroundImage, for: .selected, barMetrics: .default)
		self.setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default)
		
		let deviderImage = UIImage.getColoredRectImageWith(color: UIColor.green.cgColor, andSize: CGSize(width: 1.0, height: self.bounds.size.height))
		self.setDividerImage(deviderImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
		UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.red], for: .selected)
		UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.black], for: .normal)
	}
	
	func addUnderlineForSelectedSegment(){
		removeBorder()
		let underlineWidth: CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments)
		let underlineHeight: CGFloat = 2.0
		let underlineXPosition = CGFloat(selectedSegmentIndex * Int(underlineWidth))
		let underLineYPosition = self.bounds.size.height - 1.0
		let underlineFrame = CGRect(x: underlineXPosition, y: underLineYPosition, width: underlineWidth, height: underlineHeight)
		let underline = UIView(frame: underlineFrame)
		underline.backgroundColor = UIColor.orange
		underline.tag = 1
		self.addSubview(underline)
	}
	
	func changeUnderlinePosition(){
		guard let underline = self.viewWithTag(1) else {return}
		let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
		UIView.animate(withDuration: 0.1, animations: {
			underline.frame.origin.x = underlineFinalXPosition
		})
	}
}

extension UIImage{
	
	static func getColoredRectImageWith(color: CGColor, andSize size: CGSize) -> UIImage{
		UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
		let graphicsContext = UIGraphicsGetCurrentContext()
		graphicsContext?.setFillColor(color)
		let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
		graphicsContext?.fill(rectangle)
		let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return rectangleImage!
	}
}
