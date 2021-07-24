import UIKit

class HourWeatherCell: UICollectionViewCell {
    static var identifier: String = "HourWeatherCell"
    let textlabel=UILabel(frame: CGRect(x: 0, y: 3, width: 45, height: 10))
    let tempLabel=UILabel(frame: CGRect(x: 0, y: 45, width: 45, height: 10))
    let imageView=UIImageView(frame: CGRect(x: 0, y: 10, width: 45, height: 40))
    
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            textlabel.font=textlabel.font.withSize(11)
            textlabel.textAlignment = .center
            textlabel.textColor = UIColor.white
            contentView.addSubview(textlabel)
            
            tempLabel.font=tempLabel.font.withSize(11)
            tempLabel.textAlignment = .center
            tempLabel.textColor=UIColor.white
            contentView.addSubview(tempLabel)
            
            contentView.addSubview(imageView)
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }

        override func prepareForReuse() {
            super.prepareForReuse()
            self.reset()
        }

        func reset() {
            // @TOOD: reset things here
        }
    
}

