//
//  FeedViewController.swift
//  Marslink
//
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import UIKit
import IGListKit

class FeedViewController: UIViewController {
  
  fileprivate let loader = JournalEntryLoader()
  fileprivate let pathfinder = Pathfinder()
  
  fileprivate let collectionView: IGListCollectionView = {
    let view = IGListCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    view.backgroundColor = UIColor.black
    return view
  }()
  
  fileprivate lazy var adapter: IGListAdapter = {
    return IGListAdapter(updater: IGListAdapterUpdater(), viewController: self, workingRangeSize: 0)
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    func setupUI() {
      view.addSubview(collectionView)
    }
    
    func setupDateSource() {
      loader.loadLatest()
      
      adapter.collectionView = collectionView
      adapter.dataSource = self
    }
    
    setupUI()
    setupDateSource()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    collectionView.frame = view.bounds
  }
}

extension FeedViewController: IGListAdapterDataSource {
  /// Populate data to collection view.
  ///
  /// - Parameter listAdapter: The adapter for IGList.
  /// - Returns: Data objects to show on collection view.
  func objects(for listAdapter: IGListAdapter) -> [IGListDiffable] {
    var items: [IGListDiffable] = pathfinder.messages
    items += loader.entries as [IGListDiffable]
    return items
  }
  
  /// Asks the section controller for each data object.
  ///
  /// - Parameters:
  ///   - listAdapter: The adapter for IGList.
  ///   - object: The data object.
  /// - Returns: The secion controller for data object.
  func listAdapter(_ listAdapter: IGListAdapter, sectionControllerFor object: Any) -> IGListSectionController {
    if object is Message {
      return MessageSectionController()
    } else {
      return JournalSectionController()
    }
  }
  
  /// Requests a view when list is empty.
  ///
  /// - Parameter listAdapter: The adapter for IGList.
  /// - Returns: The view shown when list is empty.
  func emptyView(for listAdapter: IGListAdapter) -> UIView? {
    return nil
  }
}

