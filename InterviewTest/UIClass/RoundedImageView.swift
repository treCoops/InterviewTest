//
//  RoundedImageView.swift
//  InterviewTest
//
//  Created by treCoops on 2021-05-28.
//

import UIKit

class RoundedImageView: UIImageView {

    override func layoutSubviews() {
       super.layoutSubviews()

       self.roundImageView()
    }

}

extension UIImageView{
    func roundImageView(){
        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = false
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
//    func roundImageForCollectionView(){
//        self.layer.masksToBounds = false
//        self.layer.cornerRadius = self.frame.height / 16
//        self.clipsToBounds = true
//    }
//
//    func roundImageViewForXIB(){
//        self.layer.borderWidth = 5
//        self.layer.masksToBounds = false
//        self.layer.borderColor = #colorLiteral(red: 0.9725490196, green: 0.9215686275, blue: 0.462745098, alpha: 1)
//        self.layer.cornerRadius = self.frame.height / 2
//        self.clipsToBounds = true
//    }
}
