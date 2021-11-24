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
    @IBOutlet var stackView: UIStackView!
    
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
        session.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            guard let weatherInformation = try? decoder.decode(WeatherInformation.self, from: data) else { return }
//            debugPrint(weatherInformation)
            
            DispatchQueue.main.async {
                self?.stackView.isHidden = false
                self?.configureView(weatherInformation: weatherInformation)
            }
        }.resume()
    }
    
    func configureView(weatherInformation: WeatherInformation) {
        citiNameLabel.text = weatherInformation.name
        if let weather = weatherInformation.weather.first {
            weatherLabel.text = weather.description
        }
        temperatureLabel.text = "\(Int(weatherInformation.temp.temp - 273.15))℃"
        maxLabel.text = "최고: \(Int(weatherInformation.temp.tempMax - 273.15))℃"
        minLabel.text = "최저: \(Int(weatherInformation.temp.tempMin - 273.15))℃"
    }
}

