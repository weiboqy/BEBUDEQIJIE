//
//  UIButton+QYCustom.m
//  百思不得其姐
//
//  Created by lanou on 16/4/6.
//  Copyright © 2016年 xqy. All rights reserved.
//

#import "UIButton+QYCustom.h"


@implementation UIButton (QYCustom)


+ (instancetype)buttonWithType:(UIButtonType)type frame:(CGRect)frame target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:type];
    button.frame = frame;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
