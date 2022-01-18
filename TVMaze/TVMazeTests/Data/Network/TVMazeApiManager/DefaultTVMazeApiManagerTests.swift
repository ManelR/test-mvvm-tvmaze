//
//  DefaultTVMazeApiManagerTests.swift
//  TVMazeTests
//
//  Created by Manel Roca on 17/1/22.
//

import XCTest

@testable import TVMaze

class DefaultTVMazeApiManagerTests: XCTestCase {
    
    private var apiManager: DefaultTVMazeApiManager!
    private var response = """
                            [{"id":250,"url":"https://www.tvmaze.com/shows/250/kirby-buckets","name":"Kirby Buckets","type":"Scripted","language":"English","genres":["Comedy"],"status":"Ended","runtime":30,"averageRuntime":30,"premiered":"2014-10-20","ended":"2017-02-02","officialSite":"http://disneyxd.disney.com/kirby-buckets","schedule":{"time":"07:00","days":["Monday","Tuesday","Wednesday","Thursday","Friday"]},"rating":{"average":7.1},"weight":69,"network":{"id":25,"name":"Disney XD","country":{"name":"United States","code":"US","timezone":"America/New_York"}},"webChannel":{"id":83,"name":"DisneyNOW","country":{"name":"United States","code":"US","timezone":"America/New_York"}},"dvdCountry":null,"externals":{"tvrage":37394,"thetvdb":278449,"imdb":"tt3544772"},"image":{"medium":"https://static.tvmaze.com/uploads/images/medium_portrait/1/4600.jpg","original":"https://static.tvmaze.com/uploads/images/original_untouched/1/4600.jpg"},"summary":"<p>The single-camera series that mixes live-action and animation stars Jacob Bertrand as the title character. <b>Kirby Buckets</b> introduces viewers to the vivid imagination of charismatic 13-year-old Kirby Buckets, who dreams of becoming a famous animator like his idol, Mac MacCallister. With his two best friends, Fish and Eli, by his side, Kirby navigates his eccentric town of Forest Hills where the trio usually find themselves trying to get out of a predicament before Kirby's sister, Dawn, and her best friend, Belinda, catch them. Along the way, Kirby is joined by his animated characters, each with their own vibrant personality that only he and viewers can see.</p>","updated":1617744408,"_links":{"self":{"href":"https://api.tvmaze.com/shows/250"},"previousepisode":{"href":"https://api.tvmaze.com/episodes/1051658"}}}]
                            """

    override func setUpWithError() throws {
        apiManager = DefaultTVMazeApiManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCanConvertIntoJSON() throws {
        // Given
        let data = response.data(using: .utf8)
        // When
        if let data = data {
            let decodedResponse = try JSONDecoder().decode(ShowsResponse.self, from: data)
            // Then
            XCTAssertNotNil(decodedResponse)
            XCTAssertTrue(decodedResponse.count == 1)
            XCTAssertTrue(decodedResponse[0].id! == 250)
            XCTAssertTrue(decodedResponse[0].url! == "https://www.tvmaze.com/shows/250/kirby-buckets")
            XCTAssertTrue(decodedResponse[0].name! == "Kirby Buckets")
            XCTAssertTrue(decodedResponse[0].image?.original! == "https://static.tvmaze.com/uploads/images/original_untouched/1/4600.jpg")
            XCTAssertTrue(decodedResponse[0].summary! == "<p>The single-camera series that mixes live-action and animation stars Jacob Bertrand as the title character. <b>Kirby Buckets</b> introduces viewers to the vivid imagination of charismatic 13-year-old Kirby Buckets, who dreams of becoming a famous animator like his idol, Mac MacCallister. With his two best friends, Fish and Eli, by his side, Kirby navigates his eccentric town of Forest Hills where the trio usually find themselves trying to get out of a predicament before Kirby's sister, Dawn, and her best friend, Belinda, catch them. Along the way, Kirby is joined by his animated characters, each with their own vibrant personality that only he and viewers can see.</p>")
            XCTAssertTrue(decodedResponse[0].rating?.average! == 7.1)
        } else {
            fatalError("Data is null")
        }
    }

    func testConvertShowsResponseIntoDomain() throws {
        // Given
        let showsResponses = [ShowResponse(id: 1,
                                           url: "test_url",
                                           name: "Test 1",
                                           genres: nil,
                                           rating: ShowRatingResponse(average: 3),
                                           image: ShowImageResponse(medium: "test_image_url1", original: "test_image_url2"),
                                           summary: "summary, summary, summary"),
                              ShowResponse(id: 2,
                                           url: "test_url_2",
                                           name: "Test 2",
                                           genres: nil,
                                           rating: ShowRatingResponse(average: 5),
                                           image: ShowImageResponse(medium: "test_image_url3", original: "test_image_url4"),
                                           summary: "summary, summary, summary, 1"),]
        
        // When
        let converted = apiManager.convertShowsResponseIntoDomain(showsResponses)

        // Then
        XCTAssertNotNil(converted)
        XCTAssertTrue(converted.count == 2)
        // 1
        XCTAssertTrue(converted[0].title == "Test 1")
        XCTAssertTrue(converted[0].imageURL == "test_image_url1")
        XCTAssertTrue(converted[0].rating == 3)
        XCTAssertTrue(converted[0].summary == "summary, summary, summary")
        // 2
        XCTAssertTrue(converted[1].title == "Test 2")
        XCTAssertTrue(converted[1].imageURL == "test_image_url3")
        XCTAssertTrue(converted[1].rating == 5)
        XCTAssertTrue(converted[1].summary == "summary, summary, summary, 1")
    }

}
