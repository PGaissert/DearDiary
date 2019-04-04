//
//  DiaryListViewController.swift
//  DearDiary
//
//  Created by Patrick Gaissert on 02.04.19.
//  Copyright © 2019 MaibornWolff GmbH. All rights reserved.
//

import UIKit

class DiaryListViewController: UIViewController {
    @IBOutlet var quoteTextLabel: UILabel!
    @IBOutlet var quoteAuthorLabel: UILabel!
    @IBOutlet var tableView: UITableView!

    let service = Service.shared

    var tableData = [DiaryEntry]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        displayQuote()
        displayDiaryEntries()
    }

    func displayQuote() {
        service.quote { (quote) in
            self.quoteTextLabel.text = quote?.quoteText
            self.quoteAuthorLabel.text = quote?.quoteAuthor
        }
    }

    func displayDiaryEntries() {
        service.diaryEntries { (diaryEntries) in
            guard let diaryEntries = diaryEntries else {
                return
            }

            self.tableData = diaryEntries
            self.tableView.reloadData()
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? UITableViewCell,
            let selectedIndexPath = tableView.indexPath(for: cell),
            let diaryEntryViewController = segue.destination as? DiaryEntryViewController else {
            return
        }

        let selectedDiaryEntry = tableData[selectedIndexPath.row]
        diaryEntryViewController.diaryEntry = selectedDiaryEntry
    }
}

extension DiaryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = tableData[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "DiaryListTableViewCell", for: indexPath)

        cell.textLabel?.text = data.title

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .short
        cell.detailTextLabel?.text = dateFormatter.string(from: data.date!)

        return cell
    }
}
