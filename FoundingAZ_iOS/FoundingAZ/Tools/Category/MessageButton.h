//
//  MessageButton.h
//  iMuGou
//
//  Created by 创业酵母 on 2021/01/21.
//

#import <UIKit/UIKit.h>

@interface MessageButton : UIButton

@property (nonatomic,strong) UILabel *lblNum;
@property (nonatomic,strong) NSString *number;
@property (nonatomic) CGRect theFrame;

@end
