//
//  NewsDetailView.swift
//  iOS-Boilerplate
//
//  Created by Marcus Vinicius Palassi Sales on 15/06/25.
//

import SwiftUI

struct NewsDetailView: View {
    @Bindable var viewModel: NewsDetailViewModel
    @Environment(NavigationRouter.self) var router
    
    var body: some View {
        let article = viewModel.article
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: article.urlToImage ?? "")) { phase in
                if let image = phase.image {
                    image.resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .clipped()
                }
            }
            Text(article.title)
                .font(.title)
                .padding(4.0)
            Text(article.description ?? "")
                .font(.caption)
                .padding(EdgeInsets(top: 0.0, leading: 4.0, bottom: 0.0, trailing: 4.0))
            Text(article.content ?? "No content available")
                .font(.body)
                .padding(8.0)
            Text(article.author ?? "Unknown author")
                .font(.caption2)
                .padding(EdgeInsets(top: 0.0, leading: 8.0, bottom: 0.0, trailing: 8.0))
                .frame(alignment: .leading)
            Text("Published at \(article.formatPublishedDate(format: "dd MMM yyyy"))")
                .font(.caption2)
                .padding(EdgeInsets(top: 0.0, leading: 8.0, bottom: 0.0, trailing: 8.0))
                .frame(alignment: .leading)
            Button("Read more on \(article.source.name)") {
                // TODO
            }
            .padding(8.0)
            Button("Save for later") {
                // TODO
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button{
                    router.pop()
                } label: {
                    Image(systemName: "chevron.backward")
                    Text("News Detail")
                }
            }
        }
    }
}

#Preview {
    NewsDetailView(
        viewModel: NewsDetailViewModel(
            article: ArticleNews(
                author: "shrutishekar@gmail.com (Shruti Shekar)",
                title: "Android Central's Best of 2024: Apps and Services",
                description: "Here are all the winners for Best Apps and Services for 2024!",
                url: "https://www.androidcentral.com/apps-software/android-central-best-of-2024-apps-services",
                urlToImage: "https://cdn.mos.cms.futurecdn.net/kWGZ6wr2t9dDGdmZW7pLEP-1200-80.jpg",
                publishedAt: "2025-01-01T13:00:00Z",
                content: "There have been some stellar apps and services that were released this year and I can wholeheartedly agree with every single one of the winners on this list. \r\nI am a bit biased here, but I am a huge… [+4354 chars]",
                source: ArticleSource(
                    id: nil,
                    name: "Android Central"
                )
            )
        )
    )
}
