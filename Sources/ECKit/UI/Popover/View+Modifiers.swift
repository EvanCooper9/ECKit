//
//  View+Modifiers.swift
//  Popovers
//
//  Copyright © 2021 PSPDFKit GmbH. All rights reserved.
//

import SwiftUI

extension View {
    public func alwaysPopover<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        modifier(AlwaysPopoverModifier(isPresented: isPresented, content: content))
    }
}
