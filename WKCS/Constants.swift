//
//  Constants.swift
//  WKCS
//
//  Created by Bryan Dunbar on 5/20/16.
//  Copyright © 2016 vantege, inc. All rights reserved.
//

import Foundation

struct Constants {
    static let NEXT_BUTTON_TAG = 10001
    static let LEADERBOARD_STEP_IDX = -1
    
    /** API **/
    #if DEBUG
    //static let API_ENDPOINT = "http://localhost:8080/api/v1/"
    static let API_ENDPOINT = "https://whokilledcustomerservice.herokuapp.com/api/v1/"
    #else
    static let API_ENDPOINT = "https://whokilledcustomerservice.herokuapp.com/api/v1/"
    #endif
}