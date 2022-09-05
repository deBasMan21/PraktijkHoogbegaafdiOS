//
//  ConsentView.swift
//  PhriOS
//
//  Created by Bas Buijsen on 05/09/2022.
//

import SwiftUI

struct ConsentView: View {
    @Binding var hasConsent: Bool
    @State var showAlert: Bool = false
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Image("Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.top, 25)
                    
                    Text(.init(ONBOARDING_CONSENT))
                }.padding()
            }
            
            Spacer()
            
            HStack {
                Button("Decline", action: {
                    showAlert = true
                })
                
                Spacer()
                
                Button("Accept", action: {
                    hasConsent = true
                })
            }.padding(.horizontal, 25)
                .padding(.vertical, 10)
        }.alert("Zonder toestemming kan de app niet werken. Als je geen toestemming wilt geven kun je de app niet gebruiken helaas. Neem voor eventuele vragen contact op met je begeleidster of de praktijk via de website.", isPresented: $showAlert) {
            Button("Oke", action: {
                showAlert = false
            })
        }
    }
}
