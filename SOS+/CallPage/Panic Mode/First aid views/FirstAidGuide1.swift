import SwiftUI

struct FirstAidGuide1: View {
    let safetyGuidelines: [Guideline] = [
        Guideline(title: "Safety Check",
                  icon: Image(systemName: "exclamationmark.triangle"),
            description: "Take care not to endanger yourself by approaching the scene of the accident, after checking the safety conditions and any potential additional risks "),
        
        Guideline(title: "Emergency Alert",
                  icon: Image(systemName: "bell.slash"),
                  description: "If you cannot act without taking risks, alert the emergency services (go directly to step 3 of the tutorial), then set up a safety perimeter around the accident until they arrive.")
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                Image("FA1")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding()

                ForEach(safetyGuidelines, id: \.title) { guideline in
                    GuidelineView(guideline: guideline)
                }
            }
            .padding(.top, 20)
            .background(Color(.systemGray6))
            .foregroundColor(.white)
        }
        .navigationBarTitle("Securing the place and the people", displayMode: .inline)
    }
}

struct Guideline {
    let title: String
    let icon: Image
    let description: String
}

struct GuidelineView: View {
    let guideline: Guideline

    var body: some View {
        HStack(spacing: 15) {
            guideline.icon
                .resizable()
                .frame(width: 40, height: 35)
                .foregroundColor(Color.green)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(guideline.title)
                    .font(.headline)
                Text(guideline.description)
                
            }
        }
        .padding()
        .background(Color.black)
        .cornerRadius(15)
    }
}

struct FirstAidGuide1_Previews: PreviewProvider {
    static var previews: some View {
        FirstAidGuide1()
    }
}
