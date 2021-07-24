import UIKit

class DailyWeatherCell: UITableViewCell {
    static var identifier: String = "DailyWeatherCell"
    let dataLabel=UILabel(frame: CGRect(x: 15, y: 15, width: 100, height: 20))
    let mainImageView=UIImageView(frame: CGRect(x: UIScreen.main.bounds.width/2-25, y: 0, width: 50, height: 50))
    let dayTempLabel=UILabel(frame: CGRect(x: UIScreen.main.bounds.width-70, y: 15, width: 20, height: 20))
    let nightTempLabel=UILabel(frame: CGRect(x: UIScreen.main.bounds.width-40, y: 15, width: 20, height: 20))
    let popLabel=UILabel(frame: CGRect(x: UIScreen.main.bounds.width/2+40, y: 15, width: 50, height: 20))
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: "DailyWeatherCell")
        dataLabel.font = dataLabel.font.withSize(16)
        dataLabel.textColor=UIColor.black
        contentView.addSubview(dataLabel)
        contentView.addSubview(mainImageView)
        
        dayTempLabel.font=dayTempLabel.font.withSize(16)
        dayTempLabel.textColor=UIColor.black
        contentView.addSubview(dayTempLabel)
        
        nightTempLabel.font=nightTempLabel.font.withSize(16)
        nightTempLabel.textColor = UIColor.lightGray
        contentView.addSubview(nightTempLabel)
        
        popLabel.font=popLabel.font.withSize(13)
        popLabel.textColor=UIColor.white
        contentView.addSubview(popLabel)
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
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}


