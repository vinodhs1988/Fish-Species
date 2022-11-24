//
//  AppDelegate.swift
//  FishSpecies
//
//  Created by MacBook Pro on 22/11/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "FishListHome") as? UINavigationController
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        if UIDevice.current.isJailBroken() {
            CommonUtils.showAlert(alertTitle: AppConstants.JailBrokenDeviceAlertTitle, message: AppConstants.JailBrokenDeviceAlertMessage)
        }
        
        return true
    }
}
