//
//  SnapTableViewCell.swift
//  NewsDomo-Swift
//
//  Created by Dai Qinfu on 16/4/12.
//  Copyright © 2016年 Wingzki. All rights reserved.
//

import UIKit

import SnapKit

class SnapTableViewCell: UITableViewCell {
    
    lazy var testImageView: UIImageView = {
       
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.gray
        imageView.contentMode     = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds   = true
        
        return imageView;
    }()
    
    lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    var detailLabel = UILabel()
    var typeLabel   = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(testImageView)
        
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(detailLabel)
        self.contentView.addSubview(typeLabel)
        
        detailLabel.numberOfLines = 2;
        detailLabel.font          = UIFont.systemFont(ofSize: 12)
        detailLabel.textColor     = UIColor.gray
        
        testImageView.snp.makeConstraints { (make) in
            
            make.top.bottom.left.equalTo(self.contentView).inset(UIEdgeInsetsMake(10, 10, 10, 0))
            make.width.equalTo(90)
            
        }
        
        titleLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(testImageView.snp.right).offset(10)
            make.top.equalTo(testImageView)
            make.right.equalTo(self.contentView).offset(-10)
            
        }
        
        detailLabel.snp.makeConstraints { (make) in
            
            make.left.equalTo(testImageView.snp.right).offset(10)
            make.bottom.equalTo(testImageView)
            make.right.equalTo(self.contentView).offset(-10)
            
        }
        
        typeLabel.snp.makeConstraints { (make) in
            
            make.bottom.equalTo(self.contentView).offset(-10)
            make.right.equalTo(self.contentView).offset(-10)
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
