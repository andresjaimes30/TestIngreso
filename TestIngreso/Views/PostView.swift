import SwiftUI

struct PostView: View {
    let userId: Int // Aquí recibirás el ID del usuario seleccionado
    @State private var posts: [Post] = [] // Propiedad de estado para almacenar las publicaciones

    var body: some View {
        VStack {
            if posts.isEmpty {
                Text("Loading...") // Muestra "Loading..." si no hay publicaciones disponibles aún
            } else {
                List(posts, id: \.id) { post in
                    VStack(alignment: .leading) {
                        Text("Título: \(post.title)")
                            .font(.title)
                        Text("\(post.body)")
                            .font(.body)
                            .padding(.top)
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            // Al aparecer la vista, realiza una solicitud para obtener las publicaciones asociadas al usuario con el `userId`
            fetchPostData(for: userId) { fetchedPosts in
                DispatchQueue.main.async {
                    self.posts = fetchedPosts // Actualiza el estado con las publicaciones obtenidas
                }
            }
        }
    }
}


// Asigna un valor de prueba para el userId en la vista previa
// Aquí, se utiliza un `Binding<Int?>` para simular la selección de un usuario
#Preview {
    let selectedUserID: Binding<Int?> = .constant(1)
    return ListView(selectedUserID: selectedUserID)
}

