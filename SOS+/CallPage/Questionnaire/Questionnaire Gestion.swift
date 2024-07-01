import SwiftUI
import CoreLocation

struct CountryViewQuestion: View {
    @State private var selectedEmergencyType: String = ""
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    let CountryTypes = [
         "USA",
         "France",
         "Australia",
     ]
    
    let locationManager = CLLocationManager()

    
    @State private var shouldNavigate = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Select Emergency Type")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()

                VStack(alignment: .leading) {
                    ForEach(CountryTypes, id: \.self) { emergencyType in
                        Button(action: {
                            selectedEmergencyType = emergencyType
                        }) {
                            HStack {
                                Text(emergencyType)
                                Spacer()
                                if selectedEmergencyType == emergencyType {
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

                Button(action: {
                    autoLocateUser()
                }) {
                    Text("Auto-location")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.bottom)

                Button(action: {
                    if !selectedEmergencyType.isEmpty {
                        shouldNavigate = true
                    }
                }) {
                    Text("Next")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(selectedEmergencyType.isEmpty ? Color.gray.opacity(0.5) : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(selectedEmergencyType.isEmpty)
             
                NavigationLink(
                    destination: destinationView(value: selectedEmergencyType),
                    isActive: $shouldNavigate
                ) {
                    EmptyView()
                }
                
                .frame(width: 0, height: 0)
                .hidden()
               

                Spacer()
            }
            .padding()
            .navigationBarTitle("Emergency Selection", displayMode: .inline)
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    
    private func destinationView(value: String) -> some View {
        switch value {
        case "USA":
            return AnyView(EmergencyUSAQuestion())
        case "France":
            return AnyView(EmergencyFRQuestion())
        case "Australia":
            return AnyView( EmergencyAUSQuestion())
        default:
            return AnyView(EmptyView())
        }
    }
    

    private func autoLocateUser() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        if let location = locationManager.location {
            CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
                if let error = error {
                    showAlert(title: "Error", message: "Failed to get location: \(error.localizedDescription)")
                } else if let placemarks = placemarks, let placemark = placemarks.first {
                    let country = placemark.country ?? ""

                    if CountryTypes.contains(country) {
                        selectedEmergencyType = country
                    } else {
                        showAlert(title: "Error", message: "Your location is not in the list of supported countries.")
                    }
                }
            }
        } else {
            showAlert(title: "Error", message: "Failed to get your location. Please try again.")
        }
    }

    private func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}

struct CountryViewQuestion_Previews: PreviewProvider {
    static var previews: some View {
        CountryViewQuestion()
    }
}
