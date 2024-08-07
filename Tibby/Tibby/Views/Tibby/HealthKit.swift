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
    var healthStore: HKHealthStore?
    
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
}
