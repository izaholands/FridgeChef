import SwiftUI

struct RevenueView: View {
    @EnvironmentObject var viewModel: CameraViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    if viewModel.recipes.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "fork.knife")
                                .font(.system(size: 40))
                                .foregroundColor(.secondary)
                            
                            Text("Nenhuma receita salva")
                                .font(.headline)
                            
                            Text("Suas receitas criadas aparecerão aqui.")
                                .foregroundColor(.secondary)
                        }
                        .padding(.top, 100)
                    }
                    
                    ForEach(viewModel.recipes) { recipe in
                        NavigationLink {
                            YourReveneu(recipe: recipe)
                        } label: {
                            RecipeCardView(
                                title: recipe.title,
                                timeInfo: recipe.time
                            )
                        }
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
    let viewModel = CameraViewModel()
    
    viewModel.recipes = [
        Recipe(
            title: "Frittata especial da geladeira",
            time: "Pronta em 30 min",
            description: "Uma receita deliciosa usando os ingredientes disponíveis.",
            ingredients: [
                Ingredient(name: "Ovos"),
                Ingredient(name: "Tomate"),
                Ingredient(name: "Queijo")
            ],
            steps: [
                "Corte os ingredientes.",
                "Misture tudo.",
                "Cozinhe até finalizar."
            ]
        )
    ]
    
    return RevenueView()
        .environmentObject(viewModel)
}
