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
    @Published var newTibbyImage: Image?
    @Published var baseImages: [Image] = []
    @Published var seriesImages: [Image] = []
    @Published var commomCapsuleImages: [Image] = []
    @Published var epicCapsuleImages: [Image] = []
    @Published var rareCapsuleImages: [Image] = []
    @Published var sparkImages: [Image] = []
    
    
    private var animationIndex = 0
    
    // sprites gacha animations - all series
    let gachaBaseAnimation = [
        "https://tibbyappstorage.blob.core.windows.net/base-gacha-animation/GachaBase1.png",
        "https://tibbyappstorage.blob.core.windows.net/base-gacha-animation/GachaBase2.png",
        "https://tibbyappstorage.blob.core.windows.net/base-gacha-animation/GachaBase3.png",
        "https://tibbyappstorage.blob.core.windows.net/base-gacha-animation/GachaBase4.png",
        "https://tibbyappstorage.blob.core.windows.net/base-gacha-animation/GachaBase5.png",
        "https://tibbyappstorage.blob.core.windows.net/base-gacha-animation/GachaBase6.png"
    ]
    
    let gachaSeaSeriesAnimation = [
        "https://tibbyappstorage.blob.core.windows.net/sea-series-gacha-animation/GachaSea1.png",
        "https://tibbyappstorage.blob.core.windows.net/sea-series-gacha-animation/GachaSea2.png",
        "https://tibbyappstorage.blob.core.windows.net/sea-series-gacha-animation/GachaSea2.png",
        "https://tibbyappstorage.blob.core.windows.net/sea-series-gacha-animation/GachaSea3.png",
        "https://tibbyappstorage.blob.core.windows.net/sea-series-gacha-animation/GachaSea4.png",
        "https://tibbyappstorage.blob.core.windows.net/sea-series-gacha-animation/GachaSea5.png",
        "https://tibbyappstorage.blob.core.windows.net/sea-series-gacha-animation/GachaSea6.png"
    ]
    
    let gachaHouseSeriesAnimation = [
        "https://tibbyappstorage.blob.core.windows.net/house-searies-gacha-animation/GachaHouse1.png",
        "https://tibbyappstorage.blob.core.windows.net/house-searies-gacha-animation/GachaHouse2.png",
        "https://tibbyappstorage.blob.core.windows.net/house-searies-gacha-animation/GachaHouse3.png",
        "https://tibbyappstorage.blob.core.windows.net/house-searies-gacha-animation/GachaHouse4.png",
        "https://tibbyappstorage.blob.core.windows.net/house-searies-gacha-animation/GachaHouse5.png",
        "https://tibbyappstorage.blob.core.windows.net/house-searies-gacha-animation/GachaHouse6.png"
    ]
    
    let gachaForestSeriesAnimation = [
        "https://tibbyappstorage.blob.core.windows.net/forest-series-gacha-animation/GachaForest1.png",
        "https://tibbyappstorage.blob.core.windows.net/forest-series-gacha-animation/GachaForest2.png",
        "https://tibbyappstorage.blob.core.windows.net/forest-series-gacha-animation/GachaForest3.png",
        "https://tibbyappstorage.blob.core.windows.net/forest-series-gacha-animation/GachaForest4.png",
        "https://tibbyappstorage.blob.core.windows.net/forest-series-gacha-animation/GachaForest5.png",
        "https://tibbyappstorage.blob.core.windows.net/forest-series-gacha-animation/GachaForest6.png"
    ]
    
    let gachaBeachSeriesAnimation = [
        "https://tibbyappstorage.blob.core.windows.net/beach-series-gacha-animation/GachaBeach1.png",
        "https://tibbyappstorage.blob.core.windows.net/beach-series-gacha-animation/GachaBeach2.png",
        "https://tibbyappstorage.blob.core.windows.net/beach-series-gacha-animation/GachaBeach3.png",
        "https://tibbyappstorage.blob.core.windows.net/beach-series-gacha-animation/GachaBeach4.png",
        "https://tibbyappstorage.blob.core.windows.net/beach-series-gacha-animation/GachaBeach5.png",
        "https://tibbyappstorage.blob.core.windows.net/beach-series-gacha-animation/GachaBeach6.png"
    ]
    
    let gachaFoodSeriesAnimation = [
        "https://tibbyappstorage.blob.core.windows.net/food-series-gacha-animation/GachaFood1.png",
        "https://tibbyappstorage.blob.core.windows.net/food-series-gacha-animation/GachaFood2.png",
        "https://tibbyappstorage.blob.core.windows.net/food-series-gacha-animation/GachaFood3.png",
        "https://tibbyappstorage.blob.core.windows.net/food-series-gacha-animation/GachaFood4.png",
        "https://tibbyappstorage.blob.core.windows.net/food-series-gacha-animation/GachaFood5.png",
        "https://tibbyappstorage.blob.core.windows.net/food-series-gacha-animation/GachaFood6.png"
    ]
    
    let gachaUrbanSeriesAnimation = [
        "https://tibbyappstorage.blob.core.windows.net/urban-series-gacha-animation/GachaUrban1.png",
        "https://tibbyappstorage.blob.core.windows.net/urban-series-gacha-animation/GachaUrban2.png",
        "https://tibbyappstorage.blob.core.windows.net/urban-series-gacha-animation/GachaUrban3.png",
        "https://tibbyappstorage.blob.core.windows.net/urban-series-gacha-animation/GachaUrban4.png",
        "https://tibbyappstorage.blob.core.windows.net/urban-series-gacha-animation/GachaUrban5.png",
        "https://tibbyappstorage.blob.core.windows.net/urban-series-gacha-animation/GachaUrban6.png"
    ]
    
    let commonCapsuleAnimation = [
        "https://tibbyappstorage.blob.core.windows.net/common-capsule-animation/CommonAnimation1.png",
        "https://tibbyappstorage.blob.core.windows.net/common-capsule-animation/CommonAnimation2.png",
        "https://tibbyappstorage.blob.core.windows.net/common-capsule-animation/CommonAnimation3.png",
        "https://tibbyappstorage.blob.core.windows.net/common-capsule-animation/CommonAnimation4.png",
        "https://tibbyappstorage.blob.core.windows.net/common-capsule-animation/CommonAnimation5.png",
        "https://tibbyappstorage.blob.core.windows.net/common-capsule-animation/CommonAnimation6.png",
        "https://tibbyappstorage.blob.core.windows.net/common-capsule-animation/CommonAnimation7.png",
        "https://tibbyappstorage.blob.core.windows.net/common-capsule-animation/CommonAnimation8.png",
        "https://tibbyappstorage.blob.core.windows.net/common-capsule-animation/CommonAnimation9.png",
        "https://tibbyappstorage.blob.core.windows.net/common-capsule-animation/CommonAnimation10.png",
        "https://tibbyappstorage.blob.core.windows.net/common-capsule-animation/CommonAnimation11.png",
        "https://tibbyappstorage.blob.core.windows.net/common-capsule-animation/CommonAnimation12.png",
        "https://tibbyappstorage.blob.core.windows.net/common-capsule-animation/CommonAnimation13.png",
        "https://tibbyappstorage.blob.core.windows.net/common-capsule-animation/CommonAnimation14.png",
        "https://tibbyappstorage.blob.core.windows.net/common-capsule-animation/CommonAnimation15.png",
        "https://tibbyappstorage.blob.core.windows.net/common-capsule-animation/CommonAnimation16.png"
    ]
    
    let rareCapsuleAnimation = [
        "https://tibbyappstorage.blob.core.windows.net/rare-capsule-animation/RareAnimation1.png",
        "https://tibbyappstorage.blob.core.windows.net/rare-capsule-animation/RareAnimation2.png",
        "https://tibbyappstorage.blob.core.windows.net/rare-capsule-animation/RareAnimation3.png",
        "https://tibbyappstorage.blob.core.windows.net/rare-capsule-animation/RareAnimation4.png",
        "https://tibbyappstorage.blob.core.windows.net/rare-capsule-animation/RareAnimation5.png",
        "https://tibbyappstorage.blob.core.windows.net/rare-capsule-animation/RareAnimation6.png",
        "https://tibbyappstorage.blob.core.windows.net/rare-capsule-animation/RareAnimation7.png",
        "https://tibbyappstorage.blob.core.windows.net/rare-capsule-animation/RareAnimation8.png",
        "https://tibbyappstorage.blob.core.windows.net/rare-capsule-animation/RareAnimation9.png",
        "https://tibbyappstorage.blob.core.windows.net/rare-capsule-animation/RareAnimation10.png",
        "https://tibbyappstorage.blob.core.windows.net/rare-capsule-animation/RareAnimation11.png",
        "https://tibbyappstorage.blob.core.windows.net/rare-capsule-animation/RareAnimation12.png",
        "https://tibbyappstorage.blob.core.windows.net/rare-capsule-animation/RareAnimation13.png",
        "https://tibbyappstorage.blob.core.windows.net/rare-capsule-animation/RareAnimation14.png",
        "https://tibbyappstorage.blob.core.windows.net/rare-capsule-animation/RareAnimation15.png",
        "https://tibbyappstorage.blob.core.windows.net/rare-capsule-animation/RareAnimation16.png"
    ]
    
    let epicCapsuleAnimation = [
        "https://tibbyappstorage.blob.core.windows.net/epic-capsule-animation/EpicAnimation1.png",
        "https://tibbyappstorage.blob.core.windows.net/epic-capsule-animation/EpicAnimation2.png",
        "https://tibbyappstorage.blob.core.windows.net/epic-capsule-animation/EpicAnimation3.png",
        "https://tibbyappstorage.blob.core.windows.net/epic-capsule-animation/EpicAnimation4.png",
        "https://tibbyappstorage.blob.core.windows.net/epic-capsule-animation/EpicAnimation5.png",
        "https://tibbyappstorage.blob.core.windows.net/epic-capsule-animation/EpicAnimation6.png",
        "https://tibbyappstorage.blob.core.windows.net/epic-capsule-animation/EpicAnimation7.png",
        "https://tibbyappstorage.blob.core.windows.net/epic-capsule-animation/EpicAnimation8.png",
        "https://tibbyappstorage.blob.core.windows.net/epic-capsule-animation/EpicAnimation9.png",
        "https://tibbyappstorage.blob.core.windows.net/epic-capsule-animation/EpicAnimation10.png",
        "https://tibbyappstorage.blob.core.windows.net/epic-capsule-animation/EpicAnimation11.png",
        "https://tibbyappstorage.blob.core.windows.net/epic-capsule-animation/EpicAnimation12.png",
        "https://tibbyappstorage.blob.core.windows.net/epic-capsule-animation/EpicAnimation13.png",
        "https://tibbyappstorage.blob.core.windows.net/epic-capsule-animation/EpicAnimation14.png",
        "https://tibbyappstorage.blob.core.windows.net/epic-capsule-animation/EpicAnimation15.png",
        "https://tibbyappstorage.blob.core.windows.net/epic-capsule-animation/EpicAnimation16.png"
    ]
    
    let sparkAnimation = [
        "https://tibbyappstorage.blob.core.windows.net/sparks-animation/PrizeAnimation1.png",
        "https://tibbyappstorage.blob.core.windows.net/sparks-animation/PrizeAnimation2.png",
        "https://tibbyappstorage.blob.core.windows.net/sparks-animation/PrizeAnimation3.png",
        "https://tibbyappstorage.blob.core.windows.net/sparks-animation/PrizeAnimation4.png"
    ]
    
    init(roll: Roll = Roll()) {
        self.roll = roll
    }
    
    func getNewTibby(service: Service, isCoins: Bool, price: Int) -> Tibby? {
        if let user = service.getUser() {
            if isCoins {
                let newTibby = self.roll.roll(collection: nil, service: service)
                user.coins -= price
                return newTibby
            } else {
                let newTibby = self.roll.roll(collection: self.currentSeries, service: service)
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
        AudioManager.instance.playSFX(audio: Int.random(in: 1...2) == 1 ? .coinInsert1 : .coinInsert2)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            AudioManager.instance.playSFX(audio: .gachaMachineTwist)
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
        })
    }
    
    func getBaseSprite(species: String) -> String {
        print("parametro:\(species)")
        for tibbyCase in TibbySpecie.allCases {
            print("caso:\(tibbyCase.rawValue.lowercased())")
            if tibbyCase.rawValue.lowercased() == species.lowercased() {
                print(tibbyCase.baseAnimation()[0])
                return tibbyCase.baseAnimation()[0]
            }
        }
        return ""
    }
    
    func getTibbyImage(species: String) {
        var tempImage: Image?
        let group = DispatchGroup()
        group.enter()
        ImageHandler.shared.loadImage(urlString: self.getBaseSprite(species: species)) { baseTibby in
            
            print("baseTIbby: \(baseTibby)")
            if let uiimage = baseTibby {
                tempImage = Image(uiImage: uiimage)
                group.leave()
            } else {
                print("error: image dind load")
                group.leave()
            }
        }
        group.notify(queue: .main, execute: {
            //storing values
            self.newTibbyImage = tempImage
            
        })
    }
    
    func getCapsuleAnimation(rarity: String?) -> [Image] {
        if let rarity = rarity {
            if rarity.lowercased() == "epic" {
                return self.epicCapsuleImages
            }
            if rarity.lowercased() == "rare" {
                return self.rareCapsuleImages
            }
            else {
                return self.commomCapsuleImages
            }
        } else {
            return self.commomCapsuleImages
        }
    }
    
    func loadCapsuleAnimation() {
        
        let group = DispatchGroup()
        group.enter()
        
        var tempCommonCapsuleImages: [Image] = []
        var tempEpicCapsuleImages: [Image] = []
        var tempRareCapsuleImages: [Image] = []
        var tempSparkAnimation: [Image] = []
        
        //load base animation
        for texture in commonCapsuleAnimation{
            group.enter()
            ImageHandler.shared.loadImage(urlString: texture) { image in
                if let image = image {
                    let texture = Image(uiImage: image)
                    tempCommonCapsuleImages.append(texture)
                    group.leave()
                } else {
                    //TODO: Handle the case where the image could not be loaded here
                    print("Failed to load image")
                    group.leave()
                }
            }
        }
        
        for texture in rareCapsuleAnimation{
            group.enter()
            ImageHandler.shared.loadImage(urlString: texture) { image in
                if let image = image {
                    let texture = Image(uiImage: image)
                    tempRareCapsuleImages.append(texture)
                    group.leave()
                } else {
                    //TODO: Handle the case where the image could not be loaded here
                    print("Failed to load image")
                    group.leave()
                }
            }
        }
        
        for texture in epicCapsuleAnimation{
            group.enter()
            ImageHandler.shared.loadImage(urlString: texture) { image in
                if let image = image {
                    let texture = Image(uiImage: image)
                    tempEpicCapsuleImages.append(texture)
                    group.leave()
                } else {
                    //TODO: Handle the case where the image could not be loaded here
                    print("Failed to load image")
                    group.leave()
                }
            }
        }
        
        for texture in sparkAnimation {
            group.enter()
            ImageHandler.shared.loadImage(urlString: texture) { image in
                if let image = image {
                    let texture = Image(uiImage: image)
                    tempSparkAnimation.append(texture)
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
            self.commomCapsuleImages = tempCommonCapsuleImages
            self.rareCapsuleImages = tempRareCapsuleImages
            self.epicCapsuleImages = tempEpicCapsuleImages
            self.sparkImages = tempSparkAnimation
            
        })
        
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
//        case .forestSeries:
//            animation = gachaForestSeriesAnimation
//        case .beachSeries:
//            animation = gachaBeachSeriesAnimation
//        case .foodSeries:
//            animation = gachaFoodSeriesAnimation
//        case .urbanSeries:
//            animation = gachaUrbanSeriesAnimation
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
