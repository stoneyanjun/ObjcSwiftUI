//
//  Remote.swift
//  ImageLoading
//
//  Created by stone on 2022/7/14.
//

import SwiftUI

struct LoadError: Error {}

final class Remote<T>: ObservableObject {
    @Published var result: Result<T, Error>? = nil
    var value: T? { try? result?.get() }
    
    let url: URL
    let transform: (Data) -> T?
    
    init(_ url: URL, transform: @escaping (Data) -> T?) {
        self.url = url
        self.transform = transform
    }
    
    func load() {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                if let d = data, let v = self.transform(d) {
                    self.result = .success(v)
                } else {
                    self.result = .failure(LoadError())
                }
            }
        }.resume()
    }
}
