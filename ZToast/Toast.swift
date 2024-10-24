//
//  Toast.swift
//  ZToast
//
//  Created by Hariharan R S on 07/06/24.
//

import SwiftUI

@available(iOS 16.0, *)
struct Toast: View {
    @Environment(\.ToastStyle) private var toastStyle
    @State private var presentToast: Bool = false
    
    let message: String?
    
    init(message: String?) {
        self.message = message
    }
    
    public var body: some View {
        ZStack {
            if presentToast {
                ZStack {
                    toastStyle.makeBody(message: message)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, 20)
                .animation(.spring, value: presentToast)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .onAppear(perform: {
            togglePresentToast()
            toggleDismissToast()
        })
    }
    
    private func togglePresentToast() {
        withAnimation(.spring) {
            self.presentToast.toggle()
        }
    }
    
    private func toggleDismissToast() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.spring(duration: 3.0)) {
                self.presentToast.toggle()
            }
        }
    }
}
