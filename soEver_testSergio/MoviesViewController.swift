//
//  MoviesViewController.swift
//  soEver_testSergio
//
//  Created by Ruben Dominguez on 22/3/18.
//  Copyright © 2018 Jorge. All rights reserved.
//

import UIKit
import PromiseKit
import Kingfisher
import PKHUD

class MoviesViewController: UIViewController {
    
    //MARK: - Properties
    var arrayGenerico : [GenericModel] = []
    var refresh = UIRefreshControl()
    var customCell : MovieCustomCell?
    
    //MARK: - IBOutlets
    @IBOutlet weak var myCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Peliculas"
        
        self.myCollectionView.delegate = self
        self.myCollectionView.dataSource = self
        
        llamadaGenerica()
        
        refresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresh.addTarget(self, action: #selector(self.refreshMovies), for: .valueChanged)
        myCollectionView.addSubview(refresh)

        // Do any additional setup after loading the view.
    }
    
    func refreshMovies(){
        llamadaGenerica()
        self.refresh.endRefreshing()
    }
    
    func llamadaGenerica() {
        let parser = ParserGenerico()
        
        HUD.show(.progress)
        parser.getDataFromWeb("us",
                              firstPath: CONSTANTES.ARGUMENTOS.MOVIES_FIRST_PATH,
                              secondPath: CONSTANTES.ARGUMENTOS.MOVIES_SECOND_PATH,
                              nElements: "20") { (result) in
                                DispatchQueue.main.async {
                                    self.arrayGenerico = result
                                    self.myCollectionView.reloadData()
                                    PKHUD.sharedHUD.hide(afterDelay: 0)
                                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFromMovies" {
            let VcDetail = segue.destination as! GenericDetailViewController
            let selectId = myCollectionView.indexPathsForSelectedItems?.first?.row
            let objectId = arrayGenerico[selectId ?? 0]
            
            VcDetail.dataModel = objectId
            VcDetail.imageDetail = diccionarioImagenes[objectId.id!]!
        }
    }

}

//MARK: - Extension
extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collecitonView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayGenerico.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MovieCustomCell
        let model = arrayGenerico[indexPath.row]
        if let pathImage = model.artworkUrl100{
            cell.myMovieImg.kf.setImage(with: ImageResource(downloadURL: URL(string: pathImage)!),
                                         placeholder: nil,
                                         options: [.transition(ImageTransition.fade(1))],
                                         progressBlock: nil,
                                         completionHandler: { (imageData, error, cacheType, imageUrl) in
                                            guard let imageDataDes = imageData else {return}
                                            diccionarioImagenes[model.id!] = imageDataDes
                                            
            })
        }
        
        customCell = cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imagenSeleccionada = customCell?.myMovieImg.image
        performSegue(withIdentifier: "showFromMovies", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellSpacing = CGFloat(1)
        let leftRightMar = CGFloat(20)
        let numColmuns = CGFloat(2)
        let totalCellSpace = cellSpacing * (numColmuns - 1)
        let screenWidth = UIScreen.main.bounds.width
        let width = (screenWidth - leftRightMar - totalCellSpace) / numColmuns
        var height = CGFloat(270)
        height = width * height / 180
        return CGSize(width: width, height: height)
    }
    
}
