//
//  Tab.swift
//  SOS+
//
//  Created by Ryan Delépine on 14/08/2023.
//

import SwiftUI

// Tab Model and sample Intro Tabs....
struct Tab: Identifiable{
    var id = UUID().uuidString
    var title: String
    var description: String
    var image: String
    var color: Color
}

// Add more tabs for more intro screens....
var tabs: [Tab] = [

    Tab(title: "Manage your contact",  description: "Create new contact for emergency ! No need for dialling codes, the app takes care of that! These contacts will be contacted in an emergency.", image: "Pic2.2",color: Color("ColorG")),
    Tab(title: "Call emergency services",  description: "Make a quick call to the emergency services with a problem, or carry out a rapid diagnosis! ", image: "Pic5",color: Color("ColorG")),
    Tab(title: "Médical File",  description: "Enter your medical details to help the fire brigade or others if you have an accident! ", image: "Pic7",color: Color("ColorG")),
    Tab(title: "Settigns",  description: "Go to settings , to activate notifications and consult the documentation on data use ! coming soon , Audio description of the app !", image: "Pic6",color: Color("ColorG")),
    Tab(title: "First Aid",  description: "A quick guide to help in an emergency! ", image: "Pic3.3",color: Color("ColorG")),
    Tab(title: "Panic Mode",  description: "If you don't know what to do, press one of the panic mode buttons on the app, and it will switch to a mode containing only useful information! ", image: "Pic1.1",color: Color("ColorG")),
    Tab(title: "Discover community",  description: "Coming soon! Create a community space on Discord!", image: "Pic4",color: Color("ColorG")),
    Tab(title: "Enjoy the app !",  description: "I hope you like this app! I've still got a few things to add that I'm working on at the moment, such as a little questionnaire to help you learn emergency procedures and finishing off the app's interface!", image: "Pic8",color: Color("ColorG")),
]
