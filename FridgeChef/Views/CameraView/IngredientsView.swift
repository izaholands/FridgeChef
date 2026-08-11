import SwiftUI

struct IngredientsView: View {
    @EnvironmentObject var viewModel: CameraViewModel
    @Environment(\.modelContext) private var modelContext
    @State private var newIngredient: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Encontramos estes itens")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("Remova o que não estiver disponível ou adicione algo\nque ficou de fora.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Tag wrap view manual para os ingredientes
                    FlowLayout(spacing: 8) {
                        ForEach(viewModel.ingredients) { ingredient in
                            HStack(spacing: 4) {
                                Text(ingredient.name)
                                    .font(.subheadline)
                                
                                Button(action: {
                                    viewModel.removeIngredient(ingredient)
                                }) {
                                    Image(systemName: "xmark")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color("secondColor"))
                            .cornerRadius(20)
                        }
                    }
                    
                    HStack {
                        TextField("Adicionar ingrediente", text: $newIngredient)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .background(Color("bgColor"))
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .strokeBorder(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                        
                        Button(action: {
                            viewModel.addIngredient(newIngredient)
                            newIngredient = ""
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .padding(12)
                                .background(Color("systemPrimaryColor"))
                                .cornerRadius(12)
                        }
                        .disabled(newIngredient.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                    .padding(.top, 8)
                }
                .padding(.horizontal, 24)
            }
            
            Spacer()
            
            Button {
                viewModel.navigationPath.append(CameraNavigationRoute.generatingRecipe)
                Task {
                    await viewModel.generateRecipe(context: modelContext)
                }
            } label: {
                HStack {
                    Image(systemName: "wand.and.stars")
                    Text("Gerar receita")
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(viewModel.ingredients.isEmpty ? Color.gray : Color("systemPrimaryColor"))
                .cornerRadius(12)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 20)
            .disabled(viewModel.ingredients.isEmpty)
        }
        .navigationTitle("Ingredientes")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    viewModel.navigationPath.removeLast()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color("systemPrimaryColor"))
                    }
                }
            }
        }
    }
}

// Uma view simples para imitar um Flow Layout de tags (já que não há suporte nativo para iOS mais antigos sem Layout Protocol ou third party, usaremos GeometryReader ou VStack/HStack agrupado. No iOS 16, usaríamos Layout. Vou colocar um FlowLayout usando o iOS 16 Layout protocol, já que SwiftData tá lá (iOS 17)).
@available(iOS 16.0, *)
struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(in: proposal.width ?? 0, subviews: subviews, spacing: spacing)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(in: bounds.width, subviews: subviews, spacing: spacing)
        for (index, subview) in subviews.enumerated() {
            let point = result.frames[index].origin
            subview.place(at: CGPoint(x: point.x + bounds.minX, y: point.y + bounds.minY), proposal: .unspecified)
        }
    }

    struct FlowResult {
        var size: CGSize = .zero
        var frames: [CGRect] = []

        init(in maxWidth: CGFloat, subviews: Subviews, spacing: CGFloat) {
            var currentX: CGFloat = 0
            var currentY: CGFloat = 0
            var lineHeight: CGFloat = 0

            for subview in subviews {
                let size = subview.sizeThatFits(.unspecified)
                if currentX + size.width > maxWidth && currentX != 0 {
                    currentX = 0
                    currentY += lineHeight + spacing
                    lineHeight = 0
                }
                frames.append(CGRect(x: currentX, y: currentY, width: size.width, height: size.height))
                currentX += size.width + spacing
                lineHeight = max(lineHeight, size.height)
            }
            size = CGSize(width: maxWidth, height: currentY + lineHeight)
        }
    }
}
