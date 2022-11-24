//
//  AppConstants.swift
//  FishSpecies
//
//  Created by MacBook Pro on 22/11/22.
//

import Foundation
import UIKit

struct AppConstants {
    static let FishwatchEndPointURLString = "https://www.fishwatch.gov/api/species"
    static let placeholderImg =  UIImage(named: "placeholderImg")
    static let DetailPageSegueIdentifier = "moveToDetailPage"
    static let JailBrokenDeviceAlertMessage = "Sorry, your iOS seems to be modified. This app is only supported on unmodified versions of iOS."
    static let kEmptyStr = ""
    static let doubleHTMLBreak = "<br/><br/>"
    static let downloadingStr =  "Downloading Data..."
    static let JailBrokenDeviceAlertTitle = "System Requirements"
    static let MainSB = "Main"
    static let HomeNavPageIdentifier = "FishListHome"
}

class CommonUtils {
    
    class func showAlert(alertTitle: String, message: String) {
        let alertStyle = UIAlertController.Style.alert
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: alertStyle)
        UIApplication.shared.topMostViewController()?.present(alert, animated: true)
    }
}
