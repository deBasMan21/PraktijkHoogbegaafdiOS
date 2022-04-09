//
//  GraphView.swift
//  PhriOS
//
//  Created by Bas Buijsen on 07/04/2022.
//

import SwiftUI

struct GraphView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        GraphChildView()
    }
}
