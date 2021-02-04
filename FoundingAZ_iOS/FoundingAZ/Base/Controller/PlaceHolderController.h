//
//  PlaceHolderController.h
//  FoundingAZ
//
//  Created by 创业酵母 on 2021/01/21.
//

#import "HandleBarController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlaceHolderController : HandleBarController

@property (nonatomic, strong) UIButton *reloadPlaceHolderBtn;

//没有数据占位
- (void)noData_placeHolder;

//webview占位
- (void)noWebView_placeHolder;

//移除占位图
- (void)removePlaceHolderView;

@end

NS_ASSUME_NONNULL_END
