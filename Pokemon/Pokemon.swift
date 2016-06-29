//
//  Pokemon.swift
//  Pokemon
//
//  Created by Alexander Kaplan on 6/27/16.
//  Copyright © 2016 develop. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon{
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionText: String!
    private var _nextEvolutionId: String!
    private var _pokemonURL: String!
    private var _nextEvolutionLvl: String!
    
    var name: String{
        get{
            if _name == nil{
            _name = ""
            }
        return _name
        }
    }
    
    var pokedexId: Int{
            if _pokedexId == nil{
                _pokedexId = 0
            }
           return _pokedexId
    }
    
    var description: String{
        
        if _description == nil{
            _description = ""
        }
        return _description
    }
    
    var type: String{
        if _type == nil{
            _type = ""
        }
        return _type
    }
    
    var defense: String{
        if _defense == nil{
            _defense = ""
        }
        return _defense
    }
    
    var height: String{
        if _height == nil{
            _height = ""
        }
        return _height
    }
    
    var weight: String{
        if _weight == nil{
            _weight = ""
        }
        return _weight
    }
    
    var attack: String{
        if _attack == nil{
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolutionTxt: String{
        if _nextEvolutionText == nil{
            _nextEvolutionText = ""
        }
        return _nextEvolutionText
    }
    
    var nextEvolutionId:String{
        if _nextEvolutionId == nil{
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var pokemonUrl: String{
        return _pokemonURL
    }
    
    var nextEvolutionLvl: String{
        if _nextEvolutionLvl == nil{
            _nextEvolutionLvl = ""
        }
        return _nextEvolutionLvl
    }
    
    init(name: String, pokedexId: Int){
        _name = name
        _pokedexId = pokedexId
        _pokemonURL = "\(URL_Base)\(URL_POKEMON)\(self._pokedexId)"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete){
        let url = NSURL(string: _pokemonURL)!
        Alamofire.request(.GET, url).responseJSON{ response in
            let result = response.result
            
            //Now parse the JSON! (its a dictionary)
            if let dict = result.value as? Dictionary<String,AnyObject>{
                if let weight =  dict["weight"] as? String{
                    self._weight = weight
                }
                if let height = dict["height"] as? String{
                    self._height = height
                }
                if let attack = dict["attack"] as? Int{
                    self._attack = "\(attack)"
                }
                if let defense = dict["defense"] as? Int{
                    self._defense = "\(defense)"
                }
                if let types = dict["types"] as? [Dictionary<String,String>] where types.count>0{
                    if let name = types[0]["name"]{
                        self._type = name.capitalizedString
                    }
                    
                    if types.count>1{
                        for x in 1..<types.count{
                            let name = types[x]["name"]!
                            self._type = "\(self._type)/\(name.capitalizedString)"
                        }
                        
                    }
                } else{
                    self._type = ""
                }
                
                
                if let descriptionArray = dict["descriptions"] as? [Dictionary<String,String>] where descriptionArray.count>0{
                
                    if let url = descriptionArray[0]["resource_uri"]{
                        
                        let NSurl = NSURL(string: "\(URL_Base)\(url)")!
                        Alamofire.request(.GET, NSurl).responseJSON{ response in
                            let descResult = response.result
                            if let descDict = descResult.value as? Dictionary<String, AnyObject>{
                                if let description = descDict["description"] as? String{
                                    self._description = description
                                    print(self._description)
                                }
                            }
                            completed()
                        }
                    }
                }else{
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String,AnyObject>]where evolutions.count>0{
                    if let to = evolutions[0]["to"] as? String{
                        //mega is not found
                        if to.rangeOfString("mega") == nil{
                            if let uri = evolutions[0]["resource_uri"] as? String{
                                let newStr = uri.stringByReplacingOccurrencesOfString(URL_POKEMON, withString: "")
                                let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                self._nextEvolutionId = num
                                self._nextEvolutionText = to
                                print(self._nextEvolutionText)
                            }
                        }
                    }
                
                    if let lvl = evolutions[0]["level"] as? Int{
                        self._nextEvolutionLvl = "\(lvl)"
                        print((self._nextEvolutionLvl))
                    }
                
                }
            }
            
        }
       completed()
    }
    
}