import SwiftUI

struct WelcomeSheetView: View {
    @State private var selectedCategory: Category = .tutorial

    enum Category {
        case tutorial, community, other
        
        var color: Color {
            switch self {
            case .tutorial:
                return Color.green
            case .community:
                return Color.red
            case .other:
                return Color.yellow
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome To SOS+")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                Text("The first application for your safety, learning and community discovery.")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                
                Spacer()
                
                VStack (spacing: 20) {
                    CategoryView(icon: "books.vertical.fill", title: "Learn Application !", category: .tutorial, selectedCategory: $selectedCategory)
                    CategoryView(icon: "person.fill.badge.plus", title: "Discover Community", category: .community, selectedCategory: $selectedCategory)
                    CategoryView(icon: "creditcard.and.123", title: "Donation", category: .other, selectedCategory: $selectedCategory)
                }
                .padding([.top, .bottom])
                .padding(.horizontal, 20)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
                .animation(.easeInOut)
                
                Spacer()

                categoryButton()
            }
            .padding()
        }
    }
    
    @ViewBuilder
    private func categoryButton() -> some View {
        switch selectedCategory {
        case .tutorial:
            NavigationLink(destination: TutorialView()) {
                Text("Access to tutorial")
                    .font(.headline)
                    .bold()
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.bottom, 20)
        case .community:
            Button(action: {
                if let url = URL(string: "https://discord.gg/gREU27DBHb") {
                    UIApplication.shared.open(url)
                }
            }) {
                Text("Go to Discord!")
                    .font(.headline)
                    .bold()
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.bottom, 20)
        case .other:
            Button(action: {
                if let url = URL(string: "https://mee6.xyz/fr/m/1130189221706092647?subscribe=1130525699808043008&bundle=1130799894391427072") {
                    UIApplication.shared.open(url)
                }
            }) {
                Text("Access to donation")
                    .font(.headline)
                    .bold()
                    .padding()
                    .background(Color.yellow)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.bottom, 10)
        }
    }
}

struct CategoryView: View {
    let icon: String
    let title: String
    let category: WelcomeSheetView.Category
    @Binding var selectedCategory: WelcomeSheetView.Category

    var body: some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundColor(selectedCategory == category ? category.color : .gray)
                .onTapGesture {
                    selectedCategory = category
                }
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
                .foregroundColor(selectedCategory == category ? category.color : .gray)
        }
        .padding(.vertical, 10)
        .padding(.leading, 5)
        .frame(maxWidth: .infinity)
        .background(selectedCategory == category ? category.color.opacity(0.2) : Color.clear)
        .cornerRadius(10)
        .onTapGesture {
            selectedCategory = category
        }
    }
}

struct WelcomeSheetView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeSheetView()
    }
}
