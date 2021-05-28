//
//  DetailViewController.swift
//  InterviewTest
//
//  Created by treCoops on 2021-05-28.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtDescription: UILabel!
    var hotel = [String: Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtTitle.text = self.hotel["title"] as? String
        txtDescription.text = self.hotel["description"] as? String
        imgView.kf.setImage(
            with: URL(string: self.hotel["imageLarge"] as? String ?? ""),
            completionHandler: { result in
                switch result {
                    case .success(let value):
                        print("Task done for: \(value.source.url?.absoluteString ?? "")")
                    case .failure(let error):
                        print("Job failed: \(error.localizedDescription)")
                    }
            }
        )
    }
    
    @IBAction func btnPackPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnMapMarkerPressed(_ sender: UIButton) {
        performSegue(withIdentifier: SegueIdentifier.SEGUE_MAP, sender: self)
    }
    
}

extension DetailViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == SegueIdentifier.SEGUE_MAP {

            (segue.destination as! MapViewController).mapData = [
                "id" : self.hotel["id"]!,
                "title" : self.hotel["title"]!,
                "address" : self.hotel["address"]!,
                "latitude" : self.hotel["latitude"]!,
                "longitude" : self.hotel["longitude"]!,
            ]
       
        }
    }
}
