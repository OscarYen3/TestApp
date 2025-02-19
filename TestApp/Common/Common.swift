//
//  Common.swift
//  TestApp
//
//  Created by Oscar Yen on 2025/2/17.
//
import Foundation
import UIKit

class Common {
    
    static let URL_USER = "https://dimanyen.github.io/man.json"
    static let URL_FRIENDLIST1 = "https://dimanyen.github.io/friend1.json"
    static let URL_FRIENDLIST2 = "https://dimanyen.github.io/friend2.json"
    static let URL_FRIENDINVITE = "https://dimanyen.github.io/friend3.json"
    static let URL_NODATA = "https://dimanyen.github.io/friend4.json"
    
    static let xib_FriendsCell = "FriendsCell"
    static let xib_InviteCell  = "InviteCell"
}



// MARK: - UserApi
struct UserApi: Codable {
    let response: [User]
}

// MARK: - User
struct User: Codable {
    let name, kokoid: String
}

struct FriendApi: Codable {
    let response: [Friends]
}

// MARK: - Friend
struct Friends: Codable {
    let name: String
    let status: Int
    let isTop, fid, updateDate: String
}
