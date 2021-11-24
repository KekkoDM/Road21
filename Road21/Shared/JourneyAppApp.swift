//
//  JourneyAppApp.swift
//  Shared
//
//  Created by Francesco on 15/11/21.
//

import SwiftUI

@main
struct JourneyAppApp: App{
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            if !UserDefaults.standard.bool(forKey: "FirstOpen"){
                IntroView().environment(\.managedObjectContext, persistenceController.container.viewContext)
            }else{
                MyScheduleView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            
        }
    }
    
}
