//
//  SceneDelegate.swift
//  Bakernate
//
//  Created by Roshani Ayu Pranasti on 07/06/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        var ingredientCollection = [Ingredient]()
        
        do {
            ingredientCollection = try context.fetch(Ingredient.fetchRequest())
        } catch {
            
        }
        
        if ingredientCollection.count == 0 {
            let substitutionController = SubstitutionViewController()
            
            substitutionController.createData()
        }
        // Unwrap scene, so that usable to generate window
        guard let windowScene = scene as? UIWindowScene else { return }
        // Instantiate window with scene
        let window = UIWindow(windowScene: windowScene)
        
        if UserDefaults.standard.bool(forKey: "isOnboardingDone") == true {
            skipOnboarding(window: window)
        } else {
            showOnboarding(window: window)
        }
    }

    func skipOnboarding(window: UIWindow) {
        // Instantiate view controller from story board and provide our apps root view controller
        window.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "viewController")
        // assign attribute window in the scene delegate
        self.window = window
        // Show window in the front
        window.makeKeyAndVisible()
    }
    
    func showOnboarding(window: UIWindow) {
        // Instantiate view controller from story board and provide our apps root view controller
        window.rootViewController = UIStoryboard(name: "OnBoarding", bundle: nil).instantiateViewController(withIdentifier: "onBoardingViewController")
        // assign attribute window in the scene delegate
        self.window = window
        // Show window in the front
        window.makeKeyAndVisible()
        
        UserDefaults.standard.set(true, forKey: "isOnboardingDone")
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

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

}

