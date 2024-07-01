import SwiftUI
import UserNotifications
import CoreLocation

struct NotificationManager {
    // Notification templates
    let notificationTemplates = [
        (title: "Découvrez SOS+", body: "Rejoignez-nous sur SOS+ et explorez toutes les fonctionnalités exceptionnelles que nous avons à vous offrir. Accédez facilement aux services d'urgence et plus encore!"),
        
        (title: "Ne restez pas seul", body: "Notre communauté SOS+ s'agrandit chaque jour. Joignez-vous à nous et partagez vos expériences."),
        
        (title: "Support 24/7", body: "Besoin d'aide ? Nous sommes là pour vous à toute heure du jour et de la nuit. Contactez-nous à tout moment via SOS+"),
        
        (title: "Votre guide SOS+", body: "Vous ne savez pas par où commencer ? Notre guide détaillé sur l'application est là pour vous aider à naviguer facilement."),
        
        (title: "Nouveauté SOS+", body: "Aidez nous à ajouter encore plus de fonctionnalité en rejoignant notre discord et prenez part activement au devellopement de l'application !"),
        
        (title: "Votre sécurité avant tout", body: "Notre mode Panique vous donne un accès rapide aux services d'urgence en affichant seulement l'essentiel !"),
        
        (title: "Restez connecté", body: "Joignez-vous à notre serveur Discord pour discuter, poser des questions et rencontrer notre équipe de soutien"),
        
        (title: "Vos retours comptent", body: "Aidez-nous à améliorer SOS+ en partageant vos retours et suggestions."),
        
        (title: "Soutenez SOS+", body: "Aimez-vous notre application ? Pensez à souscrire à un plan premium pour nous soutenir et profiter de fonctionnalités exclusives"),
        
        (title: "La langue n'est plus une barrière", body: "SOS+ est maintenant disponible en français et en anglais. Choisissez votre langue préférée dans les paramètres."),
        
        (title: "Améliorez votre expérience avec les plans SOS+", body: "Saviez-vous que SOS+ offre des plans premium ? Bénéficiez d'un accès anticipé aux nouvelles fonctionnalités , d'avantages au sein du discord et bien plus encore. Découvrez nos plans aujourd'hui !"),
        
        (title: "Nous sommes toujours là pour vous aide", body: "Avez-vous besoin d'aide ou avez-vous des questions sur l'application SOS+? N'hésitez pas à nous contacter par email ou via notre serveur Discord."),
        
        (title: "Avez-vous exploré toutes nos fonctionnalités?", body: "SOS+ est plus qu'une simple application d'urgence. Avez-vous exploré toutes nos fonctionnalités ? Des guides de survie aux numéros d'urgence locaux, nous sommes là pour vous soutenir!"),
        
        (title: "Rejoignez notre communauté!", body: "Rejoignez notre communauté de soutien. Partagez vos expériences et obtenez des conseils d'autres utilisateurs de l'application SOS+"),


            ]
            
    func scheduleNotifications() {
        let center = UNUserNotificationCenter.current()

        // Remove all pending notifications
        center.removeAllPendingNotificationRequests()

        // Get the current day
        let currentDay = Calendar.current.component(.day, from: Date())

        let content = UNMutableNotificationContent()
        content.title = notificationTemplates[currentDay % notificationTemplates.count].title
        content.body = notificationTemplates[currentDay % notificationTemplates.count].body
        content.sound = .default

        var dateComponents = DateComponents()
        dateComponents.hour = 16
        dateComponents.minute = 0

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        center.add(request)
    }
            
            func requestNotificationAuthorization(completion: @escaping (Bool) -> Void) {
                let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
                UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { (success, error) in
                    if let error = error {
                        print("Error: ", error)
                        completion(false)
                    } else {
                        completion(success)
                    }
                }
            }
        }

        struct Notifs: View {
            @AppStorage("notificationsEnabled") private var notificationsEnabled = false
            let notificationManager = NotificationManager()
            
            var body: some View {
                Toggle("Enable Notifications", isOn: $notificationsEnabled)
                    .onChange(of: notificationsEnabled) { newValue in
                        if newValue {
                            UNUserNotificationCenter.current().getNotificationSettings { settings in
                                DispatchQueue.main.async {
                                    if settings.authorizationStatus == .authorized {
                                        notificationManager.scheduleNotifications()
                                    } else if settings.authorizationStatus == .notDetermined {
                                        // It's up to you to handle this case if you want to ask permission here
                                    } else {
                                        // The user has denied notifications, handle this case as per your requirement.
                                    }
                                }
                            }
                        } else {
                            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                        }
                    }
            }
        }

struct SettingsView: View {
    @AppStorage("notificationsEnabled") private var notificationsEnabled = false
      @AppStorage("selectedLanguage") private var selectedLanguage = "English"
      @State private var isLocationEnabled = CLLocationManager.locationServicesEnabled()
      @State private var showAlert = false

      let notificationManager = NotificationManager()
    
      @EnvironmentObject var locationManager: WelcomeViewLocationManager
    
  

    @State private var showingAlert = false
    @State private var showingPrivacy = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: 20) {

                    Divider()

                    Text("Configure your SOS+ App")
                        .font(.title2)
                        .fontWeight(.bold)

                    Text("Set your preferences and learn more about our policies.")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)

                    Divider()

                            VStack {
                                HStack {
                                    Toggle(isOn: $notificationsEnabled) {
                                        HStack {
                                            Image(systemName: notificationsEnabled ? "bell.fill" : "bell.slash.fill") // Change the icon depending on the state of the toggle
                                                .font(.system(size: 23))
                                                .foregroundColor(Color.blue)
                                            Text("Notification")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                        }
                                    }
                                    .onChange(of: notificationsEnabled) { newValue in
                                        if newValue {
                                            notificationManager.requestNotificationAuthorization { authorized in
                                                if authorized {
                                                    notificationManager.scheduleNotifications()
                                                } else {
                                                    // The user has denied notifications, handle this case as per your requirement.
                                                }
                                            }
                                        } else {
                                            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                                        }
                                    }

                                    Button(action: {
                                        showingAlert = true
                                    }) {
                                        Image(systemName: "info.circle.fill")
                                            .font(.system(size: 20))
                                            .foregroundColor(Color.gray)
                                    }
                                    .alert(isPresented: $showingAlert) {
                                        Alert(title: Text("Notification activation"), message: Text("Notifications can only be activated once, due to the iOS API, so if you want to disable or reactivate them, go straight to your settings!"), dismissButton: .default(Text("Got it!")))
                                    }
                                }
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                          
                    VStack {
                        HStack {
                           
                            Image(systemName: isLocationEnabled ? "location.circle.fill" : "location.slash")
                                .font(.system(size: 23))
                                .foregroundColor(Color.blue)
                                .padding(.leading, -16)
                            Text("Localisation")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.leading, 0)
                            Spacer()                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .frame(width: 331, height: 0)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .onTapGesture {
                        showAlert = true
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Redirection vers les paramètres"),
                            message: Text("La localisation ne peut pas être désactivée ici. Veuillez aller dans les paramètres de l'appareil pour la désactiver."),
                            primaryButton: .default(Text("OK"), action: {
                                // Redirigez les utilisateurs vers les paramètres de l'appareil.
                                if let url = URL(string: UIApplication.openSettingsURLString) {
                                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                }
                            }),
                            secondaryButton: .cancel()
                        )
                    }

                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                            
                            Button(action: { showingPrivacy = true }) {
                                HStack {
                                    Image(systemName: "shield.lefthalf.fill")
                                        .font(.system(size: 23))
                                        .foregroundColor(Color.yellow)
                                    Text("SOS+ Privacy")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Spacer()
                                    Image(systemName: "arrow.right")
                                        .font(.system(size: 20))
                                        .foregroundColor(Color.gray)
                                }
                            }
                            .sheet(isPresented: $showingPrivacy) {
                                GuideView3()
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)

                      
                    
                    VStack {
                        HStack {
                            Image(systemName: "sos.circle")
                                .font(.system(size: 23))
                                .foregroundColor(.red)
                            Text("Version")
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                            Text("1.10 Beta")
                                .foregroundColor(.gray)
                           
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
         
                        
                            VStack {
                                Text("Contact Us")
                                    .font(.headline)
                                    .foregroundColor(.white)

                                Text("If you need help with the SOS+ app or have any questions, please contact us at Mail or join our Discord server.")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)

                                HStack {
                                    Button(action: {
                                        let url = URL(string: "mailto:sos+contact@gmail.com")!
                                        if UIApplication.shared.canOpenURL(url) {
                                            UIApplication.shared.open(url)
                                        }
                                    }) {
                                        Text("Email")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(Color.green)
                                            .cornerRadius(10)
                                    }

                                    Button(action: {
                                        let url = URL(string: "https://discord.gg/gREU27DBHb")!
                                        if UIApplication.shared.canOpenURL(url) {
                                            UIApplication.shared.open(url)
                                        }
                                    }) {
                                        Text("Discord")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                            .frame(maxWidth: .infinity)
                                            .padding()
                                            .background(Color.blue)
                                            .cornerRadius(10)
                                    }
                                }
                                
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        }
                        .padding()
                    }
                    .navigationTitle("Settings and support")
                    .background(Color(.systemGroupedBackground))
                    .edgesIgnoringSafeArea(.bottom)
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
    
    

            func requestNotificationAuthorization() {
                let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
                UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { (success, error) in
                    if let error = error {
                        print("Error: ", error)
                    }
                }
            }
        }

        struct SettingsView_Previews: PreviewProvider {
            static var previews: some View {
                SettingsView()
            }
        }
