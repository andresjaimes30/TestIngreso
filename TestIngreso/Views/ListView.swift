import SwiftUI

struct ListView: View {
    
    @Binding var selectedUserID: Int? // Binding para el ID del usuario seleccionado
    @State private var users: [Users] = [] // Propiedad de estado para almacenar la lista de usuarios

    var body: some View {
        VStack {
            // Verificar si hay un usuario seleccionado y si existe en la lista de usuarios
            
            if let selectedID = selectedUserID, let selectedUser = users.first(where: { $0.id == selectedID }) {
                VStack(alignment: .leading) {
                    
                    VStack(alignment: .leading)
                    {
                        // Mostrar información del usuario seleccionado
                        Text("\(selectedUser.name)").font(.title)
                        Text("Email: \(selectedUser.email)")
                        Text("Phone: \(selectedUser.phone)")
                    }
                    // Pasar el ID del usuario seleccionado a la vista `PostView`
                    PostView(userId: selectedUser.id)
                }
            } else {
                // Si no hay un usuario seleccionado o no se encuentra en la lista, mostrar un mensaje
                Text("User not found")
                    .font(.title)
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            // Al aparecer la vista, obtener la lista de usuarios
            fetchUsers { fetchedUsers, error in
                if let fetchedUsers = fetchedUsers {
                    DispatchQueue.main.async {
                        self.users = fetchedUsers // Actualizar la lista de usuarios en el estado
                    }
                }
            }
        }
    }
}

// Vista previa para la vista `ListView`
// Asigna un valor de prueba para el selectedUserID en la vista previa
#Preview {
    let selectedUserID: Binding<Int?> = .constant(nil)
    return ListView(selectedUserID: selectedUserID)
}

