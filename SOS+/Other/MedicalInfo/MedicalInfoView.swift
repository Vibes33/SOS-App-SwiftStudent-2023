import SwiftUI
import Security

class MedicalInfoViewModel: ObservableObject {
    @Published var height: String = ""
    @Published var weight: String = ""
    
    var imc: Double {
        if let heightValue = Double(height), let weightValue = Double(weight), heightValue > 0 {
            let heightInMeters = heightValue / 100
            return weightValue / (heightInMeters * heightInMeters)
        } else {
            return 0.0
        }
    }
}

struct MedicalInfoView: View {
    @StateObject private var viewModel = MedicalInfoViewModel()
    @State private var name = ""
    @State private var surname = ""
    @State private var bloodGroup = ""
    @State private var specificPathologies = ""
    @State private var advancedDirectives = ""
    @State private var currentMedications: [String] = []
    @State private var newMedication = ""
    @State private var showDossierView = false
    @State private var showContactView = false
    @State private var age = ""
    @State private var sex = ""

    let bloodGroups = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"]
    let sexes = ["Male", "Female"]

    @AppStorage("SavedMedicalInfo") var savedMedicalInfo: Data = Data()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Information")) {
                    TextField("Name", text: $name)
                    TextField("Surname", text: $surname)
                    TextField("Age", text: $age)
                        .keyboardType(.numberPad)
                    HStack {
                        VStack {
                            TextField("Height (cm)", text: $viewModel.height)
                                .keyboardType(.numberPad)
                            TextField("Weight (kg)", text: $viewModel.weight)
                                .keyboardType(.numberPad)
                        }
                        Text(String(format: "BMI: %.2f", viewModel.imc))
                            .foregroundColor(viewModel.imc > 0 ? .green : .clear)
                    }
                    Picker("Sex", selection: $sex) {
                        ForEach(sexes, id: \.self) { sex in
                            Text(sex)
                        }
                    }
                    Button(action: { showContactView = true }) {
                        Text("Contacts")
                            .foregroundColor(Color.green)
                            .accessibilityLabel("Contacts button")
                    }
                    .sheet(isPresented: $showContactView) {
                        EmergencyContactsViewController()
                    }
                }

                Section(header: Text("Medical Information")) {
                    Picker("Blood Group", selection: $bloodGroup) {
                        ForEach(bloodGroups, id: \.self) { group in
                            Text(group)
                        }
                    }.accessibilityLabel("Blood Group Picker")
                    TextField("Specific Pathologies", text: $specificPathologies)
                    TextField("Advanced Directives", text: $advancedDirectives)
                    Button(action: { showDossierView = true }) {
                        Text("Dossier")
                            .foregroundColor(Color.green)
                            .accessibilityLabel("Dossier button")
                    }
                    .sheet(isPresented: $showDossierView) {
                        DossierView()
                    }
                }

                Section(header: Text("Current Medications")) {
                    HStack {
                        TextField("Add a medication", text: $newMedication)
                        Button(action: {
                            if !newMedication.isEmpty {
                                currentMedications.append(newMedication)
                                newMedication = ""
                            }
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                                .accessibilityLabel("Add a new medication button")
                        }
                    }

                    ForEach(currentMedications.indices, id: \.self) { index in
                        Text(currentMedications[index])
                            .accessibilityLabel("Medication \(currentMedications[index])")
                    }.onDelete(perform: deleteMedication)
                }

                Button(action: {
                    do {
                        let medicalInfo = MedicalInfo(name: name, surname: surname, bloodGroup: bloodGroup, specificPathologies: specificPathologies, advancedDirectives: advancedDirectives, currentMedications: currentMedications, age: age, height: viewModel.height, weight: viewModel.weight, sex: sex)
                        let encoder = JSONEncoder()
                        let encoded = try encoder.encode(medicalInfo)
                        savedMedicalInfo = encoded
                    } catch {
                        print("Erreur lors de l'encodage des informations médicales: \(error)")
                    }
                }) {
                    Text("Save")
                        .foregroundColor(Color.green)
                        .accessibilityLabel("Save button")
                }
            }
            .navigationTitle("Medical File")
            .onAppear(perform: loadData)
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    func loadData() {
        let decoder = JSONDecoder()
        do {
            let loadedMedicalInfo = try decoder.decode(MedicalInfo.self, from: savedMedicalInfo)
            self.name = loadedMedicalInfo.name
            self.surname = loadedMedicalInfo.surname
            self.bloodGroup = loadedMedicalInfo.bloodGroup
            self.specificPathologies = loadedMedicalInfo.specificPathologies
            self.advancedDirectives = loadedMedicalInfo.advancedDirectives
            self.currentMedications = loadedMedicalInfo.currentMedications
            self.age = loadedMedicalInfo.age
            self.viewModel.height = loadedMedicalInfo.height
            self.viewModel.weight = loadedMedicalInfo.weight
            self.sex = loadedMedicalInfo.sex
        } catch {
            print("Erreur lors du décodage des informations médicales: \(error)")
        }
    }

    func deleteMedication(at offsets: IndexSet) {
        currentMedications.remove(atOffsets: offsets)
    }

    struct MedicalInfo: Codable {
        let name: String
        let surname: String
        let bloodGroup: String
        let specificPathologies: String
        let advancedDirectives: String
        let currentMedications: [String]
        let age: String
        let height: String
        let weight: String
        let sex: String
    }
}

struct MedicalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MedicalInfoView()
    }
}
