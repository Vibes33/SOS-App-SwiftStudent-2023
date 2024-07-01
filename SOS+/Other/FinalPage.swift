import SwiftUI

private let defaultIconFrameHeight: CGFloat = 75.0

struct FinalPageHeader: View {
    var body: some View {
        Text("SOS+")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding()
    }
}

struct FinalPageRow: View {
    
    var value: String
    var imageName: String
    var color: Color
    var destination: AnyView

    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(color)
                .padding()
                .frame(height: defaultIconFrameHeight)
            
            Text(value)
                .font(.body)
                .lineLimit(1)
        }
        .contentShape(Rectangle())
        .background(NavigationLink("", destination: destination).opacity(0))
    }
}

struct FinalPageList: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        List {
            FinalPageRow(value: "Emergency Contacts",
                         imageName: "person.crop.circle.fill.badge.plus",
                         color: .green,
                         destination: AnyView(EmergencyContactsViewController()))
            FinalPageRow(value: "Medical Info",
                         imageName: "rectangle.fill.badge.person.crop",
                         color: .red,
                         destination: AnyView(MedicalInfoView()))
            FinalPageRow(value: "About community",
                         imageName: "rectangle.stack.badge.person.crop.fill",
                         color: .blue,
                         destination: AnyView(CommunityView()))
            FinalPageRow(value: "Setings",
                         imageName: "gearshape.2",
                         color: .gray,
                         destination: AnyView(SettingsView()))
         
           
        }
        
        .cornerRadius(3.0)
        .background(colorScheme == .dark ? Color.black : Color.white)

    }
}

struct FinalPage: View {
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationView{
       
            VStack {
                FinalPageHeader()
                    .padding()
                FinalPageList()
                    .background(colorScheme == .dark ? Color.black : Color.white)
            }
            .background(colorScheme == .dark ? Color.black : Color.white)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

