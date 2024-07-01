import SwiftUI
import MessageUI

struct MessageComposer: UIViewControllerRepresentable {
    var recipients: [String]
    @Binding var result: Result<MFMessageComposeViewController, Error>?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
        let controller = MFMessageComposeViewController()
        controller.recipients = recipients
        controller.messageComposeDelegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: Context) {}

    class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        let parent: MessageComposer

        init(_ parent: MessageComposer) {
            self.parent = parent
        }

        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            parent.result = .success(controller)
            controller.dismiss(animated: true)
        }
    }
}

struct DeafHOEView: View {
    @State private var selectedEmergencyNumber: String = ""
    @StateObject private var locationManager = LocationManager()
    @State private var messageComposeResult: Result<MFMessageComposeViewController, Error>? = nil
    @State private var showSMSComposer = false

    let emergencyNumbers = [
        ("USA", "911"),
        ("France", "114"),
        ("Australia", "000"),
    ]

    var body: some View {
        VStack {
            Text("Deaf And Hard Of Hearing")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.top)

            Divider()

            Text("Number for Deaf And Hard Of Hearing")
                .padding()

            VStack(alignment: .leading) {
                ForEach(emergencyNumbers, id: \.1) { (country, number) in
                    Button(action: {
                        selectedEmergencyNumber = number
                    }) {
                        HStack {
                            Text("\(country) - \(number)")
                            Spacer()
                            if selectedEmergencyNumber == number {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                    .frame(minHeight: 44)
                    Divider()
                }
            }
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .padding(.bottom)

            VStack(spacing: 16) {
                Button(action: {
                    sendSMS()
                }) {
                    Text("SMS")
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .disabled(selectedEmergencyNumber.isEmpty)
                .background(selectedEmergencyNumber.isEmpty ? Color.gray.opacity(0.5) : Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)

                Button(action: {
                    callEmergencyNumber()
                }) {
                    Text("Call")
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .disabled(selectedEmergencyNumber.isEmpty)
                .background(selectedEmergencyNumber.isEmpty ? Color.gray.opacity(0.5) : Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding(.top)

            Spacer()
        
        }
        .onAppear {
            locationManager.requestLocation()
        }
        .sheet(isPresented: $showSMSComposer) {
            if MFMessageComposeViewController.canSendText() {
                MessageComposer(recipients: [selectedEmergencyNumber], result: $messageComposeResult)
            } else {
                Text("Cannot send SMS messages.")
            }
        }
    }

    private func sendSMS() {
        guard !selectedEmergencyNumber.isEmpty else {
            print("No emergency number selected.")
            return
        }

        if MFMessageComposeViewController.canSendText() {
            showSMSComposer = true
        } else {
            print("Cannot send SMS messages.")
        }
    }
    
    private func callEmergencyNumber() {
        guard !selectedEmergencyNumber.isEmpty else {
            print("No emergency number selected.")
            return
        }

        if let url = URL(string: "tel://\(selectedEmergencyNumber)") {
            UIApplication.shared.open(url)
        } else {
            print("Failed to create URL.")
        }
    }
}

struct DeafHOEView_Previews: PreviewProvider {
    static var previews: some View {
        DeafHOEView()
    }
}
