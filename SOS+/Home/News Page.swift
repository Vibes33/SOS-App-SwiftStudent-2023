import SwiftUI

struct SiriView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Siri will be here soon in SOS+")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("In the next update of the application, we will implement Siri to make the interface of SOS+ even simpler, this feature can be used when you can't use your hands, to answer the emergency questionnaire, and thus call for help as soon as possible, share your location and more! This feature will also be used to make the application accessible to blind people.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                Divider()
                
                Image("Siri1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width - 60)
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Back")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.top)
            }
            .padding()
        }
        .navigationBarTitle("Siri in SOS+", displayMode: .inline)
    }
}

struct SiriView_Previews: PreviewProvider {
    static var previews: some View {
        SiriView()
    }
}
