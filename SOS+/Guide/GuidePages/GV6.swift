import SwiftUI

struct GuideView6: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Call without connexion")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                Text("If you have neither location nor connection, a solution is still possible, you will have to go to the section 'emergency call' of your settings, once in this section, you just have to follow the instructions provided by Apple to make an emergency call directly from your iPhone, a demonstration of the call mode by satellite is available at the bottom.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
                Divider()
                
                Image("Guide6")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width - 60)
                    .padding(.top)
                
                Button(action: {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }) {
                    Text("Open Settings")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 16)
                
                Text("The 'Open Settings' button takes you to the application settings, so simply go back to the phone settings, where you will have to manually navigate to the 'Emergency Call' section. So follow the indications provided in this page to find your way. ")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            .padding()
        }
        .navigationBarTitle("SOS+ Guide", displayMode: .inline)
    }
}
    
    struct GuideView6_Previews: PreviewProvider {
        static var previews: some View {
            GuideView6()
        }
    }
