import SwiftUI

struct IntroScreen: View {
    
    @State var currentIndex: Int = 0
    @Binding var isPresented: Bool
    
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
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            .padding(25)
            
            // Skip Button..
            Button("Skip"){
                isPresented = false
            }
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding()
        }
        .preferredColorScheme(.dark)
    }
}

struct IntroScreen_Previews: PreviewProvider {
    static var previews: some View {
        IntroScreen(isPresented: .constant(true))
    }
}
