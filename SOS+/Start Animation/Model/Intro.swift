//
//  Intro.swift
//  SOS+
//
//  Created by Ryan Delépine on 14/08/2023.
//

import SwiftUI

/// Intro Model
struct Intro: Identifiable {
    var id: UUID = .init()
    var text: String
    var textColor: Color
    var circleColor: Color
    var bgColor: Color
    var circleOffset: CGFloat = 0
    var textOffset: CGFloat = 0
}

/// Sample Intros
var sampleIntros: [Intro] = [
    .init(
        text: "Welcome",
        textColor: .color4,
        circleColor: .color4,
        bgColor: .color1
    ),
    .init(
        text: "Bonjour",
        textColor: .color1,
        circleColor: .color1,
        bgColor: .color2
    ),
    .init(
        text: "Hola",
        textColor: .color2,
        circleColor: .color2,
        bgColor: .color3
    ),
    .init(
        text: "Willkommen",
        textColor: .color3,
        circleColor: .color3,
        bgColor: .color4
    ),
    .init(
        text: "Bienvenidos",
        textColor: .color4,
        circleColor: .color4,
        bgColor: .color1
    ),
    .init(
        text: "Benvenuti",
        textColor: .color1,
        circleColor: .color1,
        bgColor: .color2
    ),
    .init(
        text: "Bem-vindos",
        textColor: .color2,
        circleColor: .color2,
        bgColor: .color3
    ),
    .init(
        text: "Välkommen",
        textColor: .color3,
        circleColor: .color3,
        bgColor: .color4
    ),

    .init(
        text: "Tervetuloa",
        textColor: .color1,
        circleColor: .color1,
        bgColor: .color2
    ),
    .init(
        text: "Olá",
        textColor: .color2,
        circleColor: .color2,
        bgColor: .color3
    ),
    .init(
        text: "Witajcie",
        textColor: .color3,
        circleColor: .color3,
        bgColor: .color4
    ),
    .init(
        text: "Salve",
        textColor: .color4,
        circleColor: .color4,
        bgColor: .color1
    ),
    .init(
        text: "Приветствие",
        textColor: .color1,
        circleColor: .color1,
        bgColor: .color2
    ),
    
]

