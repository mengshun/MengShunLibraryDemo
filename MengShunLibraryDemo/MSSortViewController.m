//
//  MSSortViewController.m
//  MengShunLibraryDemo
//
//  Created by MS on 6/18/15.
//  Copyright (c) 2015 孟顺. All rights reserved.
//

#import "MSSortViewController.h"

@interface MSSortViewController ()

@end

@implementation MSSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self sortMethod];
    
    
    // Do any additional setup after loading the view.
}
- (void)sortMethod{
    //从大到小
    
    NSArray * array = @[@(12),@(42),@(121),@(42),@(423),@(5345),@(654),@(32),@(2),@(2)];
    
    NSMutableArray * tmpArr = [NSMutableArray arrayWithArray:array];
    
    //    for (int i = 0; i<tmpArr.count; i++) {
    //        for (int j = i+1; j<tmpArr.count; j++) {
    //            NSInteger a = [tmpArr[i] integerValue];
    //            NSInteger b = [tmpArr[j] integerValue];
    //            if(b>a){
    //                tmpArr[i] = @(b);
    //                tmpArr[j] = @(a);
    //            }
    //            NSLog(@"%d",++count);
    //        }
    //    }
    //
    
    
    
    ////    从大到小
    //    for (int i = 1; i<tmpArr.count; i++) {
    //
    //
    //
    //        int j=0;
    //
    //        NSInteger a = [tmpArr[j] integerValue];
    //
    //        NSInteger b = [tmpArr[i] integerValue];
    //
    //
    //        while (j < i && a>b) {
    //            j++;
    //            a = [tmpArr[j] integerValue];
    //            if (a >b) {
    //                [tmpArr exchangeObjectAtIndex:i withObjectAtIndex:j];
    //            }
    //
    //            NSLog(@"%d",++count);
    //
    //        }
    //
    //
    //    }
    
    
    //由小到大
    int i, j;
    for (i = 1; i < tmpArr.count; i++)
        if (tmpArr[i] < tmpArr[i - 1])
        {
            int temp = [tmpArr[i] intValue];
            for (j = i - 1; j >= 0 && [tmpArr[j] intValue] > temp; j--)
                tmpArr[j + 1] = tmpArr[j];
            tmpArr[j + 1] = @(temp);
        }
    
    
    NSLog(@"%@",tmpArr);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
