//
//  ModifiyView.swift
//  JourneyApp
//
//  Created by Aristide LAUGA on 22/11/2021.
//

import SwiftUI

struct ModifiyView: View {
    
    @Binding var showModifyModal: Bool
    @Environment(\.managedObjectContext) private var viewContext
    
    
    @State var title = ""
    @State var description = ""
    @State var convertedDate: String!
    @State var activityDescription = ""
    @State var startTime = defaultStartTime
    @State var endTime = defaultEndTime
    @State var startingTimeD: String = ""
    @State var endingTimeD: String = ""
    
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

    
    var body: some View {
//        NavigationView {
        VStack {
                TextField("Title",text: $title)
                    .foregroundColor(.black)
                    .font(Font.title.weight(.bold))
                    .font(.title)
                    .font(.system(size: 35.0))
                    .padding(.horizontal, 7)
//                    .navigationBarTitle(Text("Modify your activity"), displayMode: .inline)
        }
//            .background(Color.purple)
    }
}

struct ModifiyView_Previews: PreviewProvider {
    static var previews: some View {
        ModifiyView(showModifyModal: .constant(true))
    }
}
