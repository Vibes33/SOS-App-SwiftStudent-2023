//
//  GuidePage2.swift
//  SOS+
//
//  Created by Ryan Delépine on 06/11/2023.
//

import SwiftUI

struct GuidePage2: View {
    @State private var showTutorial = false
    
    var body: some View {
        
        VStack(spacing: 0) { // Réglage de l'espacement sur 0 pour que les éléments se touchent
            Image("Image4655") // Assurez-vous que "Image1" est le bon nom de l'image
                .resizable()
                .scaledToFill()
                .frame(height: 250) // Augmentation de la taille de l'image
                .clipped()

            VStack {
                Text("Start SOS+ Tutorial")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding()
                 

                Button(action: {
                    self.showTutorial = true
                }) {
                    HStack {
                        Text("Start Now")
                            .foregroundColor(.white)
                        Spacer()
                            .frame(width: 190.0)
                        Image(systemName: "arrow.right")
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(10)
                }
                .fullScreenCover(isPresented: $showTutorial) {
                    IntroScreen(isPresented: $showTutorial)
                }
                .padding(.bottom, 50)
                
            }
         
            .frame(maxWidth: .infinity)
            .background(Color(.systemGray6))
         
           
        }
        .frame(width: 370, height: 350) // Augmenter selon les dimensions souhaitées
        .cornerRadius(10)
        .shadow(radius: 10)
        .edgesIgnoringSafeArea(.all) // Si vous souhaitez que la vue ignore la Safe Area
        
    }
}

#Preview {
    GuidePage2()
}
