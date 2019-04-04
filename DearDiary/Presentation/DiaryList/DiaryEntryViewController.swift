//
//  DiaryEntryViewController.swift
//  DearDiary
//
//  Created by Patrick Gaissert on 04.04.19.
//  Copyright © 2019 MaibornWolff GmbH. All rights reserved.
//

import UIKit

class DiaryEntryViewController: UIViewController {
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextView: UITextView!

    let service = Service.shared

    var diaryEntry: DiaryEntry?

    override func viewDidLoad() {
        super.viewDidLoad()

        if diaryEntry != nil {
            showDiaryEntry()
        } else {
            newDiaryEntry()
        }
    }

    func showDiaryEntry() {
        titleTextField.text = diaryEntry?.title
        contentTextView.text = diaryEntry?.content

        view.isUserInteractionEnabled = false
        navigationItem.rightBarButtonItem = nil
    }

    func newDiaryEntry() {
        titleTextField.text = nil
        contentTextView.text = nil
    }

    // MARK: - User interaction

    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text, !title.isEmpty,
            let content = contentTextView.text, !content.isEmpty else {
            return
        }

        service.addDiaryEntry(title: title, content: content)
        navigationController?.popViewController(animated: true)
    }
}
