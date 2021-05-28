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
    @IBOutlet weak var tblViewHotels: UITableView!
    @IBOutlet weak var txtUserEmail: UILabel!
    
    var apiHelper = APIHelper()
    
    var hotelXIBArray : [XIBHotel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiHelper.delagate = self

        let user = Auth.auth().currentUser
        
        if user != nil{
            txtUserName.text = user?.displayName
            txtUserEmail.text = user?.email
        }
        
        tblViewHotels.register(UINib(nibName: XIBIdentifier.XIB_HOTEL, bundle: nil), forCellReuseIdentifier: XIBIdentifier.XIB_CELL_HOTEL)
        
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
            hotelXIBArray.append(XIBHotel(id: data.id, title: data.title, address: data.address, image: "a"))
        }
        
        tblViewHotels.reloadData()
    }
    
    func error(error: String){
        print(error)
        AlertBar.danger(title: error)
    }
}

extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotelXIBArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblViewHotels.dequeueReusableCell(withIdentifier: XIBIdentifier.XIB_CELL_HOTEL, for: indexPath) as! HotelTableViewCell
               cell.configXIB(data: hotelXIBArray[indexPath.row])
               
               cell.alpha = 0
               UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row), animations: {
                   cell.alpha = 1
               })
               
               return cell
    }
}

