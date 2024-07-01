import SwiftUI
import ContactsUI
import Contacts

struct AddContactView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedFlag = "🇫🇷"
    @State private var selectedCountryCode = "+33"
    @State private var name = ""
    @State private var phoneNumber = ""
    @State private var showContactPicker = false
    
    var completionHandler: (String, String, String, String) -> Void
    
    func openContactPicker() {
        showContactPicker.toggle()
    }

    func contactPicked(contact: CNContact) {
        if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
            self.phoneNumber = removeCountryCode(from: phoneNumber)
        }
        self.name = "\(contact.givenName) \(contact.familyName)"
    }
    
    func saveContact() {
        completionHandler(selectedFlag, selectedCountryCode, name, phoneNumber)
        
        let newContact = EmergencyContact(flag: selectedFlag, countryCode: selectedCountryCode, name: name, phoneNumber: phoneNumber)
        var updatedContacts: [EmergencyContact] = [newContact]
        
        if let existingContactsData = UserDefaults.standard.data(forKey: "emergencyContacts") {
            let decoder = JSONDecoder()
            if let existingContacts = try? decoder.decode([EmergencyContact].self, from: existingContactsData) {
                updatedContacts = existingContacts + [newContact]
            }
        }
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(updatedContacts) {
            UserDefaults.standard.set(encoded, forKey: "emergencyContacts")
        }
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Country", selection: $selectedFlag) {
                        Text("🇫🇷").tag("🇫🇷")
                        Text("🇺🇸").tag("🇺🇸")
                        Text("🇬🇧").tag("🇬🇧")
                        Text("🇦🇺").tag("🇦🇺")
                    }
                    .onChange(of: selectedFlag, perform: { value in
                        updateCountryCode(for: value)
                    })
                }
                
                Section(header: Text("Contact Info")) {
                    TextField("Name", text: $name)
                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.numberPad)
                   
                    Button("Import Contact") {
                        openContactPicker()
                    }
                    .foregroundColor(.green) // Couleur du bouton "Import Contact"
                    .sheet(isPresented: $showContactPicker) {
                        CNContactPickerViewControllerRepresentable(completionHandler: contactPicked)
                    }
                }
            }
            .navigationBarTitle("Add Contact", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            }
            .foregroundColor(.white), // Couleur du bouton "Cancel"
            trailing: Button("Save") {
                saveContact()
                presentationMode.wrappedValue.dismiss()
            }
            .foregroundColor(.white)) // Couleur du bouton "Save"
        }
    }
    
    func updateCountryCode(for flag: String) {
        switch flag {
        case "🇫🇷":
            selectedCountryCode = "+33"
        case "🇺🇸":
            selectedCountryCode = "+1"
        case "🇬🇧":
            selectedCountryCode = "+44"
        case "🇦🇺":
            selectedCountryCode = "+61"
        default:
            selectedCountryCode = ""
        }
    }

    func removeCountryCode(from number: String) -> String {
        let digits = number.filter("0123456789".contains)
        if digits.hasPrefix("33") {
            return String(digits.dropFirst(2))
        } else if digits.hasPrefix("1") {
            return String(digits.dropFirst(1))
        } else if digits.hasPrefix("44") {
            return String(digits.dropFirst(2))
        } else if digits.hasPrefix("61") {
            return String(digits.dropFirst(2))
        }
        return digits
    }
}

struct CNContactPickerViewControllerRepresentable: UIViewControllerRepresentable {
    let completionHandler: (CNContact) -> Void
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(completionHandler: completionHandler)
    }
    
    func makeUIViewController(context: Context) -> CNContactPickerViewController {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = context.coordinator
        return contactPicker
    }
    
    func updateUIViewController(_ uiViewController: CNContactPickerViewController, context: Context) {
    }
    
    class Coordinator: NSObject, CNContactPickerDelegate {
        let completionHandler: (CNContact) -> Void
        
        init(completionHandler: @escaping (CNContact) -> Void) {
            self.completionHandler = completionHandler
        }
        
        func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            completionHandler(contact)
        }
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView(completionHandler: { _, _, _, _ in })
    }
}
