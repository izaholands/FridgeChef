import SwiftUI

struct RevenueView: View {
    let mockRecipes = [
        ("Frittata especial da geladeira", "Pronta em 30 min"),
        ("Frittata especial da geladeira", "Pronta em 30 min"),
        ("Frittata especial da geladeira", "Pronta em 30 min")
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(0..<mockRecipes.count, id: \.self) { index in
                        RecipeCardView(
                            title: mockRecipes[index].0,
                            timeInfo: mockRecipes[index].1
                        )
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
            }
            .navigationTitle("Minhas Receitas")
        }
    }
}

#Preview {
    RevenueView()
}
