//
//  ViewController.swift
//  InterviewTest
//
//  Created by treCoops on 2021-05-28.
//

import UIKit
import FacebookLogin
import Firebase


class SignInViewController: UIViewController {
    
    var loginButton : FBLoginButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton = FBLoginButton()
        loginButton.delegate = self
        loginButton.isHidden = true
        loginButton.permissions = ["email"]
        
        
        let user = Auth.auth().currentUser
        
        if user != nil{
            self.performSegue(withIdentifier: SegueIdentifier.SEGUE_HOME, sender: SignInViewController.self)
        }
        
    }

    @IBAction func btnFacebookLoginPressed(_ sender: UIButton) {
        loginButton.sendActions(for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}

extension SignInViewController: LoginButtonDelegate{
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
            
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)

        Auth.auth().signIn(with: credential) { (authResult, error) in
          if let error = error {
            print(error.localizedDescription)
            return
          }
            
            self.performSegue(withIdentifier: SegueIdentifier.SEGUE_HOME, sender: SignInViewController.self)

        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
}

