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
                                            (AnyView(OnboardingViewNotifications()), Color(PHR_ORANGE)),
                                            (AnyView(OnboardingViewEntering()), Color(PHR_PURPLE)),
                                            (AnyView(OnboardingViewShare()), Color(PHR_ORANGE))
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
            Image("bell")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 75, height: 100)
                .padding()
            
            Text("Notificaties")
                .foregroundColor(.white)
                .bold()
            
            Text(ONBOARDING_NOTIFICATIONS)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 50)
                .padding()
        }
        
    }
}

struct OnboardingViewEntering: View {
    var body: some View {
        VStack{
            Image("edit")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 75, height: 100)
                .padding()
            
            Text("Scores invullen")
                .foregroundColor(.white)
                .bold()
            
            Text(ONBOARDING_SCORES)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 50)
                .padding()
        }
        
    }
}

struct OnboardingViewShare: View {
    
    var body: some View {
        VStack{
            Image("share")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 75, height: 100)
                .padding()
            
            Text("Delen")
                .foregroundColor(.white)
                .bold()
            
            Text(ONBOARDING_SHARE)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 50)
                .padding()
        }
        
    }
}
