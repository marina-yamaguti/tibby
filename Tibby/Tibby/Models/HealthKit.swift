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
    
    func fetchInformation(informationList: [(dateInfo: Date, sampleInfo: SampleType, dataTypeInfo: DateType)]) {
        for information in informationList {
            getHealthInfo(startDate: information.dateInfo, sample: information.sampleInfo, frequency: information.dataTypeInfo)
        }
    }
    
    //fetch all the HealthKit informations that are used
    func fetchAllInformation() {
        let list: [(dateInfo: Date, sampleInfo: SampleType, dataTypeInfo: DateType)] = [(.startOfWeek, .workoutCalories, .week), (.startOfWeek, .workoutCalories, .week), (.startOfWeek, .workoutTime, .week), (.startOfDay, .workoutCalories, .day), (.startOfDay, .workoutTime, .day), (.startOfWeek, .steps, .week), (.startOfDay, .steps, .day), (.startOfWeek, .energyBurned, .week), (.startOfDay, .energyBurned, .day)]
        
        fetchInformation(informationList: list)
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
