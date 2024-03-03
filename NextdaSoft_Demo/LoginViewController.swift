//
//  LoginViewController.swift
//  NextdaSoft_Demo
//
//  Created by Sarfaraz Ali on 02/03/24.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var loginBtn2: UIButton!
    
    @IBOutlet weak var googleBtn: UIButton!
    
    @IBOutlet weak var facebookBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginBtn2.layer.cornerRadius = 16
        googleBtn.layer.borderWidth = 1
        googleBtn.layer.borderColor = UIColor.white.cgColor
        facebookBtn.layer.borderWidth = 1
        facebookBtn.layer.borderColor = UIColor.white.cgColor
        googleBtn.layer.cornerRadius = 16
        facebookBtn.layer.cornerRadius = 16
//        emailTextField.text = "eve.holt@reqres.in"
//        passwordTextField.text = "cityslicka"
       gradientColor()
       
    }
    func gradientColor(){
        let gradientLayer = CAGradientLayer()
                gradientLayer.frame = view.bounds
                gradientLayer.colors = [UIColor.blue.cgColor,UIColor.red.cgColor]
                gradientLayer.startPoint = CGPoint(x: 0, y: 0)
                gradientLayer.endPoint = CGPoint(x: 1, y: 1)
                view.layer.insertSublayer(gradientLayer, at: 0)
    }
   
    
    @IBAction func logInBtnAction(_ sender: Any) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            showAlert(title: "Error", message: "Please enter email and password")
            return
        }
        
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        AF.request("https://reqres.in/api/login", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let statusCode = response.response?.statusCode {
                        print("response code->>>", statusCode)
                        if statusCode == 200 {
                            self.showAlert(title: "Success", message: "Login successful")
                        } else {
                            self.showAlert(title: "Error", message: "Login failed")
                        }
                    }
                case .failure(let error):
                    self.showAlert(title: "Error", message: "Failed to connect to server: \(error.localizedDescription)")
                }
            }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default) {_ in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "saveDataViewController") as! saveDataViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        alertController.addAction(alertAction)
        
        present(alertController,animated: true,completion: nil)
    }
    
}

