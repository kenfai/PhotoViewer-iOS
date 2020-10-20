//
//  Model.swift
//  PhotoViewer
//
//  Created by Ginger on 20/10/2020.
//

import Foundation

struct Photo: Identifiable, Decodable {
    var id: String
    var alt_description: String?
    var urls: [String: String]
}

class UnsplashData: ObservableObject {
    @Published var photoArray: [Photo] = []
    
    init() {
        loadData()
        //loadJson()
    }
    
    func loadData() {
        let key = "Xn79ogP9VQzPxRbdhldcjlV4BPpdZZbza9WJUR9xlg4"
        let url = "https://api.unsplash.com/photos/random/?count=30&client_id=\(key)"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, response, error) in
            guard let data = data else {
                print("URLSession dataTask error:", error?.localizedDescription ?? "nil")
                return
            }

            do {
                let json = try JSONDecoder().decode([Photo].self, from: data)
                print(json)
                for photo in json {
                    DispatchQueue.main.async {
                        self.photoArray.append(photo)
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func loadJson()
    {
        let file = "unsplash.json"
        
        guard let url = Bundle.main.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle")
        }
        
        do {
            let json = try JSONDecoder().decode([Photo].self, from: data)
            print(json)
            for photo in json {
                DispatchQueue.main.async {
                    self.photoArray.append(photo)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
