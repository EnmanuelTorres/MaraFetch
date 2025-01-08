//
//  RowView.swift
//  MaraFetch
//
//  Created by ENMANUEL TORRES on 20/12/24.
//

import SwiftUI

struct RowView: View {
    
    @ObservedObject var viewModel: MainViewModel
    
    var recipe: Recipe
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            
            if let image = viewModel.images[recipe.photoUrl] {
                
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
            } else {
                ProgressView()
                
            }
            
            
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.headline)
                    .lineLimit(1)
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        
        .padding(.vertical, 8)
        .onAppear{
            Task {
                await viewModel.fetchImages(for: recipe)
            }
        }
        
    }
}



#Preview {
    RowView(viewModel: mainViewModelMock,
            recipe: recipeMock)
}

