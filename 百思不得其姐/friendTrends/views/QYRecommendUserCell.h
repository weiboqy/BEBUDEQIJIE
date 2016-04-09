//
//  QYRecommendUserCell.h
//  百思不得其姐
//
//  Created by lanou on 16/4/7.
//  Copyright © 2016年 xqy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYRecommendUserModel.h"

@interface QYRecommendUserCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headerImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *fans_countLabel;
@property (strong, nonatomic) IBOutlet UIButton *actionButton;

@property (strong, nonatomic)QYRecommendUserModel *userModel;

@end
