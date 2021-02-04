//
//  ConnectUsItemsCell.h
//  FoundingAZ
//
//  Created by mark on 2021/2/1.
//

#import "BaseCollectionCell.h"

#import "ConnectUsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ConnectUsItemsCell : BaseCollectionCell
- (void)configureCellWithModel:(ConnectUsModel *)contentModel;
@end
NS_ASSUME_NONNULL_END
