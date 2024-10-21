//
//  AdSettings.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 18/10/24.
//

import Foundation
import GoogleMobileAds

class adsIds: ObservableObject {
    
    static let shared = adsIds()
    
    //private let bannerAdID = ""
#warning("ID DOS ANUNCIOS AQUI")
    private let interstitialAdID = ""
    
//    func getBannerAdID() -> String {
//        return bannerAdID
//    }
    
    func getInterstitialAdID() -> String {
        return interstitialAdID
    }
}
