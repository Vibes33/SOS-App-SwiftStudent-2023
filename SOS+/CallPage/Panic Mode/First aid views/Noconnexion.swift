import SwiftUI
import UIKit

struct NoConnectionView: View {
    @State private var titleText1: String = "Emergency Call"
    @State private var subtitleText1: String = "you can make an emergency call by holding down the start and top volume buttons at the same time "
    @State private var titleText2: String = "Satelite Mode"
    @State private var subtitleText2: String = "Make a real call to the emergency services , after that you will see a Satelite icon , click on , you will be redirected on the Stellite iPhone mode . This mode was available only on iPhone 14 and 15 "
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            
          
            
            // Image en haut
            Image("Noconnexion")
                .resizable()
                .scaledToFit()
               
            
            // Première zone de texte
            HStack {
                VStack(alignment: .leading) {
                    Text(titleText1)
                        .font(.headline)
                    Text(subtitleText1)
                        .opacity(0.7)
                }
                Spacer()
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            
            // Deuxième zone de texte
            HStack {
                VStack(alignment: .leading) {
                    Text(titleText2)
                        .font(.headline)
                    Text(subtitleText2)
                        .opacity(0.7)
                }
                Spacer()
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            
           
            
            // Bouton pour ouvrir les paramètres généraux
            Button(action: openSettings) {
                Text("Open settings")
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, content: {
                Text("if you click on 'open settings' , you will be redirected in the app settings , for find the settings home page , click on back button")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                
            })
            
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .foregroundColor(.white)
        .navigationTitle("Satelite mode")
        
    }
    
    
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

struct NoConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        NoConnectionView()
    }
}
