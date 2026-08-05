import SwiftUI

struct IngredientRow: View {
    var name: String
    var showDivider: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(name)
                .font(.body)
                .padding(.vertical, 16)
                .padding(.horizontal, 20)
            
            if showDivider {
                Divider()
                    .padding(.horizontal, 20)
            }
        }
    }
}
