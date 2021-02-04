//
//  HandleBarController.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import "HandleBarController.h"

@interface HandleBarController ()

@end

@implementation HandleBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initWithData{
    [super initWithData];
}

- (void)initWithNaviUI{
    [super initWithNaviUI];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)initWithMainUI{
    [super initWithMainUI];
}

#pragma mark 不透明白色背景+有底部线条+返回按钮+title
- (void)setNavigationTitle:(NSString *)title isShowBack:(BOOL)isShowBack hasLine:(BOOL)hasLine{
    
   UIView *navView = [self setNavigationTitle:title NavBackViewGroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] isShowBack:isShowBack];
    
    if (hasLine) {
        UIImageView *lineImageView = [UIImageView createImageViewWithFrame:CGRectMake(0, kTopHeight-0.5, kScreen_Width, 0.5) imageWithString:@""];
        lineImageView.backgroundColor = Color_Separator;
        [navView addSubview:lineImageView];
    }
}

#pragma mark 可以在具体页面通过返回的UIView来进行具体自定义
- (UIView *)setNavigationTitle:(NSString *)title NavBackViewGroundColor:(UIColor *)navBackViewGroundColor textColor:(UIColor *)textColor isShowBack:(BOOL)isShowBack{
    
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kTopHeight)];
    navView.backgroundColor = navBackViewGroundColor;
    navView.userInteractionEnabled = true;
    [self.view addSubview:navView];
    
    if (isShowBack) {
        UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"G_Nav_back"]];
        backImageView.frame = CGRectMake(15, kStatusBarHeight+(kNavBarHeight-CGRectGetHeight(backImageView.bounds))/2, CGRectGetWidth(backImageView.bounds), CGRectGetHeight(backImageView.bounds));
        backImageView.backgroundColor = [UIColor clearColor];
        [navView addSubview:backImageView];
        
        UIButton *backBtn = [UIButton createButtonWithFrame:CGRectMake(0, kStatusBarHeight, 120, kNavBarHeight) normalImage:@""];
        [backBtn addTarget:self action:@selector(navBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
        backBtn.backgroundColor = [UIColor clearColor];
        [navView addSubview:backBtn];
    }
    
    UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectMake(80, kStatusBarHeight, kScreen_Width-2*80, kNavBarHeight) font:[UIFont M_PingFang_MediumOfSize:Font_17] textColor:Color_MainBlack textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor clearColor] text:title];
    [navView addSubview:titleLabel];
    
    return navView;
}
/*
 * 不透明白色背景+有底部线条+返回按钮+title+右侧按钮
 */
- (void)setNavigationTitle:(NSString *)title
                isShowBack:(BOOL)isShowBack
                   hasLine:(BOOL)hasLine
              hasRightItem:(BOOL)hasRightItem
                  CallBack:(nonnull void (^)(void))callBack{
    self.block = callBack;
    if (hasRightItem) {
        UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kTopHeight)];
        
        navView.userInteractionEnabled = true;
        [self.view addSubview:navView];
        
        if (isShowBack) {
            UIImageView *backImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"G_Nav_back"]];
            backImageView.frame = CGRectMake(15, kStatusBarHeight+(kNavBarHeight-CGRectGetHeight(backImageView.bounds))/2, CGRectGetWidth(backImageView.bounds), CGRectGetHeight(backImageView.bounds));
            backImageView.backgroundColor = [UIColor clearColor];
            [navView addSubview:backImageView];
            
            UIButton *backBtn = [UIButton createButtonWithFrame:CGRectMake(0, kStatusBarHeight, 120, kNavBarHeight) normalImage:@""];
            [backBtn addTarget:self action:@selector(navBackBtnClick) forControlEvents:UIControlEventTouchUpInside];
            backBtn.backgroundColor = [UIColor clearColor];
            [navView addSubview:backBtn];
        }
        
        UILabel *titleLabel = [UILabel createLabelWithFrame:CGRectMake(80, kStatusBarHeight, kScreen_Width-2*80, kNavBarHeight) font:[UIFont M_PingFang_MediumOfSize:Font_17] textColor:Color_MainBlack textAlignment:NSTextAlignmentCenter backgroundColor:[UIColor clearColor] text:title];
        [navView addSubview:titleLabel];
        
        if (hasRightItem) {
            UIImageView *rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Course_RightItem"]];
            rightImageView.frame = CGRectMake(kScreen_Width-15-CGRectGetWidth(rightImageView.bounds), kStatusBarHeight+(kNavBarHeight-CGRectGetHeight(rightImageView.bounds))/2, CGRectGetWidth(rightImageView.bounds), CGRectGetHeight(rightImageView.bounds));
            rightImageView.backgroundColor = [UIColor clearColor];
            [navView addSubview:rightImageView];
            
            UIButton *rightItemBtn = [UIButton createButtonWithFrame:CGRectMake(kScreen_Width-120, kStatusBarHeight, 120, kNavBarHeight) normalImage:@""];
            [rightItemBtn addTarget:self action:@selector(rightItemBtnClick) forControlEvents:UIControlEventTouchUpInside];
            rightItemBtn.backgroundColor = [UIColor clearColor];
            [navView addSubview:rightItemBtn];
        }
     
        if (hasLine) {
            UIImageView *lineImageView = [UIImageView createImageViewWithFrame:CGRectMake(0, kTopHeight-0.5, kScreen_Width, 0.5) imageWithString:@""];
            lineImageView.backgroundColor = Color_Separator;
            [navView addSubview:lineImageView];
        }
        
    }else{
        
        UIView *navView = [self setNavigationTitle:title NavBackViewGroundColor:[UIColor whiteColor] textColor:[UIColor blackColor] isShowBack:isShowBack hasRightItem:hasRightItem];
        if (hasLine) {
            UIImageView *lineImageView = [UIImageView createImageViewWithFrame:CGRectMake(0, kTopHeight-0.5, kScreen_Width, 0.5) imageWithString:@""];
            lineImageView.backgroundColor = Color_Separator;
            [navView addSubview:lineImageView];
        }
    }
   
     
    
    
    
}

/*
 * 可以在具体页面通过返回的UIView来进行具体自定义
 */

#pragma mark 返回按钮点击事件
- (void)navBackBtnClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightItemBtnClick{
    
    if (self.block) {
        self.block();
    }
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
