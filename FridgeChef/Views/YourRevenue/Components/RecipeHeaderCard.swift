import SwiftUI

struct RecipeHeaderCard: View {
    var time: String
    var title: String
    var description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(time.uppercased())
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.white.opacity(0.9))
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text(description)
                .font(.body)
                .foregroundColor(.white.opacity(0.9))
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color("systemPrimaryColor")) 
        .cornerRadius(16)
    }
}
