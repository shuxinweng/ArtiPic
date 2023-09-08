//
//  VIPView.swift
//  ArtiPic
//
//  Created by Shuxin Weng on 8/23/23.
//

import SwiftUI

struct VIPView: View {
    @StateObject var paymentHandler = PaymentHandler()

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                if paymentHandler.isPaymentSuccess {
                    AIView()
                } else {
                    VStack {
                        Image("artipic_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding(.top, 20)
                        
                        Text("Access to AI Generated Photos")
                            .font(.title)
                            .padding()
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .bold()
                        
                        Text("Reason to get the VIP")
                            .font(.title3)
                            .foregroundColor(.white)
                            .bold()
                        
                        HStack {
                            VStack {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(Color.red)
                                    .font(.largeTitle)
                                Text("Variety")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            VStack {
                                Image(systemName: "pencil.circle.fill")
                                    .foregroundColor(Color.yellow)
                                    .font(.largeTitle)
                                Text("Personalization")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            VStack {
                                Image(systemName: "person.fill")
                                    .foregroundColor(Color.green)
                                    .font(.largeTitle)
                                Text("Dynamic Content")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.vertical, 20)
                        
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            Text("New User Special!")
                                .font(.title2)
                                .padding()
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text("90% OFF")
                                .font(.title2)
                                .padding()
                                .foregroundColor(.white)
                            
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            
                            Text("Originally $99.99")
                                .font(.title2)
                                .padding(.bottom, 20)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text("NOW Only $9.99!!!")
                                .font(.title2)
                                .padding(.bottom, 20)
                                .foregroundColor(.white)
                            
                            Spacer()
                        }
                        
                        Spacer()
                        
                        Text("Upgrade to VIP Now!")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                        
                        Spacer()
                    }
                    
                    PaymentButton() {
                        paymentHandler.presentPaymentAuthorizationViewController()
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 360, height: 40)
                    .background(Color(.systemBrown))
                    .cornerRadius(7)
                    
                    Spacer()
                }
            }
        }
    }
}

struct VIPView_Previews: PreviewProvider {
    static var previews: some View {
        VIPView()
    }
}
