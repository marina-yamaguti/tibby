//
//  HealthKit.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 07/08/24.
//

import Foundation
import HealthKit
import UIKit

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
        let healthTypes: Set = [
            HKQuantityType(.stepCount),
            HKQuantityType(.activeEnergyBurned),
            HKSampleType.workoutType()
        ]
        
        //Request authorization for writing a certain type
        healthStore?.requestAuthorization(toShare: [], read: healthTypes, completion: { success, error in
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
    
    //fetch all the HealthKit informations that are used
    func fetchAllInformation() {
        getHealthInfo(startDate: .startOfWeek, sample: HKSampleType.workoutType(), sampleUnit: .kilocalorie(), varName: "workoutCaloriesWeek")
        getHealthInfo(startDate: .startOfWeek, sample: HKSampleType.workoutType(), varName: "workoutTimeWeek")
        getHealthInfo(startDate: .startOfDay, sample: HKSampleType.workoutType(), sampleUnit: .kilocalorie(), varName: "workoutCaloriesDay")
        getHealthInfo(startDate: .startOfDay, sample: HKSampleType.workoutType(), varName: "workoutTimeDay")
        getHealthInfo(startDate: .startOfWeek, sample: HKQuantityType(.stepCount), sampleUnit: .count(), varName: "stepsWeek")
        getHealthInfo(startDate: .startOfDay, sample: HKQuantityType(.stepCount), sampleUnit: .count(), varName: "stepsDay")
        getHealthInfo(startDate: .startOfWeek, sample: HKQuantityType(.activeEnergyBurned), sampleUnit: .kilocalorie(), varName: "caloriesWeek")
        getHealthInfo(startDate: .startOfDay, sample: HKQuantityType(.activeEnergyBurned), sampleUnit: .kilocalorie(), varName: "caloriesDay")
    }
    
    private func getHealthInfo(startDate: Date, sample: HKSampleType, sampleUnit: HKUnit? = nil, varName: String) {
        //Create the time interval
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date())
        
        var query: HKQuery? = nil
        var count: Int = 0
        
        if sample.isEqual(HKSampleType.workoutType()) {
            //Create the Query to handle with the information
            query = HKSampleQuery(sampleType: sample, predicate: predicate, limit: 20, sortDescriptors: nil, resultsHandler: { _, sampleList, error in
                guard let workouts = sampleList as? [HKWorkout], error == nil else {
                    print("error fetching data")
                    if varName == "workoutCaloriesWeek" {
                        self.workoutCaloriesWeek = -1
                    }
                    else if varName == "workoutCaloriesDay" {
                        self.workoutCaloriesDay = -1
                    }
                    else if varName == "workoutTimeWeek" {
                        self.workoutTimeWeek = -1
                    }
                    else if varName == "workoutTimeDay" {
                        self.workoutTimeDay = -1
                    }
                    return
                }
                //Sum the workouts' information
                for workout in workouts {
                    if sampleUnit == .kilocalorie() {
                        count += Int(round((workout.totalEnergyBurned?.doubleValue(for: sampleUnit!)) ?? 0))
                    }
                    else if sampleUnit ==  nil {
                        count += Int(workout.duration/60)
                    }
                }
                
                print("Jorge", sample, sampleUnit, count)
                
                //Save the workouts' information
                DispatchQueue.main.async {
                    if varName == "workoutCaloriesWeek" {
                        self.workoutCaloriesWeek = count
                    }
                    else if varName == "workoutCaloriesDay" {
                        self.workoutCaloriesDay = count
                    }
                    else if varName == "workoutTimeWeek" {
                        self.workoutTimeWeek = count
                    }
                    else if varName == "workoutTimeDay" {
                        self.workoutTimeDay = count
                    }
                }
                
            })
        }
        else {
            //Create the Query to handle with the information
            query = HKStatisticsQuery(quantityType: sample as! HKQuantityType, quantitySamplePredicate: predicate, completionHandler: { _, result, error in
                guard let quantity = result?.sumQuantity(), error == nil else {
                    print("error fetching data")
                    if varName == "caloriesWeek" {
                        self.caloriesWeek = -1
                    }
                    else if varName == "caloriesDay" {
                        self.caloriesDay = -1
                    }
                    else if varName == "stepsWeek" {
                        self.stepsWeek = -1
                    }
                    else if varName == "stepsDay" {
                        self.stepsDay = -1
                    }
                    return
                }
                //Save the steps/calories' information
                count = Int(quantity.doubleValue(for: sampleUnit!))
                DispatchQueue.main.async {
                    if varName == "caloriesWeek" {
                        self.caloriesWeek = count
                    }
                    else if varName == "caloriesDay" {
                        self.caloriesDay = count
                    }
                    else if varName == "stepsWeek" {
                        self.stepsWeek = count
                    }
                    else if varName == "stepsDay" {
                        self.stepsDay = count
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
