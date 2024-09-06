//
//  StreakComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 02/09/24.
//

import SwiftUI


struct StreakDayComponent: View {
    @State var isOn: Bool
    @State var isToday: Bool
    var day: String
    var dayOfWeek: String
    
    var body: some View {
        VStack {
            Image(isOn ? "CapsuleStreakOn" : "CapsuleStreakOff")
                .resizable()
                .scaledToFit()
                .frame(width: 21, height: 21)


            Text("\(day)")
                .font(.typography(.body))
                .foregroundStyle(isOn ? .tibbyBaseDarkBlue : .tibbyBaseWhite)
                .padding(8)
                .background {
                    RoundedRectangle(cornerRadius: 50)
                        .fill(isOn ? .tibbyBaseWhite : .tibbyBaseDarkBlue)
    
                }
            
            Text(dayOfWeek)
                .font(.typography(.label2))
                .foregroundStyle(isOn ? .tibbyBaseWhite : .tibbyBaseBlack)

        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(isToday ? .tibbyBaseBlack : .clear )
                .stroke(.tibbyBaseDarkBlue, lineWidth: isToday ? 0 : 1)
        }
    }
}
