import SwiftUI

struct RecipeCardView: View {
    var title: String
    var timeInfo: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "bookmark.fill")
                .foregroundColor(.white)
                .font(.title2)
                .frame(width: 60, height: 60)
                .background(Color("systemPrimaryColor"))
                .cornerRadius(16)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(timeInfo)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer() 
        }
        .padding(12)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(20)
    }
}

#Preview {
    RecipeCardView(title: "Frittata especial da geladeira", timeInfo: "Pronta em 30 min")
        .padding()
}
