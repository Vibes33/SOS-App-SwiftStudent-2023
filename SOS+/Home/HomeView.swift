import SwiftUI
import CoreLocation


class WelcomeViewLocationManager: NSObject, ObservableObject {
    private let manager = CLLocationManager()

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
}

extension WelcomeViewLocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Gérez les changements d'autorisation ici
    }
}

struct WelcomeView: View {
    
    @State private var selectedTab = 0
    @State private var showSiriView = false
    @AppStorage("easterEggCount") private var easterEggCount = 0
    @State private var showEasterEggAlert = false
    
    @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore = false
    @State private var showWelcomeSheet = false

    // Utilisez WelcomeViewLocationManager au lieu de LocationManager
    @StateObject var welcomeViewLocationManager = WelcomeViewLocationManager()
    
    var body: some View {
        GeometryReader { geometry in
          
                VStack {
                    VStack {
                        Text("SOS+")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding(.top)
                            .onTapGesture(count: 8 ) {
                                if self.easterEggCount < 3 {
                                    self.showEasterEggAlert = true
                                    self.easterEggCount += 1
                                }
                            }
                    }
                    Divider()
                    
                    // Intégration de ViewParallaxe ici
                    ViewParallaxe()
                        .frame(height: 520)  // ajustez la hauteur selon vos besoins
                        .padding(.top)
                    
                    VStack {
                        Raccourcis()
                    }
                    .offset(y: -geometry.size.height * 0.35) // Déplace la vue de 25% de la hauteur de l'écran vers le haut
                    .padding([.leading, .bottom, .trailing])
                    .padding(.top)
                }
                .onAppear {
                    // Demandez l'autorisation de localisation lorsque la vue apparaît
                    welcomeViewLocationManager.requestAuthorization()
                }
            
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
