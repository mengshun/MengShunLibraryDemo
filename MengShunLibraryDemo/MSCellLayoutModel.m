//
//  MSCellLayoutModel.m
//  MengShunLibraryDemo
//
//  Created by MS on 7/21/15.
//  Copyright (c) 2015 孟顺. All rights reserved.
//

#import "MSCellLayoutModel.h"


@implementation MSCellLayoutModel

- (NSString *)description{
    return [NSString stringWithFormat:@"imageUrl : %@ name : %@ docterdescreption : %@ time : %@",self.imageUrl,self.name,self.docterdescreption,self.time];
}



@end
