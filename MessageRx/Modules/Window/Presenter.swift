//
//  Presenter.swift
//  Window
//
//  Created by Goyal, Pratik on 17/03/21.
//

import Foundation

protocol Routing {
    func routeToLanding()
    func routeToLogin()
    func routeToChatsView()
}

class Presenter : Presentation {
    
    private let router : Routing
    
    init(router : Routing) {
        self.router = router
        process()
    }
}

private extension Presenter {
    func process() {
        self.router.routeToLanding()
    }
}
