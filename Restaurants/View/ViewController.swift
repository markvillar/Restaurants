//
//  ViewController.swift
//  Restaurants
//
//  Created by Mark on 12/04/2020.
//  Copyright © 2020 Mark Villar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    fileprivate let disposeBag = DisposeBag()
    private var viewModel: RestaurantListViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    static func instantiate(viewModel: RestaurantListViewModel) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateInitialViewController() as! ViewController
        viewController.viewModel = viewModel
        return viewController
    }
    
    fileprivate func setupNavigation() {
        navigationItem.title = "Restaurants"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        
        //let service = RestaurantService()
        //service.fetchRestaurants().subscribe(onNext: { restaurants in
        //    print(restaurants)
        //}).disposed(by: disposeBag)
        
        tableView.tableFooterView = UIView()
        
        viewModel.fetchRestaurantViewModels().observeOn(MainScheduler.instance).bind(to: tableView.rx.items(cellIdentifier: "cell")) { index, viewModel, cell in
            cell.textLabel?.text = viewModel.displayText
        }.disposed(by: disposeBag)
    }
    
}

