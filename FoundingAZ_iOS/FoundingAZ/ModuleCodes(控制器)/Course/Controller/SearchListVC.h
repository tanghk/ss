//
//  SearchListVC.h
//  FoundingAZ
//
//  Created by mark on 2021/2/1.
//

#import "HandleBarController.h"
#import "SearchReusableView.h"
NS_ASSUME_NONNULL_BEGIN
@protocol SearchDelegate<NSObject>

- (void)searchChildViewDidScroll;

- (void)searchChildViewDidSelectItem:(id)value;
- (void)searchChildViewDidSelectRow:(id)value;

@end

@interface SearchListVC : HandleBarController
@property (nonatomic, strong) NSMutableArray *historyList;
@property (nonatomic, weak) id<SearchDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
