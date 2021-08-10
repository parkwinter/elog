//
//  CreateViewController.swift
//  elog_ver0
//
//  Created by You Jong Park on 2021/08/11.
//

// youtube 참고 : https://www.youtube.com/watch?v=K_4ZwerOxDs


import UIKit
import HSCycleGalleryView

class CreateViewController: UIViewController, HSCycleGalleryViewDelegate {
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var pagerContainer: UIView!
    
    let pager = HSCycleGalleryView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // carousel ui init
        pager.register(cellClass: PagerCell.self, forCellReuseIdentifier: "PagerCell")
        pager.delegate = self
        pagerContainer.addSubview(pager)
        pager.reloadData()
    }
    
    func changePageControl(currentIndex: Int) {
        pageControl.currentPage = currentIndex
    }
    
    func numberOfItemInCycleGalleryView(_ cycleGalleryView: HSCycleGalleryView) -> Int {
        let count = 3
        pageControl.numberOfPages = count
        pageControl.isHidden = !(count > 1)
        return count
    }
    
    func cycleGalleryView(_ cycleGalleryView: HSCycleGalleryView, cellForItemAtIndex index: Int) -> UICollectionViewCell {
        let cell = cycleGalleryView.dequeueReusableCell(withIdentifier: "PagerCell", for: IndexPath(item: index, section: 0)) as! PagerCell
        
        cell.backgroundColor = UIColor.black
        return cell
    }
    

}
