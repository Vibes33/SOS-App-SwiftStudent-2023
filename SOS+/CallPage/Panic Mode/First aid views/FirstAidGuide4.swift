import SwiftUI

struct FirstAidGuide4: View {
    let safetyGuidelines4: [Guideline4] = [
        Guideline4(title: "First Aid",
                   icon: Image(systemName: "cross.case"),
                   description: "You can start giving first aid if you think it is necessary or if the competent services have asked you to do so "),
        
        Guideline4(title: "Exemple",
                   icon: Image(systemName: "list.bullet.clipboard"),
                   description: "they will help the victim while waiting for help to arrive, examples of situations and how to react are present just below.")
    ]
    
    @State private var showFirstAidView = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                Image("FA2")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding()
                
                ForEach(safetyGuidelines4, id: \.title) { guideline4 in
                    GuidelineView4(guideline4: guideline4)
                }
                
                Button(action: {
                    showFirstAidView = true
                }) {
                    HStack {
                        Spacer()
                           Text("See how to give first aid ")
                               .font(.headline)
                               .foregroundColor(.white)
                        Spacer()

                           Image(systemName: "arrow.right.circle.fill")
                               .foregroundColor(.green)
                    }
                    .padding()
                        .background(Color.black)
                        .cornerRadius(15)
                }
                .sheet(isPresented: $showFirstAidView) {
                    FirstAidView()
                }
            }
            .padding(.top, 20)
            .background(Color(.systemGray6))
            .foregroundColor(.white)
            
         Spacer(minLength: 20)
            
            Button(action: {
                showFirstAidView = true
            }) {
                HStack {
                    Spacer()
                       Text("How to deal with specific situations ")
                           .font(.headline)
                           .foregroundColor(.white)
                    Spacer()
                       Image(systemName: "arrow.right.circle.fill")
                           .foregroundColor(.green)
                }
                .padding()
                    .background(Color.black)
                    .cornerRadius(15)
            }
            .sheet(isPresented: $showFirstAidView) {
                FirstAidView()
            }
        }
        .padding(.top, 20)
        .background(Color(.systemGray6))
        .foregroundColor(.white)
    }
    
    
    struct Guideline4 {
        let title: String
        let icon: Image
        let description: String
    }
    
    struct GuidelineView4: View {
        let guideline4: Guideline4
        
        var body: some View {
            HStack(spacing: 15) {
                guideline4.icon
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color.green)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(guideline4.title)
                        .font(.headline)
                    Text(guideline4.description)
                }
            }
            .padding()
            .background(Color.black)
            .cornerRadius(15)
        }
    }
    
    struct FirstAidGuide4_Previews: PreviewProvider {
        static var previews: some View {
            FirstAidGuide4()
        }
    }
}
