//
//  PopulationListViewModel.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//

import Foundation
import Combine

class PopulationListViewModel: PopulationListViewModelProtocol {

    // MARK: - Properties

    private(set) var isFetching = false
    private let statePublisher = CurrentValueSubject<[StateModel], Never>([])
    private let nationPublisher = CurrentValueSubject<[NationModel], Never>([])

    private let service: PopulationListServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initializer

    init(service: PopulationListServiceProtocol) {
        self.service = service
        fetchInitialStateData()
    }

    // MARK: - Public Publishers

    var stateData: AnyPublisher<[StateModel], Never> {
        statePublisher.eraseToAnyPublisher()
    }

    var nationData: AnyPublisher<[NationModel], Never> {
        nationPublisher.eraseToAnyPublisher()
    }

    // MARK: - Fetching Methods

    func fetchInitialStateData() {
        statePublisher.send([])
        fetchStateData()
    }

    func fetchInitialNationData() {
        nationPublisher.send([])
        fetchNationData()
    }

    // MARK: - Private Fetching Methods

    private func fetchStateData() {
        guard !isFetching else { return }
        isFetching = true

        let request = PopulationRequest(regionType: .state, page: nil)
        
        service.fetchPopulationData(request: request)
            .tryMap { data -> [StateDataModel] in
                guard let stateData = data as? [StateDataModel] else {
                    throw NetworkError.decodingFailed("Expected [StateDataModel], return \(type(of: data))")
                }
                return stateData
            }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isFetching = false
                if case .failure(let error) = completion {
                    self?.handleError(error, message: "Failed to fetch state data")
                }
            }, receiveValue: { [weak self] data in
                self?.handleFetchedStateData(data)
                self?.isFetching = false
            })
            .store(in: &cancellables)
    }

    private func fetchNationData() {
        guard !isFetching else { return }
        isFetching = true

        let request = PopulationRequest(regionType: .nation, page: nil) 
        
        service.fetchPopulationData(request: request)
            .tryMap { data -> [NationDataModel] in
                guard let nationData = data as? [NationDataModel] else {
                    throw NetworkError.decodingFailed("Expected [NationDataModel], return \(type(of: data))")
                }
                return nationData
            }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isFetching = false
                if case .failure(let error) = completion {
                    self?.handleError(error, message: "Failed to fetch nation data")
                }
            }, receiveValue: { [weak self] data in
                self?.handleFetchedNationData(data)
                self?.isFetching = false
            })
            .store(in: &cancellables)
    }
    
    func fetchMoreStateData() -> AnyPublisher<Void, any Error> {
        return Empty(completeImmediately: true).eraseToAnyPublisher()
    }

    func fetchMoreNationData() -> AnyPublisher<Void, any Error> {
        return Empty(completeImmediately: true).eraseToAnyPublisher()
    }

    // MARK: - Private Helper Methods

    private func handleFetchedStateData(_ data: [StateDataModel]) {
        let states = data.map { StateModel(from: $0) }
        statePublisher.send(states)
    }

    private func handleFetchedNationData(_ data: [NationDataModel]) {
        let nations = data.map { NationModel(from: $0) }
        nationPublisher.send(nations)
    }

    private func handleError(_ error: Error, message: String) {
        print("\(message): \(error.localizedDescription)")
    }
}
