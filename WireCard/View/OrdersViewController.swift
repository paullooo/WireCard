//
//  OrdersViewController.swift
//  WireCard
//
//  Created by Claro on 02/06/19.
//  Copyright © 2019 paulopereira. All rights reserved.
//

import Foundation
import UIKit

class OrdersViewController: UIViewController {
    private let orderViewModel = OrderViewModel()
    private var orders: [OrderElement] = []
    var indicator = UIActivityIndicatorView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(OrdersTableViewCell.self, forCellReuseIdentifier: OrdersTableViewCell.description())
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.separatorColor = UIColor.init(red: 198/255, green: 203/255, blue: 212/255, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        orderViewModel.completion = { [weak self] state in
            switch state {
            case .failure(_):
                break
            case .success:
                self?.orders = self?.orderViewModel.orders ?? []
                self?.indicator.stopAnimating()
                self?.tableView.separatorStyle = .singleLine
                self?.tableView.reloadData()
            case .detailSuccess:
                self?.navigationController?.pushViewController(OrderDetailViewController(orderDetail: (self?.orderViewModel.orderDetail)!), animated: true)
            }
            self?.tableView.isUserInteractionEnabled = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = UIColor.init(red: 14/255, green: 19/255, blue: 23/255, alpha: 1)
        title = "Pedidos"
        indicator.startAnimating()
        orderViewModel.listOrders()
    }
    
    func setupView() {
        activityIndicator()
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)])
    }
    
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        indicator.color = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.88)
        indicator.hidesWhenStopped = true
        indicator.center = view.center
        view.addSubview(indicator)
    }
}

extension OrdersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrdersTableViewCell.description(), for: indexPath) as! OrdersTableViewCell
        cell.bind(order: orders[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        orderViewModel.orderDetail(id: orders[indexPath.row].id)
        tableView.isUserInteractionEnabled = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


class OrdersTableViewCell: UITableViewCell {
    let formatHelper = FormatHelper()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(red: 0/255, green: 184/255, blue: 212/255, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ownIdLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var currentStatusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var currentStatusDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        setupViews()
    }
    
    private func setupViews() {
        addSubview(amountLabel)
        
        NSLayoutConstraint.activate([amountLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 8),
                                     amountLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 8)])
        
        addSubview(emailLabel)
        
        NSLayoutConstraint.activate([emailLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 8),
                                     emailLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 8)])
        
        addSubview(ownIdLabel)
        
        NSLayoutConstraint.activate([ownIdLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
                                     ownIdLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 8),
                                     ownIdLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)])

        addSubview(currentStatusLabel)
        
        NSLayoutConstraint.activate([currentStatusLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 8),
                                     currentStatusLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -8)])

        addSubview(currentStatusDateLabel)
        
        NSLayoutConstraint.activate([currentStatusDateLabel.topAnchor.constraint(equalTo: currentStatusLabel.bottomAnchor, constant: 8),
                                     currentStatusDateLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -8)])
    }
    
    func bind(order: OrderElement) {
        emailLabel.text = order.customer.email
        ownIdLabel.text = order.ownID
        //mandar para o viewmodel
        amountLabel.text = formatHelper.currencyFormater(value: order.amount.total)
        currentStatusLabel.text = OrderStatus(rawValue: order.status)?.formated
        currentStatusLabel.textColor = OrderStatus(rawValue: order.status)?.color
        currentStatusDateLabel.text = formatHelper.dateFormater(date: order.createdAt)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
