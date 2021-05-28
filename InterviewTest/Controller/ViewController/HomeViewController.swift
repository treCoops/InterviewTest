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
    
    var apiHelper = APIHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiHelper.delagate = self

        let user = Auth.auth().currentUser
        
        if user != nil{
            txtUserName.text = user?.displayName
            txtUserEmail.text = user?.email
        }
        
        apiHelper.getHotelData();
        
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

extension HomeViewController : API{
    func error(error: Error) {
        print(error.localizedDescription)
        AlertBar.danger(title: error.localizedDescription)
    }
    func response(hotels: [Hotel]){
        for data in hotels{
            print(data.address)
        }
    }
    
    func error(error: String){
        print(error)
        AlertBar.danger(title: error)
    }
}
