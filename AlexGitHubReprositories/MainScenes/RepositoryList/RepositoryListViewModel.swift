//
//  RepositoryListViewModel.swift

//
//  Created by Alex on 01/03/2024.
//

import SwiftUI
import AlexGitHubReprositoriesDbApi

class RepositoryListViewModel: ObservableObject {
    enum State: Equatable {
        static func == (lhs: RepositoryListViewModel.State, rhs: RepositoryListViewModel.State) -> Bool {
              switch (lhs, rhs) {
              case (.idle, .idle):
                  return true
              case (.loading, .loading):
                  return true
              case let (.failed(lhsError), .failed(rhsError)):
                  return lhsError.localizedDescription == rhsError.localizedDescription
              case let (.loaded(lhsData), .loaded(rhsData)):
                  return lhsData == rhsData
              default:
                  return false
              }
          }
        
        case idle
        case loading
        case failed(Error)
        case loaded(GitHubRepositories)
    }
    
    @Published private(set) var state = State.idle
    
    private let api: GitHubRepositoriesDBApi
            
    init(api: GitHubRepositoriesDBApi = GitHubRepositoriesDBApi()) {
        self.api = api
    }
    
    @MainActor
    func loadData() {
        state = .loading
        
        Task {
            do {
                let data = try await api.getTrendingRepositories()
                state = .loaded(data)
            } catch {
                state = .failed(error)
            }
        }
    }
}
