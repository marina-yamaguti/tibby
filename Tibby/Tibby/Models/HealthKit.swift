//
//  HealthKit.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 07/08/24.
//

import Foundation
import HealthKit
import UIKit

enum SampleType {
    case workoutCalories, workoutTime, steps, energyBurned
    
    func getUnit() -> HKUnit? {
        switch self {
        case .workoutCalories:
            return .kilocalorie()
        case .workoutTime:
            return nil
        case .steps:
            return .count()
        case .energyBurned:
            return .kilocalorie()
        }
    }
    
    func getSample() -> HKSampleType {
        switch self {
        case .workoutCalories:
            return HKSampleType.workoutType()
        case .workoutTime:
            return HKSampleType.workoutType()
        case .steps:
            return HKQuantityType(.stepCount)
        case .energyBurned:
            return HKQuantityType(.activeEnergyBurned)
        }
    }
}

class HealthManager: ObservableObject {
    ///Storage of the health data
    var healthStore: HKHealthStore?
    
    ///Health Kit information variables
    var workoutCaloriesWeek: Int = 0
    var workoutCaloriesDay: Int = 0
    var workoutTimeWeek: Int = 0
    var workoutTimeDay: Int = 0
    var caloriesWeek: Int = 0
    var caloriesDay: Int = 0
    var stepsWeek: Int = 0
    var stepsDay: Int = 0
    
    var getAllWorkout: [WorkoutActivityType] {
        return WorkoutActivityType.allCases
    }
    
    init() {
        isHealthDataAvailable()
    }
    
    //Check if HealthKit is available in yout device
    func isHealthDataAvailable() {
        if HKHealthStore.isHealthDataAvailable() {
            //Code using health data
            healthStore = HKHealthStore()
        } else {
            //If not available, you can make a way to run your app without that data
        }
    }
    
    //Asking for permission to read health data
    func authorizationToWriteInHealthStore() {
        // Types of samples you want to use
        let healthTypesWrite: Set = [
            HKQuantityType(.stepCount),
            HKQuantityType(.activeEnergyBurned),
            HKSampleType.workoutType(),
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!
        ]
        
        let healthTypesRead: Set = [
            HKQuantityType(.stepCount),
            HKQuantityType(.activeEnergyBurned),
            HKSampleType.workoutType()
        ]
        
        //Request authorization for writing a certain type
        healthStore?.requestAuthorization(toShare: healthTypesWrite, read: healthTypesRead, completion: { success, error in
            if success {
                //save sample here or call method that saves sample
            } else {
                //retry
            }
        })
    }
    
    //Send user to the phone settings
    func goToiOSSettings() {
        UIApplication.shared.open(URL(string: "App-Prefs:")!)
    }
    
    //Fetch HealthKit informations that are used
    func fetchInformation(informationList: [(dateInfo: Date, sampleInfo: SampleType, dataTypeInfo: DateType)]) {
        for information in informationList {
            getHealthInfo(startDate: information.dateInfo, sample: information.sampleInfo, frequency: information.dataTypeInfo)
        }
    }
    
    //Fetch all the HealthKit informations that are used
    func fetchAllInformation() {
        let list: [(dateInfo: Date, sampleInfo: SampleType, dataTypeInfo: DateType)] = [(.startOfWeek, .workoutCalories, .week), (.startOfWeek, .workoutCalories, .week), (.startOfWeek, .workoutTime, .week), (.startOfDay, .workoutCalories, .day), (.startOfDay, .workoutTime, .day), (.startOfWeek, .steps, .week), (.startOfDay, .steps, .day), (.startOfWeek, .energyBurned, .week), (.startOfDay, .energyBurned, .day)]
        
        fetchInformation(informationList: list)
    }
    
    //Save Healthkit informations from the app
    func saveHealthInformation() {
        
    }
    
    private func getHealthInfo(startDate: Date, sample: SampleType, frequency: DateType) {
        //Create the time interval
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date())
        
        var query: HKQuery? = nil
        var count: Int = 0
        
        switch sample {
        case .workoutCalories:
            //Create the Query to handle with the information
            query = HKSampleQuery(sampleType: sample.getSample(), predicate: predicate, limit: 20, sortDescriptors: nil, resultsHandler: { _, sampleList, error in
                guard let workouts = sampleList as? [HKWorkout], error == nil else {
                    print("error fetching data")
                    if frequency == .day {
                        self.workoutCaloriesDay = -1
                    }
                    else if frequency == .week {
                        self.workoutCaloriesWeek = -1
                    }
                    return
                }
                //Sum the workouts' information
                for workout in workouts {
                    count += Int(round((workout.totalEnergyBurned?.doubleValue(for: sample.getUnit()!)) ?? 0))
                }
                
                print("Jorge", sample, count)
                
                //Save the workouts' information
                DispatchQueue.main.async {
                    if frequency == .day {
                        self.workoutCaloriesDay = count
                    }
                    else if frequency == .week {
                        self.workoutCaloriesWeek = count
                    }
                }
                
            })
            
        case .workoutTime:
            //Create the Query to handle with the information
            query = HKSampleQuery(sampleType: sample.getSample(), predicate: predicate, limit: 20, sortDescriptors: nil, resultsHandler: { _, sampleList, error in
                guard let workouts = sampleList as? [HKWorkout], error == nil else {
                    print("error fetching data")
                    if frequency == .day {
                        self.workoutTimeWeek = -1
                    }
                    else if frequency == .week {
                        self.workoutTimeDay = -1
                    }
                    return
                }
                //Sum the workouts' information
                for workout in workouts {
                    count += Int(workout.duration/60)
                }
                
                print("Jorge", sample, count)
                
                //Save the workouts' information
                DispatchQueue.main.async {
                    if frequency == .day {
                        self.workoutTimeDay = count
                    }
                    else if frequency == .week {
                        self.workoutTimeWeek = count
                    }
                }
                
            })
        case .steps:
            //Create the Query to handle with the information
            query = HKStatisticsQuery(quantityType: sample.getSample() as! HKQuantityType, quantitySamplePredicate: predicate, completionHandler: { _, result, error in
                guard let quantity = result?.sumQuantity(), error == nil else {
                    print("error fetching data")
                    if frequency == .day {
                        self.stepsDay = -1
                    }
                    else if frequency == .week {
                        self.stepsWeek = -1
                    }
                    return
                }
                //Save the steps/calories' information
                count = Int(quantity.doubleValue(for: sample.getUnit()!))
                DispatchQueue.main.async {
                    if frequency == .day {
                        self.stepsDay = count
                    }
                    else if frequency == .week {
                        self.stepsWeek = count
                    }
                }
                print("Jorge", sample, count)
            })
            
        case .energyBurned:
            //Create the Query to handle with the information
            query = HKStatisticsQuery(quantityType: sample.getSample() as! HKQuantityType, quantitySamplePredicate: predicate, completionHandler: { _, result, error in
                guard let quantity = result?.sumQuantity(), error == nil else {
                    print("error fetching data")
                    if frequency == .day {
                        self.caloriesDay = -1
                    }
                    else if frequency == .week {
                        self.caloriesWeek = -1
                    }
                    return
                }
                //Save the steps/calories' information
                count = Int(quantity.doubleValue(for: sample.getUnit()!))
                DispatchQueue.main.async {
                    if frequency == .day {
                        self.caloriesDay = count
                    }
                    else if frequency == .week {
                        self.caloriesWeek = count
                    }
                }
                print("Jorge", sample, count)
            })
        }
        
        guard let query = query else {
            fatalError("Query needed")
        }
        
        healthStore?.execute(query)
    }
}

enum WorkoutActivityType: CaseIterable {
    case americanFootball, archery, australianFootball, badminton, baseball, basketball, bowling, boxing, climbing, crossTraining, curling, cycling, elliptical, equestrianSports, fencing, fishing, functionalStrengthTraining, golf, gymnastics, handball, hiking, hockey, hunting, lacrosse, martialArts, mindAndBody, mixedMetabolicCardioTraining, paddleSports, play, preparationAndRecovery, racquetball, rowing, rugby, running, sailing, skatingSports, snowSports, soccer, softball, squash, stairClimbing, surfingSports, swimming, tableTennis, tennis, trackAndField, traditionalStrengthTraining, volleyball, walking, waterFitness, waterPolo, waterSports, wrestling, yoga, barre, coreTraining, crossCountrySkiing, downhillSkiing, flexibility, highIntensityIntervalTraining, jumpRope, kickboxing, pilates, snowboarding, stairs, stepTraining, wheelchairWalkPace, wheelchairRunPace, taiChi, mixedCardio, handCycling, discSports, fitnessGaming

    /*
    Simple mapping of available workout types to a human readable name.
    */
    var name: String {
        switch self {
        case .americanFootball:             return "American Football"
        case .archery:                      return "Archery"
        case .australianFootball:           return "Australian Football"
        case .badminton:                    return "Badminton"
        case .baseball:                     return "Baseball"
        case .basketball:                   return "Basketball"
        case .bowling:                      return "Bowling"
        case .boxing:                       return "Boxing"
        case .climbing:                     return "Climbing"
        case .crossTraining:                return "Cross Training"
        case .curling:                      return "Curling"
        case .cycling:                      return "Cycling"
        case .elliptical:                   return "Elliptical"
        case .equestrianSports:             return "Equestrian Sports"
        case .fencing:                      return "Fencing"
        case .fishing:                      return "Fishing"
        case .functionalStrengthTraining:   return "Functional Strength Training"
        case .golf:                         return "Golf"
        case .gymnastics:                   return "Gymnastics"
        case .handball:                     return "Handball"
        case .hiking:                       return "Hiking"
        case .hockey:                       return "Hockey"
        case .hunting:                      return "Hunting"
        case .lacrosse:                     return "Lacrosse"
        case .martialArts:                  return "Martial Arts"
        case .mindAndBody:                  return "Mind and Body"
        case .mixedMetabolicCardioTraining: return "Mixed Metabolic Cardio Training"
        case .paddleSports:                 return "Paddle Sports"
        case .play:                         return "Play"
        case .preparationAndRecovery:       return "Preparation and Recovery"
        case .racquetball:                  return "Racquetball"
        case .rowing:                       return "Rowing"
        case .rugby:                        return "Rugby"
        case .running:                      return "Running"
        case .sailing:                      return "Sailing"
        case .skatingSports:                return "Skating Sports"
        case .snowSports:                   return "Snow Sports"
        case .soccer:                       return "Soccer"
        case .softball:                     return "Softball"
        case .squash:                       return "Squash"
        case .stairClimbing:                return "Stair Climbing"
        case .surfingSports:                return "Surfing Sports"
        case .swimming:                     return "Swimming"
        case .tableTennis:                  return "Table Tennis"
        case .tennis:                       return "Tennis"
        case .trackAndField:                return "Track and Field"
        case .traditionalStrengthTraining:  return "Traditional Strength Training"
        case .volleyball:                   return "Volleyball"
        case .walking:                      return "Walking"
        case .waterFitness:                 return "Water Fitness"
        case .waterPolo:                    return "Water Polo"
        case .waterSports:                  return "Water Sports"
        case .wrestling:                    return "Wrestling"
        case .yoga:                         return "Yoga"
        case .barre:                        return "Barre"
        case .coreTraining:                 return "Core Training"
        case .crossCountrySkiing:           return "Cross Country Skiing"
        case .downhillSkiing:               return "Downhill Skiing"
        case .flexibility:                  return "Flexibility"
        case .highIntensityIntervalTraining:    return "High Intensity Interval Training"
        case .jumpRope:                     return "Jump Rope"
        case .kickboxing:                   return "Kickboxing"
        case .pilates:                      return "Pilates"
        case .snowboarding:                 return "Snowboarding"
        case .stairs:                       return "Stairs"
        case .stepTraining:                 return "Step Training"
        case .wheelchairWalkPace:           return "Wheelchair Walk Pace"
        case .wheelchairRunPace:            return "Wheelchair Run Pace"
        case .taiChi:                       return "Tai Chi"
        case .mixedCardio:                  return "Mixed Cardio"
        case .handCycling:                  return "Hand Cycling"
        case .discSports:                   return "Disc Sports"
        case .fitnessGaming:                return "Fitness Gaming"
        }
    }
}
