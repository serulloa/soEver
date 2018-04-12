//
//  GenericDetailViewController.swift
//  soEver_testSergio
//
//  Created by Ruben Dominguez on 5/4/18.
//  Copyright © 2018 Jorge. All rights reserved.
//

import UIKit
import MapKit
import Kingfisher
import PKHUD

class GenericDetailViewController: UITableViewController {
    
    //MARK: - Variables
    var dataModel : GenericModel?
    var imageDetail : UIImage?
    var genericArray : [GenericModel] = []
    var latitude = 40.352467
    var longitude = -3.809620
    
    //MARK: - IBOutlets
    @IBOutlet weak var myBackgroundImage: UIImageView!
    @IBOutlet weak var myImageMovie: UIImageView!
    @IBOutlet weak var myFechaModel: UILabel!
    @IBOutlet weak var myTituloModel: UILabel!
    @IBOutlet weak var myNameModel: UILabel!
    @IBOutlet weak var myTitleModel: UILabel!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var mySummaryText: UILabel!
    @IBOutlet weak var myMovilButton: UIButton!
    @IBOutlet weak var myWebSiteButton: UIButton!
    @IBOutlet weak var myEmailMe: UILabel!
    @IBOutlet weak var myMapView: MKMapView!
    
    //MARK: - IBActions
    @IBAction func myMovilCallMeACTION(_ sender: UIButton) {
        guard let telefono = sender.titleLabel?.text else { return }
        llamarMovil(telefono)
        print("Aqui llamando")
    }
    
    @IBAction func myWebSiteACTION(_ sender: Any) {
        guard let web = (sender as! UIButton).titleLabel?.text else { return }
        muestraWebSite(web)
        print("Aqui mostrando la web")
    }
    
    @IBAction func mySearchACTION(_ sender: Any) {
        openMap()
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        llamadaGenerica()
        
        guard let movieDes = dataModel else { return }
        self.title = movieDes.name
        myBackgroundImage.image = imageDetail
        myImageMovie.image = imageDetail
        myTituloModel.text = "Lorem Ipsum es simplemente el texto de relleno de las imprentas "
        myNameModel.text = movieDes.genres![0].name
        myTitleModel.text = movieDes.name
        myFechaModel.text = movieDes.releaseDate
        mySummaryText.text = randomLorem()
        myMovilButton.setTitle("653940573", for: .normal)
        myWebSiteButton.setTitle(movieDes.name, for: .normal)
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
        myMapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        annotation.title = dataModel?.name
        annotation.subtitle = dataModel?.name
        myMapView.addAnnotation(annotation)
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section == 1 && indexPath.row == 0) {
            return UITableViewAutomaticDimension
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }

    //MARK: - Utils
    func llamarMovil(_ telefono : String) {
        guard let phoneCall = URL(string: "tel://\(telefono)") else { return }
        let application : UIApplication = UIApplication.shared
        if application.canOpenURL(phoneCall) {
            application.open(phoneCall,
                             options: [:],
                             completionHandler: nil)
        }
    }
    
    func muestraWebSite(_ url : String) {
        let webVC = self.storyboard?.instantiateViewController(withIdentifier: "WebViewGenericoViewController") as! WebViewGenericViewController
        guard let dataModelDes = dataModel else { return }
        webVC.myUrl = dataModelDes.url
        present(webVC, animated: true, completion: nil)
    }
    
    func openMap() {
        let regionDistance : CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [MKLaunchOptionsMapCenterKey : NSValue(mkCoordinate: regionSpan.center),
                       MKLaunchOptionsMapSpanKey : NSValue(mkCoordinateSpan: regionSpan.span)]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = dataModel?.name
        mapItem.openInMaps(launchOptions: options)
    }
    
    func llamadaGenerica() {
        let parser = ParserGenerico()
        
        HUD.show(.progress)
        parser.getDataFromWeb("us", firstPath: CONSTANTES.ARGUMENTOS.BOOKS_FIRST_PATH, secondPath: CONSTANTES.ARGUMENTOS.BOOKS_SECOND_PATH, nElements: "10") { (result) in
            DispatchQueue.main.async {
                self.genericArray = result
                self.myCollectionView.reloadData()
                PKHUD.sharedHUD.hide(afterDelay: 0)
            }
        }
    }

}

//MARK: - Extension
extension GenericDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genericArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let modelData = genericArray[indexPath.row]
        let customCell = myCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MovieCustomCell
        guard let pathImage = modelData.artworkUrl100 else { return customCell }
        customCell.myMovieImg.kf.setImage(with: ImageResource(downloadURL: URL(string: pathImage)!),
                                          placeholder: nil,
                                          options: [.transition(ImageTransition.fade(1))],
                                          progressBlock: nil,
                                          completionHandler: nil)
        
        return customCell
    }
}
