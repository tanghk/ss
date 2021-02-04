//
//  BaseTableController.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import "BaseTableController.h"

@interface BaseTableController ()

@property (nonatomic, strong) UIView *placeHolderView;
@property (nonatomic, strong) UIImageView *placeImageV;
@property (nonatomic, strong) UILabel *placeLabel;

@end

@implementation BaseTableController

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.lineEdgeInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark 初始化数据
- (void)initWithData{
    [super initWithData];
}

#pragma mark 配置导航栏
- (void)initWithNaviUI{
    [super initWithNaviUI];
}

#pragma mark 配置UI
- (void)initWithMainUI{
    [super initWithMainUI];
    
    self.tableFrame = self.view.bounds;
    [self.view addSubview:self.tableView];
}

#pragma mark 设置头部刷新
- (void)setUpHeaderRefresh{
    
    if (self.tableView.mj_header) {
        [self.tableView.mj_header removeFromSuperview];
        self.tableView.mj_header=nil;
    }
    
    @weakify(self);
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self pullDownRefresData];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
}

#pragma mark 设置尾部加载更多
- (void)setUpFooterMoreData{
    
    if (self.tableView.mj_footer) {
        [self.tableView.mj_footer removeFromSuperview];
        self.tableView.mj_footer= nil;
    }
    
    @weakify(self);
    __block MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        @strongify(self);
        footer.stateLabel.hidden = NO;
        [self pullUpMoreData];
    }];
    footer.stateLabel.hidden = NO;
    [footer setTitle: @"" forState:MJRefreshStateIdle];
    if (!self.MJRefreshStateNoMoreDataTitle) {
        self.MJRefreshStateNoMoreDataTitle = @"没有更多数据";
    }
    [footer setTitle: self.MJRefreshStateNoMoreDataTitle forState:MJRefreshStateNoMoreData];
    footer.stateLabel.textColor = Color_MainGray;
    footer.stateLabel.font = [UIFont M_PingFang_RegularOfSize:14];
    self.tableView.mj_footer = footer;
}

- (void)pullDownRefresData{}
- (void)pullUpMoreData{}

#pragma mark 结束刷新
- (void)endRefresh{
    
    if ([self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header endRefreshing];
    }
    
    if ([self.tableView.mj_footer isRefreshing]) {
        [self.tableView.mj_footer endRefreshing];
    }
}

#pragma mark 没有更多数据
- (void)noMoredata{
    
    if (self.tableView.mj_footer) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

#pragma mark 重置上拉状态
- (void)resetNoMoredata{
    
    if (self.tableView.mj_footer) {
        [self.tableView.mj_footer resetNoMoreData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *sectionFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0.01)];
    sectionFootView.backgroundColor = [UIColor whiteColor];
    
    return sectionFootView;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentify=@"indentify";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentify];
    }
    
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_tableView.separatorStyle == UITableViewCellSeparatorStyleNone) {
        return;
    }

    // 下面这几行代码是用来设置cell的上下行线的位置
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:self.lineEdgeInsets];
    }

    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:self.lineEdgeInsets];
    }
    
    //默认为NO
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark 设置tableview的frame
- (void)setTableFrame:(CGRect)tableFrame{
    
    _tableFrame = tableFrame;
    
    if (_tableView) {
        _tableView.frame = tableFrame;
    }
}

#pragma mark 设置UITableViewStyle
- (void)setTableViewStyle:(UITableViewStyle)style{
    
    if (style==UITableViewStylePlain) {
        return;
    }else{
        
        _tableView.delegate = nil;
        _tableView.dataSource= nil;
        [_tableView removeFromSuperview];
        _tableView=nil;
        
        _tableView=[[UITableView alloc]initWithFrame:_tableFrame style:UITableViewStyleGrouped];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        _tableView.estimatedRowHeight=60.0f;
        _tableView.backgroundColor = Color_MainGroud;
                
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            _tableView.scrollIndicatorInsets = _tableView.contentInset;
        } else {
            //Fallback on earlier versions
        }
    }
    
    [self.view addSubview:_tableView];
}

/*
 * creat tableView
 */
- (UITableView*)tableView{
    
    if (_tableView==nil) {
        
        _tableView=[[UITableView alloc]initWithFrame:_tableFrame style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.estimatedRowHeight=60.0f;
        _tableView.backgroundColor = Color_MainGroud;
                        
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            _tableView.scrollIndicatorInsets = _tableView.contentInset;
        } else {
            //Fallback on earlier versions
        }
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}


/*
 *
 *  无数据占位图
 */
#pragma mark 没有数据占位
- (void)noData_placeHolder:(NSString *)title{
    
    if (self.tableView.mj_footer) {
        [self.tableView.mj_footer removeFromSuperview];
        self.tableView.mj_footer= nil;
    }
    
    self.tableView.tableFooterView = self.placeHolderView;
    
    [self.placeHolderView addSubview:self.placeImageV];
    [self.placeHolderView addSubview:self.placeLabel];
    
    self.placeLabel.text = title;

    [self.placeImageV mas_makeConstraints:^(MASConstraintMaker *make) {

        make.size.mas_equalTo(CGSizeMake(200, 164));
        make.centerX.equalTo(self.placeHolderView);
        make.centerY.equalTo(self.placeHolderView).with.offset(-50);
    }];

    [self.placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerX.equalTo(self.placeHolderView);
        make.centerY.equalTo(self.placeHolderView).with.offset(-10);
        make.height.mas_equalTo(20);
    }];
}

#pragma mark 移除占位图
- (void)removePlaceHolderView{
    
    if (!self.tableView.mj_footer) {
        [self setUpFooterMoreData];
    }
    
    [self.placeHolderView removeFromSuperview];
    self.tableView.tableFooterView = nil;
}

/*
 * creat placeHolderView
 */
- (UIView *)placeHolderView{
    
    if (!_placeHolderView) {
        _placeHolderView = [[UIView alloc] initWithFrame:self.view.bounds];
        
    }
    
    return _placeHolderView;
}

/*
 * creat placeImageV
 */
- (UIImageView *)placeImageV{
    
    if (!_placeImageV) {
        _placeImageV = [UIImageView createImageViewWithFrame:CGRectZero imageWithString:@"G_noData_Img"];
    }
    
    return _placeImageV;
}

/*
 * creat placeLabel
 */
- (UILabel *)placeLabel{
    
    if (!_placeLabel) {
        _placeLabel = [UILabel createLabelWithFrame:CGRectZero font:[UIFont M_PingFang_RegularOfSize:14.0] textColor:Color_MainGray textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor clearColor] text:@""];
    }
    
    return _placeLabel;
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
