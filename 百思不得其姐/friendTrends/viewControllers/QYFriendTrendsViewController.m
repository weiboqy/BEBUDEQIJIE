//
//  QYFriendTrendsViewController.m
//  百思不得其姐
//
//  Created by lanou on 16/4/6.
//  Copyright © 2016年 xqy. All rights reserved.
//

#import "QYFriendTrendsViewController.h"
#import "QYRecommendViewController.h"

@interface QYFriendTrendsViewController ()

@end

@implementation QYFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" selectImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsAction)];
    
    //设置背景色
    self.view.backgroundColor = GlobalColor;
    // Do any additional setup after loading the view from its nib.
}
- (void)friendsAction {
    QYLogFunc;
    QYRecommendViewController *recommendVC = [[QYRecommendViewController alloc]init];
    [self.navigationController pushViewController:recommendVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
