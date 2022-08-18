//
//  ViewExtensino.swift
//  PhriOS
//
//  Created by Bas Buijsen on 20/05/2022.
//

import Foundation
import SwiftUI

extension View {
    func snapshot(geo: GeometryProxy) -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let rect = CGRect(x: .zero, y: .zero, width: geo.size.width, height: geo.size.height)
        view?.bounds = rect
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: CGSize(width: geo.size.width, height: geo.size.height))

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
