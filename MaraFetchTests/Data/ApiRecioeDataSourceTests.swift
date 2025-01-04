//
//  ApiRecipeDataSourceTests.swift
//  MaraFetchTests
//
//  Created by ENMANUEL TORRES on 30/12/24.
//

import XCTest
@testable import MaraFetch

final class ApiRecipeDataSourceTests: XCTestCase {

    func test_getRecipeList_sucesses_when_httpClient_request_successes_and_respond_is_correct() async throws {
        //Given
        
        let data: Data? = """
            {
                "recipes": [
                    {
                    "cuisine": "Croatian",
                    "name": "Walnut Roll Gužvara",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/8f60cd87-20ab-419b-a425-56b7ad7c8566/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/8f60cd87-20ab-419b-a425-56b7ad7c8566/small.jpg",
                    "source_url": "https://www.visit-croatia.co.uk/croatian-cuisine/croatian-recipes/",
                    "uuid": "7d6a2c69-f0ef-459a-abf5-c2e90b6555ff",
                    "youtube_url": "https://www.youtube.com/watch?v=Q_akngSJVrQ"
                    },
                    {
                    "cuisine": "French",
                    "name": "White Chocolate Crème Brûlée",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/f4b7b7d7-9671-410e-bf81-39a007ede535/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/f4b7b7d7-9671-410e-bf81-39a007ede535/small.jpg",
                    "source_url": "https://www.bbcgoodfood.com/recipes/2540/white-chocolate-crme-brle",
                    "uuid": "ef7d81b7-07ba-4fab-a791-ae10e2817e66",
                    "youtube_url": "https://www.youtube.com/watch?v=LmJ0lsPLHDc"
                    }
        
                ]
          }
        """.data(using: .utf8)
        
        let expectedResult: [RecipeDTO] = [
            .init(cuisine: "Croatian",
                  name: "Walnut Roll Gužvara",
                  photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/8f60cd87-20ab-419b-a425-56b7ad7c8566/large.jpg",
                  photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/8f60cd87-20ab-419b-a425-56b7ad7c8566/small.jpg",
                  uuid: "7d6a2c69-f0ef-459a-abf5-c2e90b6555ff",
                  sourceUrl: "https://www.visit-croatia.co.uk/croatian-cuisine/croatian-recipes/",
                  youTubeUrl: "https://www.youtube.com/watch?v=Q_akngSJVrQ"),
            
                .init(cuisine: "French",
                      name: "White Chocolate Crème Brûlée",
                      photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/f4b7b7d7-9671-410e-bf81-39a007ede535/large.jpg",
                      photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/f4b7b7d7-9671-410e-bf81-39a007ede535/small.jpg",
                      uuid: "ef7d81b7-07ba-4fab-a791-ae10e2817e66",
                      sourceUrl: "https://www.bbcgoodfood.com/recipes/2540/white-chocolate-crme-brle",
                      youTubeUrl: "https://www.youtube.com/watch?v=LmJ0lsPLHDc")
        ]
        
        let sut = APIRecipeDataSource(httpClient: HttpClientStub(result: .success(data!)))
        
        //When
        let capturedResult = await sut.getDessertList()
        
        //Then
        let result = try XCTUnwrap(capturedResult.get())
        
        XCTAssertEqual(result, expectedResult)
    }
    
    func test_getRecipeList_fails_when_httpClient_response_data_error() async throws {
        //Given
        let expectedResult: DataError = .dataError
        let sut = APIRecipeDataSource(httpClient: HttpClientStub(result: .failure(.dataError)))
        
        //When
        let capturedResult = await sut.getDessertList()
        
        //Then
        guard case .failure(let result) = capturedResult else {
            XCTFail("Expected .failure but got success ")
            return
        }

        XCTAssertEqual(expectedResult, result)
        
    }

    func test_getRecipeList_fails_when_httpClient_response_decoding_error() async throws {
        
        //Given
        
        let data: Data? = """
            {
                "recipes": [
                    {
                    "cuisi": "Croatian",
                    "name": "Walnut Roll Gužvara",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/8f60cd87-20ab-419b-a425-56b7ad7c8566/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/8f60cd87-20ab-419b-a425-56b7ad7c8566/small.jpg",
                    "source_url": "https://www.visit-croatia.co.uk/croatian-cuisine/croatian-recipes/",
                    "uuid": "7d6a2c69-f0ef-459a-abf5-c2e90b6555ff",
                    "youtube_url": "https://www.youtube.com/watch?v=Q_akngSJVrQ"
                    },
                    {
                    "cuisine": "French",
                    "nam": "White Chocolate Crème Brûlée",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/f4b7b7d7-9671-410e-bf81-39a007ede535/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/f4b7b7d7-9671-410e-bf81-39a007ede535/small.jpg",
                    "source_url": "https://www.bbcgoodfood.com/recipes/2540/white-chocolate-crme-brle",
                    "uuid": "ef7d81b7-07ba-4fab-a791-ae10e2817e66",
                    "youtube_url": "https://www.youtube.com/watch?v=LmJ0lsPLHDc"
                    }
        
                ]
          }
        """.data(using: .utf8)
        
        let expectedResult: DataError = .decodingError
        
        let sut = APIRecipeDataSource(httpClient: HttpClientStub(result: .success(data!)))
        
        //When
        let capturedResult = await sut.getDessertList()
        
        //Then
        guard case .failure(let result) = capturedResult else {
            XCTFail("Expected .failure but got success ")
            return
        }

        XCTAssertEqual(expectedResult, result)
        
    }
    
    func test_getRecipeList_fails_when_httpClient_request_success_and_response_is_empty() async throws {
        
        //Given
        
        let data: Data? = """
                            {
                            "recipes": []
                            }
                            """.data(using: .utf8)
        
        let expectedResult: DataError = .emptyData
        
        let sut = APIRecipeDataSource(httpClient: HttpClientStub(result: .success(data!)))
        
        //When
        let capturedResult = await sut.getDessertList()
        
        //Then
        guard case .failure(let result) = capturedResult else {
            XCTFail("Expected .failure but got success ")
            return
        }

        XCTAssertEqual(expectedResult, result)
        
        
    }
}
