//
//  FriendsCell.swift
//  TestApp
//
//  Created by Oscar Yen on 2025/2/17.
//

import UIKit

class FriendsCell: UITableViewCell {
    
    @IBOutlet weak var btnOther: UIButton!
    @IBOutlet weak var btnInvite: UIButton!
    @IBOutlet weak var btnTransfer: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgStart: UIImageView!
    
    
    var status: Int = 1 {
        didSet {
            switch status {
            case 2:
                btnOther.isHidden = true
                btnInvite.isHidden = false
                btnTransfer.isHidden = false
            case 1:
                btnOther.isHidden = false
                btnInvite.isHidden = true
                btnTransfer.isHidden = false
            default:
                btnOther.isHidden = false
                btnInvite.isHidden = true
                btnTransfer.isHidden = false
            }
        }
    }
    var name: String = "" {
        didSet {
            lblName.text = name
        }
    }
    
    var isTop: Bool = false {
        didSet {
            if isTop {
                imgStart.isHidden = false
            } else {
                imgStart.isHidden = true
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnTransfer.layer.borderWidth = 1.0
        btnTransfer.layer.borderColor =  UIColor(red: 238/255, green: 38/255, blue: 162/255, alpha: 1.0).cgColor
        btnTransfer.layer.cornerRadius = 4
        btnInvite.layer.borderWidth = 1.0
        btnInvite.layer.borderColor =  UIColor.lightGray.cgColor
        btnInvite.layer.cornerRadius = 4
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
