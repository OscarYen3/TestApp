//
//  ViewModel.swift
//  TestApp
//
//  Created by Oscar Yen on 2025/2/18.
//

import Foundation
import UIKit

public class HomeVM: HomeInterface {
    var friends: [Friends]?
    var invite: [Friends]?
    var user: User?
    weak var delegate: HomeDelegate?
    var isRequesting: Bool = false
    var netWork: Bool = false
    var userName: String?
    var kokoid:String?
    
    var allFriends: [Friends] = []
    
    
    func getUserData() {
        Task {
            await getData()
        }
        
    }
    
    func getFriendsData() {
        Task {
            await getFriends1()
        }
        Task {
            await getFriends2()
        }
        Task {
            await getFriendsWithInvite()
        }
        
    }
    
    
    func getData() async {
        let url = URL(string: Common.URL_USER)!
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let loaddata = data {
                do {
                    let userData = try JSONDecoder().decode(UserApi.self, from: loaddata)
                    self.userName = userData.response.first?.name
                    self.kokoid = (userData.response.first?.kokoid ?? "") + " "
                    self.delegate?.reloadViews()
                }
                catch {
                    print("Error: \(error)")
                }
            }
        }.resume()
    }
    
     func  getFriends1() async {
        let url = URL(string: Common.URL_FRIENDLIST1)!
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let loaddata = data {
                do {
                    var data: [Friends] = []
                    let friendsData = try JSONDecoder().decode(FriendApi.self, from: loaddata)
                    data = friendsData.response
                    for i in data {
                        self.allFriends.append(i)
                    }
                    
                    self.friends = self.allFriends
                    self.delegate?.reloadViews()
                }
                catch {
                    print("Error: \(error)")
                }
            }
        }.resume()
    }
    
     func  getFriends2() async {
        let url = URL(string: Common.URL_FRIENDLIST2)!
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let loaddata = data {
                do {
                    var data: [Friends] = []
                    let friendsData = try JSONDecoder().decode(FriendApi.self, from: loaddata)
                    data = friendsData.response
                    for i in data {
                        self.allFriends.append(i)
                    }
                    let uniqueArray = self.allFriends.enumerated().filter { current in
                        self.allFriends.firstIndex { $0.fid == current.element.fid } == current.offset
                    }.map { $0.element }
                    
                    self.friends = uniqueArray
                    self.delegate?.reloadViews()
                    
                }
                catch {
                    print("Error: \(error)")
                }
            }
        }.resume()
    }
    
     func  getFriendsWithInvite() async {
        let url = URL(string: Common.URL_FRIENDINVITE)!
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let loaddata = data {
                do {
                    let friendsData = try JSONDecoder().decode(FriendApi.self, from: loaddata)
                    var data:[Friends] = []
                    for i in friendsData.response {
                        if i.status == 2 {
                            data.append(i)
                        }
                       
                    }
                    self.invite = data
                    self.delegate?.reloadViews()
                }
                catch {
                    print("Error: \(error)")
                }
            }
        }.resume()
    }
    
    func  getNoData() async {
        let url = URL(string: Common.URL_NODATA)!
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let loaddata = data {
                do {
                    let friendsData = try JSONDecoder().decode(FriendApi.self, from: loaddata)
                }
                catch {
                    print("Error: \(error)")
                }
            }
        }.resume()
    }
    
}
