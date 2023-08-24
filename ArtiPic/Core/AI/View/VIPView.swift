//
//  VIPView.swift
//  ArtiPic
//
//  Created by Shuxin Weng on 8/23/23.
//

import SwiftUI
import PassKit

struct VIPView: View {
    @StateObject var paymentHandler = PaymentHandler()

    var body: some View {
        VStack {
            PaymentButton() {
                paymentHandler.presentPaymentAuthorizationViewController()
            }
        }
    }
}

class PaymentHandler: NSObject, ObservableObject, PKPaymentAuthorizationViewControllerDelegate {
    private var paymentRequest: PKPaymentRequest = {
        let request = PKPaymentRequest()
        request.merchantIdentifier = "merchant.com.shuxinweng.ArtiPic"
        request.supportedNetworks = [.masterCard, .visa]
        request.supportedCountries = ["US"]
        request.merchantCapabilities = .capability3DS
        request.countryCode = "US"
        request.currencyCode = "USD"
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "ArtiPic VIP", amount: NSDecimalNumber(decimalValue: 9.99))]
        return request
    }()

    func presentPaymentAuthorizationViewController() {
        let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
        controller?.delegate = self
        
        if let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            if let rootViewController = windowScene.windows.first?.rootViewController {
                rootViewController.present(controller!, animated: true, completion: nil)
            }
        }
    }

    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }

    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
    }
}

extension NSDecimalNumber {
    convenience init(decimalValue: Decimal) {
        self.init(decimal: decimalValue)
    }
}
