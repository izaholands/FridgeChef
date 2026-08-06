import SwiftUI

import SwiftData

struct RevenueView: View {
    @EnvironmentObject var viewModel: CameraViewModel
    @Query private var recipes: [Revenue]
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            Group {
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
                } else {
                    List {
                        ForEach(recipes) { recipe in
                            ZStack(alignment: .leading) {
                                RecipeCardView(
                                    title: recipe.title,
                                    timeInfo: recipe.time
                                )
                                
                                NavigationLink {
                                    YourReveneu(recipe: recipe)
                                } label: {
                                    EmptyView()
                                }
                                .opacity(0)
                            }
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 8, leading: 24, bottom: 8, trailing: 24))
                        }
                        .onDelete(perform: deleteRecipes)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Minhas Receitas")
        }
    }
    
    private func deleteRecipes(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(recipes[index])
            }
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
