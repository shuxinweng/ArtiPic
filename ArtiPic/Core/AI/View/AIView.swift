//
//  AIView.swift
//  ArtiPic
//
//  Created by Dream K on 8/13/23.
//

import SwiftUI
import OpenAIKit
import FirebaseFirestore
import FirebaseStorage

struct AIView: View {
    @StateObject var AIModel = AIViewModel()
    
    @State var text = ""
    @State var keyword = "Other"
    let options = ["People", "Plant", "Photos", "Other"]
    
    @State var image: UIImage?
    @State var retrievedImages = [UIImage]()
    @State var isImageGenerated = false
   
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250, height: 250)
                }
                else {
                    Text("Please enter Keyword and Prompt to generate image")
                        .fontWeight(.black)
                        .foregroundColor(Color(.systemBrown))
                }


                if isImageGenerated {
                    Button {
                        Task{
                            try await AIModel.uploadPhoto(keyword: keyword, prompt: text)
                            text = ""
                            keyword = "Other"
                        }
                    } label: {
                        Text("Upload photo")
                    }
                }
                
                Spacer()
                
                
                HStack {
                    Text("Keyword: ")
                        .fontWeight(.black)
                        .foregroundColor(Color(.systemBrown))

                    Picker(selection: $keyword, label: Text("Select Keyword")) {
                        ForEach(options, id: \.self) { keyword in
                            Text(keyword).tag(keyword)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.horizontal, 24)
                    .background(
                        RoundedRectangle(cornerRadius: 7)
                            .fill(Color.white)
                            .shadow(radius: 3)
                    )
                }
                
                TextField("Enter Image Prompt", text: $text)
                    .modifier(TextFieldModifier())
                    .fontWeight(.black)
                
                Button("Generate") {
                    if !text.trimmingCharacters(in: .whitespaces).isEmpty {
                        Task {
                            let result = await AIModel.generateImage(prompt: text)
                            if result == nil {
                                print("Failed to get image")
                            }
                            self.image = result
                            self.isImageGenerated = true
                        }
                    }
                }
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(width: 200, height: 40)
                .background(Color(.systemBrown))
                .cornerRadius(7)
            }
            .navigationTitle("ArtiPic")
            .onAppear {
                AIModel.setup()
            }
            .padding()
        }
    }
    
}

struct AIView_Previews: PreviewProvider {
    static var previews: some View {
        AIView()
    }
}
