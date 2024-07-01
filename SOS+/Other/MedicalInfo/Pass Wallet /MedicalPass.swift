import SwiftUI

struct AppleWalletCardView: View {
    let personalInfo: String
    let medicalInfo: String

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("SOS+")
                .font(.title)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Text("Personal Information")
                .font(.headline)
                .foregroundColor(.black)
            
            Text(personalInfo)
                .font(.subheadline)
                .foregroundColor(.black)
            
            Spacer()
            
            Text("Medical Information")
                .font(.headline)
                .foregroundColor(.black)
            
            Text(medicalInfo)
                .font(.subheadline)
                .foregroundColor(.black)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(radius: 5)
        )
        .padding(.horizontal)
        .padding(.vertical, 20)
    }
}

struct ApplWal: View {
    var body: some View {
        ScrollView {
            AppleWalletCardView(
                personalInfo: "Name: John Doe\nAge: 30\nHeight: 175 cm\nWeight: 70 kg\nSex: Male",
                medicalInfo: "Blood Group: A+\nSpecific Pathologies: None\nCurrent Medications:\n- Medication 1\n- Medication 2"
            )
        }
    }
}

struct ApplWal_Previews: PreviewProvider {
    static var previews: some View {
        ApplWal()
    }
}
