//
//  QYMeViewController.m
//  百思不得其姐
//
//  Created by lanou on 16/3/30.
//  Copyright © 2016年 xqy. All rights reserved.
//

#import "QYMeViewController.h"

@implementation QYMeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.navigationItem.title = @"我的";
    self.navigationItem.rightBarButtonItems = @[
                                                [UIBarButtonItem itemWithImage:@"mine-setting-icon" selectImage:@"mine-setting-icon-click" target:self action:@selector(settingAction)],
                                                [UIBarButtonItem itemWithImage:@"mine-moon-icon" selectImage:@"mine-moon-icon-click" target:self action:@selector(moonAction)]
                                                
                                                ];
    //设置背景色
    self.view.backgroundColor = GlobalColor;
}

- (void)moonAction {
    QYLogFunc;
}

- (void)settingAction {
    QYLogFunc;
}

@end
