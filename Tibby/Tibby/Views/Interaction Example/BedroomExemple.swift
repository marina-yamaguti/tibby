//
//  BedroomExemple.swift
//  Tibby
//
//  Created by Felipe  Elsner Silva on 11/07/24.
//

import SwiftUI

struct BedroomExemple: View {
    @EnvironmentObject var constants: Constants
    var body: some View {
        VStack {
            Image("shark1")
                .resizable()
            Button(action: {
                constants.tibbySleeping.toggle()
            }, label: {
                Text("Light")
            })
        }
    }
}

