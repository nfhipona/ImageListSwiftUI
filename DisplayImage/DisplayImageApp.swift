//
//  DisplayImageApp.swift
//  DisplayImage
//
//  Created by Neil Francis Hipona on 7/27/23.
//

import SwiftUI

@main
struct DisplayImageApp: App {
    var body: some Scene {
        WindowGroup {
            ImageView(coordinator: .init())
        }
    }
}
