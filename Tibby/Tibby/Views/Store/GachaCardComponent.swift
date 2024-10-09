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
                        if gachaType == .series {
                            VStack {
                                Text("Reset in")
                                    .font(.typography(.label2))
                                    .foregroundStyle(.tibbyBaseBlack)
                                
                                Text("00:16:24")
                                    .font(.typography(.label2))
                                    .foregroundStyle(.tibbyBaseBlack)
                                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                                    .background {
                                        Capsule()
                                            .fill(.tibbyBasePearlBlue)
                                            .opacity(0.7)
                                    }
                            }
                            .padding(.top, 8)
                        } else {
                                VStack {
                                    Text("Reset in")
                                        .font(.typography(.label2))
                                        .foregroundStyle(.tibbyBaseBlack)
                                    
                                    Text("00:16:24")
                                        .font(.typography(.label2))
                                        .foregroundStyle(.tibbyBaseBlack)
                                        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                                        .background {
                                            Capsule()
                                                .fill(.tibbyBasePearlBlue)
                                                .opacity(0.7)
                                        }
                                }
                                .padding(.top, 8)
                                .hidden()
                                
                            }
                        
                            Spacer()
                            
                            Text(title)
                                .font(.typography(.body))
                                .foregroundStyle(.tibbyBaseBlack)
                                .multilineTextAlignment(.leading)
                            
                                .padding(.trailing, 1)
                            Spacer()
                            
                            
                            
                        }
                    .frame(width: proxy.size.width * 0.5)
                    }
                }
            }
            .frame(width: 180, height: 238)
        }
    }
    
    #Preview {
        GachaCardComponent(gachaType: .base, title: Collection.forestSeries.rawValue, color: .tibbyBasePearlBlue, image: "gatchaBase1")
    }
