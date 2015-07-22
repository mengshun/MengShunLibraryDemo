//
//  MSLayoutCell.h
//  MengShunLibraryDemo
//
//  Created by MS on 7/21/15.
//  Copyright (c) 2015 孟顺. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSCellLayoutModel.h"
#define kMainScreenWidth [UIScreen mainScreen].bounds.size.width
#define kMainScreenHeight [UIScreen mainScreen].bounds.size.height
#define calculateWandH(x) (x)/1920.0*kMainScreenHeight

@interface MSLayoutCell : UITableViewCell

- (void)setCellWithModel:(MSCellLayoutModel *)model;

@end
