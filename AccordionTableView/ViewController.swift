//
//  ViewController.swift
//  AccordionTableView
//
//  Created by 鶴本 賢太朗 on 2020/06/19.
//  Copyright © 2020 鶴本 賢太朗. All rights reserved.
//

import UIKit

class Section {
    internal var isOpen: Bool = false
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let sections: [Section] = [
        Section(),
        Section(),
        Section(),
        Section(),
        Section(),
        Section(),
        Section(),
        Section()
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    @objc func didTapHeader(_ sender: UITapGestureRecognizer) {
        self.sections[sender.view!.tag].isOpen.toggle()
        tableView.beginUpdates()
        tableView.reloadSections(IndexSet(integer: sender.view!.tag), with: .fade)
        tableView.endUpdates()
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].isOpen ? 10 : 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let rect: CGRect = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 50)
        let view: UIView = UIView(frame: rect)
        let label = UILabel(frame: rect)
        label.text = "\(section)セクション"
        view.addSubview(label)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTapHeader))
        view.addGestureRecognizer(tap)
        view.tag = section
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
