//
//  ViewController.m
//  SelectTableViewDelete
//
//  Created by 岚海网络 on 2018/11/1.
//  Copyright © 2018年 岚海网络. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
    NSMutableArray *dataSource;
    NSMutableArray *contacts;
    UIButton *button;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.

    dataSource = [NSMutableArray array];
    contacts = [NSMutableArray array];
    
    [self setupWithTable];
    [self setupWithButton];
    

}

- (void) setupWithTable
{
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 320, 500)];// style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.rowHeight = 48;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];
}

- (void) setupWithButton
{
    for (int i = 0; i <50; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:@"NO" forKey:@"checked"];
        [contacts addObject:dic];
        [dataSource addObject:[NSString stringWithFormat:@"     %d",i]];
    }
    
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"全选" forState:UIControlStateNormal];
    button.frame = CGRectMake(10, 10, 100, 50);
    [button addTarget:self action:@selector(allSelect:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton * deleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [deleButton setTitle:@"批量删除" forState:UIControlStateNormal];
    deleButton.frame = CGRectMake(110, 10, 100, 50);
    [deleButton addTarget:self action:@selector(deleteSelect) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleButton];
}

// 初始化让所有cell 未选中
- (void)allSelect:(UIButton*)sender{
    // 获取所有可用的indexPaths
    NSArray *anArrayOfIndexPath = [NSArray arrayWithArray:[table indexPathsForVisibleRows]];
    // 遍历indexPaths
    for (int i = 0; i < [anArrayOfIndexPath count]; i++) {
        NSIndexPath *indexPath= [anArrayOfIndexPath objectAtIndex:i];
        // 取出每个indexPaths对应的cell
        TableViewCell *cell = (TableViewCell*)[table cellForRowAtIndexPath:indexPath];
        NSUInteger row = [indexPath row];
        NSLog(@"%lu",(unsigned long)row);
        // 出去每个indexPaths所对应的标识
        NSMutableDictionary *dic = [contacts objectAtIndex:row];
        // 如果点击的是全选
        if ([[[(UIButton*)sender titleLabel] text] isEqualToString:@"全选"]) {
            [dic setObject:@"YES" forKey:@"checked"]; // 把标识改为yes
            [cell setChecked:YES]; // 更改cell的图片
        }else {
            [dic setObject:@"NO" forKey:@"checked"];
            [cell setChecked:NO];
        }
    }
    // 对button的标题进行更改 并把所有的标识更改 （上面更改的只是显示部分的而不是所有的）
    if ([[[(UIButton*)sender titleLabel] text] isEqualToString:@"全选"]){
        for (NSDictionary *dic in contacts) {
            [dic setValue:@"YES" forKey:@"checked"];
        }
        [(UIButton*)sender setTitle:@"取消" forState:UIControlStateNormal];
    }else{
        for (NSDictionary *dic in contacts) {
            [dic setValue:@"NO" forKey:@"checked"];
        }
        [(UIButton*)sender setTitle:@"全选" forState:UIControlStateNormal];
    }
}

#pragma mark - TableView dataSource and delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"Cell";
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
//    else
//    {
//        while ([cell.contentView.subviews lastObject] != nil) {
//            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
//        }
//    }
    NSUInteger row = [indexPath row];
    NSMutableDictionary *dic = [contacts objectAtIndex:row];
    if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
        [dic setObject:@"NO" forKey:@"checked"];
        [cell setChecked:NO];
        
    }else {
        [dic setObject:@"YES" forKey:@"checked"];
        [cell setChecked:YES];
    }
    cell.titleLab.text = dataSource[row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 获取点击的cell
    TableViewCell *cell = (TableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    NSUInteger row = [indexPath row];
    // 获取点击cell的标识
    NSMutableDictionary *dic = [contacts objectAtIndex:row];
    // 如何是选中改成未选中，如果是为选中改成选中
    if ([[dic objectForKey:@"checked"] isEqualToString:@"NO"]) {
        [dic setObject:@"YES" forKey:@"checked"];
        [cell setChecked:YES];
    }else {
        [dic setObject:@"NO" forKey:@"checked"];
        [cell setChecked:NO];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - DeleteSelect cell

- (void)deleteSelect
{
    
    NSMutableIndexSet *indexs = [NSMutableIndexSet indexSet];
    // 遍历选中的数据源的index并添加到set里面
    for (int i = 0; i < contacts.count; i ++) {
        if ([contacts[i][@"checked"] isEqualToString:@"YES"]) {
            [indexs addIndex:i];
        }
    }
    //  删除选中数据源 并更新tableView
    [dataSource removeObjectsAtIndexes:indexs];
    [contacts removeObjectsAtIndexes:indexs];
    [table reloadData];
    
}

@end
