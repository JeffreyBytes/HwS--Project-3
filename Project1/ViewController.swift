//
//  ViewController.swift
//  Project1
//
//  Created by Jeffrey Carpenter on 6/25/20.
//  Copyright © 2020 Jeffrey Carpenter. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Storm Viewer"
        
        getPictures()
    }
    
    // Mark: - General Functions
    
    func getPictures() {
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        sortPicturesArray()
    }
    
    func sortPicturesArray() {
        pictures.sort()
    }
    
    // Mark: - tableView Functions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 1: try loading the "Detail view controller and typecast it to tbe DetailViewController
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailViewController {
            
            // 2: success! Set its selectedImage property
            vc.selectedImage = pictures[indexPath.row]
            vc.selectedImageNumber = indexPath.row
            vc.picturesCount = pictures.count
            
            // 3: now push it onto the navitation controller
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

