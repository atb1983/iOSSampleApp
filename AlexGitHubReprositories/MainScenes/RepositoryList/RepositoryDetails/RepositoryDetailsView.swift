//
//  RepositoryDetailsView.swift

//
//  Created by Alex on 01/03/2024.
//

import SwiftUI
import AlexGitHubReprositoriesDbApi

struct RepositoryDetailsView: View {
    
    @ObservedObject var viewModel: RepositoryDetailsViewModel
    
    var body: some View {
        ZStack {
            Color(.appSecondary)
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    headerView
                    descriptionView
                    authorView
                    builtInView
                    starsView
                    projectUrlView
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color(.list))
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
        .navigationBarTitle(Text("Details"))
    }
    
    var headerView: some View {
        HStack {
            AsyncImage(api: viewModel.api, url: viewModel.model.avatar) { image in
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(viewModel.model.name?.uppercasingFirst ?? "")
                    .font(.body)
                    .bold()
                    .foregroundColor(Color(hex: viewModel.model.languageColor ?? ""))
                Text(viewModel.model.language ?? "")
                    .font(.caption)
                    .bold()
                    .foregroundColor(Color(hex: viewModel.model.languageColor ?? ""))
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
    }
    
    @ViewBuilder
    var descriptionView: some View {
        Divider()
        Text("Description")
            .font(.subheadline)
            .bold()
            .modifier(TernaryTextModifier())
        Text(viewModel.model.gitHubRepositoryDescription ?? "")
            .font(.caption)
            .modifier(TernaryTextModifier())
    }

    @ViewBuilder
    var authorView: some View {
        Divider()
        Text("Author")
            .font(.subheadline)
            .bold()
            .modifier(TernaryTextModifier())
        Text(viewModel.model.author ?? "")
            .font(.caption)
            .modifier(TernaryTextModifier())
    }
    
    @ViewBuilder
    var builtInView: some View {
        Divider()
        Text("Built in")
            .font(.subheadline)
            .bold()
            .modifier(TernaryTextModifier())
        ScrollView(.horizontal) {
            HStack {
                ForEach(viewModel.model.builtBy ?? [], id: \.self) { builtBy in
                    VStack {
                        AsyncImage(api: viewModel.api, url: builtBy.avatar) { image in
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        .frame(width: 25, height: 25)
                        .clipShape(Circle())
                        Text(builtBy.username ?? "")
                            .font(.caption)
                            .lineLimit(1)
                    }

                }
            }
        }
    }
    
    @ViewBuilder
    var starsView: some View {
        Divider()
        Group {
            starView(label: "Stars:", value: viewModel.model.stars ?? 0)
            starView(label: "Current Period Stars:", value: viewModel.model.currentPeriodStars ?? 0)
            starView(label: "Forks: ", value: viewModel.model.forks ?? 0, color: .blue)
        }
    }
    
    private func starView(label: String, value: Int, color: Color = .yellow) -> some View {
        HStack {
            Text(label)
                .font(.caption)
                .bold()
                .modifier(TernaryTextModifier())
            Image(systemName: "star.fill")
                .foregroundColor(color)
            Text("\(value)")
                .font(.caption)
                .bold()
                .modifier(PrimaryTextModifier())
        }
    }
   
    @ViewBuilder
    var projectUrlView: some View {
        Divider()
        Button {
            viewModel.onOpenRepository()
        } label: {
            Text(viewModel.model.url ?? "")
                .underline()
        }
        .buttonStyle(HoverButtonStyle())
    }
}

struct RepositoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryDetailsView(viewModel: RepositoryDetailsViewModel(model: .sample))
            .preferredColorScheme(.light)
        
        RepositoryDetailsView(viewModel: RepositoryDetailsViewModel(model: .sample))
            .preferredColorScheme(.dark)
    }
}
