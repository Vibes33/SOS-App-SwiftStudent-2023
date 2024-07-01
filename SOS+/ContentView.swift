import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
   
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.black.opacity(0.4))
                        .frame(height: 60)
                        .edgesIgnoringSafeArea(.top)
                    
                    TabView {
                        
                        // HomePage
                        WelcomeView()                            .tabItem {
                                Label("Home", systemImage: "house")
                            }

                        // CallPage
                        EmergencyServicesView()
                            .tabItem {
                                Label("Emergency call", systemImage: "phone")
                            }
                        
                        // A view for introduce a guide about application
                        GuideView()
                            .tabItem {
                                Label("Guide", systemImage: "book.circle")
                            }

                        // A Final Page
                        FinalPage()
                            .tabItem {
                                Label("Other", systemImage: "ellipsis.circle.fill")
                            }
                        
                    }
                    .accentColor(.primary)
                }
            }
            
            }
        }
    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

