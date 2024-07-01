
import SwiftUI

struct GuideView3: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Privacy")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("SOS+ uses your location to allow you to contact the emergency services as quickly and easily as possible and to allow you to find the most appropriate center for your needs, access to contacts is also requested when creating an emergency contact but this is not mandatory for the proper functioning of the application, in fact the contact can be created manually.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                Text("No data on our users is collected and the information provided by our users remains specific to their use.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                Divider()
                
                
                Image("Guide4")
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

struct GuideView3_Previews: PreviewProvider {
    static var previews: some View {
        GuideView3()
    }
}

