//
//  ToastModifier.swift
//  ZToast
//
//  Created by Hariharan R S on 07/06/24.
//

import SwiftUI

@available(iOS 17.0, *)
extension View {
    
    public func showToast(message: Binding<String>, isShowing: Binding<Bool>, axis: ToastAxis = .top) -> some View {
        modifier(ToastModifier(message: message, isShowing: isShowing, axis))
    }
}
