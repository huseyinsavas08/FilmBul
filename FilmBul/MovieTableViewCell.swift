//
//  MovieTableViewCell.swift
//  FilmBul
//
//  Created by Hüseyin Savaş on 8.12.2022.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var movieYearLabel: UILabel!
    @IBOutlet var moviePosterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: Movie) {
        self.movieTitleLabel.text = model.title
        self.movieYearLabel.text = model.year
        let url = model.poster
        
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                self.moviePosterImageView.image = UIImage(data: data)
            }
        }.resume()
    }
}