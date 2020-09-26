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

//    var facts: Fact!

    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkManagerAF.shared.getFact(typeRequest: .general(number: "45"))
        NetworkManagerAF.shared.onCompletion = { fact in
            self.updateUI(fact: fact)
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

        NetworkManagerAF.shared.getFact(typeRequest: .general(number: number))
        NetworkManagerAF.shared.onCompletion = { fact in
            self.updateUI(fact: fact)
        }
    }

    @IBAction func getRandomMathAction() {
        NetworkManagerAF.shared.getFact(typeRequest: .random(typeFactRequest: .math))
        NetworkManagerAF.shared.onCompletion = { fact in
            self.updateUI(fact: fact)
        }
    }

    @IBAction func getRandomDateAction() {
        NetworkManagerAF.shared.getFact(typeRequest: .random(typeFactRequest: .year))
        NetworkManagerAF.shared.onCompletion = { fact in
            self.updateUI(fact: fact)
        }
    }

    @IBAction func getRandomTriviaAction() {
        NetworkManagerAF.shared.getFact(typeRequest: .random(typeFactRequest: .trivia))
        NetworkManagerAF.shared.onCompletion = { fact in
            self.updateUI(fact: fact)
        }
    }

    func updateUI(fact: Fact) {
        DispatchQueue.main.async {
            self.selectedNumberLabelOutlet.text = String(fact.number)
            self.factTFOutlet.text = fact.text
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
