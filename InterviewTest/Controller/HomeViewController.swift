//
//  HomeViewController.swift
//  InterviewTest
//
//  Created by treCoops on 2021-05-28.
//

import UIKit
import Firebase
import FacebookLogin

class HomeViewController: UIViewController {

    @IBOutlet weak var txtUserName: UILabel!
    @IBOutlet weak var txtUserEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = Auth.auth().currentUser
        
        if user != nil{
            txtUserName.text = user?.displayName
            txtUserEmail.text = user?.email
        }
        
        
    }
    

    @IBAction func btnLogoutPressed(_ sender: UIButton) {
        logOut()
    }
    
    func logOut(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            AccessToken.current = nil
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            AlertBar.warning(title: "Error signing out: \(signOutError)")
        }
    }
    
}
