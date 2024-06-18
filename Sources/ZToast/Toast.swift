//
//  Toast.swift
//  ZToast
//
//  Created by Hariharan R S on 07/06/24.
//

import SwiftUI

public enum ToastAxis {
    case top, bottom
}

@available(iOS 17.0, *)
fileprivate struct Toast: View {
    @Binding private var message: String
    @State private var presentToast: Bool = false
    private var axis: ToastAxis
    
    init(message: Binding<String>, axis: ToastAxis) {
        self._message = message
        self.axis = axis
    }
    
    public var body: some View {
        GeometryReader(content: { geometry in
            if presentToast {
                ZStack {
                    HStack(spacing: 6) {
                        Image(uiImage: getCurrentAppIcon())
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 26, height: 26)
                            .clipShape(Circle())
                        
                        Text(message)
                            .lineLimit(1)
                            .font(.footnote)
                            .frame(height: 40)
                    }
                    .padding(.horizontal, 8)
                    .background(Color(uiColor: .secondarySystemBackground))
                    .clipShape(Capsule())
                    .frame(minWidth: 0,
                           maxWidth: min(geometry.size.width * 0.7, messageWidth + 50),
                           idealHeight: 40)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: axis == .top ? .top : .bottom)
                .animation(.spring, value: presentToast)
                .transition(.move(edge: axis == .top ? .top : .bottom).combined(with: .opacity))
            }
        })
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
    
    private func getCurrentAppIcon() -> UIImage {
        guard let iconsDictionary = Bundle.main.infoDictionary?["CFBundleIcons"] as? [String: Any],
              let primaryIconsDictionary = iconsDictionary["CFBundlePrimaryIcon"] as? [String: Any],
              let iconFiles = primaryIconsDictionary["CFBundleIconFiles"] as? [String],
              let lastIcon = iconFiles.last,
              let icon = UIImage(named: lastIcon) else {
            return UIImage()
        }
        return icon
    }
    
    private var messageWidth: CGFloat {
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: UIFont.systemFontSize)]
        return (message as NSString).size(withAttributes: attributes).width
    }
}

@available(iOS 17.0, *)
public struct ToastModifier: ViewModifier {
    @Binding var message: String
    @Binding var isShowing: Bool
    private let toast: Toast
    private let axis: ToastAxis
    
    init(message: Binding<String>, isShowing: Binding<Bool>, _ axis: ToastAxis) {
        self._message = message
        self._isShowing = isShowing
        self.axis = axis
        self.toast = Toast(message: message, axis: axis)
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            if isShowing {
                toast
                    .zIndex(1.0)
                    .onAppear(perform: {
                        dismissToast()
                    })
            }
        }
    }
    
    public func dismissToast() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.isShowing.toggle()
        }
    }
}
