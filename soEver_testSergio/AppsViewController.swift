//
//  AppsViewController.swift
//  soEver_testSergio
//
//  Created by Ruben Dominguez on 22/3/18.
//  Copyright © 2018 Jorge. All rights reserved.
//

import UIKit
import PKHUD

class AppsViewController: UIViewController {
    
    //MARK: - Variables Locales
    var dataMeses : [GenericModel] = []
    
    //MARK: - IBOutlet
    @IBOutlet weak var myTableView: UITableView!
    
    //MARK: - IBActions
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movies"
        
        HUD.show(.progress)
        ParserGenerico.shared.getDataFromWeb { (results) in
            //HUD.flash(.success, delay: 1.0)
            
            DispatchQueue.main.async {
                self.dataMeses = results
                self.myTableView.reloadData()
                PKHUD.sharedHUD.hide(afterDelay: 0)
            }
        }
        
        myTableView.delegate = self
        myTableView.dataSource = self
        // Do any additional setup after loading the view.
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
        return dataMeses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let model = dataMeses[indexPath.row]
        cell.textLabel?.text = model.id
        return cell
    }
    
}
