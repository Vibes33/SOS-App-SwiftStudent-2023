import SwiftUI

enum RectangleType: String, CaseIterable, Identifiable, Codable {
    case firstAid = "First Aid"
    case call = "Call"
    case contacts = "Contacts"
    case medicalFile = "Medical File"
    case community = "Community"

    var id: String { self.rawValue }
}

struct Testing_View_1: View {
    @State private var selectedRectangles: [RectangleType] = []
    @State private var deletedRectangles: [RectangleType] = []
    @State private var isAddRectangleSheetPresented = false
    @State private var sheetItem: RectangleType?
    @State private var deleteConfirmationType: RectangleType?

    var availableRectangles: [RectangleType] {
        return RectangleType.allCases.filter { !selectedRectangles.contains($0) }
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16)  {
                ForEach(selectedRectangles, id: \.self) { type in
                    RectangleView(rectangle: RectangleData(title: type.rawValue, subTitle: "Click here for see the affiliate view"), onTap: {
                        // Afficher la vue en feuille lorsque l'utilisateur clique dessus
                        sheetItem = type
                    }, onLongPress: {
                        // Afficher la confirmation de suppression lors d'une longue pression
                        deleteConfirmationType = type
                    })
                    .onLongPressGesture {
                        // Afficher la confirmation de suppression lors d'une longue pression
                        deleteConfirmationType = type
                    }
                    .contextMenu {
                        Button(action: {
                            // Afficher la confirmation de suppression
                            deleteConfirmationType = type
                        }) {
                            Text("Delete")
                            Image(systemName: "trash")
                        }
                    }
                }

                Button(action: {
                    isAddRectangleSheetPresented = true
                }) {
                    VStack {
                        ZStack {
                            VStack(alignment: .leading, spacing: 5)  {
                                Text("Ajouter un raccourcis")
                                    .font(Font.custom("SF Pro Text", size: 15))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                            }
                            .padding(16)
                            .frame(width: 375, alignment: .topLeading)
                            .background(Color(red: 0.17, green: 0.17, blue: 0.18))
                            .cornerRadius(13)

                           
                        }
                    }
                }
            }
            .actionSheet(item: $deleteConfirmationType) { type in
                ActionSheet(
                    title: Text("Delete Rectangle"),
                    message: Text("Are you sure you want to delete this rectangle?"),
                    buttons: [
                        .destructive(Text("Delete"), action: {
                            // Supprimer le rectangle sélectionné
                            if let index = selectedRectangles.firstIndex(of: type) {
                                selectedRectangles.remove(at: index)
                                deletedRectangles.append(type)
                                deleteConfirmationType = nil // Réinitialiser la confirmation de suppression
                                saveSelectedRectangles() // Sauvegarder les modifications
                            }
                        }),
                        .cancel(Text("Cancel"))
                    ]
                )
            }
            .sheet(item: $sheetItem) { type in
                // Afficher la vue en feuille selon le type sélectionné
                switch type {
                case .firstAid:
                    FirstAidView()
                case .call:
                    CountryViewQuestion()
                case .contacts:
                    EmergencyContactsViewController()
                case .medicalFile:
                    MedicalInfoView()
                case .community:
                    CommunityView()
                }
            }
        }
        .navigationBarTitle("  ", displayMode: .inline)
        .sheet(isPresented: $isAddRectangleSheetPresented) {
            RectangleTypeSelectionView(availableRectangles: availableRectangles, addRectangle: addRectangle)
        }
        .onAppear {
            loadSelectedRectangles() // Charger les données sauvegardées au démarrage
        }
    }

    private func addRectangle(type: RectangleType) {
        // Vérifier d'abord si le rectangle était dans les supprimés
        if let index = deletedRectangles.firstIndex(of: type) {
            deletedRectangles.remove(at: index)
        }
        // Ajouter le rectangle aux sélectionnés
        selectedRectangles.append(type)
        isAddRectangleSheetPresented = false
        saveSelectedRectangles() // Sauvegarder les modifications
    }

    // Sauvegarder les rectangles sélectionnés dans UserDefaults
    private func saveSelectedRectangles() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(selectedRectangles) {
            UserDefaults.standard.set(encoded, forKey: "selectedRectangles")
        }
    }

    // Charger les rectangles sélectionnés depuis UserDefaults
    private func loadSelectedRectangles() {
        if let data = UserDefaults.standard.data(forKey: "selectedRectangles") {
            let decoder = JSONDecoder()
            if let rectangles = try? decoder.decode([RectangleType].self, from: data) {
                selectedRectangles = rectangles
            }
        }
    }
}

struct RectangleData: Identifiable {
    let id = UUID()
    let title: String
    let subTitle: String
}

struct RectangleView: View {
    var rectangle: RectangleData
    var onTap: () -> Void
    var onLongPress: () -> Void

    var body: some View {
        VStack {
            ZStack {
                VStack(alignment: .leading, spacing: 5)  {
                    Text(rectangle.title)
                        .font(Font.custom("SF Pro Text", size: 15))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)

                    Text(rectangle.subTitle)
                        .font(Font.custom("SF Pro Text", size: 13))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.92, green: 0.92, blue: 0.96).opacity(0.6))
                }
                .padding(16)
                .frame(width: 375, alignment: .topLeading)
                .background(Color(red: 0.17, green: 0.17, blue: 0.18))
                .cornerRadius(13)

                
            }
        }
        .onTapGesture {
            onTap()
        }
        .onLongPressGesture {
            onLongPress()
        }
    }
}

struct RectangleTypeSelectionView: View {
    var availableRectangles: [RectangleType] // Tableau des rectangles disponibles
    var addRectangle: (RectangleType) -> Void

    var body: some View {
        NavigationView {
            List(availableRectangles, id: \.self) { type in
                Text(type.rawValue)
                    .onTapGesture {
                        // Ajouter le rectangle sélectionné
                        addRectangle(type)
                    }
            }
            .navigationBarTitle("Select Rectangle Type", displayMode: .inline)
        }
    }
}

struct Testing_View_1_Previews: PreviewProvider {
    static var previews: some View {
        Testing_View_1()
    }
}
