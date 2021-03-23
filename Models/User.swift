//
//  User.swift
//  Models
//
//  Created by Goyal, Pratik on 19/03/21.
//

public struct User {
    
    init(username : String) {
        self.username = username
    }
    public let username : String
}

public struct Conversation {
    let id: String
    let name: String
    let otherUserEmail: String
    let latestMessage: LatestMessage
}

public struct LatestMessage {
    let date: String
    let text: String
    let isRead: Bool
}
