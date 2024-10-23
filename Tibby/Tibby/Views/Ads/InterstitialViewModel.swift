//
//  InterstitialViewModel.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 21/10/24.
//

import SwiftUI
import GoogleMobileAds

struct AdViewControllerRepresentable: UIViewControllerRepresentable {
    let viewController = UIViewController()
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

class InterstitialViewModel: NSObject, GADFullScreenContentDelegate {
    private var interstitialAd: GADInterstitialAd?
    
    func loadAd() {
        print("ADAD LOADING")
        GADInterstitialAd.load(withAdUnitID: "ca-app-pub-4451910529287129/2731396771", request: GADRequest()) { ad, _ in
            self.interstitialAd = ad
            self.interstitialAd?.fullScreenContentDelegate = self
            print("ADAD LOADED")
        }
    }

    func adDidDismissFullScreenContent(_ ad: any GADFullScreenPresentingAd) {
        interstitialAd = nil
    }
    
    func showAd(from viewController: UIViewController){
        print("ADAD WANT TO SHOW")
        guard let interstitial = interstitialAd else {
            print("ADAD NOT READY")
            return
        }
        interstitial.present(fromRootViewController: viewController)
        print("SHOWING")
    }
}

//private let adViewModel = InterstitialViewModel()
//private let adViewControllerRepresentable = AdViewControllerRepresentable()
//var adViewControllerRepresentableView: some View {
//    adViewControllerRepresentable.frame(width: .zero, height: .zero)
//}

//adViewModel.showAd(from: adViewControllerRepresentable.viewController)
//adViewModel.loadAd()

//.background(
//adViewControllerRepresentableView
//)
