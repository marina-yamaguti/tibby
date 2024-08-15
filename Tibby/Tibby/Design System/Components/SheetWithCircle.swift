//
//  SheetWithCircle.swift
//  Tibby
//
//  Created by Sofia Sartori on 08/08/24.
//

import SwiftUI

struct SheetWithCircle: View {
    var goingUp: Bool
    var body: some View {
        VStack {
            ZStack {
                BorderedShapeWithHandle()
                    .foregroundStyle(goingUp ? Color.tibbyBaseWhite : Color.tibbyBaseBlue)
                VStack {
                    Image("TibbySymbolArrowUp")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .padding()
                    Text(goingUp ? "My Tibbies" : "Home")
                        .foregroundStyle(.black)
                        .font(.typography(.label))
                        .rotationEffect(goingUp ? .zero : .degrees(180))
                    Spacer()
                }
            }.rotationEffect(goingUp ? .zero : .degrees(180))
        }
    }
}

#Preview {
    SheetWithCircle(goingUp: false)
}

struct BorderedShapeWithHandle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let handleDiameter: CGFloat = 98
        let handleRadius = handleDiameter / 2
        
        // Ponto inicial no canto superior esquerdo
        let startPoint = CGPoint(x: rect.minX, y: rect.minY + 20)
        path.move(to: startPoint)
        
        
        path.addQuadCurve(to: CGPoint(x: rect.midX/2, y: rect.minY + 25), control: CGPoint(x: rect.midX/4, y: rect.minY + 25))
        
        path.addQuadCurve(to: CGPoint(x: rect.midX - handleRadius + 15, y: rect.minY), control: CGPoint(x: rect.midX - handleRadius, y: rect.minY + 20))
        
        path.addQuadCurve(to: CGPoint(x: rect.midX + 30, y: rect.minY),
                          control: CGPoint(x: rect.midX, y: rect.minY + 55))
        
        path.addQuadCurve(to: CGPoint(x: rect.maxX * 3/4, y: rect.minY + 25), control: CGPoint(x: rect.maxX/1.5, y: rect.minY + 20))

        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: rect.minY + 20),
                          control: CGPoint(x: rect.maxX * 0.8, y: rect.minY + 30))
        
        // Desenha o resto do retângulo
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: startPoint)
        
        let handleRect = CGRect(x: rect.midX - handleRadius,
                                y: rect.minY - 10,
                                width: 98,
                                height: 74)
        path.addEllipse(in: handleRect)
        
        return path
    }
}
