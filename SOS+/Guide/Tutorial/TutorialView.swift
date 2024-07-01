import SwiftUI


struct TutorialView: View {
    
    @State var currentIndex: Int = 0
    
    var body: some View {
        
        ZStack{
            
            DotInversion(currentIndex: $currentIndex)
                .ignoresSafeArea()
            
            // Indicators...
            HStack(spacing: 10){
                
                ForEach(tabs.indices,id: \.self){index in
                    
                    Circle()
                        .fill(.white)
                        .frame(width: 8, height: 8)
                        .opacity(currentIndex == index ? 1 : 0.3)
                        .scaleEffect(currentIndex == index ? 1.1 : 0.8)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            .padding(25)
            

        }
        .preferredColorScheme(.dark)
    }
}

struct TutorialView_Previews: PreviewProvider {
    static var previews: some View {
        TutorialView()
    }
}
