//
//  ToastModifiers.swift
//
//
//  Created by Hariharan R S on 22/10/24.
//

import SwiftUI

@available(iOS 16.0, *)
struct ToastModifier: ViewModifier {
    @State private var message: String?
    @Binding private var isShowing: Bool
    
    init(message: String?, isShowing: Binding<Bool>) {
        self.message = message
        self._isShowing = isShowing
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            if isShowing {
                Toast(message: message)
                    .zIndex(1.0)
                    .onAppear(perform: { dismissToast() })
            }
        }
    }
    
    public func dismissToast() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.isShowing.toggle()
        }
    }
}
