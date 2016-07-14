//
//  MasterTableViewCell.swift
//  PokedexGo
//
//  Created by Yi Gu on 7/10/16.
//  Copyright © 2016 yigu. All rights reserved.
//

import UIKit

class MasterTableViewCell: UITableViewCell {
  @IBOutlet weak var idLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var pokeImageView: UIImageView!
  
  private var indicator: UIActivityIndicatorView!
  
  func awakeFromNib(id: Int, name: String, pokeImageUrl: String) {
    super.awakeFromNib()
    setupUI(id, name: name)
    setupNotification(pokeImageUrl)
  }
  
  deinit {
    pokeImageView.removeObserver(self, forKeyPath: "image")
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  private func setupUI(id: Int, name: String) {
    idLabel.text = id < 10 ? "#00\(id)" : id < 100 ? "#0\(id)" : "#\(id)"
    nameLabel.text = name
    pokeImageView.image = UIImage(named: "default_img")
    
    indicator = UIActivityIndicatorView()
    indicator.center = CGPointMake(CGRectGetMidX(pokeImageView.bounds), CGRectGetMidY(pokeImageView.bounds))
    indicator.activityIndicatorViewStyle = .WhiteLarge
    indicator.startAnimating()
    pokeImageView.addSubview(indicator)
    
    pokeImageView.addObserver(self, forKeyPath: "image", options: [], context: nil)
  }
  
  private func setupNotification(pokeImageUrl: String) {
    NSNotificationCenter.defaultCenter().postNotificationName(downloadImageNotification, object: self, userInfo: ["pokeImageView":pokeImageView, "pokeImageUrl" : pokeImageUrl])
  }

  override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
    if keyPath == "image" {
      indicator.stopAnimating()
    }
  }
}
