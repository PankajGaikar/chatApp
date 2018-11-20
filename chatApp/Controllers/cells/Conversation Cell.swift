//
//  Conversation Cell.swift
//  chatApp
//
//  Created by Krrish  on 20/11/18.
//  Copyright © 2018 Krrish . All rights reserved.
//

import UIKit

class Conversation_Cell: UITableViewCell {

    @IBOutlet weak var messageFromYou: UILabel!
    @IBOutlet weak var messegeFromMe: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
