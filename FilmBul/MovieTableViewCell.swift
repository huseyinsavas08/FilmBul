//
//  MovieTableViewCell.swift
//  FilmBul
//
//  Created by Hüseyin Savaş on 8.12.2022.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: Movie) {
        movieTitleLabel.text = model.title
        movieYearLabel.text = model.year
        guard let url = model.poster else { return }
        
        URLSession.shared.dataTask(with: URL(string: url)!) { data, _, error in
            guard let data = data, error == nil else { return }
            
            DispatchQueue.main.async {
                self.moviePosterImageView.image = UIImage(data: data)
            }
        }.resume()
    }
}
