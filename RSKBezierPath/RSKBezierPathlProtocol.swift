//
// RSKBezierPathProtocol.swift
//
// Copyright (c) 2021 R.SK Lab Ltd. All Rights Reserved.
//
// Licensed under the RPL-1.5 and R.SK Lab Professional licenses
// (the "Licenses"); you may not use this work except in compliance
// with the Licenses. You may obtain a copy of the Licenses in
// the LICENSE_RPL and LICENSE_RSK_LAB_PROFESSIONAL files.
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the Licenses is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
// either express or implied.
//

import CoreGraphics
import UIKit

/// The protocol to be adopted by a type of object that represents a Bézier path.
public protocol RSKBezierPathProtocol {
    
    // MARK: - Public Properties
    
    /// The Core Graphics representation of the Bézier path.
    var cgPath: CGPath { get set }
    
    // MARK: - Public Initializers
    
    ///
    /// Initializes and returns a new `RSKBezierPath` object with the contents of a Core Graphics path.
    ///
    /// - Parameters:
    ///     - cgPath: The Core Graphics path from which to obtain the initial path information.
    ///
    init(cgPath: CGPath)
    
    ///
    /// Initializes and returns a new `RSKBezierPath` object with a rectangular path rounded at the specified corners and with the specified corner radii.
    ///
    /// - Parameters:
    ///     - rect: The rectangle that defines the basic shape of the path.
    ///     - cornerRadii: The dictionary with bitmask values that identifies the corners that you want to round as keys and radii of each corner oval as values.
    ///
    init(rect: CGRect, cornerRadii: [UIRectCorner: CGFloat])
}

public extension RSKBezierPathProtocol {
    
    // MARK: - Public Initializers
    
    init(rect: CGRect, cornerRadii: [UIRectCorner: CGFloat]) {
        
        func cornerRadius(for rectCorner: UIRectCorner) -> CGFloat? {
            
            guard let cornerRadius = cornerRadii.first(where: { (key, _) -> Bool in
                
                key.contains(rectCorner)
                
            })?.value else {
                
                return nil
            }
            return min(cornerRadius,
                       min(rect.width / 2.0,
                           rect.height / 2.0))
        }
        
        let cgMutablePath = CGMutablePath()
        
        if let cornerRadius = cornerRadius(for: .topLeft) {
            
            let toPoint = CGPoint(x: rect.minX + cornerRadius,
                                  y: rect.minY)
            cgMutablePath.move(to: toPoint)
        }
        else {
            
            let toPoint = rect.origin
            cgMutablePath.move(to: toPoint)
        }
        
        if let cornerRadius = cornerRadius(for: .topRight) {
            
            var toPoint = CGPoint(x: rect.maxX - cornerRadius,
                                  y: rect.minY)
            cgMutablePath.addLine(to: toPoint)
            
            toPoint = CGPoint(x: rect.maxX,
                              y: rect.minY + cornerRadius)
            let center = CGPoint(x: rect.maxX - cornerRadius,
                                 y: rect.minY + cornerRadius)
            cgMutablePath.addArc(center: center,
                               radius: cornerRadius,
                               startAngle: -.pi/2.0,
                               endAngle: 0.0,
                               clockwise: false)
        }
        else {
            
            let toPoint = CGPoint(x: rect.maxX,
                                  y: rect.minY)
            cgMutablePath.addLine(to: toPoint)
        }

        
        if let cornerRadius = cornerRadius(for: .bottomRight) {

            var toPoint = CGPoint(x: rect.maxX,
                                  y: rect.maxY - cornerRadius)
            cgMutablePath.addLine(to: toPoint)
            
            toPoint = CGPoint(x: rect.maxX - cornerRadius,
                              y: rect.maxY)
            let center = CGPoint(x: rect.maxX - cornerRadius,
                                 y: rect.maxY - cornerRadius)
            cgMutablePath.addArc(center: center,
                               radius: cornerRadius,
                               startAngle: 0.0,
                               endAngle: .pi/2.0,
                               clockwise: false)
        }
        else {
            
            let toPoint = CGPoint(x: rect.maxX,
                                  y: rect.maxY)
            cgMutablePath.addLine(to: toPoint)
        }

        if let cornerRadius = cornerRadius(for: .bottomLeft) {
            
            var toPoint = CGPoint(x: rect.minX + cornerRadius,
                                  y: rect.maxY)
            cgMutablePath.addLine(to: toPoint)
            
            toPoint = CGPoint(x: rect.minX,
                              y: rect.maxY - cornerRadius)
            let center = CGPoint(x: rect.minX + cornerRadius,
                                 y: rect.maxY - cornerRadius)
            cgMutablePath.addArc(center: center,
                               radius: cornerRadius,
                               startAngle: .pi/2.0,
                               endAngle: .pi,
                               clockwise: false)
        }
        else {
            
            let toPoint = CGPoint(x: rect.minX,
                                  y: rect.maxY)
            cgMutablePath.addLine(to: toPoint)
        }

        if let cornerRadius = cornerRadius(for: .topLeft) {

            var toPoint = CGPoint(x: rect.minX,
                                  y: rect.minY + cornerRadius)
            cgMutablePath.addLine(to: toPoint)
            
            toPoint = CGPoint(x: rect.minX + cornerRadius,
                              y: rect.minY)
            let center = CGPoint(x: rect.minX + cornerRadius,
                                 y: rect.minY + cornerRadius)
            cgMutablePath.addArc(center: center,
                               radius: cornerRadius,
                               startAngle: .pi,
                               endAngle: -.pi / 2.0,
                               clockwise: false)
        }
        else {
            
            let toPoint = CGPoint(x: rect.minX,
                                  y: rect.minY)
            cgMutablePath.addLine(to: toPoint)
        }
        
        self.init(cgPath: cgMutablePath)
    }
}
