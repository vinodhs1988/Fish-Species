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
    private enum Constants {
        static let defaultWidth: CGFloat = 250.0
        static let defaultHeight: CGFloat = 50.0
        static let bgColor = UIColor.yellow
        static let textColor = UIColor.black
        static let cornerRadius: CGFloat = 10
    }
    init(title: String, center: CGPoint) {
        self.title = title
        let xVal = center.x - Constants.defaultWidth/2.0
        let yVal = center.y - Constants.defaultHeight/2.0
        
        self.view = UIView(frame: CGRect(x: xVal, y: yVal, width: Constants.defaultWidth, height: Constants.defaultHeight))
        self.view.backgroundColor = Constants.bgColor
        self.view.layer.cornerRadius = Constants.cornerRadius
        
        self.activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: Constants.defaultHeight, height: Constants.defaultHeight))
        self.activityIndicator.color = Constants.textColor
        self.activityIndicator.hidesWhenStopped = false
        let titleLabel = UILabel(frame: CGRect(x: Constants.defaultHeight, y: 0, width: Constants.defaultWidth, height: Constants.defaultHeight))
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
