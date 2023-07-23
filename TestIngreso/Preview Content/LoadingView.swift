import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            // Agrega aquí los elementos visuales que deseas mostrar durante la carga
            // Puedes usar un indicador de actividad (spinner), un logo de la aplicación, un mensaje de carga, etc.
            ProgressView("Loading...") // Un indicador de actividad con un mensaje de carga
                .progressViewStyle(CircularProgressViewStyle()) // Estilo de indicador circular
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white) // Color de fondo de la pantalla de carga (opcional)
    }
}

#Preview {
    LoadingView()
}
