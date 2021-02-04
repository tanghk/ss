//
//  CourseVC.m
//  FoundingAZ
//
//  Created by mark on 2021/1/29.
//

#import "CourseVC.h"
#import <JXCategoryView/JXCategoryView.h>
@interface CourseVC ()<JXCategoryViewDelegate,UIScrollViewDelegate>{
    
    
    CourseListVC *courseListVC;
}
/**
 菜单项View
 */
@property (nonatomic,strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) UIView                *pageView;
@property (nonatomic, strong) UIScrollView          *scrollView;

@property (nonatomic, strong) NSArray               *titles;
@property (nonatomic, strong) NSMutableArray               *childVCs;
@end

@implementation CourseVC

- (id)init{
    self = [super init];
    
    if (self) {
        
        self.title=@"";
        self.tabBarItem.title=@"课程";
        
        self.tabBarItem.image=[[UIImage imageNamed:@"Tab_course_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.selectedImage=[[UIImage imageNamed:@"Tab_course_red"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:true animated:false];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithNavUI];
    [self requestGoodCategoryData];
}


#pragma mark - 请求数据
- (void)requestGoodCategoryData{
    NSDictionary *token =@{
        @"from":@"APP"
      
                           };
     NSLog(@"字典%@",token);
    NSMutableDictionary *newdic = [NSMutableDictionary dictionaryWithDictionary:token ];
    
    [HttpTool getRequestWithUrl:@"/get-goods-category"
                          Params:newdic
                         success:^(id returnData) {
       
        
    } error:^(NSString *error, NSInteger errorCode) {
       
        
       
    }] ;
    
    
    
    NSDictionary *dic =@{
      
        @"id":@"f6ua"
                           };
     NSLog(@"字典%@",token);
    NSMutableDictionary *listDic = [NSMutableDictionary dictionaryWithDictionary:dic ];
    
    [HttpTool getRequestWithUrl:@"/get-goods-list"
                          Params:newdic
                         success:^(id returnData) {
       
        
    } error:^(NSString *error, NSInteger errorCode) {
       
        
       
    }] ;
    
}
- (void)initWithNavUI{
    
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kTopHeight)];
    navView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:navView];
    CusSearchBar *vSearch = [[CusSearchBar alloc] initWithFrame:CGRectMake(15, kStatusBarHeight+4, kScreen_Width-30, 32)];
    vSearch.textField.enabled = NO;
    __weak typeof(self) weakSelf = self;
    [vSearch addTapGestureWithBlock:^(id sender) {
        [weakSelf searhCoureList];
    }];
    vSearch.backgroundColor = rgba(249, 249, 249, 1);
    vSearch.layer.cornerRadius = 16;
    vSearch.textField.backgroundColor =[UIColor clearColor];
    vSearch.textField.placeholder = @"搜索课程名称";
    vSearch.textField.placeHolderColor = Color_MainGray_one;
    vSearch.textField.font = kFont(13);
    vSearch.textField.textColor = Color_MainGray_one;
    [navView addSubview:vSearch];
    
    
}
-(void)initWithMainUI{
    [super initWithMainUI];
    [self creatCategoryView];
    
}

-(void)searhCoureList{
//    // 1. Create hotSearches array
//    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
//    // 2. Create searchViewController
//    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"Search programming language" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
//
//        [searchViewController.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];
//
//    }];
    SearchListVC *searchVC =[SearchListVC new];
    
    
    
    // 3. present the searchViewController
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchVC];
    nav .modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nav  animated:NO completion:nil];
}

/*
 添加视图
 */
-(void)creatCategoryView{
    //   self.childVCs = [NSMutableArray array];
    [self.view addSubview:self.categoryView];
    [self.view addSubview:self.scrollView];
    
}
#pragma mark - 懒加载
- (JXCategoryTitleView *)categoryView {
    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, kTopHeight, kScreen_Width, 40.0f)];
        _categoryView.backgroundColor = [UIColor whiteColor];
        _categoryView.titles = @[@"全部", @"组织创新", @"业务增长",@"管理创新",@"通用能力"];
        _categoryView.titleFont = [UIFont systemFontOfSize:15.0f];
        _categoryView.titleSelectedFont = [UIFont systemFontOfSize:17.0f];
        _categoryView.titleColor =Color_MainGray;
        _categoryView.titleSelectedColor = Color_MainRed;
        
        _categoryView.delegate = self;
        // 下划线宽度
        
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.lineStyle = JXCategoryIndicatorLineStyle_Normal ;
        _categoryView.indicators = @[lineView];
        lineView.indicatorWidth= 44;
        lineView.indicatorHeight = 3;
        lineView.indicatorColor= Color_MainRed;
        _categoryView.contentScrollView =  self.scrollView;
        
        NSArray *colorArray = @[(id)[rgba(239, 69, 2, 1) CGColor],
                                (id)[rgba(255, 107, 48, 1) CGColor]];
        NSArray *colorLocationArray = @[@0, @1];
        CAGradientLayer *nextBtnLayer =  [CAGradientLayer layer];
        nextBtnLayer.frame = CGRectMake(0, 0, CGRectGetWidth(lineView.bounds), CGRectGetHeight(lineView.bounds));
        [nextBtnLayer setLocations:colorLocationArray];
        [nextBtnLayer setColors:colorArray];
        [nextBtnLayer setStartPoint:CGPointMake(1, 0.5)];
        [nextBtnLayer setEndPoint:CGPointMake(0, 0.5)];
        [nextBtnLayer setCornerRadius:3/2];
        [lineView.layer addSublayer:nextBtnLayer];
        [lineView.layer insertSublayer:nextBtnLayer atIndex:0];
    }
    return _categoryView;
}


- (UIScrollView *)scrollView {
    if (!_scrollView) {
        CGFloat scrollW = kScreen_Width;
        CGFloat scrollH = kScreen_Height-kTopHeight-40-kBottomHeight;
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kTopHeight+40, scrollW, scrollH)];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        _scrollView.backgroundColor =  kColorFromHex(@"#F7F7F7");
        [self.childVCs enumerateObjectsUsingBlock:^(UIViewController *vc, NSUInteger idx, BOOL * _Nonnull stop) {
            [self addChildViewController:vc];
            [self->_scrollView addSubview:vc.view];
            
            vc.view.frame = CGRectMake(idx * scrollW, 0, scrollW, scrollH);
        }];
        _scrollView.contentSize = CGSizeMake(self.childVCs.count * scrollW, 0);
        // _scrollView.scrollEnabled = NO;//滚动
    }
    return _scrollView;
}

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"全部", @"组织创新", @"业务增长",@"管理创新",@"通用能力"];
    }
    return _titles;
}

- (NSMutableArray *)childVCs {
    if (!_childVCs) {
        _childVCs = [NSMutableArray array];
        for (int i = 0; i<self.titles.count; i++) {
            
            CourseListVC *listVC = [[CourseListVC alloc]init];
            [_childVCs addObject:listVC];
        }
        
    }
    return _childVCs;
}
- (BOOL)categoryView:(JXCategoryBaseView *)categoryView canClickItemAtIndex:(NSInteger)index;{
    
    return YES;
}


//点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，不关心具体是点击还是滚动选中的。
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index;{
    
}

//点击选中的情况才会调用该方法
- (void)categoryView:(JXCategoryBaseView *)categoryView didClickSelectedItemAtIndex:(NSInteger)index;{
    
}

//滚动选中的情况才会调用该方法
- (void)categoryView:(JXCategoryBaseView *)categoryView didScrollSelectedItemAtIndex:(NSInteger)index;{
    
}

//正在滚动中的回调
- (void)categoryView:(JXCategoryBaseView *)categoryView scrollingFromLeftIndex:(NSInteger)leftIndex toRightIndex:(NSInteger)rightIndex ratio:(CGFloat)ratio;{
    
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
