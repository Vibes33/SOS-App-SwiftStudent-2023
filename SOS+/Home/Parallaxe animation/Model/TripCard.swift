//
//  TripCard.swift
//  SOS+
//
//  Created by Ryan Delépine on 14/08/2023.
//


import SwiftUI

/// Trip Card Model
struct TripCard: Identifiable, Hashable {
    var id: UUID = .init()
    var title: String
    var subTitle: String
    var image: String
}

/// Sample Cards
var tripCards: [TripCard] = [
    .init(title: "Watch os app", subTitle: "Download the SOS+ companion !", image: "Pic 1"),
    .init(title: "Community", subTitle: "Join the SOS+ Discord ! ", image: "Pic 2"),
    .init(title: "View the trailer", subTitle: "SOS+ trailer on youtube", image: "Image4"),
]
