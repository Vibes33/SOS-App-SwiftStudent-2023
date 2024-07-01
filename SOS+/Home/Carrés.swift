import SwiftUI

enum FeatureViewType {
    case countryViewQuestion, firstAidView, medicalInfoView, contactsView, communityView, panicModeView
}

struct Feature: Identifiable {
    var id = UUID()
    let name: String
    let image: String
    let color: Color
    let viewType: FeatureViewType
}

struct Raccourcis: View {
    @State private var currentFeatures = [
        Feature(name: "Emergency Call", image: "phone.fill", color: .red, viewType: .countryViewQuestion),
        Feature(name: "First Aid Guide", image: "book.fill", color: .blue, viewType: .firstAidView),
        Feature(name: "Medical Info", image: "info.circle.fill", color: .green, viewType: .medicalInfoView),
        Feature(name: "Panic Mode", image: "exclamationmark.triangle.fill", color: .yellow, viewType: .panicModeView),
        Feature(name: "Diagnostic", image: "doc.text.below.ecg.fill", color: .orange, viewType: .contactsView),
        Feature(name: "Settings", image: "gearshape", color: .purple, viewType: .communityView)
    ]
    @State private var showPanicModeView = false
    @State private var selectedFeatureId: UUID?
    @State private var lastSelectedFeatureId: UUID?

    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            VStack(spacing: 30) {
                ForEach(Array(currentFeatures.enumerated()), id: \.element.id) { index, _ in
                    if index % 3 == 0 {
                        HStack (spacing: 40) {
                            FeatureButton(feature: currentFeatures[index], selectedFeatureId: $selectedFeatureId, lastSelectedFeatureId: $lastSelectedFeatureId, onPanicButtonTapped: {
                                showPanicModeView = true
                            })
                            if index + 1 < currentFeatures.count {
                                FeatureButton(feature: currentFeatures[index + 1], selectedFeatureId: $selectedFeatureId, lastSelectedFeatureId: $lastSelectedFeatureId, onPanicButtonTapped: {
                                    showPanicModeView = true
                                })
                            }
                            if index + 2 < currentFeatures.count {
                                FeatureButton(feature: currentFeatures[index + 2], selectedFeatureId: $selectedFeatureId, lastSelectedFeatureId: $lastSelectedFeatureId, onPanicButtonTapped: {
                                    showPanicModeView = true
                                })
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .fullScreenCover(isPresented: $showPanicModeView) {
            PanicModeView(showPanicModeView: $showPanicModeView)
        }
    }
}

struct FeatureButton: View {
    let feature: Feature
    @Binding var selectedFeatureId: UUID?
    @Binding var lastSelectedFeatureId: UUID?
    @State private var showContent = false
    let onPanicButtonTapped: () -> Void

    var body: some View {
        VStack {
            Button(action: {
                if lastSelectedFeatureId == feature.id {
                    if feature.viewType == .panicModeView {
                        onPanicButtonTapped()
                    } else {
                        showContent = true
                    }
                } else {
                    lastSelectedFeatureId = feature.id
                }
                selectedFeatureId = feature.id
            }) {
                VStack {
                    Image(systemName: feature.image)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(selectedFeatureId == feature.id ? feature.color : Color.gray) // Condition pour afficher la couleur
                }
                .frame(width: 100, height: 100)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10) // Ajout d'une bordure
                        .stroke(selectedFeatureId == feature.id ? Color.green : Color.clear, lineWidth: 2) // Bordure verte si sélectionné
                )
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5) // Ajout d'une ombre
            }
            .sheet(isPresented: $showContent) {
                switch feature.viewType {
                case .countryViewQuestion:
                    CountryViewQuestion()
                case .firstAidView:
                    FirstAidGuideView()
                case .medicalInfoView:
                    MedicalInfoView()
                case .contactsView:
                    DiagnosticView()
                case .communityView:
                    SettingsView()
                default:
                    EmptyView()
                }
            }

            Text(feature.name)
                .font(.caption)
                .padding(.top, 5)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Raccourcis()
    }
}
