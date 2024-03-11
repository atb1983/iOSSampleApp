//
//  SceneDelegate.swift

//
//  Created by Alex on 30/02/2024.
//

import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
    
        let hostingView = UIHostingController(rootView: LandingPageView(viewModel: LandingPageViewModel()))
        hostingView.view.frame = UIScreen.main.bounds        
        window.rootViewController = hostingView
        
        self.window = window
        window.makeKeyAndVisible()
    }
}
