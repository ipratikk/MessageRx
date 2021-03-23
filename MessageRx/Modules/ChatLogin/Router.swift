//
//  Router.swift
//  ChatLogin
//
//  Created by Goyal, Pratik on 18/03/21.
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
