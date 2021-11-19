import SwiftUI

@available(iOS 15, *)
struct NewActivityView: View {
    
    @Binding var showModal: Bool
    @Environment(\.managedObjectContext) private var viewContext
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    @State var title = ""
    @State var description = ""
    @State var convertedDate: String!
    @State var activityDescription = ""
    @State var startTime = Date()
    @State var endTime = Date()
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
    
    //    static var expiryDate: Date {
    //        var components = DateComponents()
    //        components.day = 29
    //        components.month = 11
    //        return Calendar.current.date(from: components) ?? Date.now
    //    }
    
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
                        newItem.day = Int16(UserDefaults.standard.integer(forKey: "day"))
                        newItem.done = false
                        
                        let startTimeDateComponents = Calendar.current.dateComponents([.hour, .minute], from: startTime)
                        sendNotification(dateComponent: startTimeDateComponents, item: newItem, isStarting: true)
                        
                        let endTimeDateComponents = Calendar.current.dateComponents([.hour, .minute], from: endTime)
                        sendNotification(dateComponent: endTimeDateComponents, item: newItem, isStarting: false)
                        
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
                        .font(Font.title.weight(.bold))
                        .foregroundColor(.white)
                        .labelsHidden()
                        .background(Color.brickColor)
                        .cornerRadius(10)
                }
                
                HStack {
                    Text("Finish")
                        .font(.title2)
                    Spacer()
                    DatePicker("Please enter a time", selection: $endTime, displayedComponents: .hourAndMinute)
                        .font(Font.title.weight(.bold))
                        .foregroundColor(.white)
                        .labelsHidden()
                        .background(Color.brickColor)
                        .cornerRadius(10)
                }
            }
        }.padding(.horizontal, 15)
    }
    
    func sendNotification(dateComponent: DateComponents, item: Activity, isStarting: Bool) {
        
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.body = item.descrizione!
        notificationContent.badge = NSNumber(value: 1)
        var timing = ""
        var title = item.title
        
        if(isStarting){
            
            timing = "starting \(item.title!)"
            title = "STARTING: " + title!
        }
        else{
            timing = "ending \(item.title!)"
            title = "ENDING: " + title!
        }
        
        notificationContent.title = title!
        
        if let url = Bundle.main.url(forResource: "dune",
                                    withExtension: "png") {
            if let attachment = try? UNNotificationAttachment(identifier: "dune",
                                                            url: url,
                                                            options: nil) {
                notificationContent.attachments = [attachment]
            }
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        let request = UNNotificationRequest(identifier: timing,
                                            content: notificationContent,
                                            trigger: trigger)
        
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    // Local notifications
    func application(_ application: UIApplication, didReceive notification: UNNotification) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound])
    }
    
    func displayTwentyOneDay(newItem: Activity) -> Int {
        var currentDayOfChallenge = 0
        var endOfTheDay: Date {
            var components = DateComponents()
            components.hour = 23
            components.minute = 59
            return Calendar.current.date(from: components) ?? Date.now
        }
//      Create a variable to register the first activity as the

//Once it has been created :
        if endTime < endOfTheDay {
            currentDayOfChallenge = 1
        } else {

        }
        return currentDayOfChallenge
    }
}

@available(iOS 15, *)
struct NewActivityView_Previews: PreviewProvider {
    static var previews: some View {
        NewActivityView(showModal: .constant(true))
    }
}
