//
//  BaseTableController.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import "PlaceHolderController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableController : PlaceHolderController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) UITableViewStyle tableViewStyle;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) CGRect tableFrame;

@property (nonatomic, assign) UIEdgeInsets lineEdgeInsets;

@property (nonatomic, strong) NSString *MJRefreshStateNoMoreDataTitle;

#pragma mark- 安装上拉和下拉
- (void)setUpHeaderRefresh;//设置头部刷新
- (void)setUpFooterMoreData;//设置尾部加载更多

- (void)pullDownRefresData;
- (void)pullUpMoreData;

- (void)endRefresh;//结束刷新

- (void)noMoredata;//没有更多数据

- (void)resetNoMoredata;//重置上拉状态


//没有数据占位
- (void)noData_placeHolder:(NSString *)title;
//移除占位图
- (void)removePlaceHolderView;

@end

NS_ASSUME_NONNULL_END
