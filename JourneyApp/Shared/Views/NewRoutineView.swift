//
//  NewRoutineView.swift
//  ProjectTwo
//
//  Created by Aristide LAUGA on 14/11/2021.
//

import SwiftUI

@available(iOS 15, *)
struct NewRoutineView: View {
        
        static var defaultStartTime: Date {
            var components = DateComponents()
            components.hour = 7
            components.minute = 0
            return Calendar.current.date(from: components) ?? Date.now
        }
        
        static var defaultEndTime: Date {
            var components = DateComponents()
            components.hour = 7
            components.minute = 0
            return Calendar.current.date(from: components) ?? Date.now
        }
        
        @State var activityTitle = ""
        @State var activityDescription = ""
        @State var startTime = defaultStartTime
        @State var endTime = defaultEndTime
        
    var activities = NewActivity().activitiesList
    
        var body: some View {
            VStack {
                HStack {
                    Text("New Routine")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        
                    Spacer()
                    Button(action: {
                    
//                        var newActivity = NewRoutineModel(title: activityTitle, description: activityDescription, startingTime: startTime, endingTime: endTime)

//                        activities.append(newActivity)
                        
                                
                    })
                    {
                        Image(systemName: "plus")
                            .font(.title2.weight(.black))
                            .foregroundColor(.black)
                    }
                }
                .padding(7)
                .offset(y: 5)
                
                Divider()
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        TextField("Title", text: $activityTitle)
                            .foregroundColor(.black)
                            .font(Font.title.weight(.bold))
                            .padding(.leading, 7)
                        Spacer()
                    }
                    
                    
                    TextField("Description", text: $activityDescription)
                    
                        .frame(height: 150, alignment: .topLeading)
                        .foregroundColor(.black)
                        .padding()
                        .background(
                            Color.customBeige
                        )
                        .cornerRadius(20)
                    
                    HStack {
                        Text("Start")
                            .font(.title2)
                        Spacer()
                        DatePicker("Please enter a time", selection: $startTime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .foregroundColor(.white)
                            .background(Color.brickColor)
                            .cornerRadius(10)
                        
                    }
                    
                    HStack {
                        Text("Finish")
                            .font(.title2)
                        Spacer()
                        DatePicker("Please enter a time", selection: $endTime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .accentColor(.white)
//                            .colorMultiply(.white)
//                            .foregroundColor(.white)
                            .background(Color.brickColor)
                            .cornerRadius(10)
                            
                        
                    }
                }
            }.padding(.horizontal, 15)
        }
    }

@available(iOS 15, *)
struct NewRoutineView_Previews: PreviewProvider {
    static var previews: some View {
        NewRoutineView()
    }
}
