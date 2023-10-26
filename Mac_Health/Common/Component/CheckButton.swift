//
//  CheckButton.swift
//  Mac_Health
//
//  Created by 송재훈 on 2023/10/22.
//

import SwiftUI

struct CheckButton: View {
    var body: some View {
        Ellipse()
            .frame(width: UIScreen.getWidth(36), height: UIScreen.getHeight(36))
            .foregroundColor(.green_10)
            .overlay {
                Image(systemName: "checkmark")
                    .bold()
                    .foregroundColor(.green_main)
            }
    }
}

struct CheckButton_Previews: PreviewProvider {
    static var previews: some View {
        CheckButton()
    }
}