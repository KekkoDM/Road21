//
//  IntroView.swift
//  ProjectTwo
//
//  Created by Aristide LAUGA on 12/11/2021.
//

import SwiftUI

struct IntroView: View {
    var body: some View {
        ZStack {
            
            Rectangle()
                .foregroundColor(Color(UIColor(red: 0.93, green: 0.89, blue: 0.84, alpha: 1.00)))
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
                    
                }
                .padding(20)
                .padding(.horizontal, 20)
                .background(
                    Color(UIColor(red: 0.84, green: 0.34, blue: 0.23, alpha: 1.00))
                )
                .foregroundColor(.white)
                .cornerRadius(25)
            }
            
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}

//Rectangle()
//    .foregroundColor(Color(UIColor(red: 0.93, green: 0.89, blue: 0.84, alpha: 1.00)))


/*
 
 
 
 */
