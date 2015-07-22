//
//  MSLayoutConstraintViewController.m
//  MengShunLibraryDemo
//
//  Created by MS on 7/13/15.
//  Copyright (c) 2015 孟顺. All rights reserved.
//

#import "MSLayoutConstraintViewController.h"

@interface MSLayoutConstraintViewController (){
    
}
@property (nonatomic,strong)UILabel *leftView;
@property (nonatomic,strong)UILabel *centerView;
@property (nonatomic,strong)UILabel *rightView;

@property (nonatomic,strong)UIView *tmpView1;
@property (nonatomic,strong)UIView *tmpView2;
@property (nonatomic,strong)UIView *tmpView3;
@property (nonatomic,strong)UIView *tmpView4;

@property (nonatomic,strong)NSMutableArray *portraitConstraitArray;
@property (nonatomic,strong)NSMutableArray *othersConstraitArray;

@end

@implementation MSLayoutConstraintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.leftView];
    [self.view addSubview:self.rightView];
    [self.view addSubview:self.centerView];
    
    [self.view addSubview:self.tmpView1];
    [self.view addSubview:self.tmpView2];
    [self.view addSubview:self.tmpView3];
    [self.view addSubview:self.tmpView4];
    
    
    [self addConstraints];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Constraint
- (void)addConstraints{
    _portraitConstraitArray = [NSMutableArray array];
    [_portraitConstraitArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_tmpView1(>=0)]-[_leftView(60)]-[_tmpView2(_tmpView1)]-[_centerView(60)]-[_tmpView3(_tmpView1)]-[_rightView(60)]-[_tmpView4(_tmpView1)]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_leftView,_centerView,_rightView,_tmpView1,_tmpView2,_tmpView3,_tmpView4)]];
    [_portraitConstraitArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_leftView(35)]-(-35)-[_centerView(35)]-(-35)-[_rightView(35)]-(20)-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_leftView,_centerView,_rightView)]];
    
    
    
    
    _othersConstraitArray = [NSMutableArray array];
    [_othersConstraitArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_tmpView1(>=0)]-[_leftView(60)]-[_tmpView2(_tmpView1)]-[_centerView(60)]-[_tmpView3(_tmpView1)]-[_rightView(60)]-[_tmpView4(_tmpView1)]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_leftView,_centerView,_rightView,_tmpView1,_tmpView2,_tmpView3,_tmpView4)]];
    [_othersConstraitArray addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]-(40)-[_centerView(35)]-(>=0)-[_leftView(35)]-(-35)-[_rightView(35)]-(20)-|" options:0 metrics:nil views:@{@"_leftView":_leftView,@"_centerView":_centerView,@"_rightView":_rightView,@"topLayoutGuide":self.topLayoutGuide}]];
    
    
    
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait) {
        [self.view removeConstraints:_othersConstraitArray];
        [self.view addConstraints:_portraitConstraitArray];
    } else {
        [self.view removeConstraints:_portraitConstraitArray];
        [self.view addConstraints:_othersConstraitArray];
    }
    
}

- (void)updateViewConstraints{
    [super updateViewConstraints];

}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        [self.view removeConstraints:_othersConstraitArray];
        [self.view addConstraints:_portraitConstraitArray];
    } else {
        [self.view removeConstraints:_portraitConstraitArray];
        [self.view addConstraints:_othersConstraitArray];
    }
}
#pragma mark - setter or getter 
- (UILabel *)leftView{
    if (!_leftView) {
        _leftView = [UILabel new];
        _leftView.translatesAutoresizingMaskIntoConstraints = NO;
        _leftView.text = @"left";
        _leftView.backgroundColor = [ UIColor redColor];
        _leftView.textAlignment = NSTextAlignmentCenter;
    }
    return _leftView;
}
- (UILabel *)rightView{
    if (!_rightView) {
        _rightView = [UILabel new];
        _rightView.translatesAutoresizingMaskIntoConstraints = NO;
        _rightView.text = @"right";
        _rightView.backgroundColor = [ UIColor redColor];
        _rightView.textAlignment = NSTextAlignmentCenter;
    }
    return _rightView;
}
- (UILabel *)centerView{
    if (!_centerView) {
        _centerView = [UILabel new];
        _centerView.translatesAutoresizingMaskIntoConstraints = NO;
        _centerView.text = @"center";
        _centerView.backgroundColor = [ UIColor greenColor];
        _centerView.textAlignment = NSTextAlignmentCenter;
    }
    return _centerView;
}
- (UIView *)tmpView1{
    if (!_tmpView1) {
        _tmpView1 = [UIView new];
        _tmpView1.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _tmpView1;
}
- (UIView *)tmpView2{
    if (!_tmpView2) {
        _tmpView2 = [UIView new];
        _tmpView2.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _tmpView2;
}
- (UIView *)tmpView3{
    if (!_tmpView3) {
        _tmpView3 = [UIView new];
        _tmpView3.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _tmpView3;
}
- (UIView *)tmpView4{
    if (!_tmpView4) {
        _tmpView4 = [UIView new];
        _tmpView4.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _tmpView4;
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
