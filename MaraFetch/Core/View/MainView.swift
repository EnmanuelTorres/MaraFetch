//
//  MainView.swift
//  MaraFetch
//
//  Created by ENMANUEL TORRES on 20/12/24.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject private var viewModel: MainViewModel
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var result: [Recipe] {
        viewModel.RecipeList
        //  recipesMock
    }
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView{
            List(result) { recipe in
                RowView(viewModel: viewModel, recipe: recipe)
            }
            .navigationTitle("Recipes")
        }
        .onAppear{
            Task {
                await viewModel.getRecipeList()
            }
        }
        .refreshable {
            await viewModel.getRecipeList()
        }
        .alert("Error", isPresented: $showAlert) {
            Button("Accept", role: .cancel) {
                viewModel.errorMessage = nil
            }
        } message: {
            if let error = viewModel.errorMessage {
                Text(error)
            } else {
                Text("An unknown error occurred.")
            }
        }
        .onChange(of: viewModel.errorMessage) { oldValue, newValue in
            if newValue != nil {
                showAlert = true
            }
        }
    }
}

#Preview {
    MainView(viewModel: mainViewModelMock)
}
