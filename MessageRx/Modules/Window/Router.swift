//
//  Router.swift
//  Window
//
//  Created by Goyal, Pratik on 17/03/21.
//
import UIKit
class Router {
    private unowned let window : UIWindow
//    private unowned let navigationController : UINavigationController
    private let submoduels : Submodules
    
    typealias Submodules = (
        landingModule : (_ onStart: @escaping () -> Void) -> UIViewController,
        loginModule : (_ onStart: @escaping (String) -> Void) -> UIViewController,
        chatModule : (_ onStart : @escaping () -> Void) -> UIViewController
    )
    
    init(window : UIWindow, submodules : Submodules) {
        self.window = window
        self.submoduels = submodules
    }
    
//    init(navigationController : UINavigationController, submodules : Submodules) {
//        self.navigationController = navigationController
//        self.submoduels = submodules
//    }
}

extension Router : Routing {
    
    
    func routeToLanding() {
        let landingView = self.submoduels.landingModule { [weak self] in
            self?.routeToLogin()
        }
        self.window.rootViewController = landingView
        self.window.makeKeyAndVisible()
        let options: UIView.AnimationOptions = .transitionFlipFromRight
        let duration: TimeInterval = 0.3
        UIView.transition(with: window, duration: duration, options: options, animations: {}, completion:
        { completed in
        })
//        self.navigationController.pushViewController(landingView, animated: true)
    }
    
    func routeToLogin() {
        let loginView = self.submoduels.loginModule { [weak self] page in
            if page == "Landing" {
                self?.routeToLanding()
            }
            else{
                self?.routeToChatsView()
            }
        }
        self.window.rootViewController = loginView
        self.window.makeKeyAndVisible()
        let options: UIView.AnimationOptions = .transitionFlipFromLeft
        let duration: TimeInterval = 0.3
        UIView.transition(with: window, duration: duration, options: options, animations: {}, completion:
        { completed in
        })
//        self.navigationController.pushViewController(loginView, animated: true)
    }
    
    func routeToChatsView() {
        let chatView = self.submoduels.chatModule { [weak self] in
            self?.routeToLogin()
        }
        self.window.rootViewController = chatView
        self.window.makeKeyAndVisible()
        let options: UIView.AnimationOptions = .transitionFlipFromLeft
        let duration: TimeInterval = 0.3
        UIView.transition(with: window, duration: duration, options: options, animations: {}, completion:
        { completed in
        })
    }
}
