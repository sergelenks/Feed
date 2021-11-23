//
//  ViewModel.swift
//  SergelenbaatarTsogtbaatar
//
//  Created by Sergelenbaatar Tsogtbaatar on 23/11/21.
//

import Foundation
import Combine

class ViewModel {
    // internal properties
    var rows: Int { stories.count }
    
    @Published private(set) var stories = [Story]()
    @Published private(set) var rowToUpdate = 0
    
    private let apiManager: APIProtocol
    private var imageCache = [String: Data]()
    private var keyAfter = ""
    private var updating = false
    private var subscribers = Set<AnyCancellable>()
    
    init(apiManager: APIProtocol = APIManager()) {
        self.apiManager = apiManager
    }
    
    func getTitle(at row: Int) -> String? { stories[row].title }
    func getComments(at row: Int) -> String? { "Comments: \(stories[row].numComments)" }
    
    func loadData() {
        updating = true
        let url = APIUrl.storiesURL.replacingOccurrences(of: APIUrl.keyAfter, with: keyAfter)
        apiManager
            .getStories(from: url)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.updating = false
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] response in
                self?.stories.append(contentsOf: response.stories)
                self?.keyAfter = response.after
            }
            .store(in: &subscribers)
    }
    
    func getImage(by row: Int) -> Data? {
        let story = stories[row]
        
        guard let url = story.thumbnail, url.hasPrefix("https://")
        else { return nil }
        
        if let data = imageCache[url] { return data }
        
        apiManager
            .downloadImage(from: url)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] data in
                self?.imageCache[url] = data
                self?.rowToUpdate = row
            }
            .store(in: &subscribers)

        return nil
    }
    
    func loadMoreData(visibleRows rows: [Int]) {
        let lastRow = stories.count - 1
        if rows.contains(lastRow) && !updating {
            loadData()
        }
    }
    
}
