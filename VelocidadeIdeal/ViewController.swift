//
//  ViewController.swift
//  VelocidadeIdeal
//
//  Created by Palloma Ramos on 02/03/20.
//  Copyright © 2020 Palloma Ramos. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    
    var maximas: [String] = ["40", "50", "60", "70", "80"]
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //        if row == 0 {
        //            return "40"
        //        }
        //        else if row == 1{
        //            return "50"
        //        }
        //        else {
        //            return "60"
        //        }
        
        exLabel.isHidden = false
        helpView.isHidden = true
        resultLabel.layer.cornerRadius = 10
        resultLabel.layer.masksToBounds = true
        
        return maximas[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        maximas.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerVelocidade.dataSource = self
        pickerVelocidade.delegate = self
    }
    
    
    var distancia:Int = 0
    var tempo:Int = 0
    var modo:String = "0"
    
    
    @IBOutlet var segmentedcontrol: UISegmentedControl!
    
    @IBAction func helpButton(_ sender: UIButton) {
        helpView.isHidden = false
        background.layer.masksToBounds = true
    }
    
    @IBOutlet var helpView: UIView!
//    @IBAction func tudoCertoButton(_ sender: Any) {
//        helpView.isHidden = true
//    }
    
    @IBAction func indexChanged(_ sender: Any) {
        
        switch segmentedcontrol.selectedSegmentIndex
            
        {
        case 0:
            //            textLabel.text = "Modo: carro"
            modo = "carro"
            pickerVelocidade.isUserInteractionEnabled = true
            labelVelocidade.textColor = UIColor.black
        case 1:
            //            textLabel.text = "Modo: pessoa"
            modo = "pessoa"
            pickerVelocidade.isUserInteractionEnabled = false
            labelVelocidade.textColor = UIColor.gray
            //            self.pickerVelocidade.backgroundColor = UIColor.gray
            
            
        default:
            break
        }
    }
    
    @IBOutlet var perto: UISegmentedControl!
    
    //    @IBOutlet var label: UILabel!
    
    @IBAction func semaforo(_ sender: Any) {
        switch perto.selectedSegmentIndex
            
        {
        case 0:
            //            label.text = "100"
            distancia = 100
        case 1:
            //            label.text = "300"
            distancia = 300
        case 2:
            //            label.text = "500"
            distancia = 500
        default:
            break
        }
        
    }
    
    
    @IBOutlet var color: UISegmentedControl!
    
    //    @IBOutlet var seconds: UILabel!
    
    
    @IBAction func time(_ sender: Any) {
        
        switch color.selectedSegmentIndex
            
        {
        case 0:
            //            seconds.text = "40"
            tempo = 40
            
        case 1:
            //            seconds.text = "30"
            tempo = 30
            
        case 2:
            //            seconds.text = "15"
            tempo = 15
            
        default:
            break
        }
    }
    
    //    @IBAction func transporte(_ sender: UISegmentedControl) {
    //
    //        if sender == segmentedcontrol {
    //            print ("você tocou no carro")
    //
    //        }
    //
    //        else {
    //            print("Você tocou na pessoa")
    //        }
    //    }
    
    
    @IBOutlet var exLabel: UILabel!
    @IBOutlet var resultLabel: UILabel!
    
    
    @IBOutlet var pickerVelocidade: UIPickerView!
    @IBOutlet var labelVelocidade: UILabel!
    //    @IBOutlet var textFieldVelocidade: UITextField!
    
    @IBAction func concluir() {
        
        concluirButton.layer.cornerRadius = 7
       concluirButton.layer.masksToBounds = true
        
        exLabel.isHidden = true
        
        let maxima = lePicker()
        //print(maxima)
        
        let ideal = transformarMsEmKmh(semaforo: distancia, cor: tempo)
        
        if modo == "carro" && ideal>maxima
        {
            exibe(resultado:maxima)
            //resultLabel.isHidden = false
        }
        else{
            exibe(resultado:ideal)
            //resultLabel.isHidden = false
        }
    }
    
    
    @IBAction func tapView(_ sender: Any) {
         helpView.isHidden = true
        
    }
    
    @IBOutlet var concluirButton: UIButton!
    
    
    func lePicker() -> Int {
        
        //Lê o que está selecionado no picker da velocidade
        //        let velocidade = pickerVelocidade
        //        //transformar o texto em int
        //        let velocidadeInt = Int(velocidade)!
        //
        //        //print(velocidadeInt)
        //
        //        return velocidadeInt
        
        let linhaSelecionada:Int = pickerVelocidade.selectedRow(inComponent: 0)
        let max = maximas[linhaSelecionada]
        let velocidade: Int
        if max == "40"{
            velocidade = 40
        }
        else if max == "50" {
            velocidade = 50
        }
        else if max == "60"{
            velocidade = 60
        }
        else if max == "70"{
            velocidade = 70
        }
        else{
            velocidade = 80
        }
        return velocidade
    }
    
    
    func transformarMsEmKmh(semaforo:Int,cor:Int)->Int{
        
        var resultado = (Double(semaforo) / Double(cor))*3.6
        
        if modo == "carro"{
        }
        else {
            resultado = resultado - Double(20)
            if resultado < 0{
                resultado = 0
            }
            else if resultado > 30 {
                resultado = 30
            }
        }
        
        
        return Int(resultado)
        //Transforma m/s em km/h
        
    }
    
    func exibe(resultado: Int){
        //Escreve na label de resultados o valor calculado em Km/h
        let maximaString = "\(resultado) km/h"
        // isso se chama interpolacão
        
        resultLabel.text = maximaString
        //Exibe a label de resultados e botão de recalcular
        
    }
    
    
    
    
    //    override func viewDidLoad() {
    //        super.viewDidLoad()
    //
    //        let ideal: Velocidade = Velocidade(maxima: 50, metros: 500, segundos: 20)
    //        //ideal é uma constante do tipo velocidade
    //        // ideal = Velocidade()
    //
    //        print (ideal.maxima)
    //    }
    //

    @IBOutlet var background: UILabel!
    
    
}

extension UIView {

@IBInspectable
var cornerRadius: CGFloat {
    get {
        return layer.cornerRadius
    }
    set {
        layer.cornerRadius = newValue
    }
}
}
