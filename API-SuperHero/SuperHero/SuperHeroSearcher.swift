//
//  SuperHeroSearcher.swift
//  IOS
//
//  Created by Eichan Nakagawa on 01/07/2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct SuperHeroSearcher: View {
    @State var superheroname: String = ""
    @State var wrapper: ApiNetwork.Wrapper? = nil
    @State var loading:Bool = false
    var body: some View {
        VStack {
            TextField("",text: $superheroname,prompt: Text("Superman...").font(.title2).bold().foregroundColor(.gray))
                .font(.title2)
                .bold()
                .foregroundColor(.white)
                .padding(16)
                .border(.purple,width: 1.5)
                .autocorrectionDisabled()
                .onSubmit {
                    loading = true
                    print(superheroname)
                    Task {
                        do {
                            wrapper = try await ApiNetwork().getHeroByQuery(query: superheroname)
                            
                        }catch {
                            print("Error")
                        }
                        loading = false
                    }
                }
            
            if loading {
                ProgressView().tint(.white)
            }
            NavigationStack{
                List (wrapper?.results ?? []){superhero in
                    ZStack {
                        SuperHeroItem(superhero: superhero)
                        NavigationLink(destination:
                                        SuperheroDetail(id: superhero.id)){EmptyView()}.opacity(0)
                    }.listRowBackground(Color.backgroundApp)
                }.listStyle(.plain)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity).background(.backgroundApp)
        
    }
}


struct SuperHeroItem:View {
    let superhero: ApiNetwork.SuperHero
    var body: some View {
        ZStack{
            Rectangle()
            WebImage (url: URL(string: superhero.image.url))
                .resizable()
                .indicator(.activity)
                .scaledToFill()
                .frame(height: 200)
            
            VStack{
                Spacer()
                Text(superhero.name).foregroundColor(.white)
                    .font(.title)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.white.opacity(0.5))
            }.listStyle(.plain)
        }.frame(height: 200).cornerRadius(32)
        
    }
}
#Preview {
    SuperHeroSearcher()
}

