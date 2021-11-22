//
//  TipsView.swift
//  ProjectTwo
//
//  Created by Aristide LAUGA on 15/11/2021.
//

import SwiftUI

@available(iOS 15.0, *)
struct TipsView: View {
    
    let tipsList = Tips()
    @State var backgroundColor: Color = .customBeige
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(0..<tipsList.tipsList.count, id: \.self) { index in
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .shadow(color: .red, radius: 2, x: 8, y: 8)

                        LinearGradient(gradient: Gradient(colors: [.brickColor, Color(red: 0.48, green: 0.07, blue: 0.07)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("\(tipsList.tipsList[index].title)")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                                .bold()
                                .fixedSize(horizontal: false, vertical: true)
                                .navigationTitle("Tips")
                            
                            Text("\(tipsList.tipsList[index].description)")
                                .font(.system(size: 15))
                                .fixedSize(horizontal: false, vertical: true)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.8)
                        .padding()
                        
                    }
                    .cornerRadius(30)
                    .padding(.horizontal, 20)
                        //                        changeBackgroundColor(index: index)
                }
            }
        }
    }
}

@available(iOS 15, *)
func changeBackgroundColor(index: Int) -> Color {
    switch index {
    case 0...5:
        return Color(UIColor(red: 0.70, green: 0.29, blue: 0.20, alpha: 1.00))
    case 5...11:
        return Color(UIColor(red: 0.84, green: 0.34, blue: 0.23, alpha: 1.00))
    case 12...index:
        return .customBeige
    default:
        return .customBeige
    }
}

func changeForegroundColor(index: Int) -> Color {
    switch index {
    case 0...11:
        return .white
    case 11...index:
        return .black
    default:
        return .black
    }
}


@available(iOS 15.0, *)
struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        TipsView(backgroundColor: .customBeige)
    }
}



/*
 bezierPath.move(to: CGPoint(x: 56.5, y: 19.5))
 bezierPath.addCurve(to: CGPoint(x: 86.48, y: 45.84), controlPoint1: CGPoint(x: 66.26, y: 25.13), controlPoint2: CGPoint(x: 77.99, y: 31.05))
 bezierPath.addCurve(to: CGPoint(x: 109.1, y: 92.75), controlPoint1: CGPoint(x: 95.12, y: 60.88), controlPoint2: CGPoint(x: 100.51, y: 84.81))
 bezierPath.addCurve(to: CGPoint(x: 162.27, y: 114.14), controlPoint1: CGPoint(x: 137.55, y: 119.01), controlPoint2: CGPoint(x: 162.27, y: 114.14))
 bezierPath.addLine(to: CGPoint(x: 173.58, y: 106.74))
 bezierPath.addLine(to: CGPoint(x: 181.5, y: 92.5))
 bezierPath.addLine(to: CGPoint(x: 181.5, y: 77.93))
 bezierPath.addLine(to: CGPoint(x: 177.54, y: 66.41))
 bezierPath.addLine(to: CGPoint(x: 167.36, y: 50.77))
 bezierPath.addLine(to: CGPoint(x: 163.97, y: 32.67))
 UIColor(red: 0.84, green: 0.34, blue: 0.23, alpha: 1.00).setStroke()
 bezierPath.lineWidth = 1
 bezierPath.stroke()
 
 
 VStack(alignment: .leading, spacing: 8) {
     Text("\(tipsList.tipsList[index].title)")
         .font(.system(size: 24))
         .foregroundColor(.white)
         .bold()
         .fixedSize(horizontal: false, vertical: true)
         .navigationTitle("Tips")
     
     Text("\(tipsList.tipsList[index].description)")
         .font(.system(size: 15))
         .fixedSize(horizontal: false, vertical: true)
         .foregroundColor(.white)
 }
 .frame(maxWidth: UIScreen.main.bounds.width * 0.8)
 .padding()
 .background(
     LinearGradient(gradient: Gradient(colors: [.brickColor, Color(red: 0.48, green: 0.07, blue: 0.07)]), startPoint: .topLeading, endPoint: .bottomTrailing))
 
 
 
 */

//linear-gradient(to right, rgb(241, 39, 17), rgb(245, 175, 25))
