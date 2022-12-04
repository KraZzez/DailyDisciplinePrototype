//
//  CreateNewTask.swift
//  DailyDisciplinePrototype
//
//  Created by Ludvig Krantzén on 2022-12-04.
//

import SwiftUI

struct CreateNewTaskView: View {
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject var vm = CoreDataViewModel()
    @State var taskTextField: String = ""
    
    var body: some View {
        VStack {
            TextField("Add task here...", text: $taskTextField)
                .frame(height: 55)
                .background(.gray)
                .cornerRadius(10)
                .padding(.horizontal)
            
            Button {
                guard !taskTextField.isEmpty else { return }
                vm.addTaskObject(name: taskTextField)
                dismiss()
            } label: {
                Text("Submit")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            
            
            Spacer()
        }
    }
}

struct CreateNewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewTaskView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
