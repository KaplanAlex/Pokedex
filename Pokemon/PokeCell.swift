//
//  PokeCell.swift
//  Pokemon
//
//  Created by Alexander Kaplan on 6/27/16.
//  Copyright © 2016 develop. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    //Outlets
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    //Variables
    var pokemon: Pokemon!
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }
    
    func configureCell(pokemon: Pokemon){
        self.pokemon = pokemon
        nameLbl.text = self.pokemon.name.capitalizedString
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
}
