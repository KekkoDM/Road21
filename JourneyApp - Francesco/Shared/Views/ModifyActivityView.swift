import SwiftUI

@available(iOS 15, *)
struct ModifyActivityView: View {
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
    
//    var items = Activity()
//
//    init(items: Activity) {
//        self.items = items
//    }
//
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    TextField("Title",text: $title)
                    .foregroundColor(.black)
                    .font(Font.title.weight(.bold))
                    .font(.title)
                    .font(.system(size: 35.0))
                    .padding(.horizontal, 7)
                    .navigationBarTitle(Text("Modify your activity"), displayMode: .inline)
                
                TextField("Description", text: $description)
                    .frame(height: 150, alignment: .topLeading)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.customBeige)
                    .cornerRadius(20)
                }.padding(.top, 10)
                
                VStack {
                    HStack {
                        Text("Start")
                            .foregroundColor(.black)
                            .font(.title2)
                        Spacer()
                        DatePicker("Please enter a time", selection: $startTime, displayedComponents: .hourAndMinute)
                            .accentColor(.black)
                            .labelsHidden()
                            .colorInvert()
                            .background(Color.brickColor)
                            .cornerRadius(10)
                            .colorMultiply(.white)
                    }
                    HStack {
                        Text("Finish")
                            .foregroundColor(.black)
                            .font(.title2)
                        Spacer()
                        DatePicker("Please enter a time", selection: $endTime, displayedComponents: .hourAndMinute)
                            .accentColor(.black)
                            .labelsHidden()
                            .colorInvert()
                            .background(Color.brickColor)
                            .cornerRadius(10)
                            .colorMultiply(.white)
                    }
                }.padding(.top, 25)
               
                Spacer()
            }
            .navigationBarItems(leading:
                                    Button(action: {
                showModifyModal = false
            })
                                {
                Text("Cancel")
            },
                                trailing: Button("Done"){
                //                            modifyItem(item: item)
                
            })
            .padding(.horizontal, 15)
        }
    }
    
    func modifyItem(item: Activity){
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
        newItem.day = Int16(UserDefaults.standard.integer(forKey: "day"))
        newItem.done = false
        
        showModifyModal.toggle()
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    
    @available(iOS 15, *)
    struct ModifyActivityView_Previews: PreviewProvider {
        static var previews: some View {
            ModifyActivityView(showModifyModal: .constant(true))
        }
    }
}

//}
