//
//  GatchaCardComponent.swift
//  Tibby
//
//  Created by Natalia Dal Pizzol on 08/10/24.
//

import SwiftUI

enum GachaType {
    case base
    case series
}

struct GachaCardComponent: View {
    @ObservedObject private var viewModel = GatchaViewModel()
    @State private var countdownString: String = "00:00:00"
    @State private var timer: Timer? = nil
    private var gachaType: GachaType
    private var title: String
    private var color: Color
    private var image: String
    
    init(gachaType: GachaType, title: String, color: Color, image: String) {
        self.gachaType = gachaType
        self.title = title
        self.color = color
        self.image = image
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(color)
            GeometryReader { proxy in
                Image(image)
                    .resizable()
                    .frame(width: proxy.size.width + 97, height: proxy.size.height + 59)
                    .position(x: 1, y: 115)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            GeometryReader { proxy in
                HStack {
                    Spacer()
                    VStack {
                        
                        Spacer()
                        Spacer()
                        
                        Text(title)
                            .font(.typography(.body))
                            .foregroundStyle(.tibbyBaseBlack)
                            .multilineTextAlignment(.leading)
                        
                            .padding(.trailing, 1)
                        Spacer()
                        
                        
                        
                    }
                    .overlay {
                        if gachaType == .series {
                            VStack(spacing: 0) {
                                Text("Reset in")
                                    .font(.typography(.label2))
                                    .foregroundStyle(.tibbyBaseBlack)
                                
                                Text("\(countdownString)")
                                    .font(.typography(.label2))
                                    .foregroundStyle(.tibbyBaseBlack)
                                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                                    .background {
                                        Capsule()
                                            .fill(.tibbyBasePearlBlue)
                                            .opacity(0.7)
                                    }
                                Spacer()
                            }
                            .padding(.top, 8)
                        }
                    }
                    .frame(width: proxy.size.width * 0.5)
                }
            }
        }
        .frame(width: 180, height: 238)
    }
    func startTimer() {
        updateCountdown()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            updateCountdown()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func updateCountdown() {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentWeek = calendar.component(.weekOfYear, from: currentDate)
        let currentYear = calendar.component(.yearForWeekOfYear, from: currentDate)
        
        if let nextWeekStart = calendar.date(from: DateComponents(weekOfYear: currentWeek + 1, yearForWeekOfYear: currentYear)) {
            let timeInterval = nextWeekStart.timeIntervalSince(currentDate)
            
            if timeInterval <= 0 {
                stopTimer()
                countdownString = "00:00:00"
                return
            }
            let totalSeconds = Int(timeInterval)
            let hours = totalSeconds / 3600
            let minutes = (totalSeconds % 3600) / 60
            let seconds = totalSeconds % 60
            countdownString = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
    }
}
