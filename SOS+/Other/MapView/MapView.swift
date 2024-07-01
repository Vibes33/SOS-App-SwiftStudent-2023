import SwiftUI
import MapKit
import CoreLocation

class IdentifiablePointAnnotation: MKPointAnnotation, Identifiable {
    let id = UUID()
}

struct MapFinal: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    @State private var annotations: [IdentifiablePointAnnotation] = []
    @State private var showAlert = false
    @Environment(\.presentationMode) var presentationMode

    private let locationManager = CLLocationManager()

    private func fetchLocations() {
        let searchTerm = "hospital"

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchTerm
        request.region = region

        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let response = response else { return }

            for item in response.mapItems {
                let annotation = IdentifiablePointAnnotation()
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                annotations.append(annotation)
            }
        }
    }

    private func centerMapOnUserLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        if let location = locationManager.location {
            let coordinate = location.coordinate
            region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
            fetchLocations()
        } else {
            showAlert = true
        }
    }

    private func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, annotationItems: annotations) { annotation in
                MapAnnotation(coordinate: annotation.coordinate) {
                    VStack {
                        Image(systemName: "hospital")
                            .frame(width: 7.0)
                            .font(.largeTitle)
                            .foregroundColor(.red)
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear(perform: centerMapOnUserLocation)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("SOS+ does not have access to your location"),
                      message: Text("Please enable location access in settings."),
                      primaryButton: .default(Text("Activate"), action: {
                        openSettings()
                      }),
                      secondaryButton: .cancel(Text("Return"), action: {
                        presentationMode.wrappedValue.dismiss()
                      })
                )
            }
        }
    }
}

struct MapFinal_Previews: PreviewProvider {
    static var previews: some View {
        MapFinal()
    }
}
