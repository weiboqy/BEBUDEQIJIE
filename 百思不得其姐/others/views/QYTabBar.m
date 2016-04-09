//
//  QYTabBar.m
//  百思不得其姐
//
//  Created by lanou on 16/3/30.
//  Copyright © 2016年 xqy. All rights reserved.
//

#import "QYTabBar.h"

@interface QYTabBar ()

@property (strong, nonatomic)UIButton *publish;

@end



@implementation QYTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //tabbar 背景色
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
        //添加发布按钮
        self.publish = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.publish setBackgroundImage: [[UIImage imageNamed:@"tabBar_publish_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [self.publish setBackgroundImage:[[UIImage imageNamed:@"tabBar_publish_click_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
        [self addSubview:self.publish];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //发布按钮的 frame
    //自身的宽和高
    self.publish.bounds = CGRectMake(0, 0, self.publish.currentBackgroundImage.size.width, self.publish.currentBackgroundImage.size.height);
    //自身的中心点
    self.publish.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    //其他按钮的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width / 5;
    CGFloat buttonH = self.frame.size.height;
    NSInteger index = 0; //索引
    for (UIView *button  in self.subviews) {
        //判断条件 如果是分布按钮 或者 不是其他按钮的控件
        if (![button isKindOfClass:[UIControl class]] || button == self.publish) {
            continue;
        }
        CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        //增加索引
        index ++;
    }
}
@end
