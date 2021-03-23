//
//  Presenter.swift
//  ChatsView
//
//  Created by Goyal, Pratik on 20/03/21.
//

import Foundation
import RxSwift
import RxCocoa


protocol Routing {
    
}

class Presenter: Presentation {
    
    typealias UseCases = (
//        login : (_ username : String, _ password : String) -> Single<()>, ()
    )
    
    var input : Input
    var output : Output
    
    private let useCases : UseCases
    private let router : Routing
    
    init(input: Input, router : Routing, useCases : UseCases) {
        self.input = input
        self.output = Presenter.output(input: self.input)
        self.router = router
        self.useCases = useCases
    }
}

private extension Presenter {
    static func output(input : Input) -> Output {
        
//        let enableLoginDriver = Driver.combineLatest(input.username.map({ !$0.isEmpty && $0.isEmail() }), input.password.map({ !$0.isEmpty })).map({ $0 && $1 })
//
//        return (
//            enableLogin : enableLoginDriver, ()
//        )
    }
    
    func process() {
        
    }
}
