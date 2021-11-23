//
//  ContentView.swift
//  Shared
//
//  Created by Francesco on 15/11/21.
//

import CoreData
import SwiftUI


@available(iOS 15, *)

extension Color {
    
    static let customBeige = Color(red: 0.93, green: 0.89, blue: 0.84)
    static let brickColor = Color(red: 0.70, green: 0.29, blue: 0.20)
    static let unDoneBrickColor = Color(red: 0.79, green: 0.55, blue: 0.49)
}

@available(iOS 15, *)
struct MyScheduleView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(
        entity: Activity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Activity.startingHour, ascending: true)],
        animation: .default) private var items: FetchedResults<Activity>
    
    let today = Date()
    
    @State var showSheet: Bool = false
    @State var showModifyModal: Bool = false
    @State var day: Int = UserDefaults.standard.integer(forKey: "day")
    @State private var isRedirecting = false
    @State private var redirectedToDetailView = false
    
    @State var isCompleted = false
        
    @State var twentyOneDays = [Int]()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text(today, style: .date)
                        .fontWeight(.thin)
                        .navigationTitle("My Schedule")
                    
                    NavigationLink(destination: TipsView(), isActive: $isRedirecting) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .shadow(color: .gray, radius: 3, x: 2, y: 2)
                                .shadow(color: .gray, radius: 3, x: -2, y: -2)
                            
                            HStack {
                                VStack(alignment: .leading,spacing: 5) {
                                    Text("Tips")
                                        .font(.title)
                                        .bold()
                                        .foregroundColor(.black)
                                    
                                    Text("A tip for you")
                                        .fontWeight(.thin)
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                        .frame(height: 125)
                                }.padding(.top)
                                
                                Spacer()
                                
                                Image("tipsImage")
                                    .resizable()
                                    .clipped()
                                    .frame(width: 180, height: 180)
                                    .aspectRatio(contentMode: .fill)
                                    .scaledToFill()
                                    .offset(y: 6)
                                
                            }
                            .frame(height: 160)
                            .padding()
                            .background(Color.customBeige.cornerRadius(25))
                        }
                    }
                    //            MARK: The current day of the 21's challenge
                    HStack {
                        Text("Day \(day)")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        
                        Text("/21")
                            .fontWeight(.thin)
                            .foregroundColor(.customBeige)
                        
                        Spacer()
                        
                        Button(action: {
                            showSheet.toggle()
                        })
                        {
                            Image(systemName: "plus.circle")
                                .imageScale(.large)
                                .foregroundColor(.black)
                        }
                        .sheet(isPresented: $showSheet){
                            NewActivityView(showModal: self.$showSheet)
                        }
                    }
                    //            MARK: The ScrollView tracking today's activities
                    VStack {
                        ForEach(items) { item in
                            if(item.day == day){
                                HStack {
                                    Button(action: {
                                        item.done.toggle()
                                    }) {
                                        Image(systemName: item.done ? "checkmark.circle.fill" : "checkmark.circle")
                                            .imageScale(.large)
                                            .foregroundColor(.brickColor)
                                            .padding(.top, 35)
                                            .padding(.trailing, 5)
                                    }
                                    // MARK: Starting time of the activity + current day of the 21 day's challenge.
                                    VStack {
                                        HStack {
                                            Text(item.startingHour ?? "")
                                                .font(.title2)
                                                .foregroundColor(.black)
                                            Spacer()
                                                .frame(width: 170)
                                            Text("\(day)/21")
                                                .foregroundColor(.black)
                                        }
                                        NavigationLink {
                                            RoutineDetailView(item: item)
                                        }
                                    label: {
                                            HStack {
                                                VStack(alignment: .leading, spacing: 10) {
                                                    HStack {
                                                        Text(item.title!)
                                                            .fontWeight(.bold)
                                                            .font(.title3)
                                                            .foregroundColor(.white)
                                                        Spacer()
                                                        Button(action: {
                                                            showModifyModal.toggle()
                                                        })
                                                        {
                                                            Image(systemName: "square.and.pencil")
                                                                .foregroundColor(.white)
                                                        }
                                                        .sheet(isPresented: $showModifyModal){
                                                            ModifyActivityView(showModifyModal: $showModifyModal)
                                                        }
                                                    }
                                                    Text(item.descrizione!)
                                                        .fixedSize(horizontal: false, vertical: true)
                                                        .foregroundColor(.white)
                                                        .multilineTextAlignment(.leading)
                                                }
                                                .frame(maxWidth: .infinity, alignment: .leading)
                                                .padding()
                                                .background(item.done ? Color.brickColor : .unDoneBrickColor)
                                                .cornerRadius(25)
                                            }
                                        }
                                    }
                                }
                                .padding()
                            }
                        }
                        .onAppear {
                            day = UserDefaults.standard.integer(forKey:"day")
                            let dateFormatter = DateFormatter()
                            var lastDay: String!
                            dateFormatter.dateFormat = "dd-MM"
                            lastDay = dateFormatter.string(from: Date())
                            
                            if( lastDay != UserDefaults.standard.string(forKey: "lastDay")){
                                UserDefaults.standard.set(lastDay, forKey: "lastDay")
                                day += 1
                                UserDefaults.standard.set(day, forKey: "day")
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear {
            UserDefaults.standard.set(today, forKey: "currentDay")
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

@available(iOS 15, *)
struct MyScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        MyScheduleView()
    }
}
