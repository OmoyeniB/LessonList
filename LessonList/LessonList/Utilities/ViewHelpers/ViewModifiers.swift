//
//  ViewModifiers.swift
//  LessonList
//
//  Created by Sharon Omoyeni Babatunde on 12/01/2023.
//
import SwiftUI

struct ListBackgroundModifier: ViewModifier {
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .scrollContentBackground(.hidden)
        } else {
            content
        }
    }
}

