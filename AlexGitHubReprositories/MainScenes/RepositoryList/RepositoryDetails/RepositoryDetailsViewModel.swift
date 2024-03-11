//
//  RepositoryDetailsViewModel.swift

//
//  Created by Alex on 01/03/2024.
//

import SwiftUI
import AlexGitHubReprositoriesDbApi

class RepositoryDetailsViewModel: ObservableObject {
    let api: GitHubRepositoriesDBApi
    let model: GitHubRepository
    private let appUtils: AppUtilsProtocol
    
    @Published var avatar: Data?
    
    init(api: GitHubRepositoriesDBApi = GitHubRepositoriesDBApi(), appUtils: AppUtilsProtocol = AppUtils(), model: GitHubRepository) {
        self.api = api
        self.appUtils = appUtils
        self.model = model
    }
    
    @discardableResult
    func onOpenRepository() -> Bool {
        guard let url = model.url else {
            return false
        }
        
        return appUtils.open(urlString: url)
    }
}
