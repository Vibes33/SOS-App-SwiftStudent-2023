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
    @State private var consciousness = "Aware"
    @State private var newLesion = ""
    @State private var newDeformedLimb = ""
    @State private var lesions: [String] = []
    @State private var deformedLimbs: [String] = []
    @State private var accidentType = "Car accident"
    @State private var accidentDetails = ""
    @State private var country = "France"
    @State private var isBleeding = "No"
    @State private var isPresentingMessageComposeView = false
    @State private var selectedLesion = "neck"
    @State private var selectedDeformedLimb = "neck"

    let sexes = ["Man", "Women"]
    let bloodGroups = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-", "Unknown"]
    let consciousnessStates = ["Aware", "Unconscious"]
    let accidentTypes = ["Car accident", "Fall", "Malaise", "..."]
    let limbs = ["Right arm", "Left arm", "Right leg", "Left leg", "chest"]
    let bleedingOptions = ["Yes", "No"]
    let countries = ["France", "USA", "Australia"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personnal information")) {
                    TextField("Name", text: $firstName)
                    TextField("Surname", text: $lastName)
                    TextField("Age", text: $age)
                        .keyboardType(.numberPad)
                    Picker("Sex", selection: $sex) {
                        ForEach(sexes, id: \.self) { sex in
                            Text(sex)
                        }
                    }
                    Picker("Blood Group", selection: $bloodGroup) {
                        ForEach(bloodGroups, id: \.self) { group in
                            Text(group)
                        }
                    }
                }

                Section(header: Text("Medic information")) {
                    
                    Picker("Bleeding", selection: $isBleeding) {
                                          ForEach(bleedingOptions, id: \.self) { option in
                                              Text(option)
                                          }
                                      }
                                  

                    Picker("State", selection: $consciousness) {
                        ForEach(consciousnessStates, id: \.self) { state in
                            Text(state)
                        }
                    }
                    
                    HStack {
                        TextField("Add a lesion", text: $newLesion)
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
                        TextField("Add a deformed limb", text: $newDeformedLimb)
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
                
         

                Section(header: Text("Accident Details")) {
                    Picker("Kind of accident", selection: $accidentType) {
                        ForEach(accidentTypes, id: \.self) { type in
                            Text(type)
                        }
                    }
                    TextField("Accident details", text: $accidentDetails)
                }
                
                Section(header: Text("Pays")) {
                    Picker("Select a country", selection: $country) {
                        ForEach(countries, id: \.self) { country in
                            Text(country)
                        }
                    }
                }

                Button(action: {
                    self.isPresentingMessageComposeView = true
                }) {
                    Text("Send")
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



#Preview {
    DiagnosticView()
}
