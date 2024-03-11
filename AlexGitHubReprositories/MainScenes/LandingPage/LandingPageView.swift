//
//  LandingPageView.swift

//
//  Created by Alex on 30/02/2024.
//

import SwiftUI

struct LandingPageView: View {
    
    @State private var buttonAnimationEnabled: Bool = false
    @State private var buttonAnimationOpacity: CGFloat = 0.5
    @State private var buttonAnimationScale: CGFloat = 1.0
        
    @ObservedObject var viewModel: LandingPageViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                middleView
                Spacer()
                bottomView
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .padding(24)
            .navigationBarItems(trailing: headerView)
            .background(Color(.appBackground))
                .edgesIgnoringSafeArea(.all)
        }
        .navigationViewStyle(.stack)
    }
    
    var headerView: some View {
        Button {
            viewModel.onGoToMainSite()
        } label: {
            Text("Go to GitHUB")
                .font(.body)
                .modifier(SecondaryTextModifier())
        }
        .buttonStyle(HoverButtonStyle())
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    var middleView: some View {
        VStack(spacing: 24) {
            Image(.gitHubLogo)
            Text("Welcome to iOS Test")
                .font(.title)
                .modifier(SecondaryTextModifier())
            Text("Enter the app and discover some GitHub repositories")
                .font(.caption)
                .modifier(SecondaryTextModifier())
        }
    }
    
    var bottomView: some View {
        VStack(spacing: 12) {
            NavigationLink(destination: RepositoryListView(viewModel: RepositoryListViewModel())) {
                Text("Enter the app")
                    .font(.headline)
                    .bold()
                    .modifier(SecondaryTextModifier())
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .background(Color(.appPrimary))
                .cornerRadius(12)
                .scaleEffect(buttonAnimationScale)
                .opacity(buttonAnimationOpacity)
                .onAppear()  {
                    // Fade in animation after 0.5 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation(.easeInOut(duration: 1)) {
                            buttonAnimationOpacity = 1
                        }
                    }

                    // Scale animation with repetition after 2 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.easeInOut(duration: 1).repeatCount(5, autoreverses: true)) {
                            buttonAnimationScale = 0.95
                        }
                    }
                }
            }
                        
            HStack {
                Button {
                    viewModel.onGoToPrivacy()
                } label: {
                    Text("Privacy policy")
                        .underline()
                        .modifier(HiperLinkTextModifier())
                }
                .buttonStyle(HoverButtonStyle())
                
                Text("and")
                    .modifier(HiperLinkTextModifier())
                
                Button {
                    viewModel.onGoToTermsOfUse()
                } label: {
                    Text("Terms of use")
                        .underline()
                        .modifier(HiperLinkTextModifier())
                }
                .buttonStyle(HoverButtonStyle())
            }
        }
    }
}
struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView(viewModel: LandingPageViewModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone 12"))
            .previewDisplayName("iPhone 12")
            .preferredColorScheme(.light)
        
        LandingPageView(viewModel: LandingPageViewModel())
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
            .previewDisplayName("iPhone 12 Pro Max")
            .preferredColorScheme(.dark)

    }
}
