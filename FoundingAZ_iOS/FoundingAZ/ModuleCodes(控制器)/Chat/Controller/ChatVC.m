//
//  ChatVC.m
//  FoundingAZ
//
//  Created by mark on 2021/1/29.
//

#import "ChatVC.h"

@interface ChatVC ()

@end

@implementation ChatVC

- (id)init{
    self = [super init];
    
    if (self) {
        
        self.title=@"";
        self.tabBarItem.title=@"聊天";
                
        self.tabBarItem.image=[[UIImage imageNamed:@"Tab_chat_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem.selectedImage=[[UIImage imageNamed:@"Tab_chat_red"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
         
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //1.先设置样式
    self.view.ly_emptyView = [AZEmpty diyNoNetworkEmptyWithTarget:self action:@selector(tag)];

    [self.view ly_showEmptyView];
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
