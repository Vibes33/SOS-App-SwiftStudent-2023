import SwiftUI

struct PanicModeView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var showPanicModeView: Bool
    @State private var isExpanded = false

    var body: some View {
        NavigationView {
            VStack {
                Toggle(isOn: $showPanicModeView.animation()) {
                    Text("Panic Mode")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                }
                .padding()
                .toggleStyle(SwitchToggleStyle(tint: .red))
                .onChange(of: showPanicModeView) { value in
                    if !value {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                .padding()
                .toggleStyle(SwitchToggleStyle(tint: .red))

     

                VStack(spacing: 20) {
                    CustomButton(icon: "wifi.slash", text: "No connexion", iconColor: Color.red, destination: NoConnectionView())
                    CustomButton(icon: "person.fill.questionmark", text: "Help someone", iconColor: Color.blue, destination: FirstAidGuideView())
                    CustomButton(icon: "phone.connection", text: "Call emergency", iconColor: Color.green, destination: CountryViewQuestion())
                }
                .padding()

                Spacer()
            }
            .navigationTitle("")
        }
    }
}

struct CustomButton<Destination: View>: View {
    let icon: String
    let text: String
    let iconColor: Color
    let destination: Destination

    var body: some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 15) {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(iconColor)
                    .padding(10)
                    .background(Color.black)
                    .clipShape(Circle())

                Text(text)
                    .font(.system(size: 17))
                    .foregroundColor(.white)

                Spacer()

                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 15)
                    .foregroundColor(Color.white.opacity(0.6))
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
    }
}

struct PanicModeView_Previews: PreviewProvider {
    static var previews: some View {
        PanicModeView(showPanicModeView: .constant(true))
    }
}
