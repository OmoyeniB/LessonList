//
//  UIImageFetcher.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 11/01/2023.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct URLImage: View {
    let imageUrlString: String
    
    private let cache = NSCache<NSURL, UIImage>()
    
    @State private var isLoading = false
    @State private var image: UIImage?
    @State var data: Data?
    
    var body: some View {
        if let image = self.image {
            Image(uiImage: image)
                .resizable()
                .frame(width: 130, height: 70)
                .cornerRadius(10)
                .aspectRatio(contentMode: .fill)
                .background(Color.gray)
        } else {
            ZStack {
                Image(systemName: "video")
                    .frame(width: 130, height: 70)
                    .cornerRadius(10)
                    .background(Color.gray)
                    .onAppear {
                        self.downloadImage()
                    }
                if isLoading {
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                }
            }
        }
    }
    
    func downloadImage() {
        guard let url = URL(string: imageUrlString) else {
            return
        }

        if let cachedImage = cache.object(forKey: url as NSURL) {
            self.image = cachedImage
            return
        }

        self.isLoading = true
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                self.cache.setObject(image, forKey: url as NSURL)
                self.image = image
                self.isLoading = false
            }
        }
        task.resume()
    }
}
