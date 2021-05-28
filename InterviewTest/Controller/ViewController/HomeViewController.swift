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
    
    var indicatorHUD : IndicatorHUD!
    
    var alert : UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorHUD = IndicatorHUD(view: view)
        
        apiHelper.delagate = self
        
        createAlertDialog()
        
        let user = Auth.auth().currentUser
        
        if user != nil{
            txtUserName.text = user?.displayName
            txtUserEmail.text = user?.email
        }
        
        tblViewHotels.register(UINib(nibName: XIBIdentifier.XIB_HOTEL, bundle: nil), forCellReuseIdentifier: XIBIdentifier.XIB_CELL_HOTEL)
        
        if(NetworkChecker.isConnectedToNetwork()){
            indicatorHUD.show()
            apiHelper.getHotelData();
        }else{
            AlertBar.warning(title: "No network available, Please connect to the internet.")
        }
    }
    

    @IBAction func btnLogoutPressed(_ sender: UIButton) {
        self.present(alert, animated: true, completion: nil)
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
    
    func createAlertDialog() {
        alert = UIAlertController(title: "Interview Test", message: "Do you want to logout?", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {_ in
            self.logOut()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: {_ in
           
        }))
    
    }
    
}

extension HomeViewController : API{
    func error(error: Error) {
        self.indicatorHUD.hide()
        print(error.localizedDescription)
        AlertBar.danger(title: error.localizedDescription)
    }
    func response(hotels: [Hotel]){
        for data in hotels{
            print(data.image.small)
            hotelXIBArray.append(XIBHotel(id: data.id, title: data.title, address: data.address, imageSmall: data.image.small, imageLarge: data.image.large, description: data.description, latitude: data.latitude, longitude: data.longitude))
        }
        self.indicatorHUD.hide()
        tblViewHotels.reloadData()
    }
    
    func error(error: String){
        self.indicatorHUD.hide()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SegueIdentifier.SEGUE_DETAIL, sender: self)
    }
    
}


extension HomeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == SegueIdentifier.SEGUE_DETAIL {

            if let indexPath = self.tblViewHotels.indexPathForSelectedRow {
                
                let hotel : XIBHotel = hotelXIBArray[indexPath.row]
                
                (segue.destination as! DetailViewController).hotel = [
                    "id" : hotel.id,
                    "title" : hotel.title,
                    "address" : hotel.address,
                    "imageLarge" : hotel.imageLarge,
                    "description" : hotel.description,
                    "latitude" : hotel.latitude,
                    "longitude" : hotel.longitude,
                ]
            }
        }
    }
}

