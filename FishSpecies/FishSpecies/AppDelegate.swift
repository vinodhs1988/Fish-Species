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
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "FishListHome") as? UINavigationController
        window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        if UIDevice.current.isJailBroken() {
            let alertStyle = UIAlertController.Style.alert
            let alertTitle = "System Requirements"
            let alert = UIAlertController(title: alertTitle, message: AppConstants.JailBrokenDeviceAlertMessage, preferredStyle: alertStyle)
            navigationController?.present(alert, animated: true, completion: nil)
        }
        
        return true
    }
}
