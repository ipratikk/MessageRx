//
//  Router.swift
//  ChatsView
//
//  Created by Goyal, Pratik on 20/03/21.
//

import UIKit

class Router {
    
    private weak var viewController : UIViewController?
    
    init(viewController : UIViewController) {
        self.viewController = viewController
    }
}

extension Router : Routing {
    
}
