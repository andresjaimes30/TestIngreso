import Foundation

// Función para obtener los usuarios mediante una solicitud de red
func fetchUsers(completion: @escaping ([Users]?, Error?) -> Void) {
    // Construir la URL completa para la solicitud de usuarios
    let baseURLString = "https://jsonplaceholder.typicode.com"
    let endpoint = "/users"
    let urlString = baseURLString + endpoint
    
    // Verificar y crear la URL
    guard let url = URL(string: urlString) else {
        completion(nil, NSError(domain: "InvalidURL", code: -1, userInfo: nil))
        return
    }
    
    let session = URLSession.shared
    // Crear la tarea de datos para la solicitud de usuarios
    let task = session.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(nil, error)
            return
        }
        
        // Verificar si hay datos recibidos
        guard let data = data else {
            completion(nil, NSError(domain: "NoData", code: -1, userInfo: nil))
            return
        }
        
        do {
            // Intentar decodificar los usuarios desde los datos recibidos
            let users = try JSONDecoder().decode([Users].self, from: data)
            completion(users, nil)
        } catch {
            completion(nil, error)
        }
    }

    task.resume()
}
