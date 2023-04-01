//
//  LoginVC.swift
//  TrashGo
//
//  Created by Carlos Hernandez on 4/1/23.
//

import UIKit
import Alamofire
import NotificationBannerSwift

struct resp: Codable{
    let success: Bool
    let error: String
}
var user_key = ""
class LoginVC: UIViewController {

    @IBOutlet weak var email_field: UITextField!
    @IBOutlet weak var password_field: UITextField!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHideKeyboard()
    }
    

    @IBAction func login(_ sender: Any) {
        if email_field.hasText && password_field.hasText{
            
            spinner.startAnimating()
            
            let parameters: Parameters = ["email": email_field.text!, "password": password_field.text!]
            
            let request = AF.request("https://greencitygo.net/login", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                                                          
            request.responseDecodable(of: resp.self) { (response) in
                debugPrint(response)
                print("here4")
                guard let response = response.value else {
                    print("Failed")
                    print(response)
                    return }
                print("Success")
                self.spinner.stopAnimating()
                if (response.success != true){
                    let error_banner = FloatingNotificationBanner(title: "Could not Log In", subtitle: response.error, style: .danger)
                    error_banner.show(queuePosition: .front,
                                      bannerPosition: .top,
                                      cornerRadius: 10,
                                      shadowBlurRadius: 0)
                    
                }else{
                    let success_banner = FloatingNotificationBanner(title: "Logged In Successfully", subtitle: response.error, style: .success)
                    success_banner.show(queuePosition: .front,
                                        bannerPosition: .top,
                                        cornerRadius: 10,
                                        shadowBlurRadius: 0)
                    print(response.success)
                    DispatchQueue.main.async {
                        user_key = self.email_field.text!
                        self.dismiss(animated: true)
//                        self.key_label.text = user.user.key
//                        self.email_label.text = user.user.email
//                        self.name_label.text = user.user.name
//                        self.password_label.text = user.user.password
//                        self.phone_label.text = user.user.phone_number
                    }
                }
                
            }
            
            
           
        }
    }
}
extension UIViewController {
    func initializeHideKeyboard(){
    //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
        target: self,
        action: #selector(dismissMyKeyboard))
        //Add this tap gesture recognizer to the parent view
        view.addGestureRecognizer(tap)
    }
    @objc func dismissMyKeyboard(){
        //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
        //In short- Dismiss the active keyboard.
        view.endEditing(true)
    }

}
