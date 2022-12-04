//
//  DailyDisciplinePrototypeApp.swift
//  DailyDisciplinePrototype
//
//  Created by Ludvig Krantzén on 2022-12-04.
//

import SwiftUI

@main
struct DailyDisciplinePrototypeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CreateNewTaskView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
