//
//  BooksViewController.swift
//  soEver_testSergio
//
//  Created by Ruben Dominguez on 22/3/18.
//  Copyright © 2018 Jorge. All rights reserved.
//

import UIKit
import PKHUD
import PromiseKit
import Kingfisher

class BooksViewController: UIViewController {
    
    //MARK: - Variables Locales
    var arrayGenerico : [GenericModel] = []
    var refresh = UIRefreshControl()
    var customCell : CustomBookCell?
    
    //MARK: - IBOutlet
    @IBOutlet weak var myTableView: UITableView!
    
    //MARK: - IBActions
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Libros"
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        myTableView.register(UINib(nibName: CustomBookCell.defaultIdentifier, bundle: nil), forCellReuseIdentifier: CustomBookCell.defaultIdentifier)
        
        llamadaGenerica()
        
        refresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresh.addTarget(self, action: #selector(self.refreshApps), for: .valueChanged)
        myTableView.addSubview(refresh)

        // Do any additional setup after loading the view.
    }
    
    func refreshApps() {
        llamadaGenerica()
        self.refresh.endRefreshing()
    }
    
    func llamadaGenerica() {
        let parser = ParserGenerico()
        
        HUD.show(.progress)
        parser.getDataFromWebObf("us",
                              firstPath: CONSTANTES.ARGUMENTOS.BOOKS_FIRST_PATH,
                              secondPath: CONSTANTES.ARGUMENTOS.BOOKS_SECOND_PATH,
                              nElements: "20") { (result) in
                                DispatchQueue.main.async {
                                    self.arrayGenerico = result
                                    self.myTableView.reloadData()
                                    PKHUD.sharedHUD.hide(afterDelay: 0)
                                }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: Extension UITableViewDelegate, UITableViewDataSource
extension BooksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayGenerico.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: CustomBookCell.defaultIdentifier, for: indexPath) as! CustomBookCell
        let model = arrayGenerico[indexPath.row]
        cell.myBookAuthor.text = model.artistName
        cell.myBookDate.text = model.releaseDate
        cell.myBookGenre.text = model.genres?[0].name
        cell.myBookTitle.text = model.name
        if let pathImage = model.artworkUrl100{
            cell.myBookImg.kf.setImage(with: ImageResource(downloadURL: URL(string: pathImage)!),
                                         placeholder: nil,
                                         options: [.transition(ImageTransition.fade(1))],
                                         progressBlock: nil,
                                         completionHandler: nil)
        }
        
        return cell
    }
    
}
