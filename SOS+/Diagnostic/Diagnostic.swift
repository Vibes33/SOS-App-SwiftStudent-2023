//
//  Diagnostic.swift
//  SOS+
//
//  Created by Ryan Delépine on 14/03/2024.
//

import SwiftUI
import MessageUI
import CoreLocation

struct DiagnosticView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var age = ""
    @State private var sex = ""
    @State private var bloodGroup = ""
    @State private var consciousness = "Conscient"
    @State private var newLesion = ""
    @State private var newDeformedLimb = ""
    @State private var lesions: [String] = []
    @State private var deformedLimbs: [String] = []
    @State private var accidentType = "Voiture"
    @State private var accidentDetails = ""
    @State private var country = "France"
    @State private var isBleeding = "Non"
    @State private var isPresentingMessageComposeView = false
    @State private var selectedLesion = "Cou"
    @State private var selectedDeformedLimb = "Cou"

    let sexes = ["Homme", "Femme"]
    let bloodGroups = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-", "Non renseigné"]
    let consciousnessStates = ["Conscient", "Inconscient"]
    let accidentTypes = ["Voiture", "Chute", "Malaise", "..."]
    let limbs = ["Bras droit", "Bras gauche", "Jambe droite", "Jambe gauche"]
    let bleedingOptions = ["Oui", "Non"]
    let countries = ["France", "USA", "Australie"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informations personnelles")) {
                    TextField("Prénom", text: $firstName)
                    TextField("Nom", text: $lastName)
                    TextField("Age", text: $age)
                        .keyboardType(.numberPad)
                    Picker("Sexe", selection: $sex) {
                        ForEach(sexes, id: \.self) { sex in
                            Text(sex)
                        }
                    }
                    Picker("Groupe sanguin", selection: $bloodGroup) {
                        ForEach(bloodGroups, id: \.self) { group in
                            Text(group)
                        }
                    }
                }

                Section(header: Text("Informations médicales")) {
                    
                    Picker("Saignements", selection: $isBleeding) {
                                          ForEach(bleedingOptions, id: \.self) { option in
                                              Text(option)
                                          }
                                      }
                                  

                    Picker("État", selection: $consciousness) {
                        ForEach(consciousnessStates, id: \.self) { state in
                            Text(state)
                        }
                    }
                    
                    HStack {
                        TextField("Ajouter une lésion", text: $newLesion)
                        Button(action: {
                            if !newLesion.isEmpty {
                                lesions.append(newLesion)
                                newLesion = ""
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                    ForEach(lesions.indices, id: \.self) { index in
                        Text(lesions[index])
                    }.onDelete(perform: deleteLesion)
                    
                    HStack {
                        TextField("Ajouter un membre déformé", text: $newDeformedLimb)
                        Button(action: {
                            if !newDeformedLimb.isEmpty {
                                deformedLimbs.append(newDeformedLimb)
                                newDeformedLimb = ""
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                    ForEach(deformedLimbs.indices, id: \.self) { index in
                        Text(deformedLimbs[index])
                    }.onDelete(perform: deleteDeformedLimb)
                     
                }
                
         

                Section(header: Text("Détails de l'accident")) {
                    Picker("Type d'accident", selection: $accidentType) {
                        ForEach(accidentTypes, id: \.self) { type in
                            Text(type)
                        }
                    }
                    TextField("Détails de l'accident", text: $accidentDetails)
                }
                
                Section(header: Text("Pays")) {
                    Picker("Sélectionnez le pays", selection: $country) {
                        ForEach(countries, id: \.self) { country in
                            Text(country)
                        }
                    }
                }

                Button(action: {
                    self.isPresentingMessageComposeView = true
                }) {
                    Text("Envoyer aux autorités")
                        .foregroundColor(Color.green)
                        .accessibilityLabel("Envoyer aux autorités")
                }
                .sheet(isPresented: $isPresentingMessageComposeView) {
                    MessageView(isPresentingMessageComposeView: self.$isPresentingMessageComposeView, firstName: self.firstName, lastName: self.lastName, sex: self.sex, consciousness: self.consciousness, accidentType: self.accidentType, accidentDetails: self.accidentDetails, lesions: self.lesions, deformedLimbs: self.deformedLimbs, isBleeding: self.isBleeding, country: self.country)

                }
            }
            .navigationTitle("Diagnostic")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    func deleteLesion(at offsets: IndexSet) {
        lesions.remove(atOffsets: offsets)
    }

    func deleteDeformedLimb(at offsets: IndexSet) {
        deformedLimbs.remove(atOffsets: offsets)
    }
}


#Preview {
    DiagnosticView()
}
