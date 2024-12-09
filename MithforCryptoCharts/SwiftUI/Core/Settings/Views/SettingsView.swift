//
//  SettingsView.swift
//  MithforCryptoCharts
//
//  Created by Dmitriy Voronin on 09.12.2024.
//

import SwiftUI

struct SettingsView: View {

    let defaultURL = URL(string: "https://www.google.com")!
    let devoroninYouTubeURL = URL(string: "https://www.youtube.com/@dmitryvoronin9831")!
    let mithforGitHubURL = URL(string: "https://github.com/mithfor")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    let devoroninVKURL = URL(string: "https://vk.com/id10829634")!

    var body: some View {
        NavigationView {
            List {
                mithforCryptoCoinsSection
                coingeckoSection
                developerSection
                applicationSection
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton()
                }
            }
        }
    }
}

private extension SettingsView {
    var mithforCryptoCoinsSection: some View {
        Section(header: Text("Mithfor Crypto Coins")) {
            VStack(alignment: .leading) {
                Image("btc")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was made by following a @Swiftfull Thinking course on YouTube. It uses MVVM Architecture, Combine, and CoreData!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.primaryText)
            }
            .padding(.vertical)
            Link("Subscribe on YouTube 🎉" ,
                 destination: devoroninYouTubeURL)
            Link("and VK ☕️",
                 destination: devoroninVKURL)
        }
    }

    var coingeckoSection: some View {
        Section(header: Text("CoinGecko")) {
            VStack(alignment: .leading) {
                Image("btc")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("The cryptocurrency data that is used in this app comes from a free API form CoinGecko! Prices may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.primaryText)
            }
            .padding(.vertical)
            Link("Visit CoinGecko" ,
                 destination: coingeckoURL)

        }
    }

    var developerSection: some View {
        Section(header: Text("Developer")) {
            VStack(alignment: .leading) {
                Image("btc")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was developed by Dmitriy Voronin. It uses SwiftUI and is written 100% in Swift. Th eproject benefirs from multi-threading, publishers/subscribers/, and data persistance.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.primaryText)
            }
            .padding(.vertical)
            Link("Visit GitHub" ,
                 destination: mithforGitHubURL)

        }
    }

    private var applicationSection: some View {
        Section(header: Text("Application")) {
            Link("Terms of Service", destination: defaultURL)
            Link("Privacy Policy", destination: defaultURL)
            Link("Company Website", destination: defaultURL)
            Link("Learn more", destination: defaultURL)
        }

    }
}

#Preview {
    SettingsView()
}
