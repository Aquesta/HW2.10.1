//
//  ViewController.swift
//  HW2.10.1
//
//  Created by Aquesta 's on 21.09.2020.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var numberTFOutlet: UITextField!
    @IBOutlet var factTFOutlet: UILabel!
    @IBOutlet var selectedNumberLabelOutlet: UILabel!
    
    var facts: Fact!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.getFact(typeRequest: .general, typeFactRequest: nil, number: "50") { fact in
            self.facts = fact
            DispatchQueue.main.async {
                self.selectedNumberLabelOutlet.text = String(self.facts.number)
                self.factTFOutlet.text = self.facts.text
            }
        }
    }

    @IBAction func getFactAction() {
        guard let number = numberTFOutlet.text, !number.isEmpty else {
            showAlert(title: "Oooooops!😱",
                      message: "Enter the number")
            return
        }
        
        guard let _ = Int(number) else {
            showAlert(title: "Oooooops!😱",
                      message: "Алексей это не число")
            return
        }
        
        NetworkManager.shared.getFact(typeRequest: .general, typeFactRequest: nil, number: number) { fact in
            self.facts = fact
            DispatchQueue.main.async {
                self.selectedNumberLabelOutlet.text = String(self.facts.number)
                self.factTFOutlet.text = self.facts.text
            }
        }
    }

    @IBAction func getRandomMathAction() {
        NetworkManager.shared.getFact(typeRequest: .random, typeFactRequest: .math, number: nil) { fact in
            self.facts = fact
            DispatchQueue.main.async {
                self.selectedNumberLabelOutlet.text = String(self.facts.number)
                self.factTFOutlet.text = self.facts.text
            }
        }
    }

    @IBAction func getRandomDateAction() {
        NetworkManager.shared.getFact(typeRequest: .random, typeFactRequest: .year, number: nil) { fact in
            self.facts = fact
            DispatchQueue.main.async {
                self.selectedNumberLabelOutlet.text = String(self.facts.number)
                self.factTFOutlet.text = self.facts.text
            }
        }
    }

    @IBAction func getRandomTriviaAction() {
        NetworkManager.shared.getFact(typeRequest: .random, typeFactRequest: .trivia, number: nil) { fact in
            self.facts = fact
            DispatchQueue.main.async {
                self.selectedNumberLabelOutlet.text = String(self.facts.number)
                self.factTFOutlet.text = self.facts.text
            }
        }
    }
}

// MARK: - Alert Controller

extension ViewController {
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = nil
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: Text Field Delegate

extension ViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
