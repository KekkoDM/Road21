import SwiftUI

@available(iOS 15, *)
struct NewActivityView: View {
    @Binding var showModal: Bool
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
        VStack {
            HStack {
                Text("New Routine")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "plus")
                    .onTapGesture {
                        //FORMAT THE STARTING DATE
                        let dateFormatter = DateFormatter()
                        var convertDate: String!
                        dateFormatter.dateFormat = "hh:mm a"
                        convertDate = dateFormatter.string(from: startTime)
                        startingTimeD = convertDate
                        
                        //FORMAT THE STARTING DATE
                        convertDate = dateFormatter.string(from: endTime)
                        endingTimeD = convertDate
                        
                        //INSERT A NEW ACTIVITY
                        let newItem = Activity(context: viewContext)
                        newItem.title = title
                        newItem.descrizione = description
                        newItem.startingHour = startingTimeD
                        newItem.endingHour = endingTimeD
                        newItem.done = false
                        showModal.toggle()
                        
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
            
            Divider()
            
            VStack(alignment: .leading) {
                
                    TextField("Title",text: $title)
                        .font(Font.title.weight(.bold))
                        .font(.title)
                        .font(.system(size: 35.0))
                        .padding(.horizontal, 7)
//                    Spacer()
                
                TextField("Description", text: $description)
                
                    .frame(height: 150, alignment: .topLeading)
                    .padding()
                    .background(Color.customBeige)
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
                        .foregroundColor(.white)
                        .background(Color.brickColor)
                        .cornerRadius(10)
                }
            }
        }.padding(.horizontal, 15)
    }
}

//@available(iOS 15, *)
//struct NewActivityView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            MyScheduleView()
//                .previewInterfaceOrientation(.portraitUpsideDown)
//            MyScheduleView()
//                .previewInterfaceOrientation(.portrait)
//        }
//    }
//}


