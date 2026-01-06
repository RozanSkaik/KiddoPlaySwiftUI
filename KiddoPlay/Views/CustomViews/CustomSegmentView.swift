//
//  CustomSegmentView.swift
//  KiddoPlay
//
//  Created by Rozan Skaik on 07/12/2025.
//

import SwiftUI

struct CustomSegmentView: View {
    @Binding var selectedTag: Int

    var body: some View {
        VStack {
            Picker("Choose an Option", selection: $selectedTag) {
                Text("Existing").tag(0)
                Text("New").tag(1)
            }
            .frame(height: 50)
            .padding(.horizontal,26)
            .padding(.vertical,12)
            .pickerStyle(.segmented)
            .background(Color("BaseColor").opacity(0.4))
            .cornerRadius(35)
        }
    }
}

extension UISegmentedControl {
    override open func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.setContentHuggingPriority(.defaultLow, for: .vertical)

        UISegmentedControl.appearance().backgroundColor = UIColor.base.withAlphaComponent(0.2)
        // Font colors & sizes
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 21, weight: .bold)
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(normalAttributes, for: .normal)

        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.base,
            .font: UIFont.boldSystemFont(ofSize: 21)
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(selectedAttributes, for: .selected)
    }
}

#Preview {
    @Previewable @State var selected = 0
    return CustomSegmentView(selectedTag: $selected)
}
