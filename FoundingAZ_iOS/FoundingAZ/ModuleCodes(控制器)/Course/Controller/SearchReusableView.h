//
//  SearchReusableView.h
//  FoundingAZ
//
//  Created by mark on 2021/2/1.
//

#import <UIKit/UIKit.h>
typedef void(^emptyBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface SearchReusableView : UICollectionReusableView
@property (nonatomic, strong) NSString *title;

- (void)showDeleteHistoryBtn:(BOOL)show CallBack:(void(^)(void))callBack;

@end

NS_ASSUME_NONNULL_END
