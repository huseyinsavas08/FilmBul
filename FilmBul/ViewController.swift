//
//  ViewController.swift
//  FilmBul
//
//  Created by Hüseyin Savaş on 8.12.2022.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    var movies: [Movie] = []
    let networkController = NetworkController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchMovies()
        
        return true
    }
    
    func searchMovies() {
        textField.resignFirstResponder()

        guard let text = textField.text, !text.isEmpty else { return }

        movies.removeAll()
        
        let query = text.replacingOccurrences(of: " ", with: "%20")
        networkController.getData(query: query) { [weak self] data in
            let newMovies = data?.search
            self?.movies.append(contentsOf: newMovies ?? [])
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        cell.configure(with: movies[indexPath.row])
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let url = "https://www.imdb.com/title/\(movies[indexPath.row].imdbID!)/"
        let vc = SFSafariViewController(url: URL(string: url)!)
        present(vc, animated: true)
    }
}

extension ViewController: UITextFieldDelegate {
    
}
