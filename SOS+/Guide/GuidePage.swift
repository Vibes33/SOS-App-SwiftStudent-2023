import SwiftUI

struct GuideView: View {
    @State private var showTutorial = false

    var body: some View {
        NavigationView {
            ScrollView {
                
                
                VStack {
                    
                Text("Bienvenue dans le guide de SOS+")
                                                .font(.title3)
                                                .fontWeight(.semibold)
                                                .multilineTextAlignment(.center)
                                                .padding(.top)

        Text("La première application pour votre sécurité")
                                                .font(.subheadline)
                                                .multilineTextAlignment(.center)
Spacer(minLength: 30)
                                                
                    GuidePage2()
                   
                }
                .padding()
                .background(Color(.systemGroupedBackground))
                .edgesIgnoringSafeArea(.bottom)
            }
            .navigationTitle("Guide")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct GuideView_Previews: PreviewProvider {
    static var previews: some View {
        GuideView()
    }
}
