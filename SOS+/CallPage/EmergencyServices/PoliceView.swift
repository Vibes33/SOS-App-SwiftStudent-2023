import SwiftUI



struct PoliceView: View {
    @State private var selectedEmergencyNumber: String = ""
    @StateObject private var locationManager = LocationManager()
    @StateObject private var emergencyNumbers = PoliceEmergencyNumbers()

    var body: some View {
        VStack {
            
            Text("Police")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.top)
            
            Divider()
            
            Text("Number for Police")
                .padding()
            
            VStack(alignment: .leading) {
                ForEach(emergencyNumbers.numbers, id: \.1) { (country, number) in
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
                    openMapsApp()
                }) {
                    Text("Find")
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .background(Color.blue)
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
    }
    
    private func openMapsApp() {
        if let url = URL(string: "http://maps.apple.com/?q=Police%20Station") {
            UIApplication.shared.open(url)
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

class PoliceEmergencyNumbers: ObservableObject {
    let numbers = [
        ("USA", "911"),
        ("France", "17"),
        ("Australia", "000"),
    ]
}

struct PoliceView_Previews: PreviewProvider {
    static var previews: some View {
        PoliceView()
    }
}
