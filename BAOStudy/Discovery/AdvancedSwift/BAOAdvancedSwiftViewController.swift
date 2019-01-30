//
//  BAOAdvancedSwiftViewController.swift
//  BAOStudy
//
//  Created by baochuquan on 2019/1/15.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import Foundation
import SnapKit

fileprivate extension Sequence {
    func last(_ predicate: (Element) -> Bool) -> Element? {
        for element in reversed() where predicate(element) {
            return element
        }
        return nil
    }
}

// -------------------------------------------------------------------------------------------------------------------

@objc(BAOAdvancedSwiftViewController)
class BAOAdvancedSwiftViewController: BAOBaseViewController {
    private lazy var viewModel = BAODiscoveryEntryCellViewModel.advancedSwiftViewModels();

    private lazy var tableView: UITableView = {
        let v = UITableView()
        v.backgroundColor = .white
        v.separatorStyle = .none
        v.delegate = self
        v.dataSource = self
        contentView.addSubview(v)
        v.snp.makeConstraints({ (make) in
            make.edges.equalTo(0)
        })
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        _ = viewModel
        _ = tableView
    }
}

extension BAOAdvancedSwiftViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let vm = viewModel?[indexPath.row] else { return }
        switch vm.cellId {
        case CellAdvancedSwiftCollection:
            let vc = BAOAdvancedSwiftCollectionViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BAODiscoveryEntryCell.cellHeight()
    }
}

extension BAOAdvancedSwiftViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vm = viewModel?[indexPath.row] else { return BAOTableViewCell() }
        guard let cell = vm.reusableCell(with: tableView) else { return BAOTableViewCell() }
        cell.bindData(with: vm)
        return cell;
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vms = viewModel else { return 0 }
        return vms.count
    }

}


