//
//  ViewController.swift
//  codingassign2
//
//  Created by Igwe Onumah on 12/17/19.
//  Copyright © 2019 Igwe Onumah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var CoverTableView: UITableView!
   
    
  var covers = [Cover]() {
          didSet {
              orderedCovers = order(covers)
          }
      }
      
      var orderedCovers: [Int:[Cover]] = [:] {
          didSet{
              DispatchQueue.main.async {
                  self.CoverTableView.reloadData()
              }
          }
      }
      
      override func viewDidLoad() {
          
          super.viewDidLoad()
          setupData()
          // Do any additional setup after loading the view.
      }
      
      private func setupData()
      {
          getCovers()
      }
      
      private func getCovers()
      {
          CoverManager.shared.getCover{
              [weak self] phts in self?.covers = phts
          
          }
      }
   

      //MARK: Sort
      private func order(_ covers: [Cover]) -> [Int : [Cover]]
      {

          var coverDict = Dictionary(grouping: covers, by: {$0.albumid})
          
          for(key,value) in coverDict{
              coverDict[key] = value.sorted(by: { (coverOne, coverTwo) -> Bool in
                  coverOne.albumid < coverTwo.albumid
              })
          }
          
          return coverDict
      }
      
      private func getCovers(from section: Int) -> [Cover]
      {
          let keys = orderedCovers.keys.sorted(by: {$0 < $1}) //alphabetize, but keys in ascending order
          let key = keys[section]//get the correct key from section (the section has an 'ID', based on the ID, we get the key that corresponds to it's location on the table view
          return orderedCovers[key]! //grabbing the cities for that sepcific section
      }
  }

  extension ViewController: UITableViewDataSource
  {
      func numberOfSections(in tableView: UITableView) -> Int {
          orderedCovers.keys.count
      }
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          getCovers(from: section).count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
          let cell = tableView.dequeueReusableCell(withIdentifier: CoverTableViewCell.identifier, for: indexPath) as! CoverTableViewCell
          
          let covers = getCovers(from: indexPath.section)
          let cover = covers[indexPath.row]
          cell.titleLabel.text = cover.title
          
          cell.albumLabel.text = "Album: \(cover.albumid) + Track: \(cover.trackid)"
          
          DispatchQueue.global(qos: .background).async {
              guard let url = URL(string:cover.thumbnail) else {return}
              
              var data = Data()
              
              do{
                  data = try Data(contentsOf: url)
                  
                  
              }catch{
                  print("Error with image: " + error.localizedDescription)
              }

              
              guard let image = UIImage(data: data) else {return }
              
              DispatchQueue.main.async {
                  cell.coverImage.image = image
              }
          }
          
          
          
          return cell
          
      }
      
      
  }

  extension ViewController: UITableViewDelegate
  {
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 90
      }
      
      func sectionIndexTitles(for tableView: UITableView) -> [Int]? {
          return orderedCovers.keys.sorted(by: {$0 < $1})
      }
      
    private func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> Int? {
          let keys = orderedCovers.keys.sorted(by: {$0 < $1})
          return keys[section]
      }
      
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          tableView.deselectRow(at: indexPath, animated: true)
          let covers = getCovers(from: indexPath.section)
          
          let cover = covers[indexPath.row]
          showCover(of: cover)
         
      }
  }
