//
//  XZTabBarController.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import "XZTabBarController.h"
#import "BaseNavigationController.h"
#import "XZTabBar.h"

#import "HomeVC.h"
#import "OrderVC.h"
#import "MineVC.h"
#import "LoginCodeVC.h"
#import "LoginPhoneVC.h"

@interface XZTabBarController ()<UITabBarControllerDelegate, XZTabBarDelegate>

@property (nonatomic,strong) XZTabBar *xzTabBar;

@end

@implementation XZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setValue:[[XZTabBar alloc] init] forKey:@"tabBar"];
    self.delegate= self;
    
    XZTabBar * tab = (XZTabBar *)self.tabBar;
    tab.tabDelegate = self;
    
    [[UITabBar appearance] setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]]];
    
    [self addViewControllers];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginNotice:) name:NOTICE_Login_name object:nil];
    
    // Do any additional setup after loading the view.
}

#pragma mark 退出登录后切换到首页tab
- (void)loginNotice:(NSNotification *)notice{
    
    NSString *noticeStr = (NSString *)[notice object];
    
    LoginPhoneVC *vc = [[LoginPhoneVC alloc] init];
    if (![NSString stringIsEmpty:noticeStr]) {
        vc.fromeType = 1;
        vc.phoneStr = noticeStr;
    }
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
    nav.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:nav animated:YES completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.selectedIndex = 0;
    });
}

#pragma mark 设置tabbar的背景图片
- (UIImage*)createImageWithColor:(UIColor*) color{
    
    CGRect rect= self.tabBar.bounds;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark 添加控制器
- (void)addViewControllers{
    
    id homeVC = [self vcForClass:[HomeVC class]];
    id courseVC = [self vcForClass:[CourseVC class]];
    id learnVC = [self vcForClass:[LearnVC class]];
    id chatVC = [self vcForClass:[ChatVC class]];
//    id orderVC = [self vcForClass:[OrderVC class]];
    id mineVC = [self vcForClass:[MineVC class]];
    
    [self setViewControllers:@[homeVC,courseVC,learnVC,chatVC,mineVC] animated:YES];
    
    self.selectedIndex = 0;
}

#pragma mark 创建控制器
- (BaseNavigationController*)vcForClass:(Class)class{
    
    id vc = [[class alloc] init];
    BaseNavigationController *nvc = [[BaseNavigationController alloc] initWithRootViewController:vc];
    
    return nvc;
}

#pragma mark 这个方法是对VC栈的整体更新
- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers animated:(BOOL)animated{
    [super setViewControllers:viewControllers animated:animated];
    
    NSMutableArray * items = [NSMutableArray array];
    for (UINavigationController * vc in viewControllers) {
        [items addObject:vc.tabBarItem];
    }
    [self.tabBar setItems:items];
}

#pragma mark
- (void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    
    self.xzTabBar.selectedIndex = selectedIndex;
}

#pragma mark XZTabBarDelegate
- (void)tabBarDidClickButton:(UIButton *)tabBtn{
    
    self.selectedIndex = tabBtn.tag;
    
    if (tabBtn.tag == 4) {
        NSString *token =[Utility getUserToken];
        if (token.length>1) {
          
        }else{
            
            LoginCodeVC *vc = [[LoginCodeVC alloc] init];
            BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
            nav.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            [self presentViewController:nav animated:YES completion:nil];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_Login_name object:nil];
        }
        
    }
}

/*
 * creat xzTabBar
 */
- (XZTabBar *)xzTabBar{
    
    return (XZTabBar *)self.tabBar;
}

- (BOOL)shouldAutorotate{
    
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return self.selectedViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    
    return self.selectedViewController.preferredInterfaceOrientationForPresentation;
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
