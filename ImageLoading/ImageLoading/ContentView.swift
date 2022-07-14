//
//  ContentView.swift
//  ImageLoading
//
//  Created by stone on 2022/7/14.
//

import SwiftUI

struct ContentView: View {
    @StateObject var photoList = Remote(URL(string: "https://picsum.photos/v2/list")!) { data in
        try? JSONDecoder().decode([Photo].self, from: data)
    }
    
    var body: some View {
        NavigationView {
            if let photos = photoList.value {
                List(photos) { photo in
                    NavigationLink(photo.author , destination: PhotoView(photo.download_url, aspectRatio: photo.width / photo.height))
                }
            } else {
                ProgressView()
                    .onAppear() { photoList.load() }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
