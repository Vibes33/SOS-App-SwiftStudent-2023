
import SwiftUI

struct GuideView2: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Find a Number")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("In SOS+ you have the possibility to contact the emergency services in a personalized way according to your needs, categories (Fire Department, Police, etc.) are there to present you with the different numbers to call according to your emergency. , if you do not know which number to call, do not panic and simply answer our questionnaire, it will provide you with a number according to your emergency, you will only have to click on the call button to call the emergency services and that of SMS to send an sms to the emergency contacts that you have previously created!")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                Divider()
                
                Image("Guide2")
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

struct GuideView2_Previews: PreviewProvider {
    static var previews: some View {
        GuideView2()
    }
}

