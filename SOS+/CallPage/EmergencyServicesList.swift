//
//  EmergencyServicesList.swift
//  SOS+
//
//  Created by Ryan Delépine on 01/11/2023.
//

import SwiftUI

struct EmergencyServicesList: View {
    let emergencyServices = [
        ("Fire Department", "flame.fill", Color.orange),
        ("Emergency", "cross.vial.fill", Color.gray),
        ("Police", "list.clipboard.fill", Color.blue),
        ("Deaf And Hard Of Hearing ", "exclamationmark.bubble.fill", Color.purple),
        ("Sea Rescue", "sailboat.fill", Color.cyan)
    ]

    @State private var showEmergencyCountryView = false
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
                    Section(header: Text("Information about emergency services")) {
                        ForEach(emergencyServices, id: \.0) { service, imageName, color in
                            NavigationLink(destination: destination(for: service)) {
                                HStack {
                                    Image(systemName: imageName)
                                        .font(.system(size: 23))
                                        .foregroundColor(color)
                                    Text(service)
                                }
                            }
                        }
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
        .fullScreenCover(isPresented: $showPanicModeView) {
            PanicModeView(showPanicModeView: $showPanicModeView)
        }
    }

    private func destination(for service: String) -> some View {
        if service == "Sea Rescue" {
            return AnyView(CustomView())
        } else if service == "Fire Department" {
            return AnyView(FireView())
        } else if service == "Emergency" {
            return AnyView(HospitalView())
        } else if service == "Police" {
            return AnyView(PoliceView())
        } else if service == "Deaf And Hard Of Hearing " {
            return AnyView(DeafHOEView())
        } else {
            return AnyView(Text("Contenu de \(service)"))
        }
    }
}
#Preview {
    EmergencyServicesList()
}
