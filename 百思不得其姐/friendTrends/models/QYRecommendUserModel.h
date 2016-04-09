//
//  QYRecommendUserModel.h
//  百思不得其姐
//
//  Created by lanou on 16/4/7.
//  Copyright © 2016年 xqy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYRecommendUserModel : NSObject
/** 昵称 */
@property (copy, nonatomic)NSString *screen_name;
/** 粉丝数 */
@property (copy, nonatomic)NSString *fans_count;
/** 头像 */
@property (copy, nonatomic)NSString *header;


@end
