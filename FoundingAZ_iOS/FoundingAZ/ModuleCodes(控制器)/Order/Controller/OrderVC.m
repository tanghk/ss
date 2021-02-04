//
//  OrderVC.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import "OrderVC.h"
#import "OrderListVC.h"

@interface OrderVC ()

@property (nonatomic, strong) NSMutableArray *titleArray;

@end

@implementation OrderVC

- (id)init{
    self = [super init];
    
    if (self) {
        
        self.title=@"";
        self.tabBarItem.title=@"订单";
                
        self.tabBarItem.image=[[UIImage imageNamed:@"Tab_order_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.selectedImage=[[UIImage imageNamed:@"Tab_order_blue"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [self configuerWithWMPageController];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:true animated:false];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initWithNavUI];
    
    // Do any additional setup after loading the view.
}

/*
 * UI部分
 */
- (void)initWithNavUI{
    
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kTopHeight)];
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];
    
    UILabel *navTitleLabel = [UILabel createLabelWithFrame:CGRectMake(50, kStatusBarHeight, kScreen_Width-2*50, kNavBarHeight) font:[UIFont M_PingFang_MediumOfSize:18.0] textColor:Color_MainBlack textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor clearColor] text:@"订单"];
    [navView addSubview:navTitleLabel];
}

- (void)configuerWithWMPageController{
    
    self.titleColorNormal = Color_MainBlack;
    self.titleColorSelected = Color_MainBlue;
    self.titleSizeNormal = 16.0;
    self.titleSizeSelected = 16.0;
    //self.titleFontName = @"PingFangSC-Regular";
    self.progressColor = Color_MainBlue;
    self.progressHeight = 3.0;
    self.progressWidth = 36.0;
    self.menuViewStyle = WMMenuViewStyleLine;
    self.progressViewBottomSpace = 0.0;
    self.automaticallyCalculatesItemWidths = YES;
    self.itemMargin = 0;
    self.menuViewLayoutMode = WMMenuViewLayoutModeScatter;
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    
    return self.titleArray.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return [self.titleArray safeObjectIndex:index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
            
    OrderListVC *vc = [[OrderListVC alloc] init];
    
    return vc;
}

- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
    
    //self.currentCtrl = viewController;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {

    return CGRectMake(0, kTopHeight, kScreen_Width, OrderMenuViewHeight);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    return CGRectMake(0, kTopHeight, kScreen_Width, kScreen_Height-kTopHeight-kTabBarHeight);
}

- (NSMutableArray *)titleArray{
    
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"我的需求",@"我的报名",@"我的牵线", nil];
    }
    
    return _titleArray;
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
