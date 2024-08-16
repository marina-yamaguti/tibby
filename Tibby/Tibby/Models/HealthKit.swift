//
//  HealthKit.swift
//  Tibby
//
//  Created by Felipe Elsner Silva on 07/08/24.
//

import Foundation
import HealthKit
import UIKit

/// A class that manages interactions with the HealthKit framework, providing functionality for retrieving health-related data such as steps, calories burned, and workout time.
class HealthManager: ObservableObject {
    
    /// The HealthKit store where health data is accessed.
    var healthStore: HKHealthStore?
    
    /// Health data variables representing weekly and daily metrics.
    var workoutCaloriesWeek: Int = 0
    var workoutCaloriesDay: Int = 0
    var workoutTimeWeek: Int = 0
    var workoutTimeDay: Int = 0
    var caloriesWeek: Int = 0
    var caloriesDay: Int = 0
    var stepsWeek: Int = 0
    var stepsDay: Int = 0
    
    /// Initializes the HealthManager and checks if HealthKit is available on the device.
    init() {
        isHealthDataAvailable()
    }
    
    /// Checks if HealthKit is available on the device and initializes the `healthStore` if it is.
    ///
    /// If HealthKit is not available, the application should handle this scenario gracefully.
    func isHealthDataAvailable() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        } else {
            // Handle the case where HealthKit is not available
        }
    }
    
    /// Requests authorization to read health data from HealthKit.
    ///
    /// The app requests permission to access step count, active energy burned, and workout data.
    func authorizationToWriteInHealthStore() {
        let healthTypes: Set = [
            HKQuantityType(.stepCount),
            HKQuantityType(.activeEnergyBurned),
            HKSampleType.workoutType()
        ]
        
        healthStore?.requestAuthorization(toShare: [], read: healthTypes, completion: { success, error in
            if success {
                // Authorization was granted, proceed with data fetching
            } else {
                // Handle authorization failure
            }
        })
    }
    
    /// Directs the user to the iOS settings to manage HealthKit permissions.
    func goToiOSSettings() {
        guard let url = URL(string: "App-Prefs:") else { return }
        UIApplication.shared.open(url)
    }
    
    /// Fetches all health information required by the app.
    ///
    /// This function retrieves data such as workout calories, workout time, steps, and calories burned for both weekly and daily intervals.
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
    
    /// Retrieves specific health information based on the provided parameters.
    ///
    /// This method queries HealthKit for data such as workout calories, workout time, steps, and active energy burned,
    /// and updates the corresponding variables with the fetched data.
    ///
    /// - Parameters:
    ///   - startDate: The start date for the data query.
    ///   - sample: The type of health data to query.
    ///   - sampleUnit: The unit for the health data (optional).
    ///   - varName: The name of the variable to store the fetched data.
    private func getHealthInfo(startDate: Date, sample: HKSampleType, sampleUnit: HKUnit? = nil, varName: String) {
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date())
        var query: HKQuery?
        var count: Int = 0
        
        if sample.isEqual(HKSampleType.workoutType()) {
            query = HKSampleQuery(sampleType: sample, predicate: predicate, limit: 20, sortDescriptors: nil, resultsHandler: { _, sampleList, error in
                guard let workouts = sampleList as? [HKWorkout], error == nil else {
                    print("Error fetching data")
                    self.updateVariable(varName, value: -1)
                    return
                }
                
                for workout in workouts {
                    if sampleUnit == .kilocalorie() {
                        count += Int(round((workout.totalEnergyBurned?.doubleValue(for: sampleUnit!)) ?? 0))
                    } else if sampleUnit == nil {
                        count += Int(workout.duration / 60)
                    }
                }
                
                DispatchQueue.main.async {
                    self.updateVariable(varName, value: count)
                }
            })
        } else {
            query = HKStatisticsQuery(quantityType: sample as! HKQuantityType, quantitySamplePredicate: predicate, completionHandler: { _, result, error in
                guard let quantity = result?.sumQuantity(), error == nil else {
                    print("Error fetching data")
                    self.updateVariable(varName, value: -1)
                    return
                }
                
                count = Int(quantity.doubleValue(for: sampleUnit!))
                DispatchQueue.main.async {
                    self.updateVariable(varName, value: count)
                }
            })
        }
        
        guard let query = query else {
            fatalError("Query creation failed")
        }
        
        healthStore?.execute(query)
    }
    
    /// Updates the specified variable with the fetched data value.
    ///
    /// - Parameters:
    ///   - varName: The name of the variable to update.
    ///   - value: The value to set for the variable.
    private func updateVariable(_ varName: String, value: Int) {
        switch varName {
        case "workoutCaloriesWeek":
            self.workoutCaloriesWeek = value
        case "workoutCaloriesDay":
            self.workoutCaloriesDay = value
        case "workoutTimeWeek":
            self.workoutTimeWeek = value
        case "workoutTimeDay":
            self.workoutTimeDay = value
        case "caloriesWeek":
            self.caloriesWeek = value
        case "caloriesDay":
            self.caloriesDay = value
        case "stepsWeek":
            self.stepsWeek = value
        case "stepsDay":
            self.stepsDay = value
        default:
            break
        }
    }
}
