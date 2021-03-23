//
//  AccountInteractor.swift
//  UseCases
//
//  Created by Goyal, Pratik on 19/03/21.
//

import Foundation
import RxSwift
import ChatService

public final class AccountInteractor {
    
    private let chatService : ChatLoginAPI
    
    init(chatService : ChatLoginAPI) {
        self.chatService = chatService
    }
    
}

public extension AccountInteractor {
    
    func login(username : String, password : String) -> Single<()> {
        self.chatService.login(username: username, password: password)
        return .never()
    }
}
