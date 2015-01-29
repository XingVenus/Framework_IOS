//
//  CommonPerson.m
//  HuWai
//
//  Created by WmVenusMac on 15-1-23.
//  Copyright (c) 2015年 xici. All rights reserved.
//

#import "CommonPerson.h"

@interface CommonPerson ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation CommonPerson

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *dataArray = @[@"aa",@"bb",@"cc",@"dd",@"aa",@"bb",@"cc",@"dd",@"aa",@"bb",@"cc",@"dd",@"aa",@"bb",@"cc",@"dd"];
    [self.dataSource addObjectsFromArray:dataArray];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    }
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier1 = @"addCommonPersonCell";
    static NSString *CellIdentifier2 = @"commonPersonCell";
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section == 0) {
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1 forIndexPath:indexPath];
        cell1.textLabel.text = @"添加一位";
        return cell1;
    }else{
        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2 forIndexPath:indexPath];
        cell2.textLabel.text = self.dataSource[row];
        return cell2;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    if (section == 0) {
//        [self performSegueWithIdentifier:@"addCommonPerson" sender:self];
    }else{
        
    }
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end