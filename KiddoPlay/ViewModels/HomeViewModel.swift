//
//  HomeViewModel.swift
//  KiddoPlay
//
//  Created by Rozan Skaik on 22/01/2026.
//
import SwiftUI

@MainActor
@Observable
final class HomeViewModel {

    var items: [HomeCategory] = []

    init() {
        loadDemoData()
    }

    private func loadDemoData() {
        items = [
            HomeCategory(title: "NUMBERS", imageName: "numbersImg", colorName: "Green"),
            HomeCategory(title: "LETTERS", imageName: "numbersImg", colorName: "LightYellow"),
            HomeCategory(title: "ANIMALS", imageName: "numbersImg", colorName: "LightOrange"),
            HomeCategory(title: "MATH", imageName: "numbersImg", colorName: "LightBlue")
        ]
    }
}
