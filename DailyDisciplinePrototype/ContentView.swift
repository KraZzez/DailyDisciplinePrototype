//
//  ContentView.swift
//  DailyDisciplinePrototype
//
//  Created by Ludvig Krantzén on 2022-12-04.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedTaskObjects: [TaskObject] = []
    
    init() {
        container = NSPersistentContainer(name: "DailyDisciplinePrototype")
        container.loadPersistentStores { (description, error) in
            if let error =  error {
                print("Error loading core data. \(error)")
            } else {
                print("Sucessfully loaded core data!")
            }
        }
    }
    
    func fetchTaskObjects() {
        let request = NSFetchRequest<TaskObject>(entityName: "TaskObject")
        
        do {
            savedTaskObjects = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
    }
    
    func addTaskObject(name: String) {
        let newTaskObject = TaskObject(context: container.viewContext)
        newTaskObject.name = name
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchTaskObjects()
        } catch let error {
            print("Error saving. \(error)")
        }
    }
    
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject var vm = CoreDataViewModel()
    
    @State private var showNewTaskSheet = false
    
    @State var taskTextField: String = ""
    

    var body: some View {
        NavigationStack {
            VStack {
                
                TextField("Add task here...", text: $taskTextField)
                    .frame(height: 55)
                    .background(.gray)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button {
                    guard !taskTextField.isEmpty else { return }
                    vm.addTaskObject(name: taskTextField)
                    taskTextField = ""
                } label: {
                    Text("Submit")
                }

                
                List {
                    ForEach(vm.savedTaskObjects) { task in
                        Text(task.name ?? "NO NAME")
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        showNewTaskSheet.toggle()
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            /*
            .sheet(isPresented: $showNewTaskSheet) {
                CreateNewTaskView()
            }
             */
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
