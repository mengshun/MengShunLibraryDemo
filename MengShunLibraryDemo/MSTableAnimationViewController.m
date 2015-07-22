//
//  MSTableAnimationViewController.m
//  MengShunLibraryDemo
//
//  Created by MS on 7/16/15.
//  Copyright (c) 2015 孟顺. All rights reserved.
//

#import "MSTableAnimationViewController.h"
#import "MJRefresh.h"

@interface MSTableAnimationViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView  *topView;

@end

@implementation MSTableAnimationViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    float width = [UIScreen mainScreen].bounds.size.width;
    float height = [UIScreen mainScreen].bounds.size.height;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]-0-[_scrollView]-0-|" options:0 metrics:nil views:@{@"_scrollView":_scrollView,@"topLayoutGuide":self.topLayoutGuide}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_scrollView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_scrollView)]];

    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_topView(80)]-0-[_tableView(height)]" options:0 metrics:@{@"height":@(8000)} views:@{@"_tableView":_tableView,@"topLayoutGuide":self.topLayoutGuide,@"_topView":_topView}]];


    [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_topView(width)]" options:0 metrics:@{@"width":@(width)} views:NSDictionaryOfVariableBindings(_topView)]];
       [self.scrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_tableView(width)]" options:0 metrics:@{@"width":@(width)} views:NSDictionaryOfVariableBindings(_tableView)]];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"scrollview : %@",NSStringFromCGRect(_scrollView.frame));
    NSLog(@"tableview : %@",NSStringFromCGRect(_topView.frame));
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatSubview];
    
    // Do any additional setup after loading the view.
}

- (void)creatSubview{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.tableView];
    [self.scrollView addSubview:self.topView];
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        NSLog(@"松手了");
        [self performSelector:@selector(delayStop) withObject:nil afterDelay:2.5f];
    }];
    
    NSMutableArray *array =  [NSMutableArray array];
    for (int i = 0 ;i<36;i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"CiecleLoading%02d.png",i]];
        if (image) {
            [array addObject:image];
        }
    }
    [header setImages:array duration:1.5 forState:MJRefreshStateRefreshing];
    [header setImages:array duration:1.5 forState:MJRefreshStateIdle];
    [header setImages:array duration:1.5 forState:MJRefreshStatePulling];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    
    self.tableView.header = header;
    self.tableView.scrollEnabled = YES;

}
- (void)delayStop{
    NSLog(@"停止了");
    [self.tableView.header endRefreshing];

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = @"cell";
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}







#pragma mark - uitableViewDataSource or UITableViewDelegate
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate =self;
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.delegate = self;
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        _scrollView.backgroundColor = [UIColor purpleColor];
    }
    return _scrollView;
}
- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = [UIColor greenColor];
        _topView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _topView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    
    if ([scrollView isEqual:_scrollView] ) {
        NSLog(@"1111");
    } else {
        self.scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y < 0 ? scrollView.contentOffset.y : 0);
    }
    
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
