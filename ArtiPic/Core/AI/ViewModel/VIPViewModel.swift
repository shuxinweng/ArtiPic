//
//  VIPViewModel.swift
//  ArtiPic
//
//  Created by Shuxin Weng on 8/24/23.
//

import Foundation
import PassKit
import FirebaseAuth
import FirebaseFirestore

class PaymentHandler: NSObject, ObservableObject, PKPaymentAuthorizationViewControllerDelegate {
    @Published var isPaymentViewControllerPresented = false
    
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
        
        if let currentUser = Auth.auth().currentUser {
            let currentUserID = currentUser.uid

            // Update the VIP status in Firestore
            let db = Firestore.firestore()
            let userRef = db.collection("users").document(currentUserID)
            userRef.updateData(["isVIP": true]) { error in
                if let error = error {
                    print("Error updating VIP status: \(error)")
                } else {
                    print("VIP status updated successfully")
                }
            }
        }
        
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
        isPaymentViewControllerPresented = true
    }
}

extension NSDecimalNumber {
    convenience init(decimalValue: Decimal) {
        self.init(decimal: decimalValue)
    }
}
