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
            return "112"
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
        let messageBody = "Bonjour, une personne est en situation d'urgence à cette localisation : \(userLocation), elle s'appelle \(firstName) \(lastName), c'est un(e) \(sex). La personne est \(consciousness), le type d'accident est \(accidentType), les détails de l'accident sont les suivants : \(accidentDetails). Lésions : \(lesions.joined(separator: ", ")), Membres déformés : \(deformedLimbs.joined(separator: ", ")), la personne \(isBleeding == "Oui" ? "saigne" : "ne semble pas saigner"). Message envoyé au numéro suivant : \(emergencyNumber), si il s'agit d'une erreur merci de faire suivre ce message au numéro mentionné. Message envoyé depuis l'application SOS+."

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
