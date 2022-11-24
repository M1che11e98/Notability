//
//  Color.swift
//  Notability
//
//  Created by Marta Michelle Caliendo on 21/11/22.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

extension Color {

    var components: (r: Double, g: Double, b: Double, a: Double) {
        
        #if canImport(UIKit)
        typealias NativeColor = UIColor
        #elseif canImport(AppKit)
        typealias NativeColor = NSColor
        #endif
        
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        guard NativeColor(self).getRed(&r, green: &g, blue: &b, alpha: &a) else { return (0,0,0,0) }
        
        return (Double(r), Double(g), Double(b), Double(a))
    }
}
