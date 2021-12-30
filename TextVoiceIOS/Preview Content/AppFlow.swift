//
//  AppFlow.swift
//  TextVoiceIOS
//
//  Created by amministratore on 30/04/2021.
//
import Foundation
import Speech

class audioTranscribe: ObservableObject {
    private var contaAppend = 0
    private var segment = SFTranscriptionSegment()
    private var text : String = ""
    private var arrString : [String] = []
    @Published var finalString : String = ""

    
    
    
    func transcribe(url : URL) {
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                
                guard let recognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "it-IT")) else {return}
                
                let request = SFSpeechURLRecognitionRequest(url: url)
                request.shouldReportPartialResults = true
                
                if recognizer.supportsOnDeviceRecognition {
                    request.requiresOnDeviceRecognition = true
                }
                print("funziona")
                recognizer.recognitionTask(with: request) { (result, error) in
                    
                    if let error = error {
                        
                        print(error.localizedDescription)
                        
                    }else if let result = result {
                        
                        if result.isFinal {
                            print(self.arrString)
                            print("final")
                        }
                        
                        self.text = result.bestTranscription.formattedString
                        
                        if self.arrString.count == 0 {
                            
                            self.arrString.append(self.text)
                            
                        }else{
                            
                            self.arrString.remove(at: self.contaAppend)
                            self.arrString.append(self.text)

                        }
                        self.convertString()
                        
                    }else{
                        print("error undefined")
                    }
                }
                
            }
        }
        
    }
    
    func convertString() {
        if arrString.count == 1 {
            self.finalString = self.arrString[0]
        }else if arrString.count > 1 {
            for index in 1...self.arrString.count - 1 {
                self.finalString = self.finalString + self.arrString[index]
            }
            
        }
    }
}

    


