//
//  CusSearchBar.h
//  iMuGou
//
//  Created by 九博 on 2017/5/10.
//  Copyright © 2017年 imugou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CusTextField.h"

typedef void(^DidSearchAction)(NSString *searchText);
typedef void(^DidBeginInput)(void);

@interface CusSearchBar : UIView<UITextFieldDelegate>


@property(nonatomic,copy) DidSearchAction didSearchAction;
@property(nonatomic,copy) DidBeginInput didBeginInput;

@property (nonatomic,strong) UIImageView *imgSearch;
//@property (nonatomic,assign) CGFloat imageSize;
@property(nonatomic,assign) BOOL SearchTextAlignmentMiddle;
@property (nonatomic,assign) NSInteger enableDelegate;


@property (nonatomic,strong)CusTextField *textField;

- (instancetype)initWithFrame:(CGRect)frame;

- (instancetype)initWithFrame:(CGRect)frame DidClickSearch:(DidSearchAction)didClickSearch;

@end
