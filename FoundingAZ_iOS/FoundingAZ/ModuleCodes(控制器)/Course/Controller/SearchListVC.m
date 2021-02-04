//
//  SearchListVC.m
//  FoundingAZ
//
//  Created by mark on 2021/2/1.
//

#import "SearchListVC.h"
#import "IntegratorHomeCell.h"
#import "IntegrHomeHeadView.h"
#import "IntegrCaseDetailVC.h"
#import "SearchCell.h"
#import "SearchNormalLayout.h"
static NSString *SearchHeader_ID = @"searchHeader_ID";
static NSString *SearchCell_ID = @"search_ID";

@interface SearchListVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) NSArray *hotList;

@end

@implementation SearchListVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:true animated:false];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *hots = @[@"热门",@"热门热门",@"热门热门热门",@"热门热门",@"热门",@"热门",@"热热门热门热门门"];
    [self setHotList:hots];
    // Do any additional setup after loading the view.
    [self initWithNavUI];
    [self loadHistorySource];
}
#pragma mark - config data
- (void)setHotDataSource:(NSArray *)datas {
    self.hotList = datas.copy;
    [self.collectionView reloadData];
}

- (void)loadHistorySource {
    [self.collectionView reloadData];
}

- (void)refreshHistoryView {
    [self.collectionView reloadData];
}
#pragma mark - 方法
/*
 * 方法
 */
-(void)navBackBtnClick{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
-(void)searchBtnClicked:(UIButton *)btn{
    
  
}
#pragma mark - private
- (void)saveSearchCacheWith:(NSString *)searchText {
    if (searchText.length > 0) {
        [self.historyList removeObject:searchText];
        [self.historyList insertObject:searchText atIndex:0];
        
        [NSKeyedArchiver archiveRootObject:self.historyList toFile:HISTORY_CACHE_PATH];
        [self.collectionView reloadData];
    }
}

-(void)searchText:(NSString *)searchText{
//    [self.historyList insertObject:searchText atIndex:0];
//    [self.collectionView reloadData];
    [self saveSearchCacheWith:searchText];
    
}
/*
 * UI部分
 */

- (void)initWithNavUI{
    
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kTopHeight)];
    navView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:navView];
    
    UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"G_Nav_back"]];
    backImageView.frame = CGRectMake(15, kStatusBarHeight+(kNavBarHeight-CGRectGetHeight(backImageView.bounds))/2, CGRectGetWidth(backImageView.bounds), CGRectGetHeight(backImageView.bounds));
    backImageView.backgroundColor = [UIColor clearColor];
    [navView addSubview:backImageView];
    
    UIButton *backBtn = [UIButton createButtonWithFrame:CGRectMake(0, kStatusBarHeight, 120, kNavBarHeight) normalImage:@""];
    [backBtn addTarget:self action:@selector(navBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    backBtn.backgroundColor = [UIColor clearColor];
    [navView addSubview:backBtn];
  
    __weak typeof(self) weakSelf = self;
    CusSearchBar *vSearch = [[CusSearchBar alloc] initWithFrame:CGRectMake(52, kStatusBarHeight+4, kScreen_Width-52-63, 32) DidClickSearch:^(NSString *searchText) {
        [weakSelf searchText:searchText];
    }];
    vSearch.backgroundColor = rgba(249, 249, 249, 1);
    vSearch.layer.cornerRadius = 16;
    vSearch.textField.backgroundColor =[UIColor clearColor];
    vSearch.textField.placeholder = @"搜索课程名称";
    vSearch.textField.placeHolderColor = Color_MainGray_one;
    vSearch.textField.font = kFont(13);
    vSearch.textField.textColor = Color_MainBlack;
    [navView addSubview:vSearch];
    [navView addSubview:self.searchBtn];
    UIColor *color =[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1];
    ViewShadow(navView, color, CGSizeMake(0, 1), 7, 1);

}
- (UIButton *)searchBtn {
    if (!_searchBtn) {
        CGFloat  itemWidth  =63;
        CGFloat  itemHeigh  =44;
        _searchBtn = [UIButton createButtonWithFrame:CGRectZero titleColor:Color_MainBlack font:[UIFont M_PingFang_RegularOfSize:14.0] backgroundColor:[UIColor whiteColor] title:@"搜索"];
        _searchBtn.frame = CGRectMake(kScreen_Width-itemWidth,  kStatusBarHeight, itemWidth, itemHeigh);
        [_searchBtn addTarget:self action:@selector(searchBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
    return _searchBtn;
}
- (void)initWithMainUI{
    [super initWithMainUI];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[SearchCell class] forCellWithReuseIdentifier:SearchCell_ID];
    [self.collectionView registerClass:[SearchReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SearchHeader_ID];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (self.historyList.count) {
        return 2;
    }
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.historyList.count) {
        if (section == 0) {
            return self.historyList.count;
            
        } else {
            return self.hotList.count;
        }
    } else {
        return self.hotList.count;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    BOOL showDeleteBtn = NO;
    
    SearchReusableView *header = (SearchReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:SearchHeader_ID forIndexPath:indexPath];
    if (self.historyList.count) {
        header.title = indexPath.section == 0 ?@"搜索历史"  : @"精彩推荐";
        showDeleteBtn = indexPath.section == 0;
    } else {
        header.title = @"精彩推荐";
        showDeleteBtn = indexPath.section == 1;
    }
    
    @weakify(self)
    
    [header showDeleteHistoryBtn:showDeleteBtn CallBack:^{
        @strongify(self)
        [self.historyList removeAllObjects];
        [NSKeyedArchiver archiveRootObject:self.historyList toFile:HISTORY_CACHE_PATH];
        [self.collectionView reloadData];
    }];
    return header;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SearchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SearchCell_ID forIndexPath:indexPath];
    if (self.historyList.count) {
        cell.title = indexPath.section == 0 ? self.historyList[indexPath.item] : self.hotList[indexPath.item];
    } else {
        cell.title = self.hotList[indexPath.item];
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchChildViewDidScroll)]) {
        [self.delegate searchChildViewDidScroll];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchChildViewDidSelectItem:)]) {
        id value;
        if (self.historyList.count) {
            value = indexPath.section == 0 ? self.historyList[indexPath.item] : self.historyList[indexPath.item];
        } else {
            value = self.hotList[indexPath.item];
        }
        [self.delegate searchChildViewDidSelectItem:value];
    }
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width , 45);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *string = nil;
    if (self.historyList.count) {
        string = indexPath.section == 0 ? self.historyList[indexPath.item] : self.hotList[indexPath.item];
    } else {
        string = self.hotList[indexPath.item];
    }
    
    CGSize size = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 19) options: NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont M_PingFang_RegularOfSize:Font_13]} context:nil].size;
    CGSize rSize = CGSizeMake(size.width + 10 * 2, 30);
    
    return rSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 15, 30, 15);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 15.f;
}

- (UICollectionView*)collectionView{
    
    if (!_collectionView) {
        
        SearchNormalLayout*flowLayout=[[SearchNormalLayout alloc]init];
        flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
        
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, kTopHeight+7, kScreen_Width, kScreen_Height-kTopHeight) collectionViewLayout:flowLayout];
        _collectionView.dataSource=self;
        _collectionView.delegate=self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.scrollEnabled = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            _collectionView.scrollIndicatorInsets = _collectionView.contentInset;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    
    return _collectionView;
}

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}
- (NSMutableArray *)historyList
{
    if (!_historyList) {
      
        _historyList =   [ NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:HISTORY_CACHE_PATH]];
    }
    return _historyList;
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
