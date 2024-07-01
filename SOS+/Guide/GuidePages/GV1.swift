
import SwiftUI

struct GuideView1: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Add Contact")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("In SOS+ , you can add emergency contacts so that they are called in case of use of the application by the user for an emergency , In the menu of the application is the category Other , click on it then go to Emergency Contact . When you arrive here, you just have to click on the + button to add a contact manually, or add it from your existing contacts, remember to choose the code of the number (+1, +33 etc. ...), and that's it, you now have emergency contacts, which will be notified when you are in danger !")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                Divider()
                
                Image("Guide1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width - 60)
                

                .padding(.top)
            }
            .padding()
        }
        .navigationBarTitle("SOS+ Guide", displayMode: .inline)
    }
}

struct GuideView1_Previews: PreviewProvider {
    static var previews: some View {
        GuideView1()
    }
}
