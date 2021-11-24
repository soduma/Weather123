//
//  ViewController.swift
//  Weather
//
//  Created by 장기화 on 2021/11/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    @IBOutlet var citiNameLabel: UILabel!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var maxLabel: UILabel!
    @IBOutlet var minLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapPatchButton(_ sender: UIButton) {
        if let citiName = textField.text {
            getCurrentWeather(citiName: citiName)
            view.endEditing(true)
        }
    }
    
    func getCurrentWeather(citiName: String) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(citiName)&appid=0de57519925dcbac571ee1c1b5f7ee4a") else { return }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            let weatherInformation = try? decoder.decode(WeatherInformation.self, from: data)
            debugPrint(weatherInformation)
        }.resume()
    }
}

