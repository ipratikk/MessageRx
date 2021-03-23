//
//  Window.swift
//  Window
//
//  Created by Goyal, Pratik on 17/03/21.
//

import UIKit

protocol Presentation {
    
}

//class Window : UINavigationController {
//    
//    var presenter : Presentation?
//    
//    override init(rootViewController: UIViewController) {
//        super.init(rootViewController: rootViewController)
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//    }
//    
//}

class Window : UIWindow {
    
    var presenter : Presentation?
    
    override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
