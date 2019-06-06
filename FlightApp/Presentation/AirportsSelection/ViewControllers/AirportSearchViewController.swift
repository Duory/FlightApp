//
//  AirportSearchViewController.swift
//  FlightApp
//
//  Created by Ilyas Siraev on 31/05/2019.
//  Copyright © 2019 com.onthemoon2. All rights reserved.
//

import UIKit

class AirportSearchViewController: BaseViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var emptyResultsView: UIView!
    @IBOutlet private var emptyResultsLabel: UILabel!

    struct Actions {
        let search: (_ airportName: String, _ completion: @escaping (Result<[Airport], Error>) -> Void) -> Void
        let selectAirport: (_ airport: Airport) -> Void
    }

    var actions: Actions!

    private var airports: [Airport] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        performSearch(with: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        searchBar.becomeFirstResponder()
    }

    private func setup() {
        subscribeToKeyboardNotifications()
        title = Localization.AirportsSelection.search
        view.backgroundColor = Style.Color.blue
        searchBar.delegate = self
        searchBar.placeholder = Localization.AirportsSelection.searchPlaceholder
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AirportCell.nib, forCellReuseIdentifier: AirportCell.reusableIdentifier)
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = UITableView.automaticDimension
        emptyResultsLabel.font = Style.Font.regular(size: 22)
        emptyResultsLabel.textColor = Style.Color.black
        emptyResultsLabel.text = Localization.AirportsSelection.notFound
        emptyResultsView.isHidden = true
    }

    // MARK: - Keyboard handling

    private func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    // MARK: - Search

    private func performThrottledSearch(text: String) {
        throttler.throttle { [weak self] in
            self?.performSearch(with: text)
        }
    }

    private func performSearch(with text: String?) {
        actions.search(text ?? "") { [weak self] result in
            guard let self = self else { return }

            switch result {
                case .success(let airports):
                    self.handleNewAirports(airports)
                case .failure(let error):
                    self.handle(error: error)
            }
        }
    }

    private func handleNewAirports(_ newAirports: [Airport]) {
        self.airports = newAirports
        tableView.isHidden = airports.isEmpty
        emptyResultsView.isHidden = !airports.isEmpty
        tableView.reloadData()
    }

    // MARK: - UISearchBarDelegate

    private let throttler: Throttler = Throttler(timeInterval: 0.25, queue: .main)

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        throttler.throttle { [weak self] in
            self?.performSearch(with: searchText)
        }
        performThrottledSearch(text: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        performThrottledSearch(text: searchBar.text ?? "")
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.setShowsCancelButton(false, animated: true)
    }

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airports.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AirportCell = tableView.dequeueReusableCell(for: indexPath)
        cell.update(with: airports[indexPath.row])
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        actions.selectAirport(airports[indexPath.row])
    }
}
