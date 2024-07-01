//
//  ViewParallaxe.swift
//  SOS+
//
//  Created by Ryan Delépine on 14/08/2023.
//

import SwiftUI

struct ViewParallaxe: View {
    /// View Properties
    @State private var searchText: String = ""
    var body: some View {
       
                
                /// Parallax Carousel
                GeometryReader(content: { geometry in
                    let size = geometry.size
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 5) {
                            ForEach(tripCards) { card in
                                /// In order to Move the Card in Reverse Direction (Parallax Effect)
                                GeometryReader(content: { proxy in
                                    let cardSize = proxy.size
                                    /// Simple Parallax Effect (Type 2)
                                    //let minX = proxy.frame(in: .scrollView).minX - 30.0
                                    /// Moving Parallax Effect (Type 1)
                                    let minX = min((proxy.frame(in: .scrollView).minX - 10.0) * 1.4, size.width * 1.4)
                                    
                                    Image(card.image)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        /// Or You can simply Use scaling
                                        //.scaleEffect(1.25)
                                        .offset(x: -minX)
                                        /// Disable this for Type one Effect
                                        .frame(width: proxy.size.width * 2.5)
                                        .frame(width: cardSize.width, height: cardSize.height)
                                        .overlay {
                                            OverlayView(card)
                                        }
                                        .clipShape(.rect(cornerRadius: 15))
                                        .shadow(color: .black.opacity(0.25), radius: 8, x: 5, y: 20)
                                })
                                .frame(width: size.width - 90, height: size.height - 300)
                                /// Scroll Animation
                                .scrollTransition(.interactive, axis: .horizontal) { view, phase in
                                    view
                                        .scaleEffect(phase.isIdentity ? 1 : 0.95)
                                }
                            }
                        }
                        .padding(.horizontal, 30)
                        .scrollTargetLayout()
                        .frame(height: size.height, alignment: .top)
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .scrollIndicators(.hidden)
                })
                .frame(height: 530)
                .padding(.horizontal, -20)
                .padding(.top, 20)
            
        }
        
    }
    
    /// Overlay View
    @ViewBuilder
    func OverlayView(_ card: TripCard) -> some View {
        ZStack(alignment: .bottomLeading, content: {
            LinearGradient(colors: [
                .clear,
                .clear,
                .clear,
                .clear,
                .clear,
                .black.opacity(0.1),
                .black.opacity(0.5),
                .black
            ], startPoint: .top, endPoint: .bottom)
            
            VStack(alignment: .leading, spacing: 4, content: {
                Text(card.title)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundStyle(.white)
                
                Text(card.subTitle)
                    .font(.callout)
                    .foregroundStyle(.white.opacity(0.8))
            })
            .padding(20)
            
            
        })
    }
    
#Preview {
    ViewParallaxe()
}
