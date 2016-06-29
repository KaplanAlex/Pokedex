//
//  PokemonDetailVC.swift
//  Pokemon
//
//  Created by Alexander Kaplan on 6/28/16.
//  Copyright © 2016 develop. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexIdLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    
     var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "\(pokemon.pokedexId)")
        nameLbl.text = pokemon.name.capitalizedString
        mainImg.image = image
        currentEvoImg.image = image
        
        pokemon.downloadPokemonDetails { () -> () in
            //Called after the download is done
            print("Did we get here")
            self.updateUI()
        }
    }
    
    func updateUI(){
        self.descriptionLbl.text = self.pokemon.description
        self.typeLbl.text = self.pokemon.type
        self.defenseLbl.text = self.pokemon.defense
        self.heightLbl.text = self.pokemon.height
        self.pokedexIdLbl.text = "\(self.pokemon.pokedexId)"
        self.weightLbl.text = self.pokemon.weight
        self.attackLbl.text = self.pokemon.attack
        
        if pokemon.nextEvolutionId == ""{
            evoLbl.text = "Fully Evolved!"
            nextEvoImg.hidden = true
        }else{
            self.nextEvoImg.hidden = false
            self.nextEvoImg.image = UIImage(named: pokemon.nextEvolutionId)
            var str = "Next Evolution: \(pokemon.nextEvolutionTxt)"
            if pokemon.nextEvolutionTxt != ""{
                str += " - LVL \(pokemon.nextEvolutionLvl)"
                evoLbl.text = str
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
