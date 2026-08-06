import SwiftUI

struct YourReveneu: View {
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                RecipeHeaderCard(
                    time: recipe.time,
                    title: recipe.title,
                    description: recipe.description
                )
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Ingredientes")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    VStack(spacing: 0) {
                        ForEach(recipe.ingredients) { ingredient in
                            IngredientRow(
                                name: ingredient.name, showDivider: false
                            )
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(16)
                }
                
                VStack(alignment: .leading, spacing: 24) {
                    Text("Modo de preparo")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    ForEach(Array(recipe.steps.enumerated()), id: \.offset) { index, step in
                        StepRowView(
                            number: index + 1,
                            text: step
                        )
                    }
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 32)
        }
        .background(Color("bgColor"))
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    NavigationStack {
        YourReveneu(
            recipe: Recipe(
                title: "Frittata especial da geladeira",
                time: "Pronta em 30 min",
                description: "Uma receita deliciosa usando os ingredientes disponíveis na sua geladeira.",
                ingredients: [
                    Ingredient(name: "Ovos"),
                    Ingredient(name: "Tomate"),
                    Ingredient(name: "Queijo"),
                    Ingredient(name: "Espinafre")
                ],
                steps: [
                    "Corte os ingredientes.",
                    "Misture tudo.",
                    "Cozinhe até finalizar."
                ]
            )
        )
    }
}
