//
//  MSCellLayoutViewController.m
//  MengShunLibraryDemo
//
//  Created by MS on 7/21/15.
//  Copyright (c) 2015 孟顺. All rights reserved.
//

#import "MSCellLayoutViewController.h"
#import "MSLayoutCell.h"

@interface MSCellLayoutViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *dataArray ;

@end

@implementation MSCellLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    
    [self addconstraints];
    
    
    self.dataArray = [NSMutableArray array];
    for (int i = 0; i<15; i++) {
        MSCellLayoutModel *model  = MSCellLayoutModel.new;
        model.imageUrl = @"https://www.baidu.com";
        model.name = @"刘医生";
        model.docterdescreption = @"医生专科说明";
        model.time = @"在线时间:10:00~23:00";
        [self.dataArray addObject:model];
    }
    
    // Do any additional setup after loading the view.
}

- (void)addconstraints{
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topGuide]-0-[_tableView]-0-|" options:0 metrics:nil views:@{@"_tableView":_tableView,@"topGuide":self.topLayoutGuide}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_tableView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return calculateWandH(39.0+24+18+40)+19+17+12;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MSLayoutCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setCellWithModel:self.dataArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}





- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
        [_tableView registerClass:[MSLayoutCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
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
