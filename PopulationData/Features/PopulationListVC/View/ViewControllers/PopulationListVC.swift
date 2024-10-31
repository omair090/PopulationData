//
//  PopulationListVC.swift
//  PopulationData
//
//  Created by Muhammad Umair on 27/04/1446 AH.
//
import UIKit
import Combine

class PopulationListVC: BaseViewController, PopulationListViewControllerProtocol {

    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: UIConstants.SegmentedControl.items)
        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        control.backgroundColor = .clear
        control.selectedSegmentTintColor = UIConstants.Colors.primary
        
        control.layer.cornerRadius = 8
        control.layer.masksToBounds = true

        control.layer.borderColor = UIConstants.Colors.primary.cgColor
        control.layer.borderWidth = 1.2

        
        control.setTitleTextAttributes([
            .foregroundColor: UIColor.white,
            .font: UIFont(name: UIConstants.Fonts.boldFont, size: UIConstants.FontSize.missionFontSize)!
        ], for: .selected)
        
        control.setTitleTextAttributes([
            .foregroundColor: UIConstants.Colors.primary,
            .font: UIFont(name: UIConstants.Fonts.regularFont, size: UIConstants.FontSize.missionFontSize)!
        ], for: .normal)

        
        control.layer.shadowColor = UIColor.black.cgColor
        control.layer.shadowOpacity = 0.1
        control.layer.shadowOffset = CGSize(width: 0, height: 3)
        control.layer.shadowRadius = 5

        return control
    }()



    
    private let populationTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIConstants.Colors.appBackground
        tableView.separatorStyle = .none
        return tableView
    }()

    private let viewModel: PopulationListViewModelProtocol
    private let tableViewHandler: PopulationTableViewHandler
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: PopulationListViewModelProtocol, tableViewHandler: PopulationTableViewHandler) {
        self.viewModel = viewModel
        self.tableViewHandler = tableViewHandler
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }

    // MARK: - Setup Methods

    override func setupUI() {
        view.backgroundColor = UIConstants.Colors.appBackground
        populationTableView.accessibilityIdentifier = AppConstants.TableView.identifier
        segmentedControl.accessibilityIdentifier = UIConstants.SegmentedControl.identifier

       
        title = AppConstants.Navigation.title

        let adaptiveFontSize = DeviceAdaptiveConstants.fontSize(for: UIConstants.FontSize.headerFontSize, traitCollection: view.traitCollection)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.label,
            .font: UIFont(name: UIConstants.Fonts.boldFont, size: adaptiveFontSize)!
        ]

        view.addSubview(segmentedControl)
        view.addSubview(populationTableView)

        let topMargin = DeviceAdaptiveConstants.margin(for: UIConstants.Margins.topMargin, traitCollection: view.traitCollection)
        let sideMargin = DeviceAdaptiveConstants.margin(for: UIConstants.Margins.sideMargin, traitCollection: view.traitCollection)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topMargin),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: sideMargin),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -sideMargin),
            
            segmentedControl.heightAnchor.constraint(equalToConstant: 60),
            
            populationTableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: UIConstants.Margins.verticalSpacing),
            populationTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            populationTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            populationTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        segmentedControl.addTarget(self, action: #selector(segmentedControlChanged), for: .valueChanged)
        
        tableViewHandler.configure(tableView: populationTableView)
        populationTableView.delegate = tableViewHandler
    }

    override func setupBindings() {
        bindPopulationData()
    }

    // MARK: - Data Binding

    private func bindPopulationData() {
        viewModel.stateData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] states in
                self?.displayStatePopulation(states)
            }
            .store(in: &cancellables)

        viewModel.nationData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] nations in
                self?.displayNationPopulation(nations)
            }
            .store(in: &cancellables)
    }


    func displayStatePopulation(_ states: [StateModel]) {
        tableViewHandler.updateStateData(states)
        populationTableView.reloadData()
    }

    func displayNationPopulation(_ nations: [NationModel]) {
        tableViewHandler.updateNationData(nations)
        populationTableView.reloadData()
    }

    func showError(_ message: String) {
        let alert = UIAlertController(title: UIConstants.Error.title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: UIConstants.Error.okButtonTitle, style: .default))
        present(alert, animated: true)
    }

    // MARK: - Actions

    @objc private func segmentedControlChanged() {
        let selectedSegment = segmentedControl.selectedSegmentIndex
        if selectedSegment == 0 {
            viewModel.fetchInitialStateData()
        } else {
            viewModel.fetchInitialNationData()
        }
    }
}
