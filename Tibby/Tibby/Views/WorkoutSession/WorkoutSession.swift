//
//  WorkoutSession.swift
//  Tibby
//
//  Created by Sofia Sartori on 05/09/24.
//

import SwiftUI

struct WorkoutSessionView: View {
    let image: String
    let sport: String
    var body: some View {
        VStack(alignment: .leading){
            HStack {
                Text(sport)
                    .font(.typography(.title))
                    .foregroundStyle(.tibbyBaseWhite)
                Spacer()
            }.padding()
            Spacer()
            VStack(alignment: .leading, spacing: 16) {
                Text("Elapsed Time")
                    .font(.typography(.body))
                    .foregroundStyle(.tibbyBaseGreen)
                Text("00:32:58")
                    .font(.typography(.display))
                    .foregroundStyle(.tibbyBaseWhite)
                Text("Steps Taken")
                    .font(.typography(.body))
                    .foregroundStyle(.tibbyBaseGreen)
                Text("823")
                    .font(.typography(.display))
                    .foregroundStyle(.tibbyBaseWhite)
            }.padding(.leading, 32)
            ZStack {
                Image("WorkoutMat")
                    .resizable()
                    .scaledToFit()
                Image(image)
                    .resizable()
                    .scaledToFit()
                
            }
            Divider()
                .foregroundStyle(.tibbyBaseGrey)
            HStack(alignment: .center) {
                Button(action: {}, label: {
                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .foregroundStyle(.black.opacity(0.5))
                            Image(TibbySymbols.pauseWhite.rawValue)
                                .resizable()
                                .scaledToFit()
                                .padding(10)
                        }.frame(maxWidth: 40, maxHeight: 40)
                        Text("Pause")
                            .font(.typography(.body))
                            .foregroundStyle(.tibbyBaseWhite)
                    }
                })
                Spacer()
                Button(action: {}, label: {
                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .foregroundStyle(.black.opacity(0.5))
                            Image(TibbySymbols.play.rawValue)
                                .resizable()
                                .scaledToFit()
                                .padding(10)
                        }.frame(maxWidth: 40, maxHeight: 40)
                        Text("Pause")
                            .font(.typography(.body))
                            .foregroundStyle(.tibbyBaseWhite)
                    }
                })

            }
            
            Spacer()
        }.background(.tibbyBaseBlack)

    }
}

#Preview {
    WorkoutSessionView(image: "shark1", sport: "Badminton")
}
