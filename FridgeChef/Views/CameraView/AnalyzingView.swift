import SwiftUI

struct AnalyzingView: View {
    @EnvironmentObject var viewModel: CameraViewModel
    
    var body: some View {
        VStack(spacing: 24) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color("systemPrimaryColor")))
                .scaleEffect(2.0)
            
            VStack(spacing: 8) {
                Text("Pensando na receita perfeita...")
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text("Combinando seus ingredientes com uma pitada\nde criatividade.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.horizontal, 24)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            // Simular o delay da IA e depois redirecionar para a tela de ingredientes
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                viewModel.navigationPath.append(CameraNavigationRoute.ingredients)
            }
        }
    }
}
