//
//  Constants.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 08/07/24.
//

import Foundation

//MARK: Singleton
class Constants: ObservableObject {
    static let singleton: Constants = Constants()
    
    //tibby's level variables
    ///defines the max XP level that the tibby could reach
    let maxLevel = -1
    ///defines a constants that, multiplied by the level, defines the XP quantity to level up
    let xpPerLevel = 20
    
    //rooms variables
    ///defines if the tibby is sleeping or not and if the lights will be on or off
    @Published var tibbySleeping = false
    var brightness: Double {
        if tibbySleeping {
            return -0.5
        }
        else {
            return 0
        }
    }
    ///defines where the user is
    @Published var currentEnviroment: Enviroment = .bedroom
    
}
