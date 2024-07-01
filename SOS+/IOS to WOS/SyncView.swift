//
//  SynchView.swift
//  Test For App
//
//  Created by Ryan Delépine on 26/07/2023.
//

import SwiftUI
import WatchConnectivity

struct SyncView: View {
    var body: some View {
            Button(action: syncWithWatch) {
                HStack {
                    Spacer()
                       Text("Synch with Apple Watch")
                           .font(.headline)
                           .foregroundColor(.white)
                    Spacer()
                       Image(systemName: "applewatch")
                           .foregroundColor(.green)
                }
                .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(15)
            }

    }

    func syncWithWatch() {
        if WCSession.isSupported() {
            let session = WCSession.default
            if session.isReachable {
                print("Session is reachable, trying to send contacts")
                if let contactsData = UserDefaults.standard.data(forKey: "emergencyContacts") {
                    session.sendMessage(["contactsData": contactsData], replyHandler: nil)
                }
            } else {
                print("Session is not reachable")
            }
        }
    }
}

#Preview {
    SyncView()
}
