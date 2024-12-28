//
//  MainView.swift
//  MaraFetch
//
//  Created by ENMANUEL TORRES on 20/12/24.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject private var viewModel: MainViewModel
    
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
                RowView(recipe: recipe)
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
    }
}

#Preview {
    MainView(viewModel: mainViewModelMock)
}
