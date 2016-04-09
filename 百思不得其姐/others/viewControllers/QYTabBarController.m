//
//  QYTabBarController.m
//  百思不得其姐
//
//  Created by lanou on 16/3/25.
//  Copyright © 2016年 xqy. All rights reserved.
//

#import "QYTabBarController.h"
#import "QYMeViewController.h"
#import "QYFriendTrendsViewController.h"
#import "QYNewViewController.h"
#import "QYEssenceViewController.h"
#import "QYTabBar.h"
#import "QYNavigationViewController.h"


@interface QYTabBarController ()

@end

@implementation QYTabBarController

//程序运行期间只会 执行一次
+ (void)initialize {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    //appearance只要方法后面拥有这个属性 都可以设置全局
    //通过appearance来设置所以的item属性
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

//初始化 子视图
- (void)createChildView:(UIViewController *)viewController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
    QYNavigationViewController *naVC = [[QYNavigationViewController alloc]initWithRootViewController:viewController];
    
    //添加子视图
    [self addChildViewController:naVC];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //添加子控制器
    QYEssenceViewController *vc1 = [[QYEssenceViewController alloc] init];
    [self createChildView:vc1 title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    QYNewViewController *vc2 = [[QYNewViewController alloc] init];
    [self createChildView:vc2 title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    QYFriendTrendsViewController *vc3 = [[QYFriendTrendsViewController alloc] init];
    [self createChildView:vc3 title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    QYMeViewController *vc4 = [[QYMeViewController alloc] init];
    [self createChildView:vc4 title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    [self setValue:[[QYTabBar alloc] init] forKeyPath:@"tabBar"];
    
    
    // Do any additional setup after loading the view.
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
