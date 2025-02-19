//
//  HomeProtocol.swift
//  TestApp
//
//  Created by Oscar Yen on 2025/2/18.
//

import Foundation
import UIKit

protocol HomeDelegate : AnyObject {
    func reloadViews()
}

protocol HomeInterface : AnyObject {
    var delegate: HomeDelegate? { get set }

    var userName: String? { get }
    var friends: [Friends]? { get }
    var invite: [Friends]? { get }
    var kokoid: String? {get}

    func getUserData()
    func getFriendsData()

}
