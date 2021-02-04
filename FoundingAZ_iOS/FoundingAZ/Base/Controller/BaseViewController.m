//
//  BaseViewController.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"=====创建了控制器：%@", self);
    
    [self initWithData];
    [self initWithNaviUI];
    [self initWithMainUI];
    
    // Do any additional setup after loading the view.
}

#pragma mark 初始化数据
- (void)initWithData{}

#pragma mark 配置导航栏
- (void)initWithNaviUI{}

#pragma mark 配置UI
- (void)initWithMainUI{}

- (BOOL)shouldAutorotate{
    
    return true;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    
    return UIInterfaceOrientationPortrait;
}

- (void)dealloc
{
    NSLog(@"=====销毁了控制器：%@", self);
}
-(void)dismiss{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
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
