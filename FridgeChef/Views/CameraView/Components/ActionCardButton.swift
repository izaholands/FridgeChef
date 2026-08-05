import SwiftUI

struct ActionCardButton: View {
    var title: String
    var iconName: String
    var backgroundColor: Color
    var foregroundColor: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Image(systemName: iconName)
                    .font(.title3)
                
                Text(title)
                    .font(.headline)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16) 
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(12)
        }
    }
}
