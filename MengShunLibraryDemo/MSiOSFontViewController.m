//
//  MSiOSFontViewController.m
//  MengShunLibraryDemo
//
//  Created by MS on 6/18/15.
//  Copyright (c) 2015 孟顺. All rights reserved.
//

#import "MSiOSFontViewController.h"

@interface MSiOSFontViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    NSArray * _dataArray;
}
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSArray *dataArray;
@end

@implementation MSiOSFontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView =[[ UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    NSArray *fontArray = [UIFont familyNames];
    _dataArray = fontArray;
    int i=0;
    int j=0;
    for (NSString * name in fontArray) {
        NSLog(@"name%d : %@",++i,name);
        
        NSArray * arr =[UIFont fontNamesForFamilyName:name];
        for (NSString * newname in arr) {
            NSLog(@"        detail%d : %@",++j,newname);
        }
    }

    
    // Do any additional setup after loading the view.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [UIFont fontNamesForFamilyName:_dataArray[section]].count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString * fontName = [UIFont fontNamesForFamilyName:_dataArray[indexPath.section]][indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:fontName size:13];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld Sign in with Google",indexPath.row+1];
    cell.textLabel.backgroundColor = [UIColor grayColor];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"%ld %@",section+1,_dataArray[section]];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return @"FOOTER";
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
