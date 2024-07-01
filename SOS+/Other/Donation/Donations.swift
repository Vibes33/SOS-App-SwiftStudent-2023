import SwiftUI

struct DonationView: View {
    @State private var selectedAmount: Double = 0.0
    @State private var customAmount: String = ""
    @State private var isCustomAmountSelected: Bool = false
    let donationAmounts: [Double] = [5.0, 10.0, 15.0, 20.0]

    var body: some View {
        VStack {
            Text("Make donation")
                .font(.title)
                .fontWeight(.bold)
                .padding()

            VStack(alignment: .leading) {
                ForEach(donationAmounts, id: \.self) { amount in
                    DonationButtonView(amount: amount, isSelected: selectedAmount == amount) {
                        updateSelectedAmount(amount: amount)
                        isCustomAmountSelected = false
                    }
                    .disabled(isCustomAmountSelected)
                }
                .padding(.horizontal)
                .frame(minHeight: 44)
                Divider()

                HStack {
                    if isCustomAmountSelected {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                    TextField("Customized amount", text: $customAmount)
                        .keyboardType(.decimalPad)
                        .font(.headline)
                        .foregroundColor(.blue)
                        .onChange(of: customAmount, perform: { value in
                            if !value.isEmpty {
                                selectedAmount = 0.0
                                isCustomAmountSelected = true
                            }
                        })
                }
                .padding(.horizontal)
                .frame(minHeight: 44)
                Divider()
            }
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .padding(.bottom)

            Button(action: {}) {
                Text("Faire un don")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .disabled(selectedAmount == 0.0 && customAmount.isEmpty)
            .opacity((selectedAmount == 0.0 && customAmount.isEmpty) ? 0.5 : 1.0)

            Spacer()
        }
        .padding()
        .navigationBarTitle("Donation", displayMode: .inline)
    }

    private func updateSelectedAmount(amount: Double) {
        if selectedAmount == amount {
            selectedAmount = 0.0
        } else {
            selectedAmount = amount
        }
    }
}

struct DonationButtonView: View {
    let amount: Double
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            HStack {
                Text("$\(amount, specifier: "%.0f")")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                Spacer()
                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}

struct DonationView_Previews: PreviewProvider {
    static var previews: some View {
        DonationView()
    }
}
