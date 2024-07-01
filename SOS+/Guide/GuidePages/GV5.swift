
import SwiftUI

struct GuideView5: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Open a map")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("SOS+ is the must-have application for anyone looking to be prepared in case of a medical emergency. With its geolocation feature, SOS+ allows its users to view the medical centers closest to their current location. Whether you need a hospital, medical center or clinic, SOS+ will guide you to the nearest destination.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                Text("SOS+ also allows in the emergency information category to directly locate the buildings you need near you by opening your basic map application present on all Apple devices. If you want to display the map directly in the application, no worries, just select 'Other' in the application menu, then 'Find' to open a map centered on your position and showing the nearest emergency centers.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                Text("However, if you don't have a connection or your location is disabled, don't worry. SOS+ offers you the possibility to access the 'Call without connection' category in its user guide. This category will allow you to find all the information you need to contact the emergency services without needing a connection or location.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                Divider()
                
                
                Image("Guide5")
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

struct GuideView5_Previews: PreviewProvider {
    static var previews: some View {
        GuideView5()
    }
}

