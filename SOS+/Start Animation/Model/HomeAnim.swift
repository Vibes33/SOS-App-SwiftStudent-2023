import SwiftUI
import Foundation  // Pour la méthode openURL

struct HomeAnim: View {
    /// View Properties
    @State private var intros: [Intro] = sampleIntros
    @State private var activeIntro: Intro?
    @State private var showTutorial = false
    @Environment(\.openURL) var openURL
    @Binding var isPresented: Bool  // Ajout de cette propriété pour contrôler l'affichage de la vue

    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
            VStack(spacing: 0) {
                if let activeIntro = activeIntro {
                    Rectangle()
                        .fill(activeIntro.bgColor)
                        .padding(.bottom, -30)
                        .overlay {
                            Circle()
                                .fill(activeIntro.circleColor)
                                .frame(width: 38, height: 38)
                                .background(alignment: .leading, content: {
                                    Capsule()
                                        .fill(activeIntro.bgColor)
                                        .frame(width: size.width)
                                })
                                .background(alignment: .leading) {
                                    Text(activeIntro.text)
                                        .font(.largeTitle)
                                        .foregroundStyle(activeIntro.textColor)
                                        .frame(width: textSize(activeIntro.text))
                                        .offset(x: 10)
                                        .offset(x: activeIntro.textOffset)
                                }
                                .offset(x: -activeIntro.circleOffset)
                        }
                }
                
                LoginButtons()
                    .padding(.bottom, safeArea.bottom)
                    .padding(.top, 10)
                    .background(.black, in: .rect(topLeadingRadius: 25, topTrailingRadius: 25))
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 8)
            }
            .ignoresSafeArea()
        }
        .task {
            if activeIntro == nil {
                activeIntro = sampleIntros.first
                let nanoSeconds = UInt64(1_000_000_000 * 0.25)
                try? await Task.sleep(nanoseconds: nanoSeconds)
                animate(0)
            }
        }
    }
    
    @ViewBuilder
    func LoginButtons() -> some View {
        VStack(spacing: 12) {
            Button {
                showTutorial.toggle()
            } label: {
                Label("Show Tutorial", systemImage: "books.vertical.fill")
                    .foregroundStyle(.black)
                    .fillButton(.white)
            }
            .fullScreenCover(isPresented: $showTutorial, content: {
                IntroScreen(isPresented: $showTutorial)
            })
            
            Button {
                if let url = URL(string: "https://discord.gg/gREU27DBHb") {
                    openURL(url)
                }
            } label: {
                Label("Access to discord", systemImage: "person.fill.badge.plus")
                    .foregroundStyle(.white)
                    .fillButton(.buton)
            }
            
            Button {
                if let url = URL(string: "https://mee6.xyz/fr/m/1130189221706092647") {
                    openURL(url)
                }
            } label: {
                Label("How to help the developement", systemImage: "checkmark.shield.fill")
                    .foregroundStyle(.white)
                    .fillButton(.buton)
            }
            
            Button {
                isPresented = false  // Lorsque le bouton est pressé, la vue est fermée
            } label: {
                Text("Access to application")
                    .foregroundStyle(.white)
                    .fillButton(.black)
                    .shadow(color: .white, radius: 1)
            }
        }
        .padding(15)
    }
    
    func animate(_ index: Int, _ loop: Bool = true) {
        if intros.indices.contains(index + 1) {
            activeIntro?.text = intros[index].text
            activeIntro?.textColor = intros[index].textColor
            
            withAnimation(.snappy(duration: 1), completionCriteria: .removed) {
                activeIntro?.textOffset = -(textSize(intros[index].text) + 20)
                activeIntro?.circleOffset = -(textSize(intros[index].text) + 20) / 2
            } completion: {
                withAnimation(.snappy(duration: 0.8), completionCriteria: .logicallyComplete) {
                    activeIntro?.textOffset = 0
                    activeIntro?.circleOffset = 0
                    activeIntro?.circleColor = intros[index + 1].circleColor
                    activeIntro?.bgColor = intros[index + 1].bgColor
                } completion: {
                    animate(index + 1, loop)
                }
            }
        } else if loop {
            animate(0)
        }
    }
    
    func textSize(_ text: String) -> CGFloat {
        let attributeText = NSAttributedString(string: text, attributes: [.font: UIFont.preferredFont(forTextStyle: .largeTitle)])
        return attributeText.size().width
    }
}

extension View {
    @ViewBuilder
    func fillButton(_ color: Color) -> some View {
        self
            .fontWeight(.bold)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
            .background(color)
            .cornerRadius(15)
    }
}


struct HomeAnim_Previews: PreviewProvider {
    static var previews: some View {
        HomeAnim(isPresented: .constant(true))
    }
}
