//
//  SelectListView.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-29.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "SelectListView.h"

@implementation SelectListView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
    }
    return self;
}

-(void)setListData:(NSArray *)listData
{
    _listData = listData;
    [self.tableView reloadData];
}

- (UITableView *)tableView {
    if (!_tableView) {
        CGRect tableViewFrame = self.bounds;
        _tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorInset = UIEdgeInsetsZero;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"selectlistCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSInteger row = [indexPath row];
    if (row < self.listData.count) {
        if (self.listType == ListTypeDestination) {
            NSDictionary *dic = self.listData[row];
            cell.textLabel.text = dic[@"name"];
        }else{
            cell.textLabel.text = self.listData[row];
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *value;
    if (self.listType == ListTypeDestination) {
        NSDictionary *sDic = self.listData[indexPath.row];
        value = sDic[@"id"];
    }else{
        value = self.listData[indexPath.row];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(selectedValueForListType:value:)]) {
        [_delegate selectedValueForListType:self.listType value:value];
    }
}
@end
