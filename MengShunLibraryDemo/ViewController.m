//
//  ViewController.m
//  MengShunLibraryDemo
//
//  Created by MS on 6/18/15.
//  Copyright (c) 2015 孟顺. All rights reserved.
//

#import "ViewController.h"
#import "MSDemoHeader.h"


@interface ViewController ()

@property (nonatomic,strong)NSMutableArray *titleArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Demo 列表";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self initTitleArray];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - custom method
- (void)initTitleArray{
    NSArray *tmpArray = @[@"清空导航栏的颜色和导航线条",@"字体库",@"排序",@"表的多选",@"录制视频"];
    self.titleArray = [NSMutableArray arrayWithArray:tmpArray];
}


#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%d\t%@",(int)indexPath.row+1,self.titleArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%@",self.titleArray[indexPath.row]);
    
    //取消cell选中的效果
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO animated:YES];
    
    id vc = nil;
    switch (indexPath.row) {
        case 0:
        {
            vc = [[MSCleanNavColorViewController alloc]init];
        }
            break;
        case 1:
        {
            vc = [[MSiOSFontViewController alloc]init];
        }
            break;
        case 2:
        {
            vc = [[MSSortViewController alloc]init];
        }
            break;
        case 3:
        {
            vc = [[MSMultiselectTableViewController alloc]init];
        }
            break;
        case 4:
        {
            vc = [[MSTranscribeVideoViewController alloc]init];
        }
            break;
        case 5:
        {
            
        }
            break;
        case 6:
        {
            
        }
            break;
        default:
            break;
    }
    
    
    if (vc) {
        [vc setTitle:self.titleArray[indexPath.row]];
        [[vc valueForKey:@"view"] setBackgroundColor:[UIColor whiteColor]];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
