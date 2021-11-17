//
//  ContentView.swift
//  Shared
//
//  Created by Francesco on 15/11/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext
    
     @FetchRequest(
        entity: Activity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Activity.startingHour, ascending: true)],
        animation: .default) private var items: FetchedResults<Activity>
    

    @State var showSheet: Bool = false

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Activity: \(item.title!) Description: \(item.descrizione!) Start: \(item.startingHour!) End: \(item.endingHour!)")
                        
                    }
                    label: {
                        Text(item.title!)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {

                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button("+") {
                        showSheet.toggle()
                    }
                    .sheet(isPresented: $showSheet){
                        NewActivityView(showModal: self.$showSheet)
                    }
                }
            }
            Text("Select an item")
        }

    }
        



    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
