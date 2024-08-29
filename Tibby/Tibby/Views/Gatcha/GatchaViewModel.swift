//
//  GatchaViewModel.swift
//  Tibby
//
//  Created by Sofia Sartori on 20/08/24.
//

import Foundation
import SwiftUI

final class GatchaViewModel: ObservableObject {
    @Published var roll: Roll
    @Published var currentSeries: Collection = .seaSeries
    @Published var currentGatchaSecondaryImage: Image?
    @Published var currentGatchaImage: Image?
    @Published var isAnimating = false
    @Published var baseImages: [Image] = []
    @Published var seriesImages: [Image] = []
    
    
    private var animationIndex = 0
    
    // sprites gacha animations - all series
    var gachaBaseAnimation = [
        "https://tibbyappstorage.blob.core.windows.net/base-gacha-animation/GachaBase1.png",
        "https://tibbyappstorage.blob.core.windows.net/base-gacha-animation/GachaBase2.png",
        "https://tibbyappstorage.blob.core.windows.net/base-gacha-animation/GachaBase3.png",
        "https://tibbyappstorage.blob.core.windows.net/base-gacha-animation/GachaBase4.png",
        "https://tibbyappstorage.blob.core.windows.net/base-gacha-animation/GachaBase5.png",
        "https://tibbyappstorage.blob.core.windows.net/base-gacha-animation/GachaBase6.png"
    ]
    
    var gachaSeaSeriesAnimation = [
        "https://tibbyappstorage.blob.core.windows.net/sea-series-gacha-animation/GachaSea1.png",
        "https://tibbyappstorage.blob.core.windows.net/sea-series-gacha-animation/GachaSea2.png",
        "https://tibbyappstorage.blob.core.windows.net/sea-series-gacha-animation/GachaSea2.png",
        "https://tibbyappstorage.blob.core.windows.net/sea-series-gacha-animation/GachaSea3.png",
        "https://tibbyappstorage.blob.core.windows.net/sea-series-gacha-animation/GachaSea4.png",
        "https://tibbyappstorage.blob.core.windows.net/sea-series-gacha-animation/GachaSea5.png",
        "https://tibbyappstorage.blob.core.windows.net/sea-series-gacha-animation/GachaSea6.png"
    ]
    
    var gachaHouseSeriesAnimation = [
        "https://tibbyappstorage.blob.core.windows.net/house-searies-gacha-animation/GachaHouse1.png",
        "https://tibbyappstorage.blob.core.windows.net/house-searies-gacha-animation/GachaHouse2.png",
        "https://tibbyappstorage.blob.core.windows.net/house-searies-gacha-animation/GachaHouse3.png",
        "https://tibbyappstorage.blob.core.windows.net/house-searies-gacha-animation/GachaHouse4.png",
        "https://tibbyappstorage.blob.core.windows.net/house-searies-gacha-animation/GachaHouse5.png",
        "https://tibbyappstorage.blob.core.windows.net/house-searies-gacha-animation/GachaHouse6.png"
    ]
    
    var gachaForestSeriesAnimation = [
        "https://tibbyappstorage.blob.core.windows.net/forest-series-gacha-animation/GachaForest1.png",
        "https://tibbyappstorage.blob.core.windows.net/forest-series-gacha-animation/GachaForest2.png",
        "https://tibbyappstorage.blob.core.windows.net/forest-series-gacha-animation/GachaForest3.png",
        "https://tibbyappstorage.blob.core.windows.net/forest-series-gacha-animation/GachaForest4.png",
        "https://tibbyappstorage.blob.core.windows.net/forest-series-gacha-animation/GachaForest5.png",
        "https://tibbyappstorage.blob.core.windows.net/forest-series-gacha-animation/GachaForest6.png"
    ]
    
    var gachaBeachSeriesAnimation = [
        "https://tibbyappstorage.blob.core.windows.net/beach-series-gacha-animation/GachaBeach1.png",
        "https://tibbyappstorage.blob.core.windows.net/beach-series-gacha-animation/GachaBeach2.png",
        "https://tibbyappstorage.blob.core.windows.net/beach-series-gacha-animation/GachaBeach3.png",
        "https://tibbyappstorage.blob.core.windows.net/beach-series-gacha-animation/GachaBeach4.png",
        "https://tibbyappstorage.blob.core.windows.net/beach-series-gacha-animation/GachaBeach5.png",
        "https://tibbyappstorage.blob.core.windows.net/beach-series-gacha-animation/GachaBeach6.png"
    ]
    
    var gachaFoodSeriesAnimation = [
        "https://tibbyappstorage.blob.core.windows.net/food-series-gacha-animation/GachaFood1.png",
        "https://tibbyappstorage.blob.core.windows.net/food-series-gacha-animation/GachaFood2.png",
        "https://tibbyappstorage.blob.core.windows.net/food-series-gacha-animation/GachaFood3.png",
        "https://tibbyappstorage.blob.core.windows.net/food-series-gacha-animation/GachaFood4.png",
        "https://tibbyappstorage.blob.core.windows.net/food-series-gacha-animation/GachaFood5.png",
        "https://tibbyappstorage.blob.core.windows.net/food-series-gacha-animation/GachaFood6.png"
    ]
    
    var gachaUrbanSeriesAnimation = [
        "https://tibbyappstorage.blob.core.windows.net/urban-series-gacha-animation/GachaUrban1.png",
        "https://tibbyappstorage.blob.core.windows.net/urban-series-gacha-animation/GachaUrban2.png",
        "https://tibbyappstorage.blob.core.windows.net/urban-series-gacha-animation/GachaUrban3.png",
        "https://tibbyappstorage.blob.core.windows.net/urban-series-gacha-animation/GachaUrban4.png",
        "https://tibbyappstorage.blob.core.windows.net/urban-series-gacha-animation/GachaUrban5.png",
        "https://tibbyappstorage.blob.core.windows.net/urban-series-gacha-animation/GachaUrban6.png"
    ]
    
    init(roll: Roll = Roll()) {
        self.roll = roll
    }
    
    func getNewTibby(service: Service, isCoins: Bool, price: Int, collection: Collection? = nil) -> Tibby? {
        if let user = service.getUser() {
            if isCoins {
                let newTibby = self.roll.roll(collection: collection, service: service)
                user.coins -= price
                return newTibby
            } else {
                let newTibby = self.roll.roll(collection: collection, service: service)
                user.gems -= price
                return newTibby
            }
        }
        return nil
    }
    
    func checkForRoll(service: Service, isCoins: Bool, price: Int) -> Bool {
        
        if let user = service.getUser() {
            if isCoins {
                if user.coins >= price {
                    return true
                    
                }
            } else {
                if user.gems >= price {
                    return true
                }
            }
        }
        return false
    }
    
    func updateCollectionBasedOnWeek() {
        let currentDate = Date()
        
        let calendar = Calendar.current
        let currentWeek = calendar.component(.weekOfYear, from: currentDate)
        
        let collectionIndex = currentWeek % Collection.allCases.count
        
        currentSeries = Collection.allCases[collectionIndex]
    }
    
    
    func animateRoll(isBase: Bool) {
        if isBase {
            print(self.baseImages)
            guard !self.baseImages.isEmpty else {
                print("No base images to animate.")
                return
            }
            for index in 0..<self.gachaBaseAnimation.count {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.3, execute: {
                    self.currentGatchaImage = self.baseImages[index]
                })
            }
        } else {
            for index in 0..<self.seriesImages.count {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.3, execute: {
                    self.currentGatchaSecondaryImage = self.seriesImages[index]
                })
            }
        }
        
        
    }
    
    func loadImages() {
        let group = DispatchGroup()
        group.enter()
        var tempBaseImages: [Image] = []
        var tempSeriesImages: [Image] = []
        
        //load base animation
        for texture in gachaBaseAnimation {
            group.enter()
            ImageHandler.shared.loadImage(urlString: texture) { image in
                if let image = image {
                    let texture = Image(uiImage: image)
                    tempBaseImages.append(texture)
                    group.leave()
                } else {
                    //TODO: Handle the case where the image could not be loaded here
                    print("Failed to load image")
                    group.leave()
                }
            }
        }
        
        var animation: [String] = []
        switch currentSeries {
        case .seaSeries:
            animation = gachaSeaSeriesAnimation
        case .houseSeries:
            animation = gachaHouseSeriesAnimation
        case .forestSeries:
            animation = gachaForestSeriesAnimation
        case .beachSeries:
            animation = gachaBeachSeriesAnimation
        case .foodSeries:
            animation = gachaFoodSeriesAnimation
        case .urbanSeries:
            animation = gachaUrbanSeriesAnimation
        }
        
        //load series animation
        for texture in animation {
            group.enter()
            ImageHandler.shared.loadImage(urlString: texture) { image in
                if let image = image {
                    let texture = Image(uiImage: image)
                    tempSeriesImages.append(texture)
                    group.leave()
                } else {
                    //TODO: Handle the case where the image could not be loaded here
                    print("Failed to load image")
                    group.leave()
                }
            }
        }
        
        group.leave()
        group.notify(queue: .main, execute: {
            //storing values
            self.baseImages = tempBaseImages
            self.seriesImages = tempSeriesImages
            
            if !self.baseImages.isEmpty {
                self.currentGatchaImage = self.baseImages[0]
            } else {
                print("No images loaded for animations.")
            }
            
            if !self.seriesImages.isEmpty {
                self.currentGatchaSecondaryImage = self.seriesImages[0]
            } else {
                print("No images loaded for animations.")
            }
        })
    }
}
