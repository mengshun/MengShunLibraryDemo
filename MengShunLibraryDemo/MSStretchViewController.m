//
//  MSStretchViewController.m
//  MengShunLibraryDemo
//
//  Created by MS on 7/10/15.
//  Copyright (c) 2015 孟顺. All rights reserved.
//

#import "MSStretchViewController.h"

@interface MSStretchViewController ()

@end

@implementation MSStretchViewController


- (void)recieveNoti{
    NSLog(@"recieveNoti");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIImage *image = [UIImage imageNamed:@"stretch"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = CGRectMake(150, 200, 35, image.size.height);
    [self.view addSubview:imageView];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 15, 15)];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"999999999";
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 7.5;
    label.backgroundColor = [UIColor redColor];
    
    CGSize  size = [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}];
    label.bounds = CGRectMake(0, 0, size.width>15 ? size.width+2 : 15, 15);
    
    
    NSLog(@"%@",NSStringFromCGRect(label.frame));
    [self.view addSubview:label];
    
    
    
    // Do any additional setup after loading the view.
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
