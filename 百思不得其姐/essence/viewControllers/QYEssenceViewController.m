//
//  QYEssenceViewController.m
//  百思不得其姐
//
//  Created by lanou on 16/3/30.
//  Copyright © 2016年 xqy. All rights reserved.
//

#import "QYEssenceViewController.h"

@implementation QYEssenceViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" selectImage:@"MainTagSubIconClick" target:self action:@selector(tagSubAction)];
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    //设置背景色
    self.view.backgroundColor = GlobalColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIViewController *ew = [[UIViewController alloc]init];
    ew.view.backgroundColor = [UIColor orangeColor];
    [self.navigationController pushViewController:ew animated:YES];
}
- (void)tagSubAction {
    QYLogFunc;
}

@end
