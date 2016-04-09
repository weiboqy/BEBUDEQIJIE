//
//  QYRecommendTypeViewCell.h
//  百思不得其姐
//
//  Created by lanou on 16/4/7.
//  Copyright © 2016年 xqy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYRecommendTypeModel.h"

@interface QYRecommendTypeViewCell : UITableViewCell

@property (strong, nonatomic)QYRecommendTypeModel *typeModel;
@property (strong, nonatomic) IBOutlet UIView *typeView;


@end
