////
////  CourseDetailVC.m
////  FoundingAZ
////
////  Created by mark on 2021/2/3.



#import "GKPageScrollView.h"
#import "CourseDetailHeaderView.h"
#import "CourseDetailListVC.h"
#import "JXCategoryView.h"
#import "CourseDetailWKWebVC.h"
#define kWYHeaderHeight (kScreen_Width * 218.0f / 375+212+10)

@interface  CourseDetailVC ()<GKPageScrollViewDelegate, JXCategoryViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) GKPageScrollView      *pageScrollView;

@property (nonatomic, strong) CourseDetailHeaderView       *headerView;

@property (nonatomic, strong) UIView                *pageView;
@property (nonatomic, strong) JXCategoryTitleView   *categoryView;
@property (nonatomic, strong) UIScrollView          *scrollView;

@property (nonatomic, strong) NSArray               *titles;
@property (nonatomic, strong) NSArray               *childVCs;

@property (nonatomic, strong) UIImageView           *headerBgImgView;
@property (nonatomic, strong) UIVisualEffectView    *effectView;



@end

@implementation  CourseDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    [self initWithNavUI];
    
    [self.view addSubview:self.headerBgImgView];
    [self.view addSubview:self.effectView];
    [self.view addSubview:self.pageScrollView];
    
    [self.pageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(kTopHeight, 0, 0, 0));
    }];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@0);
        make.width.mas_equalTo(kScreen_Width);
        make.height.mas_equalTo(kWYHeaderHeight);
    }];
    
    [self.view addSubview:self.footView];

    [self.pageScrollView reloadData];
}
/*
 * UI部分
 */
- (void)initWithNavUI{
    
    [self setNavigationTitle:@"课程详情" isShowBack:YES hasLine:NO hasRightItem:YES CallBack:^{
        NSLog(@"分享");
    }];
}


#pragma mark - GKPageScrollViewDelegate
- (BOOL)shouldLazyLoadListInPageScrollView:(GKPageScrollView *)pageScrollView {
    return NO;
}

- (UIView *)headerViewInPageScrollView:(GKPageScrollView *)pageScrollView {
    return self.headerView;
}

- (UIView *)pageViewInPageScrollView:(GKPageScrollView *)pageScrollView {
    return self.pageView;
}

- (NSArray<id<GKPageListViewDelegate>> *)listViewsInPageScrollView:(GKPageScrollView *)pageScrollView {
    return self.childVCs;
}

- (void)mainTableViewDidScroll:(UIScrollView *)scrollView isMainCanScroll:(BOOL)isMainCanScroll {
    CGFloat offsetY = scrollView.contentOffset.y;
    

}


#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"刷新数据");
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.pageScrollView horizonScrollViewWillBeginScroll];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.pageScrollView horizonScrollViewDidEndedScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.pageScrollView horizonScrollViewDidEndedScroll];
}

#pragma mark - 懒加载
- (GKPageScrollView *)pageScrollView {
    if (!_pageScrollView) {
        _pageScrollView = [[GKPageScrollView alloc] initWithDelegate:self];
        _pageScrollView.mainTableView.backgroundColor = [UIColor clearColor];
        _pageScrollView.ceilPointHeight = 0;
    }
    return _pageScrollView;
}



- (UIImageView *)headerBgImgView {
    if (!_headerBgImgView) {
        _headerBgImgView = [UIImageView new];
        _headerBgImgView.contentMode = UIViewContentModeScaleAspectFill;
        _headerBgImgView.clipsToBounds = YES;
        _headerBgImgView.image = [UIImage imageNamed:@"wy_bg"];
    }
    return _headerBgImgView;
}

- (UIVisualEffectView *)effectView {
    if (!_effectView) {
        UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        
        _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        _effectView.alpha = 0;
    }
    return _effectView;
}

- (UIView *)pageView {
    if (!_pageView) {
        _pageView = [UIView new];
        _pageView.backgroundColor = [UIColor clearColor];
        
        [_pageView addSubview:self.categoryView];
        [_pageView addSubview:self.scrollView];
    }
    return _pageView;
}

- (JXCategoryTitleView *)categoryView {
    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 40.0f)];
        _categoryView.titles = self.titles;
        _categoryView.delegate = self;
        _categoryView.titleColor = [UIColor blackColor];
        _categoryView.titleSelectedColor = Color_MainRed;
        _categoryView.titleFont = [UIFont systemFontOfSize:16.0f];
        _categoryView.titleSelectedFont = [UIFont boldSystemFontOfSize:16.0f];
//        _categoryView.cellChangeInHalf = YES;   // 当scrollView滑动到一半时改变cell状态
        
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorColor =Color_MainRed;
        lineView.indicatorWidth = 30.0f;
        lineView.lineStyle = JXCategoryIndicatorLineStyle_Lengthen;
        _categoryView.indicators = @[lineView];
        
        _categoryView.contentScrollView = self.scrollView;
        
//        // 添加分割线
//        UIView *btmLineView = [UIView new];
//        btmLineView.frame = CGRectMake(0, 40 - 0.5, kScreenW, 0.5);
//        btmLineView.backgroundColor = GKColorGray(200);
//        [_categoryView addSubview:btmLineView];
    }
    return _categoryView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        CGFloat scrollW = kScreen_Width;
        CGFloat scrollH =kScreen_Height - kTopHeight -55-kBottomHeight- 40.0f;
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, scrollW, scrollH)];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
   
        
        [self.childVCs enumerateObjectsUsingBlock:^(UIViewController *vc, NSUInteger idx, BOOL * _Nonnull stop) {
            [self addChildViewController:vc];
            [self->_scrollView addSubview:vc.view];
            
            vc.view.frame = CGRectMake(idx * scrollW, 0, scrollW, scrollH);
        }];
        _scrollView.contentSize = CGSizeMake(self.childVCs.count * scrollW, 0);
                                                                     
    }
    return _scrollView;
}

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"详情", @"节目"];
    }
    return _titles;
}

- (NSArray *)childVCs {
    if (!_childVCs) {
        CourseDetailListVC *hotVC = [CourseDetailListVC new];
        CourseDetailWKWebVC *albumVC = [CourseDetailWKWebVC new];
     
        
        _childVCs = @[hotVC, albumVC];
    }
    return _childVCs;
}


/*
 * creat headerView
 */
- (CourseDetailHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[CourseDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width,kWYHeaderHeight)];
        
    }
    return _headerView;
}

/*
 * creat footView
 */
- (UIView *)footView{
    
    if (!_footView) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreen_Height-55-kBottomHeight, kScreen_Width, 55+kBottomHeight)];
        _footView.backgroundColor = [UIColor whiteColor];
        
        UIButton *nextBtn = [UIButton createButtonWithFrame:CGRectMake(72, 10, kScreen_Width-72-20, 35) titleColor:[UIColor whiteColor] font:[UIFont M_PingFang_MediumOfSize:Font_17] backgroundColor:Color_MainRed title:@"立即报名"];
        ViewShadow(nextBtn, Color_MainRed, CGSizeMake(0, 2), 6, 0.3);
        nextBtn.layer.cornerRadius = 35/2;
        [nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_footView addSubview:nextBtn];
        
        NSArray *colorArray = @[(id)[rgba(239, 69, 2, 1) CGColor],
                                (id)[rgba(255, 107, 48, 1) CGColor]];
        NSArray *colorLocationArray = @[@0, @1];
        CAGradientLayer *nextBtnLayer =  [CAGradientLayer layer];
        nextBtnLayer.frame = CGRectMake(0, 0, CGRectGetWidth(nextBtn.bounds), CGRectGetHeight(nextBtn.bounds));
        [nextBtnLayer setLocations:colorLocationArray];
        [nextBtnLayer setColors:colorArray];
        [nextBtnLayer setStartPoint:CGPointMake(1, 0.5)];
        [nextBtnLayer setEndPoint:CGPointMake(0, 0.5)];
        [nextBtnLayer setCornerRadius:35.0/2];
        [nextBtn.layer addSublayer:nextBtnLayer];
        [nextBtn.layer insertSublayer:nextBtnLayer atIndex:0];
        
        
        UIButton *collectionBtn =[UIButton createButtonWithFrame:CGRectMake(25, 16.5, 22, 22) normalImage:@"Course_Detail_Collection" selectedImage:@"Course_Detail_Collection1"];
        [collectionBtn  addTarget:self action:@selector(collectionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        collectionBtn .backgroundColor = [UIColor whiteColor];
        [_footView addSubview:collectionBtn];
        
    }
    
    return _footView;
}
-(void)nextBtnClick:(UIButton *)btn{
    
}
#pragma mark 眼睛按钮点击事件
- (void)collectionBtnClick:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        
    }else{
        
    }
}
@end
