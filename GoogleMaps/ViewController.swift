//
//  ViewController.swift
//  GoogleMaps
//
//  Created by admin on 20/03/2020.
//  Copyright © 2020 admin. All rights reserved.
//
import UIKit
import MapKit //Remember to import

class ViewController: UIViewController {
    @IBOutlet var setNewMarker: UILongPressGestureRecognizer!
    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
    }
    override func viewDidAppear(_ animated: Bool) {
    //Sets two markers
        createMarker(title: "Parmas Pizza", lan: 55.654393, lon: 12.4737828)
        createMarker(title: "Royal Arena", lan: 55.6254401, lon: 12.5715215)
             
    }
    @IBAction func setNewMarker(_ sender: UILongPressGestureRecognizer) {//Longpress, dragged in with ctrl
        let touchPoint = setNewMarker.location(in: self.map) //Gets location
        let location = self.map.convert(touchPoint, toCoordinateFrom: self.map)
        //Converts to coordinate
        showAlertSetTitle(location: location) //Show alertdialog and set marker w location

    }
    
    func showAlertSetTitle(location:CLLocationCoordinate2D){ //Need location to set marker
        var titleTextField: UITextField? //Txtfield to enter title for marker
        // Declare Alert message
        let dialogMessage = UIAlertController(title: "Set new marker!", message: "Location name", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "Add marker", style: .default, handler: { (action) -> Void in
            
            if let userInput = titleTextField!.text {
                print("User entered \(userInput)")
                self.createMarker(title: userInput, lan: location.latitude, lon: location.longitude) //Calls create marker with input as title
                //And location.lat & long
            }
        })
        
        // Create Cancel button with action handlder
        let cancelOpr = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
        }
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancelOpr)
        
        // Add Input TextField to dialog message
        dialogMessage.addTextField { (textField) -> Void in
            
            titleTextField = textField
            titleTextField?.placeholder = "Location name"
        }
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    
    func createMarker(title: String, lan: CLLocationDegrees, lon: CLLocationDegrees){
        let marker = MKPointAnnotation() // Initialize empty marker.
        marker.title = title // Message on the marker.
        let location = CLLocationCoordinate2DMake(lan, lon) // Initializing the marker.
        marker.coordinate = location // Add location to the marker.
        map.addAnnotation(marker) //Adds the marker as annotation to map
    }
}
