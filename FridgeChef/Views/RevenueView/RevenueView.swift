import SwiftUI

import SwiftData

struct RevenueView: View {
    @EnvironmentObject var viewModel: CameraViewModel
    @Query private var recipes: [Revenue]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    if recipes.isEmpty {
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
                    
                    ForEach(recipes) { recipe in
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
    
    // Preview with SwiftData requires ModelContainer, simplified for now
    return RevenueView()
        .environmentObject(viewModel)
        .modelContainer(for: Revenue.self, inMemory: true)
    

}
