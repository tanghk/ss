//
//  CourseDetailWKWebVC.m
//  FoundingAZ
//
//  Created by mark on 2021/2/3.
//

#import "CourseDetailWKWebVC.h"
#import "WebTableViewCell.h"
@interface CourseDetailWKWebVC ()<UITableViewDelegate, UITableViewDataSource, WKUIDelegate, WKNavigationDelegate>
{
    CGFloat _webHeight;
}
@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic, strong)WKWebView *webView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIScrollView *scrollViews;


@property (nonatomic,assign) BOOL flag;//是否翻转的动画
@property (nonatomic, copy) void(^listScrollViewScrollBlock)(UIScrollView *scrollView);
@end

@implementation CourseDetailWKWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _webHeight = 0.0;
    
    [self setupWebView];
    
    self.dataArray = [NSMutableArray array];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.showsVerticalScrollIndicator = false;
    
    
    
    [self.tableView reloadData];
    
    
    //    UIButton *rollBtn  = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth-90, kScreenHeight-100, 70, 35)];
    //    rollBtn.backgroundColor = [Util colorWithHexString:@"14C5AA"];
    //    [rollBtn addTarget:self action:@selector(rollAction) forControlEvents:UIControlEventTouchUpInside];
    //    [rollBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [rollBtn setTitle:@"翻转动画" forState:UIControlStateNormal];
    //    rollBtn.titleLabel.font  = kFont_Medium(14);
    //    rollBtn.layer.cornerRadius = 5;
    //    [self.view addSubview:rollBtn];
    
    _flag  = false;
}

- (void)setupWebView
{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    config.userContentController = wkUController;
    // 自适应屏幕宽度js
    NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    // 添加js调用
    [wkUController addUserScript:wkUserScript];
    
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width-30, 1) configuration:config];
    
    self.webView.opaque = NO;
    [self.webView sizeToFit];
    self.webView.scrollView.bounces = NO;
    
    self.webView.scrollView.scrollEnabled = NO;//禁用webView滑动
    self.webView.scrollView.userInteractionEnabled = NO;
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/"];
    NSURLRequest *cacheRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:cacheRequest];
    //监听webView.scrollView的contentSize属性
    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
    self.scrollViews = [[UIScrollView alloc] initWithFrame:CGRectMake(15, 55, kScreen_Width-30, 1)];
    [self.scrollViews addSubview:self.webView];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentSize"]) {
        //        __weak typeof(self) weakSelf = self;
        //执行js方法"document.body.offsetHeight" ，获取webview内容高度
        [_webView evaluateJavaScript:@"document.body.offsetHeight" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            CGFloat contentHeight = [result floatValue];
            
            NSLog(@"contentHeight=%f",contentHeight);
            
            _webHeight = contentHeight;
            self.webView.frame = CGRectMake(0, 0, kScreen_Width-30, _webHeight);
            
            self.scrollViews.frame = CGRectMake(15, 55, kScreen_Width-30, _webHeight);
            self.scrollViews.contentSize =CGSizeMake(kScreen_Width-30, _webHeight);
            
            _webHeight += 60;
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
}

#pragma mark tableView代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1 ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return _webHeight;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"ItemBankDetailCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId ];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId ];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone ;
    [cell.contentView addSubview:self.scrollViews];
    return cell;
    
    
}


- (void)dealloc
{
    
    [_webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    !self.listScrollViewScrollBlock ? : self.listScrollViewScrollBlock(scrollView);
}

#pragma mark - GKPageListViewDelegate
- (UIScrollView *)listScrollView {
    return self.tableView;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView * _Nonnull))callback {
    self.listScrollViewScrollBlock = callback;
}
@end
