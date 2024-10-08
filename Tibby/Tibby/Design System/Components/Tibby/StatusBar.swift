//
//  StatusBar.swift
//  Tibby
//
//  Created by Sofia Sartori on 09/08/24.
//

import SwiftUI

/// A view that displays the status of a specific necessity (e.g., sleep, happiness, hunger) for a Tibby character.
///
/// `StatusBar` shows the current value of a specified necessity alongside its name, styled according to the app's design.
struct StatusBar: View {
    /// The service object used to interact with the app's backend or data layer.
    @EnvironmentObject var service: Service
    
    /// The Tibby character whose status is being displayed.
    @State var tibby: Tibby
    
    /// The name of the necessity being displayed (e.g., "sleep", "happiness", "hunger").
    let necessityName: String
    
    var body: some View {
        HStack(alignment: .top) {
            // Display the value of the specified necessity
            necessityValueText
                .foregroundStyle(.tibbyBaseBlack)
                .font(.typography(.title))
            MoneyView(viewModel: MoneyViewModel(moneyType: .gem, service: service))
                .padding(.horizontal)
            MoneyView(viewModel: MoneyViewModel(moneyType: .coin, service: service))
                .padding(.trailing)
        }
    }
    
    /// A computed property that returns the corresponding value text for the necessity.
    ///
    /// This property uses a `switch` statement to determine which value to display based on the `necessityName`.
    @ViewBuilder
    private var necessityValueText: some View {
        switch necessityName.lowercased() {
        case "sleep":
            ProgressView(value: Float(tibby.sleep)/100)
                .progressViewStyle(CustomProgressBar(barType: .sleep))
        case "happiness":
            ProgressView(value: Float(tibby.happiness)/100)
                .progressViewStyle(CustomProgressBar(barType: .emotion))
        case "hunger":
            ProgressView(value: Float(tibby.hunger)/100)
                .progressViewStyle(CustomProgressBar(barType: .eat))
        default:
            EmptyView()
        }
    }
}

#warning("TODO: re-organize status bar and delete unused code")
//            HStack {
//                VStack(alignment: .leading) {
//                    RoundedRectangle(cornerRadius: 50)
//                        .aspectRatio(8, contentMode: .fit)
//                        .foregroundStyle(.green)
//                        .frame(height: 9.5)
//                    Text(necessityName)
//                        .foregroundStyle(.tibbyBaseBlack)
//                        .font(.typography(.label))
//                        .padding(.top, 4)
//                }
//                VStack {
//                    RoundedRectangle(cornerRadius: 50)
//                        .aspectRatio(8, contentMode: .fit)
//                        .foregroundStyle(.green)
//                        .frame(height: 9.5)
//                    Spacer()
//                }
//            }
//                .padding(.trailing, 8)

//.padding(.trailing, 8)
//            MoneyView(viewModel: MoneyViewModel(moneyType: .gem, service: service))
//                .padding(.horizontal)
//            MoneyView(viewModel: MoneyViewModel(moneyType: .coin, service: service))
//                .padding(.trailing)

//.frame(height: 35)



