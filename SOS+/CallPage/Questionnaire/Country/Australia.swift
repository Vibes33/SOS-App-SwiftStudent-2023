import SwiftUI


struct EmergencyAUSQuestion: View {
    @State private var selectedEmergencyType: String = ""
    let emergencyTypes = [
        "Vehicle accident",
                 "Illness or poison",
                 "Crime",
                 "Fire",
                 "Lost or injured"
     ]

    var body: some View {
            VStack {
                Text("Select Emergency Type")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()

                VStack(alignment: .leading) {
                    ForEach(emergencyTypes, id: \.self) { emergencyType in
                        Button(action: {
                            selectedEmergencyType = emergencyType
                        }) {
                            HStack {
                                Text(emergencyType)
                                Spacer()
                                if selectedEmergencyType == emergencyType {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                        .foregroundColor(.primary)
                        .padding(.horizontal)
                        .frame(minHeight: 44)
                        Divider()
                    }
                }
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.bottom)

                NavigationLink(
                    destination: AusNumberView(),
                    label: {
                        Text("Next")
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                )
                .disabled(selectedEmergencyType.isEmpty)
                .background(selectedEmergencyType.isEmpty ? Color.gray.opacity(0.5) : Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)

                Spacer()
            }
            .padding()
            .navigationBarTitle("Emergency Selection", displayMode: .inline)
        }
    }


struct EmergencyAUSQuestion_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyAUSQuestion()
    }
}

