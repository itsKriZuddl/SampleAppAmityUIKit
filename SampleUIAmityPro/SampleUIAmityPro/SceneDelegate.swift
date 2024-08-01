//
//  SceneDelegate.swift
//  SampleUIAmityPro
//
//  Created by DQ-Krishna Sunkara on 26/07/24.
//

import UIKit
import AmityUIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
//        guard let _ = (scene as? UIWindowScene) else { return }
        
//        if let windowScene = scene as? UIWindowScene {
//            
//            //             let client = try? AmityClient(apiKey: "b0eab9596e88a2364461844f010e4288825f85b3ef323b2c", region: .SG)
//
//            
//            // Add the API key and region logic from the main application
//            AmityUIKitManager.setup(apiKey: "b0eaec5d398ef36c4f62851c53001489d55a8ab6bf366a2c", region: .US)
//            
//            AmityUIKitManager.set(theme: AmityTheme.init(primary: UIColor.red, base: UIColor.green))
//            
//            let viewController = AmityCommunityHomePageViewController.make()
//
//            // push
//    //        navigationController?.pushViewController(viewController, animated: true)
//
//            // present
//            let navigationController = UINavigationController(rootViewController: viewController)
////            present(navigationController, animated: true, completion: nil)
//            
//                let window = UIWindow(windowScene: windowScene)
//                window.rootViewController =  navigationController
//                self.window = window
//                window.makeKeyAndVisible()
//            }
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = AppManager.shared.startingPage()
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        
        // Handler of opening external url from web browsing session.
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb, let url = userActivity.webpageURL {
            // Parse url and be sure that it is a url of a post
            let urlString = url.absoluteString //"https://Amity.co/post/124325135"
            if urlString.contains("post/") {
                if let range = urlString.range(of: "post/") {
                    // Detect id of the post
                    let postId = String(urlString[range.upperBound...])
                    
                    // Open post details page
                    openPost(withId: postId, scene: scene)
                }
            }
        }
    }


}

@available(iOS 13.0, *)
extension SceneDelegate {
    func openPost(withId postId: String, scene: UIScene) {
        guard let _ = (scene as? UIWindowScene), let windowScene = scene as? UIWindowScene else { return }
        AmityUIKitManager.registerDevice(withUserId: "victimIOS", displayName: "victimIOS".uppercased(), sessionHandler: SampleSessionHandler())
        let window = UIWindow(windowScene: windowScene)
        let postDetailViewController = AmityPostDetailViewController.make(withPostId: "c1bb8697c88a01f6423765984a3e47ac")
            
        window.rootViewController = postDetailViewController
        self.window = window
        window.makeKeyAndVisible()
        
    }
}
