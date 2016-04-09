//
//  QYRecommendUserCell.m
//  百思不得其姐
//
//  Created by lanou on 16/4/7.
//  Copyright © 2016年 xqy. All rights reserved.
//

#import "QYRecommendUserCell.h"

@implementation QYRecommendUserCell


- (void)setUserModel:(QYRecommendUserModel *)userModel {
    _userModel = userModel;
    [_headerImage  sd_setImageWithURL:[NSURL URLWithString:userModel.header] placeholderImage:[UIImage imageNamed:@"header_cry_icon"]];
    _nameLabel.text = [NSString stringWithFormat:@"%@", userModel.screen_name];
    _fans_countLabel.text = [NSString stringWithFormat:@"%@", userModel.fans_count];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
