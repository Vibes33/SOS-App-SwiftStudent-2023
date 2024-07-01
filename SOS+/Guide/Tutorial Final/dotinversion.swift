import SwiftUI

struct DotInversion: View {
    
    @Binding var currentIndex: Int
    @State var nextIndex: Int = 1
    
    var body: some View {
        ZStack {
            
            tabs[currentIndex].color
                            .ignoresSafeArea()
            
            // Display the content based on the current index
            IntroView(tab: tabs[currentIndex])
                .offset(y: -50)
                .background(tabs[currentIndex].color.ignoresSafeArea())
            
            // Button to change the slide
            Button(action: {
                currentIndex = (currentIndex + 1) % tabs.count
                nextIndex = (currentIndex + 1) % tabs.count
            }) {
                Image(systemName: "chevron.right")
                    .font(.title)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, getSafeArea().bottom + 20)
        }
    }
    
    @ViewBuilder
    func IntroView(tab: Tab) -> some View {
        VStack {
            Image(tab.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: getRect().width - 80)
                .padding(.bottom, getRect().height < 750 ? 20 : 40)
                .padding(.top,40)
            
            VStack(alignment: .leading, spacing: 0) {
                Text(tab.title)
                    .font(.system(size: 45))
                
                Text(tab.description)
                    .fontWeight(.semibold)
                    .padding(.top)
                    .frame(width: getRect().width - 100, alignment: .leading)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading,20)
            .padding([.trailing, .top])
        }
    }
    
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
    
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero
        }
        
        return safeArea
    }
}

struct DotInversion_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
