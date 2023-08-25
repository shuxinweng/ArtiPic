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
        VStack {
            if paymentHandler.isPaymentSuccess {
                AIView()
            } else {
                PaymentButton() {
                    paymentHandler.presentPaymentAuthorizationViewController()
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
