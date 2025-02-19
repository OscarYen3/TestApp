//
//  ViewController.swift
//  TestApp
//
//  Created by Oscar Yen on 2025/2/17.
//

import UIKit

class HomeView: UIViewController,HomeDelegate,UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
 
  
    @IBOutlet weak var tb_Inite: UITableView!
    @IBOutlet weak var tb_Friends: UITableView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var btnAddFriend: UIButton!
    @IBOutlet weak var lblSet: UILabel!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var stackNodata: UIStackView!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var searchbar: UISearchBar!
    private var homeViewModel: HomeInterface!
    var name: String = "" {
        didSet {
            lblUserName.text = name
        }
    }
    var friends: [Friends] = []
    var invite: [Friends] = []
    let searchName:[String] = []
    var searchArr: [String] = [String](){
        didSet {
            self.tb_Friends.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        tb_Inite.delegate = self
        tb_Inite.dataSource = self
        tb_Friends.delegate = self
        tb_Friends.dataSource = self
        homeViewModel = HomeVM()
        homeViewModel.delegate = self
      
        homeViewModel.getUserData()
        lblId.isHidden = true
        lblSet.isHidden = false
        self.tb_Inite.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tb_Inite.reloadData()
        tb_Friends.reloadData()
    }
    
    func reloadViews() {
        DispatchQueue.main.async {
            self.lblUserName.text = self.homeViewModel.userName
            if self.homeViewModel.kokoid != nil {
                self.lblId.text = ": " + (self.homeViewModel.kokoid ?? "")
                self.lblId.isHidden = false
                self.lblSet.isHidden = true
            }
            self.friends = self.homeViewModel.friends ?? []
            if self.friends.count != 0 {
                self.stackNodata.isHidden = true
            } else {
                self.stackNodata.isHidden = false
            }
            self.invite = self.homeViewModel.invite ?? []
            if self.invite.count != 0  {
                if let tableView = self.tb_Inite {
                    tableView.heightAnchor.constraint(equalToConstant: 300).isActive = true // 設定子視圖高度
                    self.stackView.layoutIfNeeded() // 更新布局
                }
            } else {
                if let tableView = self.tb_Inite {
                    tableView.heightAnchor.constraint(equalToConstant: 0).isActive = true // 設定子視圖高度
                    self.stackView.layoutIfNeeded() // 更新布局
                }
            }
            self.tb_Inite.reloadData()
            self.tb_Friends.reloadData()
            self.stackView.layoutIfNeeded()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
            case tb_Inite:
            return invite.count
        case tb_Friends:
            return friends.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case tb_Inite:
            tb_Inite.register(UINib(nibName: Common.xib_InviteCell, bundle: nil), forCellReuseIdentifier: Common.xib_InviteCell)
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Common.xib_InviteCell, for: indexPath) as! InviteCell
            cell.lblName.text = invite[indexPath.row].name
            return cell
            
        case tb_Friends:
            tb_Friends.register(UINib(nibName: Common.xib_FriendsCell, bundle: nil), forCellReuseIdentifier: Common.xib_FriendsCell)
            let cell = tableView.dequeueReusableCell(withIdentifier: Common.xib_FriendsCell, for: indexPath) as! FriendsCell
            cell.lblName.text = friends[indexPath.row].name
            cell.isTop = friends[indexPath.row].isTop == "1"
            cell.status = friends[indexPath.row].status
            return cell
           
        default: return UITableViewCell()
                
        }
        
    }
    
    
    @IBAction func btnClick(_ sender: UIButton) {
        switch sender {
        case btnAddFriend:
            homeViewModel.getFriendsData()
            break
        default: break
            
        }
        
        
    }
    
    func updateTableView(shouldShow: Bool) {
        guard let tb_Inite = tb_Inite else { return }
            
            if shouldShow {
                if !stackView.arrangedSubviews.contains(tb_Inite) {
                    stackView.addArrangedSubview(tb_Inite)
                }
                tb_Inite.isHidden = false
            } else {
                stackView.removeArrangedSubview(tb_Inite)
                tb_Inite.removeFromSuperview()
            }
        }

}

