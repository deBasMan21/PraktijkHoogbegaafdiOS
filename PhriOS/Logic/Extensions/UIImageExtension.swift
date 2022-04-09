//
//  UIViewExtension.swift
//  PhriOS
//
//  Created by Bas Buijsen on 09/04/2022.
//

import Foundation
import SwiftUI

extension UIImage {
  func cropped(boundingBox: CGRect, scale: CGFloat) -> UIImage? {
    let x = boundingBox.origin.x * scale
    let y = boundingBox.origin.y * scale
    let width = boundingBox.width * scale
    let height = boundingBox.height * scale

    let adjustedBoundingBox = CGRect(x: x, y: y, width: width, height: height)

    guard let cgImage = self.cgImage?.cropping(to: adjustedBoundingBox) else {
      print("UIImage.cropped: Couldn't create cropped image")
      return nil
    }

    return UIImage(cgImage: cgImage)
  }
}
