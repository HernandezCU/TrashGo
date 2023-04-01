//
//  RegisterViewController.swift
//  TrashGo
//
//  Created by Carlos Hernandez on 4/1/23.
//

import UIKit
import Alamofire
import NotificationBannerSwift

class RegisterViewController: UIViewController {

    struct resp: Codable{
        let success: Bool
        let error: String
    }
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!

    @IBOutlet weak var zipcode: UITextField!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHideKeyboard()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func register(_ sender: Any) {
        spinner.startAnimating()
        if email.hasText && name.hasText && username.hasText && password.hasText && zipcode.hasText{
                
            spinner.startAnimating()
            
            
            let parameters: Parameters = [
                "email": email.text!,
                "password": password.text!,
                "name": name.text!,
                "username": username.text!,
                "zip-code": zipcode.text!
            ]
            
            let request = AF.request("https://greencitygo.net/register", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                                                          
            request.responseDecodable(of: resp.self) { (response) in
                print("here4")
                guard let response = response.value else {
                    print("Failed")
                    print(response)
                    return }
                print("Success")
                self.spinner.stopAnimating()
                if (response.success != true){
                    let error_banner = FloatingNotificationBanner(title: "Could not Register", subtitle: response.error, style: .danger)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
