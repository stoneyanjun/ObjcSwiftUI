//
//  Photo.swift
//  ImageLoading
//
//  Created by stone on 2022/7/14.
//

import SwiftUI

struct Photo: Codable, Identifiable {
    var id: String
    var author: String
    var width, height: CGFloat
    var url, download_url: URL
}
