import SwiftUI

@available(iOS 15, *)
struct ModifyActivityView: View {
    

    @Binding var showModifyModal: Bool
    @Environment(\.managedObjectContext) private var viewContext
    

    @State var item: Activity

//    init(item: Activity) {
//        self.item = item
//
//    }

    
    @State var title = ""
    @State var description = ""
    @State var convertedDate: String!
    @State var activityDescription = ""
    @State var startTime = Date()
    @State var endTime = Date()
    @State var startingTimeD: String = ""
    @State var endingTimeD: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("\(item.title!)",text: $title)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .font(Font.title.weight(.bold))
                    .font(.title)
                    .font(.system(size: 35.0))
                    .padding(.horizontal, 7)
                    .padding(.top, 10)
                    .navigationBarTitle(Text("Modify your activity"), displayMode: .inline)
                    
                    Spacer()
                }
                
                    TextField("\(item.descrizione!)", text: $description)
                    .frame(height: 150, alignment: .topLeading)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.customBeige)
                    .cornerRadius(20)
//                }
            .padding(.top, 10)
                
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
                
                Button(action: {
                    deleteItem()
                                })
                                {
                                    Text("Delete the activity")
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                        .padding()
                                        .foregroundColor(.white)
                                        .background(Color.brickColor)
                                        .cornerRadius(25)
                                }.padding(.top, 10)
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
                modifyItem(item: item)
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
        
        //MODIFY AN ACTIVITY
        item.title = title
        item.descrizione = description
        item.startingHour = startingTimeD
        item.endingHour = endingTimeD
        item.day = Int16(UserDefaults.standard.integer(forKey: "day"))
        item.done = false
        
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
    
    private func deleteItem() {
        withAnimation {
            viewContext.delete(item)
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
    
    
//    @available(iOS 15, *)
//    struct ModifyActivityView_Previews: PreviewProvider {
//        static var previews: some View {
//            ModifyActivityView(showModifyModal: true)
//        }
//    }
}
