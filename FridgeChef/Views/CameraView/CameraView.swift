import SwiftUI

struct CameraView: View {
    var body: some View {
        VStack {
            HStack {
                Text("FridgeChef")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.top, 40)
            .padding(.horizontal, 24)
            
            Spacer(minLength: 40)
            
            VStack(spacing: 24) {
                VStack {
                    Image(systemName: "refrigerator")
                        .font(.system(size: 40))
                        .foregroundColor(Color("primaryColor"))
                }
                .frame(width: 100, height: 100)
                .background(Color("secondColor"))
                .cornerRadius(20)
                
                VStack(spacing: 12) {
                    Text("O que vamos cozinhar?")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Fotografe sua geladeira ou despensa\n(pode tirar mais de uma foto) e descubra\nreceitas feitas para você.")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.horizontal, 24)
            
            Spacer(minLength: 40)
            
            VStack(spacing: 16) {
                ActionCardButton(
                    title: "Tirar foto",
                    iconName: "camera",
                    backgroundColor: Color("primaryColor"),
                    foregroundColor: .white
                ) {
                    print("Ação: Abrir câmera")
                }
                
                ActionCardButton(
                    title: "Escolher da galeria",
                    iconName: "photo.on.rectangle",
                    backgroundColor: Color("secondColor"),
                    foregroundColor: Color.primary
                ) {
                    print("Ação: Abrir galeria")
                }
            }
            .padding(.bottom, 20)
            .padding(.horizontal, 24)
            
        }
    }
}

#Preview {
    CameraView()
}
