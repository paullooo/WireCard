//
//  OrderDetailViewController.swift
//  WireCard
//
//  Created by Claro on 02/06/19.
//  Copyright © 2019 paulopereira. All rights reserved.
//

import Foundation
import UIKit

class OrderDetailViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(OrdersDetailTableViewCell.self, forCellReuseIdentifier: OrdersDetailTableViewCell.description())
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
    
    private var order: OrderDetail? {
        didSet {
            tableView.reloadData()
        }
    }
    
    public init(orderDetail: OrderDetail) {
        order = orderDetail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        title = "Detalhe"
        view.backgroundColor = UIColor.init(red: 14/255, green: 19/255, blue: 23/255, alpha: 1)
    }
    
    func setupView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

extension OrderDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrdersDetailTableViewCell.description(), for: indexPath) as! OrdersDetailTableViewCell
        cell.bind(order: order!)
        return cell
    }
}

class OrdersDetailTableViewCell: UITableViewCell {
    let formatHelper = FormatHelper()
    
    private var orderDetail: OrderDetail? {
        didSet {
            
            emailLabel.text = orderDetail?.customer.email
            nameLabel.text = orderDetail?.customer.fullname
            ownIdLabel.text = orderDetail?.ownID
            amountLabel.text = formatHelper.currencyFormater(value: orderDetail?.amount.total ?? 0)
            currentStatusLabel.text = OrderStatus(rawValue: orderDetail?.status ?? "")?.formated
            currentStatusLabel.textColor = OrderStatus(rawValue: orderDetail?.status ?? "")?.color
            currentStatusDateLabel.text = formatHelper.dateFormater(date: orderDetail?.createdAt ?? "")

            totalValueLabel.text = "Total: \(formatHelper.currencyFormater(value: orderDetail?.payments.first?.amount.total ?? 0))"

            taxValueLabel.text = "Taxas: \(formatHelper.currencyFormater(value: orderDetail?.payments.first?.amount.fees ?? 0))"

            liquidValueLabel.text = "Liquido: \(formatHelper.currencyFormater(value: orderDetail?.payments.first?.amount.liquid ?? 0))"
        }
    }
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.init(red: 0/255, green: 184/255, blue: 212/255, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
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
    
    private lazy var totalValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var taxValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var liquidValueLabel: UILabel = {
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
    
    func bind(order: OrderDetail) {
        orderDetail = order
    }
    
    private func setupViews() {
        addSubview(amountLabel)
        
        NSLayoutConstraint.activate([amountLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 8),
                                     amountLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 8)])
        
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([nameLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 8),
                                     nameLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 8)])
        
        addSubview(emailLabel)
        
        NSLayoutConstraint.activate([emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
                                     emailLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 8)])
        
        addSubview(ownIdLabel)
        
        NSLayoutConstraint.activate([ownIdLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 8),
                                     ownIdLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 8)])
        
        addSubview(totalValueLabel)
        
        NSLayoutConstraint.activate([totalValueLabel.topAnchor.constraint(equalTo: ownIdLabel.bottomAnchor, constant: 8),
                                     totalValueLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 8)])
        
        addSubview(taxValueLabel)
        
        NSLayoutConstraint.activate([taxValueLabel.topAnchor.constraint(equalTo: totalValueLabel.bottomAnchor, constant: 8),
                                     taxValueLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 8)])
        
        
        addSubview(liquidValueLabel)
        
        NSLayoutConstraint.activate([liquidValueLabel.topAnchor.constraint(equalTo: taxValueLabel.bottomAnchor, constant: 8),
                                     liquidValueLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 8),
                                     liquidValueLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)])
                
        addSubview(currentStatusLabel)
        
        NSLayoutConstraint.activate([currentStatusLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 8),
                                     currentStatusLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -8)])
        
        addSubview(currentStatusDateLabel)
        
        NSLayoutConstraint.activate([currentStatusDateLabel.topAnchor.constraint(equalTo: currentStatusLabel.bottomAnchor, constant: 8),
                                     currentStatusDateLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -8)])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
