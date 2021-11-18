//
//  ContentView.swift
//  Shared
//
//  Created by Francesco on 15/11/21.
//

import SwiftUI
import CoreData

@available(iOS 15, *)

extension Color {
    
    static let customBeige = Color(red: 0.93, green: 0.89, blue: 0.84)
    static let brickColor = Color(red: 0.70, green: 0.29, blue: 0.20)
    
}

@available(iOS 15, *)
struct MyScheduleView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(
        entity: Activity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Activity.startingHour, ascending: true)],
        animation: .default) private var items: FetchedResults<Activity>
    
    
    @State var showSheet: Bool = false
    let today = Date()
    @State private var isRedirecting = false
    
    @State private var isCompleted = false
    
    @State private var firstXcoordinate: CGFloat = 0
    @State private var firstYcoordinate: CGFloat = 0
    
    @State private var secondXCoordinate: CGFloat = 0
    @State private var secondYCoordinate: CGFloat = 0
    
    var adaptiveText: String = ""
    
    var splicedAdaptiveText: [String] {
        return adaptiveText.split(separator: " ").map(String.init)
    }
    
    var body: some View {
        NavigationView {
            
            VStack(alignment: .leading) {
                Text(today, style: .date)
                    .fontWeight(.thin)
                    .navigationTitle("My Schedule")
                
                NavigationLink(destination: TipsView(), isActive: $isRedirecting) {
                    HStack {
                        
                        VStack(alignment: .leading,spacing: 5) {
                            Text("Tips")
                                .font(.title)
                                .bold()
                                .foregroundColor(.black)
                            
                            Text("1 tip for you")
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
                    .background(
                        Color.customBeige
                            .cornerRadius(25)
                    )
                }
                
                //            MARK: The current day of the 21's challenge
                HStack {
                    //Put a responsive way to modify the challenge 1's date
                    Text("Day 7")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    
                    Text("/21")
                        .fontWeight(.thin)
                        .foregroundColor(Color(UIColor(red: 0.80, green: 0.74, blue: 0.67, alpha: 1.00)))
                    
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
                
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(items) { item in
                            
                           HStack {
//                                Button action
                                Button(action: {
                                    
                                })
// MARK: How the button is displayed
                                {
                                    GeometryReader() { reader in
                                        VStack(alignment: .center, spacing: 0) {
                                            //se primo {
                                            //Spacer(minLength: reader.size.height / 2 )
                                            //}
                                            
                                            //se non primo {
                                            Rectangle()
                                                .frame(width: 3)
                                                .foregroundColor(.red)
                                            //.padding(.bottom, 4)
                                            //}
                                            
                                            Image(systemName: "checkmark.circle")
                                                .imageScale(.large)
                                                .foregroundColor(.brickColor)
                                            //.frame(width: 8, height: 8)
                                            
                                            //se ultimo {
                                            //Spacer(minLength: reader.size.height / 2)
                                            //}
                                            
                                            //se non ultimo {
                                            Rectangle()
                                                .frame(width: 3)
                                                .foregroundColor(.red)
                                            //.padding(.top, 4)
                                            //}
                                        }
                                    }.frame(width: 15)
                                }
// MARK: Starting time of the activity. Current day of the 21 day's challenge.
                               VStack {
                                   HStack {
                                       Text(today, style: .time)
                                           .font(.title2)
                                           .foregroundColor(.black)
                                       Spacer()
                                           .frame(width: 170)
                                       Text("5/21")
                                           .foregroundColor(.black)
                                   }
                                   NavigationLink {
                                       Text("Activity: \(item.title!) Description: \(item.descrizione!) Start: \(item.startingHour!) End: \(item.endingHour!)")
                                   }
                               label: {
                                   
                                   HStack(alignment: .center) {
                                       
                                       //                                Button(action: {
                                       //
                                       //                                })
                                       //                                {
                                       //                                    GeometryReader() { reader in
                                       //                                        VStack(alignment: .center, spacing: 0) {
                                       //                                            //se primo {
                                       //                                            //Spacer(minLength: reader.size.height / 2 )
                                       //                                            //}
                                       //
                                       //                                            //se non primo {
                                       //                                            Rectangle()
                                       //                                                .frame(width: 3)
                                       //                                                .foregroundColor(.red)
                                       //                                            //.padding(.bottom, 4)
                                       //                                            //}
                                       //
                                       //                                            Image(systemName: "checkmark.circle")
                                       //                                                .imageScale(.large)
                                       //                                                .foregroundColor(.brickColor)
                                       //                                            //.frame(width: 8, height: 8)
                                       //
                                       //                                            //se ultimo {
                                       //                                            //Spacer(minLength: reader.size.height / 2)
                                       //                                            //}
                                       //
                                       //                                            //se non ultimo {
                                       //                                            Rectangle()
                                       //                                                .frame(width: 3)
                                       //                                                .foregroundColor(.red)
                                       //                                            //.padding(.top, 4)
                                       //                                            //}
                                       //                                        }
                                       //                                    }.frame(width: 15)
                                       //                                }
                                       //                                VStack {
                                       //                                    HStack {
                                       //                                        Text(today, style: .time)
                                       //                                            .font(.title2)
                                       //                                            .foregroundColor(.black)
                                       //                                        Spacer()
                                       //                                        Text("5/21")
                                       //                                            .foregroundColor(.black)
                                       //                                    }
                                       VStack(alignment: .leading, spacing: 10) {
                                           HStack {
                                               Text(item.title!)
                                                   .fontWeight(.bold)
                                                   .font(.title3)
                                                   .foregroundColor(.white)
                                               Spacer()
                                               Button(action: {
                                                   
                                               })
                                               {
                                                   Image(systemName: "square.and.pencil")
                                                       .foregroundColor(.white)
                                               }
                                           }
                                           Text(item.descrizione!)
                                               .fixedSize(horizontal: false, vertical: true)
                                               .foregroundColor(.white)
                                               .multilineTextAlignment(.leading)
                                       }
                                       .frame(maxWidth: .infinity, alignment: .leading)
                                       .padding()
                                       .background(Color.brickColor)
                                       .cornerRadius(25)
                                   }
                                   
                                   .padding([.leading, .trailing])
                               }
                                   
                               }
                               }
                           .padding()
                        }
                        .onDelete(perform: deleteItems)
                        
                    }
                }
            }
            .padding()
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
        MyScheduleView(adaptiveText: "Day 6")
    }
}
