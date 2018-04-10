//
//  AppsViewController.swift
//  soEver_testSergio
//
//  Created by Ruben Dominguez on 22/3/18.
//  Copyright © 2018 Jorge. All rights reserved.
//

import UIKit
import PKHUD
import PromiseKit
import Kingfisher

class AppsViewController: UIViewController {
    
    //MARK: - Variables Locales
    var arrayGenerico : [GenericModel] = []
    var refresh = UIRefreshControl()
    var customCell : CustomCell?
    
    //MARK: - IBOutlet
    @IBOutlet weak var myTableView: UITableView!
    
    //MARK: - IBActions
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Aplicaciones"
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        //REGISTRO DE LA CELDA
        myTableView.register(UINib(nibName: CustomCell.defaultIdentifier, bundle: nil), forCellReuseIdentifier: CustomCell.defaultIdentifier)
        
        //LLAMADA
        llamadaGenerica()
        
        refresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresh.addTarget(self, action: #selector(self.refreshApps), for: .valueChanged)
        myTableView.addSubview(refresh)
        
//        HUD.show(.progress)
//        ParserGenerico.shared.getDataFromWeb { (results) in
//            //HUD.flash(.success, delay: 1.0)
//
//            DispatchQueue.main.async {
//                self.dataMeses = results
//                self.myTableView.reloadData()
//                PKHUD.sharedHUD.hide(afterDelay: 0)
//            }
//        }
        
        // Do any additional setup after loading the view.
    }
    
    func refreshApps() {
        llamadaGenerica()
        self.refresh.endRefreshing()
    }
    
    func llamadaGenerica() {
        let parser = ParserGenerico()
        
        HUD.show(.progress)
        parser.getDataFromWeb("us",
                              firstPath: CONSTANTES.ARGUMENTOS.APPS_IOS_FIRST_PATH,
                              secondPath: CONSTANTES.ARGUMENTOS.APPS_IOS_SECOND_PATH,
                              nElements: "199",
                              completion: { (result) in
                                DispatchQueue.main.async {
                                     self.arrayGenerico = result
                                    self.myTableView.reloadData()
                                    PKHUD.sharedHUD.hide(afterDelay: 0)
                                }
                                
        })
        
        
        
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
extension AppsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayGenerico.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: CustomCell.defaultIdentifier, for: indexPath) as! CustomCell
        let model = arrayGenerico[indexPath.row]
        cell.myName.text = model.name
        cell.myDate.text = model.releaseDate
        cell.myPrice.text = model.genres?[0].name
        cell.mySummary.text = "Lorem Ipsum"
        if let pathImage = model.artworkUrl100{
            cell.myImageView.kf.setImage(with: ImageResource(downloadURL: URL(string: pathImage)!),
                                                    placeholder: nil,
                                                    options: [.transition(ImageTransition.fade(1))],
                                                    progressBlock: nil,
                                                    completionHandler: nil)
        }
        return cell
    }
    
}
