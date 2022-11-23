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
        let jailbrokenLabelText = "Is JailBroken - \(UIDevice.current.isJailBroken)"
        print(jailbrokenLabelText)
        if UIDevice.current.isJailBroken {
            let alert = UIAlertController(title: "System Requirements", message: "Sorry, your iOS seems to be modified. This app is only supported on unmodified versions of iOS.", preferredStyle: UIAlertController.Style.alert)
            navigationController?.present(alert, animated: true, completion: nil)
        }

        return true
    }
    
}

