//
//  QYNewViewController.m
//  百思不得其姐
//
//  Created by lanou on 16/3/30.
//  Copyright © 2016年 xqy. All rights reserved.
//

#import "QYNewViewController.h"

@implementation QYNewViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" selectImage:@"MainTagSubIconClick" target:self action:@selector(tagSubAction)];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置背景色
    self.view.backgroundColor = GlobalColor;
}
- (void)tagSubAction {
   QYLogFunc;
}

@end
