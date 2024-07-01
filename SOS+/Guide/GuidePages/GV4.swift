
import SwiftUI

struct GuideView4: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Presentation")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("Discover SOS+, the essential application to guarantee your safety and that of your loved ones in case of emergency. SOS+ allows you to quickly contact the emergency services adapted to your situation, thanks to an intelligent emergency questionnaire that directs you to the right number.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                Text("In addition to connecting you to the emergency services, SOS+ offers you the possibility to create emergency contacts that you have defined yourself. Thus, in case of need, you can send an emergency SMS to these contacts, giving them your location and quickly informing them of a problem concerning you.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                Text("SOS+ is the essential tool to make you feel safe, everywhere and at any time. Thanks to its simple and intuitive interface, you will be able to manage your emergency situations in the best possible way, contacting the appropriate services and alerting your loved ones in the blink of an eye. Take care of yourself and your loved ones in complete serenity with SOS+.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                Divider()
                
                
                Image("Guide3")
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

struct GuideView4_Previews: PreviewProvider {
    static var previews: some View {
        GuideView4()
    }
}


