//
//  Builder.swift
//  Window
//
//  Created by Goyal, Pratik on 17/03/21.
//

import UIKit
import Landing
import ChatLogin
import ChatsView

public final class Builder {
    
    public static func build(windowScene : UIWindowScene) -> UIWindow {
        let window = Window(windowScene: windowScene)

        let landingModule = Landing.Builder.build
        let loginModule = ChatLogin.Builder.build
        let chatViewModule = ChatsView.Builder.build

        let router = Router(
            window: window,
            submodules: (
                landingModule : landingModule,
                loginModule : loginModule,
                chatModule : chatViewModule
            )
        )
        let presenter = Presenter(router: router)
        window.presenter = presenter

        return window
    }
    
//    public static func build(viewController : UIViewController) -> UIViewController {
//        let navigationController = Window(rootViewController: viewController)
//        let landingModule = Landing.Builder.build
//        let loginModule = ChatLogin.Builder.build
//        
//        let router = Router(
//            navigationController: navigationController,
//            submodules: (
//                landingModule : landingModule,
//                loginModule : loginModule
//            )
//        )
//        let presenter = Presenter(router: router)
//        navigationController.presenter = presenter
//        
//        return navigationController
//    }
    
}
