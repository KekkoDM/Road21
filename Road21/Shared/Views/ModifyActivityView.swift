import SwiftUI
import CoreData

@available(iOS 15, *)
struct ModifyActivityView: View {
  
  @Binding var showModifyModal: Bool
  @Environment(\.managedObjectContext) private var viewContext
  var item: Activity
  @State var title = ""
  @State var description = ""
  @State var convertedDate: String!
  @State var activityDescription = ""
  @State var startTime = Date()
  @State var endTime = Date()
  @State var startingTimeD: String = ""
  @State var endingTimeD: String = ""
  @State private var showingAlert = false
  
  var body: some View {
    NavigationView {
      VStack {
        HStack {
          TextField("\(item.title ?? "")",text: $title)
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
        
        TextField("\(item.descrizione ?? "")", text: $description)
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
          showingAlert.toggle()
          
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
          .alert(isPresented:$showingAlert) {
            Alert(
              title: Text("Are you sure you want to delete this?"),
              message: Text("There is no undo"),
              primaryButton: .destructive(Text("Delete")) {
                deleteItem()
              },
              secondaryButton: .cancel()
            )
          }
        
        Spacer()
      }
      .navigationBarItems(leading:
                            Button(action: {
        showModifyModal.toggle()
      })
                          {
        Text("Cancel")
      },
                          trailing: Button("Done"){
        modifyItem(item: item)
        
      }
      )
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
    item.done = false
    
    showModifyModal.toggle()
    
    do {
      try viewContext.save()
    } catch {
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
  }
  
  private func deleteItem() {
    withAnimation {
      viewContext.delete(item)
      showModifyModal.toggle()
      do {
        try viewContext.save()
      } catch {
        let nsError = error as NSError
        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
      }
    }
  }
}
  
//
//  @available(iOS 15, *)
//  struct ModifyActivityView_Previews: PreviewProvider {
//    static var previews: some View {
//      ModifyActivityView(showModifyModal: true, item: Activity(entity: <#T##NSEntityDescription#>, insertInto: <#T##NSManagedObjectContext?#>))
//    }
//  }
//}
