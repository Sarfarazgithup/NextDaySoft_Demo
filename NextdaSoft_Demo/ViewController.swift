//
//  ViewController.swift
//  NextdaSoft_Demo
//
//  Created by Sarfaraz Ali on 02/03/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var logInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logInBtn.layer.cornerRadius = 16
        registerBtn.layer.cornerRadius = 16
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

    @IBAction func registerBtn(_ sender: Any) {
        
    }
    
    
    @IBAction func logInBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        print("----?? dshudshf  ")
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

