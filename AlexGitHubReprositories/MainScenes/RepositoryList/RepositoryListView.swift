//
//  RepositoryListView.swift

//
//  Created by Alex on 01/03/2024.
//

import SwiftUI
import AlexGitHubReprositoriesDbApi

struct RepositoryListView: View {
    @ObservedObject var viewModel: RepositoryListViewModel

    var body: some View {
        VStack {
            switch viewModel.state {
            case .idle:
                Color.clear.onAppear(perform: viewModel.loadData)
            case .loading:
                ActivityIndicator(isAnimating: .constant(true), style: .large)
            case .failed(let error):
                ErrorView(error: error, retryAction: viewModel.loadData)
            case .loaded(let data):
                loadedView(data: data)
            }
        }
        .navigationBarTitle(Text("Trending Projects"))
    }

    private func loadedView(data: GitHubRepositories) -> some View {
        List {
            Section(header: Text("GitHub").bold()
                        .modifier(PrimaryTextModifier())) {
                ForEach(data, id: \.self) { item in
                    NavigationLink {
                        RepositoryDetailsView(viewModel: RepositoryDetailsViewModel(model: item))
                    } label: {
                        itemView(item: item)
                    }
                    .listRowBackground(Color(.list))
                }
            }
        }
        .refreshable {
            viewModel.loadData()
        }
        .toolbar {
            Button("Reload") {
                viewModel.loadData()
            }
        }
        .accentColor(.black)
        .onAppear {
            UITableView.appearance().separatorColor = UIColor(.appPrimary)
        }
    }

    private func itemView(item: GitHubRepository) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(item.name?.uppercasingFirst ?? "")
                    .font(.body)
                    .bold()
                    .modifier(PrimaryTextModifier())
                Spacer()
                Text(item.language ?? "")
                    .font(.caption)
                    .bold()
                    .foregroundColor(Color(hex: item.languageColor ?? ""))
            }
            Text(item.gitHubRepositoryDescription ?? "")
                .font(.caption)
                .modifier(TernaryTextModifier())
            HStack {
                Text("Author: \(item.author ?? "")")
                    .font(.caption)
                    .modifier(TernaryTextModifier())
                Spacer()
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(Color.yellow)
                    Text("\(item.stars ?? 0)")
                        .font(.caption)
                        .bold()
                        .modifier(TernaryTextModifier())
                }
            }
        }
    }
}

// MARK: - Previews

struct RepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryListView(viewModel: RepositoryListViewModel())
            .preferredColorScheme(.light)

        RepositoryListView(viewModel: RepositoryListViewModel())
            .preferredColorScheme(.dark)
    }
}
