//
//  IntegrCaseDetailVC.m
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/25.
//

#import "IntegrCaseDetailVC.h"

@interface IntegrCaseDetailVC ()

@end

@implementation IntegrCaseDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
 * UI部分
 */
- (void)initWithNaviUI{
    [super initWithNaviUI];
    
    [self setNavigationTitle:@"" isShowBack:YES hasLine:NO];
}

- (void)initWithMainUI{
    [super initWithMainUI];
    
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
