import SwiftUI

struct RevenueView: View {
    // Array fixo para simular o comportamento
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
                        
                        // 1. Envolvemos o card no NavigationLink
                        NavigationLink {
                            // 2. Destino: A tela de detalhes que acabamos de criar
                            YourReveneu()
                        } label: {
                            // 3. Label: O visual do botão (o seu card)
                            RecipeCardView(
                                title: mockRecipes[index].0,
                                timeInfo: mockRecipes[index].1
                            )
                        }
                        // 4. Mantém as cores originais do seu card ao invés de aplicar um tint de botão
                        .buttonStyle(.plain)
                        
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
