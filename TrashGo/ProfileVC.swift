//
//  ProfileVC.swift
//  TrashGo
//
//  Created by Ari Yam on 3/31/23.
//

import UIKit
import SwiftUI

class ProfileVC: UIViewController {
    
    @IBOutlet var bgView: UIView!
    
    
    
    
    @IBOutlet var profileImageView: UIImageView!
    
    
    @IBOutlet var lbButton: UIButton!
    
    private let floatingButton:UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 67, height:67)
        button.backgroundColor = UIColor.init(Color(hex: "A4036F"))
        let image = UIImage(
            systemName: "trophy.fill",
            withConfiguration:(UIImage.SymbolConfiguration(pointSize: 16 , weight:.medium)))
        button.setImage(image , for:.normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        //        button.la
        button.layer.cornerRadius = 32
        return button
        
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(
            x:view.frame.size.width/2 - floatingButton.frame.width/2,
            y: view.frame.size.height - 180,
            width: 67,
            height: 67
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(floatingButton)
        floatingButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        
        lbButton.layer.cornerRadius = 0.5 * lbButton.bounds.size.width
        lbButton.clipsToBounds = true
        
        bgView.layer.masksToBounds = false
        
        
    }
    
    @objc private func didTapButton(){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "leaderboard", sender: nil)
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
