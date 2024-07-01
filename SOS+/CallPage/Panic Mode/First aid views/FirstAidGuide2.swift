import SwiftUI

struct FirstAidGuide2: View {
    let safetyGuidelines2: [Guideline2] = [
        Guideline2(title: "Introduce yourself",
                  icon: Image(systemName: "person"),
                  description: "To reassure the victim, introduce yourself to the victim and check that he or she is conscious and able to breathe."),
        
        Guideline2(title: "Memorize informations",
                  icon: Image(systemName: "brain"),
                  description: "This information is essential and must be transmitted to the emergency services as soon as possible.")
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                Image("FA4")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding()

                ForEach(safetyGuidelines2, id: \.title) { guideline2 in
                    GuidelineView2(guideline2: guideline2)
                }
            }
            .padding(.top, 20)
            .background(Color(.systemGray6))
            .foregroundColor(.white)
        }
        .navigationBarTitle("Assessment of the victim's condition", displayMode: .inline)
    }
}

struct Guideline2 {
    let title: String
    let icon: Image
    let description: String
}

struct GuidelineView2: View {
    let guideline2: Guideline2

    var body: some View {
        HStack(spacing: 15) {
            guideline2.icon
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(Color.green)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(guideline2.title)
                    .font(.headline)
                Text(guideline2.description)
            }
       
        }
        .padding()
        .background(Color.black)
        .cornerRadius(15)
    }
}

struct FirstAidGuide2_Previews: PreviewProvider {
    static var previews: some View {
        FirstAidGuide2()
    }
}

