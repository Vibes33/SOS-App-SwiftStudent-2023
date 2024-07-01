import SwiftUI
import MessageUI
import CoreLocation

struct SMSEmergencyButton: View {
    @AppStorage("emergencyContacts") private var emergencyContactsData: Data = Data()
    @State private var isPresentingMessageComposeView = false
    var emergencyNumber: String

    private var emergencyContacts: [EmergencyContact] {
        if let contacts = try? JSONDecoder().decode([EmergencyContact].self, from: emergencyContactsData) {
            return contacts
        } else {
            return []
        }
    }

    var body: some View {
        Button(action: {
            isPresentingMessageComposeView = true
        }) {
            Text("SMS")
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .sheet(isPresented: $isPresentingMessageComposeView) {
            MessageComposeView(isPresentingMessageComposeView: $isPresentingMessageComposeView, emergencyContacts: emergencyContacts, emergencyNumber: emergencyNumber)
        }
    }
}

struct MessageComposeView: UIViewControllerRepresentable {
    @Binding var isPresentingMessageComposeView: Bool
    var emergencyContacts: [EmergencyContact]
    var emergencyNumber: String

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<MessageComposeView>) -> MFMessageComposeViewController {
        let messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = context.coordinator

        // Get the user position
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        var userLocation: String = ""

        if let location = locationManager.location {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            userLocation = "Latitude: \(latitude), Longitude: \(longitude)"
        } else {
            userLocation = "NoUserLocation"
        }

        // Create a personal SMS
        let messageBody = "Your contact encountered a problem at this address: \(userLocation) and sent this message to his emergency contacts and to the number \(emergencyNumber) because it best matched his type of emergency."

        // Update number and message
        let emergencyContactNumbers = emergencyContacts.map { $0.countryCode + $0.phoneNumber }
        messageComposeVC.recipients = [emergencyNumber] + emergencyContactNumbers
        messageComposeVC.body = messageBody

        return messageComposeVC
    }

    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: UIViewControllerRepresentableContext<MessageComposeView>) {
   
    }

    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        var parent: MessageComposeView

        init(_ parent: MessageComposeView) {
            self.parent = parent
        }

        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            parent.isPresentingMessageComposeView = false
            controller.dismiss(animated: true)
        }
    }
}

