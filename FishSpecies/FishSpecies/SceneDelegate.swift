//
//  SceneDelegate.swift
//  FishSpecies
//
//  Created by MacBook Pro on 22/11/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        let jailbrokenLabelText = "Is JailBroken - \(UIDevice.current.isJailBroken)"
        print(jailbrokenLabelText)
        if UIDevice.current.isJailBroken {
            let alert = UIAlertController(title: "System Requirements", message: "Sorry, your iOS seems to be modified. This app is only supported on unmodified versions of iOS.", preferredStyle: UIAlertController.Style.alert)
            let rootViewController = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController
            rootViewController?.present(alert, animated: true, completion: nil)
        }

    }


}

