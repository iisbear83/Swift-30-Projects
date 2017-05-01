//
//  ProductsTableViewController.swift
//  GoodAsOldPhones
//
//  Copyright © 2016 Code School. All rights reserved.
//

import UIKit

class ProductsTableViewController: UITableViewController {
  fileprivate var products: [Product]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    products = [
        Product(name: "1907 Wall Set", cellImageName: "image-cell1", fullscreenImageName: "phone-fullscreen1"),
        Product(name: "1921 Dial Phone", cellImageName: "image-cell2", fullscreenImageName: "phone-fullscreen2"),
        Product(name: "1937 Desk Set", cellImageName: "image-cell3", fullscreenImageName: "phone-fullscreen3"),
        Product(name: "1984 Moto Portable", cellImageName: "image-cell4", fullscreenImageName: "phone-fullscreen4")
    ]
  }
  
  // MARK: - UITableViewDataSource
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return products?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)
    
    guard let products = products else { return cell }
    
    cell.textLabel?.text = products[(indexPath as NSIndexPath).row].name
    
    if let imageName = products[(indexPath as NSIndexPath).row].cellImageName {
      cell.imageView?.image = UIImage(named: imageName)
    }
    
    return cell;
  }
  
  // MARK: - View Transfer
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showProduct" {
      if let cell = sender as? UITableViewCell,
        let indexPath = tableView.indexPath(for: cell),
        let productVC = segue.destination as? ProductViewController {
        productVC.product = products?[(indexPath as NSIndexPath).row]
      }
    }
  }
}
