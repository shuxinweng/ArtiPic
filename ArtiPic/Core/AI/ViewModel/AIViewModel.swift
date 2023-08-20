//
//  AIViewModel.swift
//  ArtiPic
//
//  Created by Shuxin Weng on 8/20/23.
//

import Foundation
import OpenAIKit
import SwiftUI

class AIViewModel: ObservableObject {
    private var openai: OpenAI?
    
    func setup() {
        guard let apiKey = ProcessInfo.processInfo.environment["OPENAI_API_KEY"] else {
            fatalError("Missing OPENAI_API_KEY environment variable")
        }
        
        openai = OpenAI(Configuration(
            organizationId: "Personal",
            apiKey: apiKey
        ))
    }
    
    func generateImage(prompt: String) async -> UIImage? {
        guard let openai = openai else {
            return nil
        }
        
        do {
            let params = ImageParameters(
                prompt: prompt,
                resolution: .medium,
                responseFormat: .base64Json
            )
            let result = try await openai.createImage(parameters: params)
            let data = result.data[0].image
            let image = try openai.decodeBase64Image(data)
            return image
        }
        catch {
            print(String(describing: error))
            return nil
        }
    }
}
