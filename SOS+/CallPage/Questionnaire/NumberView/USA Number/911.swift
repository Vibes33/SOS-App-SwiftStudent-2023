
import SwiftUI
import UIKit

struct USNumberView: View {
    @AppStorage("emergencyContacts") private var emergencyContactsData: Data = Data()
    @State private var showSMSConfirmationAlert = false
    @State private var isPresentingMessageComposeView = false

    private var emergencyContacts: [EmergencyContact] {
        if let contacts = try? JSONDecoder().decode([EmergencyContact].self, from: emergencyContactsData) {
            return contacts
        } else {
            return []
        }
    }

    func sendSMSToEmergencyContacts() {
        isPresentingMessageComposeView = true
    }

    var body: some View {
        VStack {
            Text("Emergency Number for you")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top)

            Text("911")
                .font(.system(size: 80))
                .fontWeight(.bold)
                .foregroundColor(.red)
                .padding(.top)

            Text("You can call this number or send one sms to your emergency contact, the SMS share your position and the number of emergency at your emergency contact and the number here")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)

            Divider()
                .padding(.vertical)

            HStack {
                SMSEmergencyButton(emergencyNumber: "911")
                
                Button(action: {
                    // Action for calling the emergency number
                    if let url = URL(string: "tel://911"), UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    } else {
                        print("Failed to make a call")
                    }
                }) {
                    Text("Call")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            Spacer()
        }
        .padding()
    }
}

struct USNumberView_Previews: PreviewProvider {
    static var previews: some View {
        USNumberView()
    }
}

