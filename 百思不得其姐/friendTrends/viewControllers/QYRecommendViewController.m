//
//  QYRecommendViewController.m
//  百思不得其姐
//
//  Created by lanou on 16/4/6.
//  Copyright © 2016年 xqy. All rights reserved.
//

#import "QYRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import "QYRecommendTypeModel.h"
#import "QYRecommendUserModel.h"
#import "QYRecommendTypeViewCell.h"
#import "QYRecommendUserCell.h"



#define kSelectedCategory self.typeArr[self.typeTableView.indexPathForSelectedRow.row]

@interface QYRecommendViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic)NSMutableArray *typeArr;
@property (strong, nonatomic)NSMutableArray *userArr;

@property (strong, nonatomic) IBOutlet UITableView *typeTableView;
@property (strong, nonatomic) IBOutlet UITableView *userTableView;

/** AFN请求管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

/** 请求参数 */
@property (nonatomic, strong) NSMutableDictionary *params;


@end

@implementation QYRecommendViewController




- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self parseTypeData];
    
    [self createRefresh];
    
    [self setupTableView];
   
    // Do any additional setup after loading the view from its nib.
}

- (void)createRefresh {
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
   
    self.userTableView.mj_footer.hidden = YES;
}
#pragma mark ---UITableView设置
- (void)setupTableView {
    self.navigationItem.title = @"推荐关注";
    self.view.backgroundColor = GlobalColor;
    
    [self.typeTableView registerNib:[UINib nibWithNibName:NSStringFromClass([QYRecommendTypeViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([QYRecommendTypeViewCell class])];
    self.typeTableView.backgroundColor = GlobalColor;

    
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([QYRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([QYRecommendUserCell class])];
    self.userTableView.rowHeight = 70;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.typeTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.typeTableView.contentInset;
}
- (void)parseTypeData {
    //显示指示器
    [SVProgressHUD show];
    
    // 发送请求
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QYLog(@"responseOJ = %@", responseObject[@"list"]);
        //隐藏指示器
        [SVProgressHUD dismiss];
        
        self.typeArr = [QYRecommendTypeModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];

        QYLog(@"typeArr - %@", self.typeArr);
        
       
            [self.typeTableView reloadData];
        
        //默认选中首行
        [self.typeTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        //让用户表格进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"信息加载失败!"];
    }];
}

- (void)loadNewData {
    QYRecommendTypeModel *typeModel = kSelectedCategory;
    
    typeModel.currentPage = 1;

    //请求参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithCapacity:0];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = @(typeModel.id);
    parameters[@"total_page"] = @(typeModel.currentPage);
    self.params = parameters;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //显示指示器
        [SVProgressHUD show];
       
        //字典数据 转 模型数组
        NSArray *users = [QYRecommendUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        QYLog(@"newData = %@", users);
        
        [typeModel.users removeAllObjects];
        
        [typeModel.users addObjectsFromArray:users];
        
        typeModel.total = [responseObject[@"total"] integerValue];
        
        //不是最后一次请求
        if (self.params != parameters) return ;
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.userTableView reloadData];
        });
        //停止刷新
        [self.userTableView.mj_header endRefreshing];
        
        //让底部控件停止刷新
        [self checkFooterState];
        
        //隐藏指示器
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != parameters) return ;
        
        //提醒
        [SVProgressHUD showErrorWithStatus:@"数据加载失败!"];
        
        //结束刷新
        [self.userTableView.mj_header endRefreshing];
        
    }];

}

- (void)loadMoreData {
    QYRecommendTypeModel *typeModel = kSelectedCategory;
    
    //显示指示器
    [SVProgressHUD show];
    
    //请求参数
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithCapacity:0];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = @(typeModel.id);
    parameters[@"page"] = @(++typeModel.currentPage);
    self.params = parameters;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //隐藏指示器
        [SVProgressHUD dismiss];
        
        //字典数据  转 模型数组
        NSArray *users = [QYRecommendUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //添加到当前类中相对应的用户数组中
        [typeModel.users addObjectsFromArray:users];
        
        //不是最后一次请求
        if (self.params != parameters)  return ;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.userTableView reloadData];
        });
        //让底部控件结束刷新
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != parameters) return ;
        
        //提醒
        [SVProgressHUD showErrorWithStatus:@"数据刷新失败"];
        
        //结束刷新
        [self.userTableView.mj_footer endRefreshing];
        
    }];
}

- (void)checkFooterState {
    QYRecommendTypeModel *typeModel = kSelectedCategory;
    
    //每次刷新用户数据时，都控制footer显示或者隐藏
    self.userTableView.mj_footer.hidden = (typeModel.users.count == 0);
    //让底部控件停止刷新
    if (typeModel.users.count == typeModel.total) {
        //加载完毕
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else {
        //还没有加载完毕
        [self.userTableView.mj_footer endRefreshing];
    }
}
#pragma mark ----UITableViewDelegate \ UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.typeTableView) {
        QYLog(@"typeArrCount %lu", self.typeArr.count);
       return self.typeArr.count;
    }
    
    //检查footer的状态
    [self checkFooterState];
    //左边的用户表格
    return [kSelectedCategory users].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.typeTableView) {
        //左边的类别表格
        QYRecommendTypeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([QYRecommendTypeViewCell class]) forIndexPath:indexPath];
        cell.typeModel = self.typeArr[indexPath.row];
        return cell;
    }else {
        //右边的用户表格
        QYRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([QYRecommendUserCell class]) forIndexPath:indexPath];
        cell.userModel = [kSelectedCategory users][indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //结束刷新
    [self.userTableView.mj_footer  endRefreshing];
    
    //开始刷新新点开的标签
    [self.userTableView.mj_header beginRefreshing];

    QYRecommendTypeModel *typeModel = kSelectedCategory;
    if (typeModel.users.count == 0) {
        //显示曾经的数据
        [self.userTableView reloadData];
    }else {
        //刷新表格,目的是，不让用户看到残余数据
        [self.userTableView reloadData];
        
        //进入下拉刷新
        [self.userTableView.mj_header beginRefreshing];
    }
}

#pragma mark  ---控制器的销毁
- (void)dealloc {
    //停止所有操作，防止用户奇怪操作，数据请求一半返回又进入
    [self.manager.operationQueue cancelAllOperations];
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
