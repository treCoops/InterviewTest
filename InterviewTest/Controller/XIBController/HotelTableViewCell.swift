//
//  HotelTableViewCell.swift
//  InterviewTest
//
//  Created by treCoops on 2021-05-28.
//

import UIKit
import Kingfisher

class HotelTableViewCell: UITableViewCell {
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var txtAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configXIB(data: XIBHotel){
        txtTitle.text = data.title
        txtAddress.text = data.address
        imgView.kf.setImage(
            with: URL(string: data.image),
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
    
}
