//
//  ActivityIndicatorView.swift
//  FishSpecies
//
//  Created by MacBook Pro on 23/11/22.
//

import Foundation
import UIKit

private class ActivityIndicatorView {
    var view: UIView!
    
    private var activityIndicator: UIActivityIndicatorView!
    
    private var title: String!
    
    private let activityIndicatorWidth: CGFloat = 250.0
    private let activityIndicatorHeight: CGFloat = 50.0
    
    init(title: String, center: CGPoint) {
        self.title = title
        let xVal = center.x - activityIndicatorWidth/2.0
        let yVal = center.y - activityIndicatorHeight/2.0
        
        self.view = UIView(frame: CGRect(x: xVal, y: yVal, width: activityIndicatorWidth, height: activityIndicatorHeight))
        self.view.backgroundColor = UIColor.yellow
        self.view.layer.cornerRadius = 10
        
        self.activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: activityIndicatorHeight, height: activityIndicatorHeight))
        self.activityIndicator.color = UIColor.black
        self.activityIndicator.hidesWhenStopped = false
        let titleLabel = UILabel(frame: CGRect(x: activityIndicatorHeight, y: 0, width: activityIndicatorWidth, height: activityIndicatorHeight))
        titleLabel.text = title
        titleLabel.textColor = UIColor.black
        self.view.addSubview(self.activityIndicator)
        self.view.addSubview(titleLabel)
    }
        
    func startAnimating() {
        self.activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
    }
    
    func stopAnimating() {
        self.activityIndicator.stopAnimating()
        self.view.isUserInteractionEnabled = true
        self.view.removeFromSuperview()
    }
    
}

class Loader {
    
    private static var activityIndicator: ActivityIndicatorView!
    
    class func showProgressView(title: String, context: UIView) {
        self.activityIndicator = ActivityIndicatorView(title: title, center: context.center)
        context.addSubview(self.activityIndicator.view)
        self.activityIndicator.startAnimating()
    }
    
    class func hideProgressView() {
        self.activityIndicator.stopAnimating()
    }
}
