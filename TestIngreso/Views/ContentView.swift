import SwiftUI

struct ContentView: View {
    @State private var users: [Users] = []
    @State private var searchText = ""
    @State private var selectedUserID: Int? // Propiedad para mantener el ID seleccionado
    
    var filteredUsers: [Users] {
        if searchText.isEmpty {
            return users
        } else {
            return users.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack {
            Text("Prueba de Inicio")
                .font(.title)
                .fontWeight(.ultraLight)
                .multilineTextAlignment(.center)
            NavigationView {
                List {
                    ForEach(filteredUsers, id: \.id) { user in
                        VStack(alignment: .leading) {
                            NavigationLink(destination: ListView(selectedUserID: $selectedUserID)) {
                                VStack(alignment: .leading) {
                                    Text("\(user.name)").font(.title)
                                    Text("Email: \(user.email)")
                                    Text("Phone: \(user.phone)")
                                    Text("ID: \(user.id)")
                                    Button(action: {
                                        selectedUserID = user.id // Actualizar el ID seleccionado en ContentView
                                    }) {
                                        Text("Más información")
                                            .multilineTextAlignment(.trailing)
                                    }
                                }
                            }
                            .buttonStyle(PlainButtonStyle()) // Evitar el resaltado del botón
                        }
                        .padding([.leading, .bottom, .trailing])
                    }
                    if filteredUsers.isEmpty {
                        Text("List is empty")
                            .font(.title)
                            .fontWeight(.ultraLight)
                            .foregroundColor(.gray)
                    }
                }
                .navigationTitle("Personas")
                .searchable(text: $searchText, placement: .automatic, prompt: "Buscar")
            }
        }
        .onAppear {
            fetchUsers { fetchedUsers, error in
                if let fetchedUsers = fetchedUsers {
                    DispatchQueue.main.async {
                        self.users = fetchedUsers
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

