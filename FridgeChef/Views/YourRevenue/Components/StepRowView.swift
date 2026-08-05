import SwiftUI

struct StepRowView: View {
    var number: Int
    var text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Text("\(number)")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 32, height: 32)
                .background(Color.green.opacity(0.8))
                .clipShape(Circle())
            
            Text(text)
                .font(.body)
                .foregroundColor(.primary)
                .padding(.top, 4)
        }
    }
}
