import SwiftUI

struct EmergencyServicesView: View {
    
    @State private var showEmergencyCountryView = false
    @State private var showEmergencyListView = false
    @State private var permanentNotificationEnabled = false
    @State private var showPermanentNotificationInfo = false
    @State private var showPanicModeView = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("Emergency Services")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                }
                
                Divider()
                
                List {
                    Section(header: Text("Emergency Questionnaire")) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Emergency Number")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text("Don't know which department to call? Don't panic, our questionnaire is designed to help you find your way!")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Button(action: {
                            showEmergencyCountryView = true
                        }) {
                            HStack {
                            }
                        }
                    }
                    }
                    .padding(.horizontal)
                    
                    Section(header: Text("Emergency list")) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Emergency Finder")
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            Text("Choose an appropriate emergency service , you can find this service on apple maps or simply call her")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            Button(action: {
                                showEmergencyListView = true
                            }) {
                                HStack {
                                }
                            }
                        }
                        .padding(.horizontal)
                        
                    }
                        
                   
                    Section(header: Text("Panic mode")) {
                        HStack {
                            Toggle(isOn: $showPanicModeView) {
                                Text("Activate Panic Mode")
                            }
                            .toggleStyle(SwitchToggleStyle(tint: .red))
                            
                            Button(action: {
                                showPermanentNotificationInfo = true
                            }) {
                                Image(systemName: "questionmark.circle")
                                    .font(.title3)
                                    .foregroundColor(.blue)
                            }
                            .padding(.leading)
                            .alert(isPresented: $showPermanentNotificationInfo) {
                                Alert(title: Text("What is Panic Mode"), message: Text("Activating this option enables you to set the application to panic mode, giving you larger buttons with the application's basic functions, allowing you to display only the information you need in an emergency. "), dismissButton: .default(Text("OK")))
                            }
                        }
                        .padding(.vertical)
                    }
                    
                }
                .listStyle(InsetGroupedListStyle())
            }
            .background(Color(.systemGroupedBackground))
            .edgesIgnoringSafeArea(.bottom)
        }
        .sheet(isPresented: $showEmergencyCountryView) {
            CountryViewQuestion()

        }
        .sheet(isPresented: $showEmergencyListView) {
            EmergencyServicesList()
        }
        .fullScreenCover(isPresented: $showPanicModeView) {
            PanicModeView(showPanicModeView: $showPanicModeView)
        }
        
    }
        
    
    
    struct EmergencyServicesView_Previews: PreviewProvider {
        static var previews: some View {
            EmergencyServicesView()
        }
    }
}

