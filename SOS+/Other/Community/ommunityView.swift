import SwiftUI

struct CommunityView: View {
    let plans = [
        ("VIP11", "Description du plan VIP11", "https://mee6.xyz/fr/m/1130189221706092647?subscribe=1130525699808043008"),
        ("VIP22", "Description du plan VIP22", "https://mee6.xyz/fr/m/1130189221706092647?subscribe=1130529317999357952"),
        ("VIP33", "Description du plan VIP33", "https://mee6.xyz/fr/m/1130189221706092647?subscribe=1130527357799501824")
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .center, spacing: 20) {
                    Divider()

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Discord Features")
                            .font(.title2)
                            .fontWeight(.bold)

                        Text("Join our Discord community !")
                            .font(.body)
                            .padding(.bottom, 10)

                        Link(destination: URL(string: "https://discord.gg/gREU27DBHb")!) {
                            Image("DiscordButton")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)

                    Divider()

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Support Us")
                            .font(.title2)
                            .fontWeight(.bold)

                        Text("Support our community by choosing one of the following plans:")
                            .font(.body)
                            .padding(.bottom, 10)

                        HStack(spacing: 10) {
                            ForEach(0..<plans.count, id: \.self) { index in
                                Link(destination: URL(string: plans[index].2)!, label: {
                                    Image(plans[index].0)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 110, height: 200)
                                        .cornerRadius(10)
                                })
                            }
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }
                .padding()
                .background(Color(.systemGroupedBackground))
                .edgesIgnoringSafeArea(.bottom)
            }
            .navigationTitle("About our community")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
    }
}
