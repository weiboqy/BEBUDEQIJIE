//
//  QYNavigationViewController.m
//  百思不得其姐
//
//  Created by lanou on 16/4/6.
//  Copyright © 2016年 xqy. All rights reserved.
//

#import "QYNavigationViewController.h"
#import "UIButton+QYCustom.h"


@interface QYNavigationViewController ()

@end

@implementation QYNavigationViewController

+ (void)initialize {
    //②
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];

}
- (void)buttonClick {
    QYLogFunc;
    [self popViewControllerAnimated:YES];
    //①
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

//可以在这个方法中拦截所以push进来的控制器
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count > 0) {
        //如果push进来的不是第一个控制器 才会执行下面的方法
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom frame:CGRectMake(-10, 0, 70, 30) target:self action:@selector(buttonClick)];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        //按钮内部所有所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //内边距设置  上左下右
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        
        //自适应尺寸
//        [button sizeToFit];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        //push之后 Tabbar消失
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    //这句需要放在后面，让viewController可以覆盖上面设置的leftBarBuutonItem
    //@!!!一定要执行这个方法，不然什么都不会显示 包括Tabbar
    [super pushViewController:viewController animated:animated];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
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
