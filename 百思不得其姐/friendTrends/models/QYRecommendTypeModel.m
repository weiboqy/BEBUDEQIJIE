//
//  QYRecommendTypeModel.m
//  百思不得其姐
//
//  Created by lanou on 16/4/7.
//  Copyright © 2016年 xqy. All rights reserved.
//

#import "QYRecommendTypeModel.h"

@implementation QYRecommendTypeModel

//- (void)setValue:(id)value forKey:(NSString *)key {
//    if ([key isEqualToString:@"id"]) {
//        _ID = value;
//    }
//}
- (NSMutableArray *)users {
    if (_users == nil) {
        _users = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _users;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
