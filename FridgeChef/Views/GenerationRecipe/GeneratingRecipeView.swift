//
//  GeneratingRecipeView.swift
//  FridgeChef
//
//  Created by Maria Izabelle Holanda de Andrade on 06/08/26.
//

import SwiftUI

struct GeneratingRecipeView: View {

    @State private var currentMessage = 0
    @State private var animate = false
    @State private var progress: Double = 0.0

    private let messages = [
        ("camera.viewfinder", "Analisando seus ingredientes..."),
        ("leaf.fill", "Escolhendo a melhor combinação..."),
        ("fork.knife", "Criando uma receita personalizada..."),
        ("sparkles", "Finalizando sua receita...")
    ]

    var body: some View {

        VStack(spacing: 40) {

            Spacer()

            ZStack {

                Circle()
                    .fill(Color("secondColor"))
                    .frame(width: 170, height: 170)
                    .scaleEffect(animate ? 1.08 : 0.92)
                    .animation(
                        .easeInOut(duration: 1.2)
                        .repeatForever(autoreverses: true),
                        value: animate
                    )

                Image(systemName: messages[currentMessage].0)
                    .font(.system(size: 55))
                    .foregroundColor(Color("systemPrimaryColor"))
                    .symbolEffect(.pulse.byLayer)
            }

            VStack(spacing: 12) {

                Text("Preparando sua receita")
                    .font(.title2)
                    .fontWeight(.bold)

                Text(messages[currentMessage].1)
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .animation(.easeInOut(duration: 0.3), value: currentMessage)

            }

            ProgressView(value: progress, total: 100.0)
                .progressViewStyle(.linear)
                .padding(.horizontal, 40)
                .tint(Color("systemPrimaryColor"))

            Spacer()

        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .onAppear {

            animate = true

            // Timer para trocar as mensagens
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
                if currentMessage < messages.count - 1 {
                    currentMessage += 1
                } else {
                    timer.invalidate()
                }
            }
            
            // Timer para animar a barra de progresso suavemente
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                if progress < 95.0 {
                    progress += 0.5
                }
            }

        }
    }
}

#Preview {
    NavigationStack {
        GeneratingRecipeView()
    }
}
