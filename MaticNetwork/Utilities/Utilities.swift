//
//  Utilities.swift
//  LetsVentureTask
//
//  Created by kashee kushwaha on 17/01/20.
//  Copyright © 2020 kashee kushwaha. All rights reserved.
//

import Foundation
import  UIKit

struct Colors {
    static let cardViewBGR = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    static let cardCellBGR = UIColor(red: 10/255, green: 178/255, blue: 230/255, alpha: 0.0)
    
    static let darkGreen = UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1)
    
    static let lightGray = UIColor(red: 239/255, green: 240/255, blue: 244/255, alpha: 1)
}


extension Date {
    static func getFormattedDate(string: String , formatter:String) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = formatter
        
        let date: Date? = dateFormatterGet.date(from: string)
        return dateFormatterPrint.string(from: date!);
    }
}

extension UIButton {
    func setBorder() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = Colors.darkGreen.cgColor
    }
}


extension UITextField {
    func setBottomBorder(color:UIColor? = UIColor(red: 226/255, green: 226/255, blue: 229/255, alpha: 1)) {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = color?.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.5)
        self.layer.shadowOpacity = 1.5
        self.layer.shadowRadius = 0.0
    }
}


class MyBetterAlertController : UIAlertController {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
}

public  func showValidationAlert(message : String, presentVc : UIViewController, completion : @escaping () -> Void ) {
    
    let alertVc = MyBetterAlertController.init(title: "", message: message, preferredStyle: .alert)
    alertVc.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
        completion()
    }))
    
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = NSTextAlignment.left
    
    let messageText = NSMutableAttributedString(
        string: message,
        attributes: [
            
            .font: UIFont.boldSystemFont(ofSize: 13)
        ]
    )
    
    alertVc.setValue(messageText, forKey: "attributedMessage")
    
    presentVc.present(alertVc, animated: true, completion: {
        
        
    })
}


