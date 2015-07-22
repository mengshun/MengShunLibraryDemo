//
//  MSLayoutCell.m
//  MengShunLibraryDemo
//
//  Created by MS on 7/21/15.
//  Copyright (c) 2015 孟顺. All rights reserved.
//

#import "MSLayoutCell.h"

@interface MSLayoutCell ()

@property (nonatomic,strong)MSCellLayoutModel *model;


@property (nonatomic,strong)UIImageView *imageCurrentView;
@property (nonatomic,strong)UILabel *nameLable;
@property (nonatomic,strong)UILabel *descrebLable;
@property (nonatomic,strong)UILabel *timeLable;

@end
@implementation MSLayoutCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.imageCurrentView];
        [self.contentView addSubview:self.nameLable];
        [self.contentView addSubview:self.descrebLable];
        [self.contentView addSubview:self.timeLable];
        [self addLayoutConstrants];
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}


- (void)setCellWithModel:(MSCellLayoutModel *)model{
    self.model = model;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.nameLable.text = self.model.name;
    self.descrebLable.text = self.model.docterdescreption;
    self.timeLable.text = self.model.time;
    
 
}
- (void)addLayoutConstrants{
    
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.imageCurrentView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_imageCurrentView(height)]" options:0 metrics:@{@"height":@(calculateWandH(154.0))}views:NSDictionaryOfVariableBindings(_imageCurrentView)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_imageCurrentView(width)]" options:0 metrics:@{@"width":@(calculateWandH(110.0))}views:NSDictionaryOfVariableBindings(_imageCurrentView)]];
    
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(Y1)-[_nameLable(19)]-(Y2)-[_descrebLable(17)]-(Y3)-[_timeLable(12)]"
                                                                             options:NSLayoutFormatAlignAllLeft
                                                                             metrics:@{@"Y1":@(calculateWandH(39.0)),
                                                                                       @"Y2":@(calculateWandH(24.0)),
                                                                                       @"Y3":@(calculateWandH(18.0)),
                                                                                       @"Y4":@(calculateWandH(40.0))}
                                                                               views:NSDictionaryOfVariableBindings(_nameLable,_descrebLable,_timeLable)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_imageCurrentView]-(left)-[_nameLable]-0-|"
                                                                             options:0
                                                                             metrics:@{@"left":@(calculateWandH(30.0))}
                                                                               views:NSDictionaryOfVariableBindings(_nameLable,_imageCurrentView)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_descrebLable]-0-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(_descrebLable,_imageCurrentView)]];
    
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_timeLable]-0-|"
                                                                             options:0
                                                                             metrics:nil
                                                                               views:NSDictionaryOfVariableBindings(_timeLable,_imageCurrentView)]];
    
}


- (UIImageView *)imageCurrentView{
    if (!_imageCurrentView) {
        _imageCurrentView = [[UIImageView alloc]init];
        _imageCurrentView.translatesAutoresizingMaskIntoConstraints = NO;
        _imageCurrentView.backgroundColor = [UIColor redColor];
    }
    return _imageCurrentView;
}
- (UILabel *)nameLable{
    if (!_nameLable) {
        _nameLable = [[UILabel alloc]init];
//        _nameLable.backgroundColor = [UIColor greenColor];
        _nameLable.font = [UIFont systemFontOfSize:19];
        _nameLable.textColor = [UIColor blackColor];
        _nameLable.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _nameLable;
}

- (UILabel *)descrebLable{
    if (!_descrebLable) {
        _descrebLable = [[UILabel alloc]init];
//        _descrebLable.backgroundColor = [UIColor orangeColor];
        _descrebLable.font = [UIFont systemFontOfSize:17];
        _descrebLable.textColor = [UIColor lightGrayColor];
        _descrebLable.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _descrebLable;
}

- (UILabel *)timeLable{
    if (!_timeLable) {
        _timeLable = [[UILabel alloc]init];
//        _timeLable.backgroundColor = [UIColor blueColor];
        _timeLable.font = [UIFont systemFontOfSize:12];
        _timeLable.textColor = [UIColor lightGrayColor];
        _timeLable.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _timeLable;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
