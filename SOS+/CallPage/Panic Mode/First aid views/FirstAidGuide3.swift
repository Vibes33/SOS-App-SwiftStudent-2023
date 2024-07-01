import SwiftUI

struct FirstAidGuide3: View {
    let safetyGuidelines3: [Guideline3] = [
        Guideline3(title: "Call emergency",
                  icon: Image(systemName: "phone"),
                  description: "It is essential to ask for help to the competent services, (Fire brigade, emergencies  etc )"),
        
        Guideline3(title: "Emergency questionnaire",
                  icon: Image(systemName: "questionmark.square.dashed"),
                  description: "the emergency questionnaire is there if you do not know which service to contact.")
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                Image("FA3")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding()

                ForEach(safetyGuidelines3, id: \.title) { guideline3 in
                    GuidelineView3(guideline3: guideline3)
                }
                
            }
            .padding(.top, 20)
            .background(Color(.systemGray6))
            .foregroundColor(.white)
        }
        .navigationBarTitle("Request for assistance", displayMode: .inline)
    }
}

struct Guideline3 {
    let title: String
    let icon: Image
    let description: String
}

struct GuidelineView3: View {
    let guideline3: Guideline3

    var body: some View {
        HStack(spacing: 15) {
            guideline3.icon
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(Color.green)
           
            VStack(alignment: .leading, spacing: 10) {
                Text(guideline3.title)
                    .font(.headline)
                Text(guideline3.description)
                
            }
        }
        .padding()
        .background(Color.black)
        .cornerRadius(15)
    }
}

struct FirstAidGuide3_Previews: PreviewProvider {
    static var previews: some View {
        FirstAidGuide3()
    }
}

