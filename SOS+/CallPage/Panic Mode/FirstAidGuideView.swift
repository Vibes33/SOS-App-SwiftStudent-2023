import SwiftUI

struct FirstAidGuideView: View {
    @State private var currentStep: Int = 0
    @State private var selectedStep: StepToShow?  // État pour stocker l'étape sélectionnée pour afficher la vue.

    let steps: [Step] = [
        Step(title: "Securing", icon: Image(systemName: "person.crop.circle.dashed.circle"), subtitle: "Securing the place and the people"),
        Step(title: "Assessment", icon: Image(systemName: "figure.2.circle.fill"), subtitle: "Assessment of the victim's condition"),
        Step(title: "Assistance", icon: Image(systemName: "message.badge.circle.fill"), subtitle: "Request for assistance"),
        Step(title: "first aid", icon: Image(systemName: "staroflife.circle.fill"), subtitle: "Realisation of first aid gestures"),
    ]
    
    let circleDiameter: CGFloat = 20
    let barWidth: CGFloat = 2
    let distanceBetweenCircleAndBar: CGFloat = 0
    let barHeight: CGFloat = 200

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(0..<steps.count, id: \.self) { index in
                        HStack(spacing: 15) {
                            VStack {
                                Circle()
                                    .frame(width: circleDiameter, height: circleDiameter)
                                    .foregroundColor(index <= currentStep ? .green : .gray)
                                Spacer()
                                    .frame(height: distanceBetweenCircleAndBar)
                                Rectangle()
                                    .frame(width: barWidth, height: (index == steps.count - 1) ? barHeight / 2 : barHeight)
                                    .foregroundColor(index < currentStep ? .green : .gray)
                                if index == steps.count - 1 {
                                    Circle()
                                        .frame(width: circleDiameter, height: circleDiameter)
                                        .foregroundColor(.gray)
                                }
                            }

                            StepView(step: steps[index], isEnabled: index <= currentStep)
                                .onTapGesture {
                                    if index == currentStep {
                                        selectedStep = StepToShow(rawValue: index)  // Mise à jour de l'étape sélectionnée.
                                        currentStep += 1
                                    }
                                }
                        }
                    }
                }
                .padding(.vertical, 10)
            }
            .padding()
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .foregroundColor(.white)
            .navigationTitle("First Aid Steps")
            .sheet(item: $selectedStep) { step in
                vuePourEtape(step)
            }
        }
    }

    // Fonction pour retourner la vue appropriée en fonction de l'étape sélectionnée.
    func vuePourEtape(_ etape: StepToShow) -> some View {
        switch etape {
        case .first:
            return AnyView(FirstAidGuide1())
        case .second:
            return AnyView(FirstAidGuide2())
        case .third:
            return AnyView(FirstAidGuide3())
        case .fourth:
            return AnyView(FirstAidGuide4())
        }
    }
}

struct Step {
    var title: String
    var icon: Image
    var subtitle: String
}

struct StepView: View {
    let step: Step
    let isEnabled: Bool

    var body: some View {
        HStack(spacing: 15) {
            step.icon
                .resizable()
                .frame(width: 40, height: 40)
                .background(Color(.systemGray6))
                .clipShape(Circle())
                .foregroundColor(isEnabled ? .green : .gray)
            
            VStack(alignment: .leading) {
                Text(step.title)
                    .font(.headline)
                Text(step.subtitle)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .opacity(isEnabled ? 1.0 : 0.5)
    }
}

enum StepToShow: Int, Identifiable {
    case first = 0
    case second
    case third
    case fourth

    var id: Int {
        return self.rawValue
    }
}

struct FirstAidGuideView_Previews: PreviewProvider {
    static var previews: some View {
        FirstAidGuideView()
    }
}
