//
//  PopulationTableViewHandler.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//

import Foundation
import UIKit
import Combine

class PopulationTableViewHandler: NSObject, TableViewHandlerProtocol,PopulationTableViewCellDelegate {


    // MARK: - Properties

    private var stateData: [StateModel] = []
    private var nationData: [NationModel] = []
    private var isShowingStateData = true
    private let didSelectItem: (Any) -> Void
    private weak var tableView: UITableView?
    private var cancellables = Set<AnyCancellable>()
    private let viewModel: PopulationListViewModelProtocol

    private lazy var noDataLabel: UILabel = {
        let label = UILabel()
        label.text = AppConstants.TableView.noDataFound
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .gray
        label.isHidden = true
        return label
    }()
    
    
    init(didSelectItem: @escaping (Any) -> Void, viewModel: PopulationListViewModelProtocol) {
        self.didSelectItem = didSelectItem
        self.viewModel = viewModel
        super.init()
        bindData()
    }

    // MARK: - Configuration

    func configure(tableView: UITableView) {
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PopulationTableViewCell.self, forCellReuseIdentifier: UIConstants.PopulationTableViewCell.identifier)
        
        // Add the no data label to the table view
        tableView.addSubview(noDataLabel)
        noDataLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noDataLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            noDataLabel.centerYAnchor.constraint(equalTo: tableView.centerYAnchor)
        ])
    }

    // MARK: - Data Binding

    private func bindData() {
        viewModel.stateData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] states in
                self?.updateStateData(states)
            }
            .store(in: &cancellables)

        viewModel.nationData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] nations in
                self?.updateNationData(nations)
            }
            .store(in: &cancellables)
    }

    // MARK: - Data Handling

    func updateStateData(_ states: [StateModel]) {
        stateData = states
        isShowingStateData = true
        toggleNoDataLabelIfNeeded()
        tableView?.reloadData()
    }

    func updateNationData(_ nations: [NationModel]) {
        nationData = nations
        isShowingStateData = false
        toggleNoDataLabelIfNeeded()
        tableView?.reloadData()
    }

    private func toggleNoDataLabelIfNeeded() {
        let hasData = isShowingStateData ? !stateData.isEmpty : !nationData.isEmpty
        noDataLabel.isHidden = hasData
    }

    // MARK: - Infinite Scrolling

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let tableView = tableView else { return }

        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height

        if offsetY > contentHeight - scrollViewHeight {
            let lastVisibleRowIndex = tableView.indexPathsForVisibleRows?.last?.row ?? 0
            let totalRows = tableView.numberOfRows(inSection: 0)

            if lastVisibleRowIndex == totalRows - 1 && !viewModel.isFetching {
                fetchMoreData()
            }
        }
    }

    private func fetchMoreData() {

    }

    // MARK: - UITableViewDataSource and UITableViewDelegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isShowingStateData ? stateData.count : nationData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UIConstants.PopulationTableViewCell.identifier, for: indexPath) as? PopulationTableViewCell else {
            return UITableViewCell()
        }

        if isShowingStateData {
            let state = stateData[indexPath.row]
            cell.configure(with: state)
        } else {
            let nation = nationData[indexPath.row]
            cell.configure(with: nation)
        }
        cell.delegate = self
        cell.selectionStyle = .none

        return cell
    }



    func didTapDetailButton(for region: Any) {
        
        if let state = region as? StateModel {
            didSelectItem(state)
        } else if let nation = region as? NationModel {
            didSelectItem(nation)
        }
    }
}
