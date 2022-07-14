//
//  PhotoView.swift
//  ImageLoading
//
//  Created by stone on 2022/7/14.
//

import SwiftUI

struct PhotoView: View {
    @ObservedObject var image: Remote<UIImage>
    let url: URL
    let aspectRatio: CGFloat
    
    init(_ url: URL, aspectRatio: CGFloat) {
        self.url = url
        self.aspectRatio = aspectRatio
        image = Remote(url, transform: {
            UIImage(data: $0)
        })
    }
    
    var placeHolderImage: Image {
        image.value.map {
            Image.init(uiImage: $0)
        } ?? Image(systemName: "photo")
    }
     
    var body: some View {
        placeHolderImage
            .resizable()
            .foregroundColor(.secondary)
            .aspectRatio(aspectRatio, contentMode: .fit)
            .padding()
            .onAppear() { image.load() }
            
    }
}
