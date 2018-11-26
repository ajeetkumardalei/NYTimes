//
//  NewsCell.swift
//  NYTimeDemo
//
//  Created by Ajeet on 26/11/18.
//  Copyright © 2018 Ajeet. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet weak var imgvw: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAbstract: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setup(){
        lblTitle.text = nil
        lblAbstract.text = nil
        lblDate.text = nil
        
        let calayr = imgvw.layer
        calayr.cornerRadius = imgvw.bounds.size.height/2
        calayr.masksToBounds = true
        imgvw.backgroundColor = UIColor.lightGray
        
    }
    
}
