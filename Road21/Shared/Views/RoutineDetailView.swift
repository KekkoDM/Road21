//
//  RoutineDetailView.swift
//  ProjectTwo
//
//  Created by Aristide LAUGA on 18/11/2021.
//

import SwiftUI

@available(iOS 15, *)
struct RoutineDetailView: View {
    
    var item: Activity
    
    init(item: Activity) {
        self.item = item
    }
    
    private var day = "3"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // MARK: Records part
            HStack {
                Text("The road so far")
                    .fontWeight(.thin)
                    .bold()
                    .font(.system(size: 25))
                    .padding(.horizontal, 20)
                    .navigationTitle("\(item.title!)")
            }
            HStack(alignment: .center,spacing: 30) {
                // MARK: X days in a Row Stacks
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .shadow(color: .gray, radius: 8, x: 2, y: 2)
                    Color(.white).cornerRadius(20)
                    VStack(alignment: .center, spacing: 8) {
                        Image(systemName: "checkmark.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(.brickColor)
                            .font(Font.system(size: 35))
                            HStack {
                            Text("\(day)")
                                .font(.largeTitle)
                                .bold()
                            Text(day == "1" ? "day" : "days" )
                                .foregroundColor(Color(UIColor(red: 0.80, green: 0.74, blue: 0.67, alpha: 1.00)))
                        }
                        Text(day == "1" ? "Day in a row" : "Days in a row")
                            .font(.title3)
                            .bold()
                    }
                    .clipped()
                    .frame(width: 150, height: 150)
                    .padding()
                }
                .frame(width: 180, height: 180)
                // MARK: X days in a month Stack
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .shadow(color: .gray, radius: 8, x: 2, y: 2)
                    Color(.white).cornerRadius(20)
                    VStack(alignment: .center, spacing: 8) {
                        
                        Image(systemName: "calendar")
                            .imageScale(.large)
                            .foregroundColor(.brickColor)
                            .font(Font.system(size: 35))
                        
                        HStack {
                            Text("\(day)")
                                .font(.largeTitle)
                                .bold()
                            Text(day == "1" ? "day" : "days")
                                .foregroundColor(Color(UIColor(red: 0.80, green: 0.74, blue: 0.67, alpha: 1.00)))
                        }
                        
                        Text(day == "1" ? "Day in June" : "Days in June")
                            .font(.title3)
                            .bold()
                    }
                    .clipped()
                    .frame(width: 150, height: 150)
                    .padding()
                }
                .frame(width: 180, height: 180)
            }
            .frame(width: UIScreen.main.bounds.width)
            
            Text("Description")
            //                .fontWeight(.bold)
                .fontWeight(.thin)
                .font(.system(size: 25))
                .padding(.horizontal, 20)
            
            Text(item.descrizione!)
                .padding(.horizontal, 20)
            
            Spacer()
        }
        
        .frame(width: UIScreen.main.bounds.width)
    }
}

//@available(iOS 15, *)
//struct RoutineDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        RoutineDetailView(item: <#Activity#>)
//    }
//}
