//
//  MSMultiselectTableViewController.m
//  MengShunLibraryDemo
//
//  Created by MS on 6/18/15.
//  Copyright (c) 2015 孟顺. All rights reserved.
//

#import "MSMultiselectTableViewController.h"

@interface MSMultiselectTableViewController ()<UITableViewDelegate,UITableViewDataSource>{
    BOOL _tableEditing;
    
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIBarButtonItem *editItem;
@property (nonatomic,strong)UIBarButtonItem *chooseAllItem;
@property (nonatomic,strong)UIBarButtonItem *deleteAllItem;


@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)NSMutableArray *deleArray;

@end

@implementation MSMultiselectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableEditing = NO;
    
    self.dataArray = [NSMutableArray array];
    self.deleArray = [NSMutableArray array];
    for (int i = 0; i<40; i++) {
        
        [self.dataArray addObject:[NSString stringWithFormat:@"第 %d 行",i+1]];
    
    }
    
    
    
    self.navigationItem.rightBarButtonItems = @[self.editItem,self.chooseAllItem,self.deleteAllItem];
    [self.view addSubview:self.tableView];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view":self.tableView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:@{@"view":self.tableView}]];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.editing) {
        [self.deleArray removeObject:self.dataArray[indexPath.row]];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.editing) {
        [self.deleArray addObject:self.dataArray[indexPath.row]];
    } else {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}
#pragma  mark - custom method
- (void)btnResponse:(UIBarButtonItem *)item{
    
    if (_tableEditing) {
        if (item.tag == 1000) {
            _tableEditing = !_tableEditing;
            [_tableView setEditing:_tableEditing animated:YES];
            
            _chooseAllItem.title = @"";
            _chooseAllItem.enabled = NO;
            _deleteAllItem.title = @"";
            _deleteAllItem.enabled = NO;
        } else if (item.tag == 1001) {
            NSLog(@"还没写");
        } else if (item.tag == 1002) {
            [self.dataArray removeObjectsInArray:_deleArray];
            [_deleArray removeAllObjects];
            _tableEditing = !_tableEditing;
            _chooseAllItem.title = @"";
            _chooseAllItem.enabled = NO;
            _deleteAllItem.title = @"";
            _deleteAllItem.enabled = NO;
            [_tableView setEditing:_tableEditing animated:YES];
            [self.tableView reloadData];
            
        }
    } else {
        if (item.tag == 1000) {
            _tableEditing = !_tableEditing;
            [_tableView setEditing:_tableEditing animated:YES] ;
            
            _chooseAllItem.title = @"全选";
            _chooseAllItem.enabled = YES;
            _deleteAllItem.title = @"删除";
            _deleteAllItem.enabled = YES;
            
           
        } else if (item.tag == 1001) {
            
        } else if (item.tag == 1002) {
            
        }
    }
    

}


#pragma  mark - setter or getter method

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _tableView;
}

- (UIBarButtonItem *)editItem{
    if (!_editItem) {
        _editItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(btnResponse:)];
        _editItem.tag = 1000;
    }
    return _editItem;
}
- (UIBarButtonItem *)chooseAllItem{
    if (!_chooseAllItem) {
        _chooseAllItem = [[UIBarButtonItem alloc]initWithTitle:@"全选" style:UIBarButtonItemStylePlain target:self action:@selector(btnResponse:)];
        _chooseAllItem.tag = 1001;
        _chooseAllItem.title = @"";
        _chooseAllItem.enabled = NO;
    }
    return _chooseAllItem;
}
- (UIBarButtonItem *)deleteAllItem{
    if (!_deleteAllItem) {
        _deleteAllItem = [[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(btnResponse:)];
        _deleteAllItem.tag = 1002;
        _deleteAllItem.title = @"";
        _deleteAllItem.enabled = NO;
    }
    return _deleteAllItem;
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
