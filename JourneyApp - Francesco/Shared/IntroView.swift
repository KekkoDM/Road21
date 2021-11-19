//
//  IntroView.swift
//  ProjectTwo
//
//  Created by Aristide LAUGA on 12/11/2021.
//

import SwiftUI
import UserNotifications

@available(iOS 15, *)
struct IntroView: View {
    @State var showSchedule: Bool = false
    // Notification center property
    let userNotificationCenter = UNUserNotificationCenter.current()
    // Auth options
    
    
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .foregroundColor(.customBeige)
                .edgesIgnoringSafeArea(.bottom)
                .frame(height: UIScreen.main.bounds.height / 2)
                .offset(y: 200)
            
            VStack {
                
                Image("Artboard")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: 300)
                
                
                Text("You’re about to take the first step in changing your life, let’s do it! The best time to start is now!")
                    .frame(width: UIScreen.main.bounds.width - 50)
                    .padding(20)
                
                
         
                        Button("Let's start") {
                            UserDefaults.standard.set(true, forKey: "FirstOpen")
                            UserDefaults.standard.set(Date(), forKey: "LastDate")
                            showSchedule.toggle()
                            
                        }
                        .padding(20)
                        .padding(.horizontal, 20)
                        .background(
                            Color(UIColor(red: 0.84, green: 0.34, blue: 0.23, alpha: 1.00))
                        )
                        .foregroundColor(.white)
                        .cornerRadius(25)
                        .fullScreenCover(isPresented: $showSchedule){
                            MyScheduleView()
                        }
                    
                
            
                
            }
            
        }
        .onAppear {
            UserDefaults.standard.set(1, forKey: "day")
            let dateFormatter = DateFormatter()
            var firstDay: String!
            dateFormatter.dateFormat = "dd-MM"
            firstDay = dateFormatter.string(from: Date())
            
            UserDefaults.standard.set(firstDay, forKey: "lastDay")
            requestNotificationAuthorization()
        }
    }
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        self.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
            if let error = error {
                print("Error: ", error)
            }
        }
    }
    
    
    

        
}

@available(iOS 15, *)
struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}

//Rectangle()
//    .foregroundColor(Color(UIColor(red: 0.93, green: 0.89, blue: 0.84, alpha: 1.00)))


/*
 
 
 
 */
