import SwiftUI

struct YourReveneu: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                
                RecipeHeaderCard(
                    time: "Pronta em 30 min",
                    title: "Frittata especial da geladeira",
                    description: "Leve, dourada e perfeita para aproveitar o que você já tem."
                )
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Ingredientes")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    VStack(spacing: 0) {
                        IngredientRow(name: "2 de ovos")
                        IngredientRow(name: "1 xícara de tomate")
                        IngredientRow(name: "A gosto de queijo")
                        IngredientRow(name: "A gosto de espinafre")
                        IngredientRow(name: "A gosto de cebola")
                        IngredientRow(name: "A gosto de pao", showDivider: false)
                    }
                    .background(Color.white)
                    .cornerRadius(16)
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Modo de preparo")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    VStack(alignment: .leading, spacing: 24) {
                        StepRowView(number: 1, text: "Prepare e corte os ingredientes em pedaços pequenos.")
                        StepRowView(number: 2, text: "Refogue tudo em uma frigideira com um fio de azeite.")
                        StepRowView(number: 3, text: "Adicione os ovos batidos, tempere e cozinhe em fogo baixo.")
                        StepRowView(number: 4, text: "Finalize no forno até dourar e sirva ainda quente.")
                    }
                }
            }
            .padding(24)
        }
        .background(Color("bgColor").ignoresSafeArea())
        .navigationTitle("Sua receita")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        YourReveneu()
    }
}
