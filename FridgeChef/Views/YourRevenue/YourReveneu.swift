import SwiftUI

struct YourReveneu: View {
    let recipe: Revenue
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                RecipeHeaderCard(
                    time: recipe.time,
                    title: recipe.title,
                    description: recipe.desc
                )
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Ingredientes")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    VStack(spacing: 0) {
                        ForEach(recipe.ingredients, id: \.self) { ingredientName in
                            IngredientRow(
                                name: ingredientName, showDivider: false
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
            .padding(.top, 32)
            .padding(.bottom, 40) // Ajustado para não ficar muito espaço
        }
        .background(Color("bgColor"))
    }
}

#Preview {
    NavigationStack {
        YourReveneu(
            recipe: Revenue(
                title: "Frittata especial da geladeira",
                time: "Pronta em 30 min",
                desc: "Uma receita deliciosa usando os ingredientes disponíveis na sua geladeira.",
                ingredients: [
                    "Ovos",
                    "Tomate",
                    "Queijo",
                    "Espinafre"
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
