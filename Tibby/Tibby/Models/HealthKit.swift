//
//  HealthKit.swift
//  Tibby
//
//  Created by Felipe Elsner Silva on 07/08/24.
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

///get the informations of the start of the activity
struct StartedWorkout {
    var start: Date
    var activity: WorkoutActivityType
    
    init(start: Date, activity: WorkoutActivityType) {
        self.start = start
        self.activity = activity
    }
    
    func createWorkoutDone(end: Date) -> WorkoutPratic {
        return WorkoutPratic(start: self.start, end: end, activity: self.activity)
    }
}
///create a complete workout in the system to compute the data
struct WorkoutPratic {
    var start: Date
    var end: Date
    var activity: WorkoutActivityType
    
    init(start: Date, end: Date, activity: WorkoutActivityType) {
        self.start = start
        self.end = end
        self.activity = activity
    }
    
    var duration: TimeInterval {
        return end.timeIntervalSince(start)
    }
}

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
    var height: Double = 1
    var bodyMass: Double = 1
    var birth: DateComponents?
    
    var getAllWorkout: [WorkoutActivityType] {
        return WorkoutActivityType.allCases
    }
    
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
        // Types of samples you want to use
        let healthTypesWrite: Set = [
            HKQuantityType(.stepCount),
            HKQuantityType(.activeEnergyBurned),
            HKSampleType.workoutType()
        ]
        
        let healthTypesRead: Set = [
            HKQuantityType(.stepCount),
            HKQuantityType(.activeEnergyBurned),
            HKSampleType.workoutType(),
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!,
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!,
            HKCharacteristicType(.dateOfBirth)
        ]
        
        //Request authorization for writing a certain type
        healthStore?.requestAuthorization(toShare: healthTypesWrite, read: healthTypesRead, completion: { success, error in
            if success {
                // Authorization was granted, proceed with data fetching
            } else {
                // Handle authorization failure
            }
        })
    }
    
    ///App check if the user authorize the write workout in Health Data
    func checkWorkoutAuthorization() -> Bool {
        if healthStore!.authorizationStatus(for: HKSampleType.workoutType()).rawValue == 2 {
            return true
        }
        return false
    }
    
    ///App check if the user authorize the write workout in Health Data
    func checkEnergyAuthorization() -> Bool {
        if healthStore!.authorizationStatus(for: HKQuantityType(.activeEnergyBurned)).rawValue == 2 {
            return true
        }
        return false
    }
    
    ///App check if the user authorize the write workout in Health Data
    func checkStepsAuthorization() -> Bool {
        if healthStore!.authorizationStatus(for: HKQuantityType(.stepCount)).rawValue == 2 {
            return true
        }
        return false
    }
    
    /// Directs the user to the iOS settings to manage HealthKit permissions.
    func goToiOSSettings() {
        guard let url = URL(string: "App-Prefs:") else { return }
        UIApplication.shared.open(url)
    }
    
    //Fetch HealthKit informations that are used
    func fetchInformation(informationList: [(dateInfo: Date, sampleInfo: SampleType, dataTypeInfo: DateType)]) {
        for information in informationList {
            getHealthInfo(startDate: information.dateInfo, sample: information.sampleInfo, frequency: information.dataTypeInfo)
        }
    }
    
    //Fetch height and body mass and birth
    func fetchCharacteristics() {
        do {
            birth = try self.healthStore?.dateOfBirthComponents()
            
            let heightSample: HKSampleType = HKQuantityType(.height)
            let heightQuery = HKSampleQuery(sampleType: heightSample, predicate: nil, limit: 1, sortDescriptors: nil, resultsHandler: {(query, result, error)in
                if let samples = result {
                    for sample in samples {
                        let quantitySample = sample as! HKQuantitySample
                        self.height = quantitySample.quantity.doubleValue(for: .meterUnit(with:.centi))
                        print("\(self.height)")
                    }
                }
                else {
                    self.height = 0
                }
            })
            self.healthStore?.execute(heightQuery)
            
            let massSample: HKSampleType = HKQuantityType(.bodyMass)
            let massQuery = HKSampleQuery(sampleType: massSample, predicate: nil, limit: 1, sortDescriptors: nil, resultsHandler: {(query, result, error)in
                if let samples = result {
                    for sample in samples {
                        let quantitySample = sample as! HKQuantitySample
                        self.bodyMass = quantitySample.quantity.doubleValue(for: .gram())
                        print("\(self.bodyMass)")
                    }
                }
                else {
                    self.bodyMass = 0
                }
            })
            self.healthStore?.execute(massQuery)
        }
        catch (let error) {
            debugPrint(error)
        }
    }
    
    //Fetch all the HealthKit informations that are used
    func fetchAllInformation() {
        
        fetchCharacteristics()
        
        let list: [(dateInfo: Date, sampleInfo: SampleType, dataTypeInfo: DateType)] = [(.startOfWeek, .workoutCalories, .week), (.startOfWeek, .workoutCalories, .week), (.startOfWeek, .workoutTime, .week), (.startOfDay, .workoutCalories, .day), (.startOfDay, .workoutTime, .day), (.startOfWeek, .steps, .week), (.startOfDay, .steps, .day), (.startOfWeek, .energyBurned, .week), (.startOfDay, .energyBurned, .day)]
        
        fetchInformation(informationList: list)
    }
    
    //Save Workout in Healthkit from the app
    func saveWorkout(workout: WorkoutPratic) {
        ///Configure the workout
        let workoutConfiguration = HKWorkoutConfiguration()
        workoutConfiguration.activityType = workout.activity.workoutType
        let builder = HKWorkoutBuilder(healthStore: healthStore!, configuration: workoutConfiguration, device: .local())
        
        ///Start the collection with all the workouts to save
        builder.beginCollection(withStart: workout.start) { success, error in
            guard success else {
                print("error to begin collection")
                return
            }
        }
        
        ///Calculate the calories burned in the activity
        var caloreisBurned: Double {
            if self.bodyMass == 0 {
                let hours: Double = workout.duration/3600
                return hours * 450
            }
            else {
                let minutes: Double = workout.duration/60
                let caloriesBurned: Double = (5 * 3.5 * self.bodyMass)/200
                return minutes * caloriesBurned
            }
        }
        
        guard let quantityType = HKQuantityType.quantityType(
            forIdentifier: .activeEnergyBurned) else {
            print("quantity type does not exists")
            return
        }
        let unit = HKUnit.kilocalorie()
        let totalEnergyBurned = caloreisBurned
        let quantity = HKQuantity(unit: unit, doubleValue: totalEnergyBurned)
        
        ///Create and add to the collection the samples of activity
        let sample = HKCumulativeQuantitySample(type: quantityType, quantity: quantity, start: workout.start, end: workout.end)
        
        builder.add([sample]) { (success, error) in
            guard success else {
                print("add sample error")
                return
            }
            
            ///Finish and add the workout in the health app
            builder.endCollection(withEnd: workout.end) { (success, error) in
                guard success else {
                    print("end collection error")
                    return
                }
                
                builder.finishWorkout { (_, error) in
                    let success = error == nil
                    print("finished workout")
                }
            }
        }
    }
    
    private func getHealthInfo(startDate: Date, sample: SampleType, frequency: DateType) {
        //Create the time interval
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date())
        var query: HKQuery?
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

enum WorkoutActivityType: CaseIterable {
    case americanFootball, archery, australianFootball, badminton, baseball, basketball, bowling, boxing, climbing, crossTraining, curling, cycling, elliptical, equestrianSports, fencing, fishing, functionalStrengthTraining, golf, gymnastics, handball, hiking, hockey, hunting, lacrosse, martialArts, mindAndBody, paddleSports, play, preparationAndRecovery, racquetball, rowing, rugby, running, sailing, skatingSports, snowSports, soccer, softball, squash, stairClimbing, surfingSports, swimming, tableTennis, tennis, trackAndField, traditionalStrengthTraining, volleyball, walking, waterFitness, waterPolo, waterSports, wrestling, yoga, barre, coreTraining, crossCountrySkiing, downhillSkiing, flexibility, highIntensityIntervalTraining, jumpRope, kickboxing, pilates, snowboarding, stairs, stepTraining, wheelchairWalkPace, wheelchairRunPace, taiChi, mixedCardio, handCycling, discSports, fitnessGaming
    
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
    
    var workoutType: HKWorkoutActivityType {
        switch self {
        case .americanFootball:
            return HKWorkoutActivityType.americanFootball
        case .archery:
            return HKWorkoutActivityType.archery
        case .australianFootball:
            return HKWorkoutActivityType.australianFootball
        case .badminton:
            return HKWorkoutActivityType.badminton
        case .baseball:
            return HKWorkoutActivityType.baseball
        case .basketball:
            return HKWorkoutActivityType.basketball
        case .bowling:
            return HKWorkoutActivityType.bowling
        case .boxing:
            return HKWorkoutActivityType.boxing
        case .climbing:
            return HKWorkoutActivityType.climbing
        case .crossTraining:
            return HKWorkoutActivityType.crossTraining
        case .curling:
            return HKWorkoutActivityType.curling
        case .cycling:
            return HKWorkoutActivityType.cycling
        case .elliptical:
            return HKWorkoutActivityType.elliptical
        case .equestrianSports:
            return HKWorkoutActivityType.equestrianSports
        case .fencing:
            return HKWorkoutActivityType.fencing
        case .fishing:
            return HKWorkoutActivityType.fishing
        case .functionalStrengthTraining:
            return HKWorkoutActivityType.functionalStrengthTraining
        case .golf:
            return HKWorkoutActivityType.golf
        case .gymnastics:
            return HKWorkoutActivityType.gymnastics
        case .handball:
            return HKWorkoutActivityType.handball
        case .hiking:
            return HKWorkoutActivityType.hiking
        case .hockey:
            return HKWorkoutActivityType.hockey
        case .hunting:
            return HKWorkoutActivityType.hunting
        case .lacrosse:
            return HKWorkoutActivityType.lacrosse
        case .martialArts:
            return HKWorkoutActivityType.martialArts
        case .mindAndBody:
            return HKWorkoutActivityType.mindAndBody
        case .paddleSports:
            return HKWorkoutActivityType.paddleSports
        case .play:
            return HKWorkoutActivityType.play
        case .preparationAndRecovery:
            return HKWorkoutActivityType.preparationAndRecovery
        case .racquetball:
            return HKWorkoutActivityType.racquetball
        case .rowing:
            return HKWorkoutActivityType.rowing
        case .rugby:
            return HKWorkoutActivityType.rugby
        case .running:
            return HKWorkoutActivityType.running
        case .sailing:
            return HKWorkoutActivityType.sailing
        case .skatingSports:
            return HKWorkoutActivityType.skatingSports
        case .snowSports:
            return HKWorkoutActivityType.snowSports
        case .soccer:
            return HKWorkoutActivityType.soccer
        case .softball:
            return HKWorkoutActivityType.softball
        case .squash:
            return HKWorkoutActivityType.squash
        case .stairClimbing:
            return HKWorkoutActivityType.stairClimbing
        case .surfingSports:
            return HKWorkoutActivityType.surfingSports
        case .swimming:
            return HKWorkoutActivityType.swimming
        case .tableTennis:
            return HKWorkoutActivityType.tableTennis
        case .tennis:
            return HKWorkoutActivityType.tennis
        case .trackAndField:
            return HKWorkoutActivityType.trackAndField
        case .traditionalStrengthTraining:
            return HKWorkoutActivityType.traditionalStrengthTraining
        case .volleyball:
            return HKWorkoutActivityType.volleyball
        case .walking:
            return HKWorkoutActivityType.walking
        case .waterFitness:
            return HKWorkoutActivityType.waterFitness
        case .waterPolo:
            return HKWorkoutActivityType.waterPolo
        case .waterSports:
            return HKWorkoutActivityType.waterSports
        case .wrestling:
            return HKWorkoutActivityType.wrestling
        case .yoga:
            return HKWorkoutActivityType.yoga
        case .barre:
            return HKWorkoutActivityType.barre
        case .coreTraining:
            return HKWorkoutActivityType.coreTraining
        case .crossCountrySkiing:
            return HKWorkoutActivityType.crossCountrySkiing
        case .downhillSkiing:
            return HKWorkoutActivityType.downhillSkiing
        case .flexibility:
            return HKWorkoutActivityType.flexibility
        case .highIntensityIntervalTraining:
            return HKWorkoutActivityType.highIntensityIntervalTraining
        case .jumpRope:
            return HKWorkoutActivityType.jumpRope
        case .kickboxing:
            return HKWorkoutActivityType.kickboxing
        case .pilates:
            return HKWorkoutActivityType.pilates
        case .snowboarding:
            return HKWorkoutActivityType.snowboarding
        case .stairs:
            return HKWorkoutActivityType.stairs
        case .stepTraining:
            return HKWorkoutActivityType.stepTraining
        case .wheelchairWalkPace:
            return HKWorkoutActivityType.wheelchairWalkPace
        case .wheelchairRunPace:
            return HKWorkoutActivityType.wheelchairRunPace
        case .taiChi:
            return HKWorkoutActivityType.taiChi
        case .mixedCardio:
            return HKWorkoutActivityType.mixedCardio
        case .handCycling:
            return HKWorkoutActivityType.handCycling
        case .discSports:
            return HKWorkoutActivityType.discSports
        case .fitnessGaming:
            return HKWorkoutActivityType.fitnessGaming
        }
    }
}
