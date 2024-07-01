import SwiftUI
import MessageUI
import CoreLocation

struct MessageView: UIViewControllerRepresentable {
    @Binding var isPresentingMessageComposeView: Bool
    var firstName: String
    var lastName: String
    var sex: String
    var consciousness: String
    var accidentType: String
    var accidentDetails: String
    var lesions: [String]
    var deformedLimbs: [String]
    var isBleeding: String
    var country: String

    var emergencyNumber: String {
        switch country {
        case "France":
            return "114"
        case "USA":
            return "911"
        case "Australie":
            return "000"
        default:
            return "112"
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<MessageView>) -> MFMessageComposeViewController {
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
        let messageBody = "Hello, a person is in emergency situation at this localisation : \(userLocation), it is called \(firstName) \(lastName), its a \(sex). The person is \(consciousness), The kind of the accident is : \(accidentType), Accident Details : \(accidentDetails). Lesion : \(lesions.joined(separator: ", ")), deformed limbs  : \(deformedLimbs.joined(separator: ", ")), The person \(isBleeding == "Oui" ? "bleeds" : "does not appear to be bleeding"). Message send at this number : \(emergencyNumber), if this is an error, please forward this message to the number given. Message sent from the SOS+ application."

        // Update number and message
        messageComposeVC.recipients = [emergencyNumber]
        messageComposeVC.body = messageBody

        return messageComposeVC
    }

    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: UIViewControllerRepresentableContext<MessageView>) {
   
    }

    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        var parent: MessageView

        init(_ parent: MessageView) {
            self.parent = parent
        }

        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            parent.isPresentingMessageComposeView = false
            controller.dismiss(animated: true)
        }
    }
}

