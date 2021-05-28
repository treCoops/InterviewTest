//
//  RoundedUIButton.swift
//  InterviewTest
//
//  Created by treCoops on 2021-05-28.
//

import UIKit

class RoundedUIButton: UIButton {


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        layer.cornerRadius = self.frame.height / 10
        layer.masksToBounds = true
    }

}
