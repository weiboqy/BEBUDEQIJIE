//
//  QYRecommendTypeModel.h
//  百思不得其姐
//
//  Created by lanou on 16/4/7.
//  Copyright © 2016年 xqy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYRecommendTypeModel : NSObject

/** 数量 */
@property (assign ,nonatomic)NSInteger count;
/** 用户id */
@property (assign, nonatomic)NSInteger id;
/** 名称 */
@property (copy, nonatomic)NSString *name;

/** 这个类别对应的用户数据 */
@property (nonatomic, strong) NSMutableArray *users;
/** 总数 */
@property (nonatomic, assign) NSInteger total;
/** 当前页码 */
@property (nonatomic, assign) NSInteger currentPage;


@end
