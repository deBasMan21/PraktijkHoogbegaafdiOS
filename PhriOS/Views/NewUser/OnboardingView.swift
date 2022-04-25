//
//  TempView.swift
//  PhriOS
//
//  Created by Bas Buijsen on 25/04/2022.
//

import SwiftUI
import ConcentricOnboarding

struct OnboardingView: View {
    @Binding var isNew : Bool
    
    var body: some View{
        VStack{
            ConcentricOnboardingView(pageContents:
                                        [
                                            (AnyView(OnboardingViewNotifications()), .red),
                                            (AnyView(OnboardingViewEntering()), .green),
                                            (AnyView(OnboardingViewShare()), .blue)
                                        ]).insteadOfCyclingToFirstPage {
                                            withAnimation{
                                                isNew = false
                                            }
                                        }
        }
    }
}

struct OnboardingViewNotifications: View {
    var body: some View {
        VStack{
            Text("Notifications")
        }
        
    }
}

struct OnboardingViewEntering: View {
    var body: some View {
        VStack{
            Text("Scores invullen")
        }
        
    }
}

struct OnboardingViewShare: View {
    
    var body: some View {
        VStack{
            Text("Delen")
        }
        
    }
}
