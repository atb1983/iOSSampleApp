//
//  AsyncImage.swift
//
//  Created by Alex on 01/03/2024.
//

import SwiftUI
import AlexGitHubReprositoriesDbApi

public struct AsyncImage<Placeholder: View, Content: View>: View {
    private let url: String?
    private let placeholder: Placeholder?
    private let imageView: (UIImage) -> Content
    
    @ObservedObject private var loader: ImageLoader
    
    public init(api: GitHubRepositoriesDBApi = GitHubRepositoriesDBApi(),
                url: String?,
                @ViewBuilder placeholder: () -> Placeholder?,
                @ViewBuilder imageView: @escaping (UIImage) -> Content) {
        self.url = url
        self.placeholder = placeholder()
        self.imageView = imageView
        self.loader = ImageLoader(api: api, urlString: url)
    }
}

public extension AsyncImage where Placeholder == EmptyView {
    init(api: GitHubRepositoriesDBApi = GitHubRepositoriesDBApi(),
         url: String?,
         @ViewBuilder imageView: @escaping (UIImage) -> Content) {
        self.init(api: api, url: url, placeholder: { EmptyView() }, imageView: imageView)
    }
}

extension AsyncImage {
    @ViewBuilder
    public var body: some View {
        if let imageData = loader.data,
           let uiImage = UIImage(data: imageData) {
            self.imageView(uiImage)
        } else {
            self.placeholder
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var data: Data?
    
    init(api: GitHubRepositoriesDBApi = GitHubRepositoriesDBApi(), urlString: String?) {
        guard let urlString = urlString else { return }
                
        Task {
            if let result = try? await api.getImage(url: urlString) {
                await MainActor.run {
                    self.data = result
                }
            }
        }
    }
}
