//
//  ContentView.swift
//  TextVoiceIOS
//
//  Created by amministratore on 30/04/2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var transcriber = audioTranscribe()
    @State var isImporting = false
   
    var body: some View {
        VStack{
            ScrollView{
                TextEditor(text: $transcriber.finalString).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    .lineLimit(nil)
                    .border(Color.blue)
                    .padding()
            }
            Spacer()
            Button(action: {isImporting = true}, label: {
                Text("Import").foregroundColor(.blue)
            })
        }
        .fileImporter(isPresented: $isImporting, allowedContentTypes: [.audio], allowsMultipleSelection: false) { result in
            do{
                guard let url = try result.get().first else {return}
                transcriber.transcribe(url: url)
                isImporting = false
            }
            catch{
                print(error.localizedDescription)
            }
        }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(audioTranscribe())
    }
}
