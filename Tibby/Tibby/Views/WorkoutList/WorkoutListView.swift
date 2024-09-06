//
//  WorkoutListView.swift
//  Tibby
//
//  Created by Sofia Sartori on 04/09/24.
//

import SwiftUI

struct WorkoutListView: View {
    @Binding var isOpen: Bool
    @State var tibby: Tibby
    @State var text = ""
    @State var workouts = HealthManager().getAllWorkout
    var filteredList: [WorkoutActivityType] {
            if text.isEmpty {
                return workouts
            } else {
                return workouts.filter { $0.name.localizedCaseInsensitiveContains(text) }
            }
        }
    var body: some View {
        VStack {
            HStack {
                Text("New Workout")
                    .font(.typography(.title))
                    .foregroundStyle(.tibbyBaseWhite)
                Spacer()
                Button(action: {
                    isOpen = false
                }, label: {
                    ZStack {
                        Circle().foregroundStyle(.black.opacity(0.5))
                        Image(TibbySymbols.xMark.rawValue)
                            .resizable()
                            .padding(12)
                    }.frame(width: 40, height: 40)
                })
            }.padding(24)
            CustomSearchBar(text: $text)
                .padding(.horizontal)
                .padding(.bottom)
            ScrollView {
                ForEach(filteredList, id: \.self) { workout in
                    NavigationLink(destination: WorkoutSessionView(image: "\(tibby.species)1", workout: workout), label: {
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 5)
                                .foregroundStyle(.tibbyBaseGreen)
                                .frame(width: 35, height: 35)
                            Image(systemName: workout.icon)
                                .foregroundStyle(.black)
                        }
                        Text(workout.name)
                            .font(.typography(.body))
                            .foregroundStyle(.tibbyBaseGreen)
                            .padding(.leading)
                            .lineSpacing(5.5)
                        Spacer()
                    }.padding(.horizontal)
                        .padding(.bottom)
                        
                    })
                }
            }
            Spacer()
        }.background(.tibbyBaseBlack)
            .clipShape(RoundedRectangle(cornerRadius: 45))
    }
}

