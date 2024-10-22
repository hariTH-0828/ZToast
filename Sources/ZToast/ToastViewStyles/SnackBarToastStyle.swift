//
//  SnackBarToastStyle.swift
//
//
//  Created by Hariharan R S on 22/10/24.
//

import SwiftUI

public struct SnackBarToastStyle: ToastViewStyle {
    public func makeBody(message: String?) -> some View {
        ZStack {
            HStack {
                Text(message ?? "")
                    .foregroundStyle(.background)
                    .lineLimit(1)
                    .font(.footnote)
                    .frame(height: 40)
                
                Spacer()
                
                Button(action: {}, label: {
                    Text("Dismiss")
                        .foregroundStyle(.background)
                        .font(.footnote)
                })
            }
            .padding(.horizontal)
            .background(
                Rectangle()
                    .fill(.indigo)
            )
        }
    }
}
