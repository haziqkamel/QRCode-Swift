//
//  ViewController.swift
//  QRCode Swift
//
//  Created by USER on 8/29/22.
//

import UIKit
import QRCode

class ViewController: UIViewController {
    
    @IBOutlet weak var qrImage: UIImageView!
    @IBOutlet weak var generateQrButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        generateQrButton.setTitle("Generate QR", for: .normal)
    }
    
    @IBAction func qrGenerateOnPressed(_ sender: Any) {
        let doc = QRCode.Document()
        
        // Set the data, and correction level
        doc.utf8String = "https://tgt.wtf"
        doc.errorCorrection = .high
        
        //Set the EyeShape
        doc.design.backgroundColor(UIColor.white.cgColor)
        doc.design.shape.eye = QRCode.EyeShape.Circle()
        doc.design.shape.onPixels = QRCode.PixelShape.Circle()
        doc.design.shape.offPixels = QRCode.PixelShape.Circle()
        doc.design.style.offPixels = QRCode.FillStyle.Solid(UIColor.white.cgColor)
        
        // Set the pixels color
        // Set the fill color for the data to radial gradient
        let linear = QRCode.FillStyle.LinearGradient(
            DSFGradient(pins: [
                DSFGradient.Pin(colorWithHexString(hexString: "#e42268").cgColor, 0),
                DSFGradient.Pin(colorWithHexString(hexString: "#8392c9").cgColor, 1)
            ])!
//            ,
//            startPoint: CGPoint(x: 0, y: 0),
//            endPoint: CGPoint(x: 1, y: 1)
        )
        
        doc.design.style.onPixels = linear
        
        let generatedImage = doc.uiImage(CGSize(width: 400, height: 400))
        
        qrImage.image = generatedImage
    }
    
    private func colorWithHexString(hexString: String, alpha:CGFloat = 1.0) -> UIColor {
        
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexStr: hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    private func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        hexInt = UInt32(bitPattern: scanner.scanInt32(representation: .hexadecimal) ?? 0)
        return hexInt
    }
    
}

