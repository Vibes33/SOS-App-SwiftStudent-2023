import SwiftUI

struct EmergencyContact: Identifiable, Codable {
    var id = UUID()
    var flag: String // Vous pourriez vouloir renommer cette propriété puisqu'elle ne contient plus un drapeau
    var countryCode: String
    var name: String
    var phoneNumber: String
}

struct EmergencyContactsViewController: View {
    @State private var emergencyContacts: [EmergencyContact] = []
    @State private var showAddContactSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(emergencyContacts) { contact in
                                          Button(action: {
                                              // Inclure l'indicatif téléphonique dans l'URL
                                              let fullPhoneNumber = contact.countryCode + contact.phoneNumber
                                              if let phoneNumberURL = URL(string: "tel://\(fullPhoneNumber)") {
                                                  UIApplication.shared.open(phoneNumberURL)
                                              }
                        }) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(contact.name)
                                        .font(.headline)

                                    Text(contact.countryCode + " " + contact.phoneNumber)
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                }

                                Spacer()

                                Image(systemName: "person")
                                    .foregroundColor(.green)
                                    .imageScale(.large) // Ajustez la taille de l'icône
                            }
                            .padding(.vertical, 3) // Réduire la hauteur du rectangle
                            .padding(.horizontal)
                            .background(Color(.systemGray6))
                            .cornerRadius(15)
                        }
                    }
                    .onDelete(perform: deleteContact)
                }

                VStack(spacing: 10) {
                    Button(action: {
                        showAddContactSheet.toggle()
                    }) {
                        HStack {
                            Spacer()
                            Text("Create a new contact")
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                            Image(systemName: "iphone") // Remplacez par l'icône de votre choix
                                .foregroundColor(.green)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(15)
                    }
                    .sheet(isPresented: $showAddContactSheet) {
                        AddContactView { flag, countryCode, name, phoneNumber in
                            let newContact = EmergencyContact(flag: flag, countryCode: countryCode, name: name, phoneNumber: phoneNumber)
                            emergencyContacts.append(newContact)
                            let encoder = JSONEncoder()
                            if let encoded = try? encoder.encode(emergencyContacts) {
                                UserDefaults.standard.set(encoded, forKey: "emergencyContacts")
                            }
                            showAddContactSheet = false
                        }
                    }

                    SyncView()
                }
                .padding()
            }
            .navigationTitle("Emergency Contacts")
            .navigationBarItems(trailing: EditButton().tint(Color.white))
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.black) // Fond en noir
        }
        .onAppear {
            if let contactsData = UserDefaults.standard.data(forKey: "emergencyContacts") {
                let decoder = JSONDecoder()
                if let contacts = try? decoder.decode([EmergencyContact].self, from: contactsData) {
                    self.emergencyContacts = contacts
                }
            }
        }
    }
    
    func deleteContact(at offsets: IndexSet) {
        emergencyContacts.remove(atOffsets: offsets)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(emergencyContacts) {
            UserDefaults.standard.set(encoded, forKey: "emergencyContacts")
        }
    }
}

struct EmergencyContactsViewController_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyContactsViewController()
    }
}
