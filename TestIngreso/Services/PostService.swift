import Foundation

// Función para obtener los datos de la API
func fetchPostData(for userId: Int, completion: @escaping ([Post]) -> Void) {
    
    // Construir la URL para obtener los datos de la API usando el ID del usuario
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts?userId=\(userId)") else {
        completion([])
        return
    }
    
    // Crear una tarea de datos para la solicitud
    URLSession.shared.dataTask(with: url) { data, _, error in
        if let error = error {
            // En caso de error, imprimir el mensaje de error y llamar al bloque de finalización con un array vacío
            print("Error fetching data: \(error.localizedDescription)")
            completion([])
            return
        }
        
        if let data = data {
            do {
                // Intentar decodificar los datos en formato JSON a un array de posts
                let posts = try JSONDecoder().decode([Post].self, from: data)
                completion(posts)
            } catch {
                // En caso de error al decodificar, imprimir el mensaje de error y llamar al bloque de finalización con un array vacío
                print("Error decoding data: \(error.localizedDescription)")
                completion([])
            }
        } else {
            completion([])
        }
    }.resume()
}
