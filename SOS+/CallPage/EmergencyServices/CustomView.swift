import SwiftUI
import CoreLocation

struct CustomView: View {
    @State private var selectedEmergencyNumber: String = ""
    @StateObject private var locationManager = LocationManager()

    let emergencyNumbers = [
        ("USA", "911"),
        ("France", "196"),
        ("Australia", "000"),
    ]

    private func openMapsApp() {
        if let url = URL(string: "http://maps.apple.com/?q=Sea%20Rescuer") {
            UIApplication.shared.open(url)
        }
    }

    var body: some View {
        VStack {
            
            Text("Sea Rescuer")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.top)
            
            Divider()
            
            Text("Number for emergency")
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

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var lastLocation: CLPlacemark?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

    func requestLocation() {
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Error reverse geocoding location: \(error.localizedDescription)")
                return
            }
            guard let placemark = placemarks?.first else { return }
            DispatchQueue.main.async {
                self.lastLocation = placemark
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error.localizedDescription)")
    }
}

struct CustomView_Previews: PreviewProvider {
    static var previews: some View {
        CustomView()
    }
}

        
