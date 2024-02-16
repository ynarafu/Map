//
//  ContentView.swift
//  MyMap
//
//  Created by 楢府佑 on 2023/07/03.
//

import SwiftUI

struct ContentView: View {
    @State var inputText: String = ""
    @State var displaySearchKey: String = ""
    @State var displayMapType: MapType = .standard
    
    var body: some View {
        VStack {
            // 入力欄
            TextField("キーワード", text:$inputText, prompt: Text("キーワードを入力してください"))
            // 入力完了時
                .onSubmit {
                    displaySearchKey = inputText
                }
                .padding()
            ZStack (alignment: .bottomTrailing){
                //マップ表示
                MapView(searchKey: displaySearchKey, mapType: displayMapType)
                
                Button {
                    if displayMapType == .standard{
                        displayMapType = .satelite
                    } else if displayMapType == .satelite {
                        displayMapType = .hybrid
                    } else {
                        displayMapType = .standard
                    }
                } label: {
                    Image(systemName: "map")
                        .resizable()
                        .frame(width: 35.0,height: 35.0)
                }

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
