//
//  AlertBar.swift
//  InterviewTest
//
//  Created by treCoops on 2021-05-28.
//

import Foundation
import NotificationBannerSwift

class AlertBar{
    
    static func success(title: String){
        let banner = StatusBarNotificationBanner(title: title, style: .success)
        banner.duration = 2
        banner.show()
    }
    
    static func danger(title: String){
        let banner = StatusBarNotificationBanner(title: title, style: .danger)
        banner.duration = 2
        banner.show()
    }
    
    static func warning(title: String){
        let banner = StatusBarNotificationBanner(title: title, style: .warning)
        banner.duration = 2
        banner.show()
    }
    
    static func info(title: String){
        let banner = StatusBarNotificationBanner(title: title, style: .info)
        banner.duration = 2
        banner.show()
    }
    
}

