//
//  MainViewController.m
//  TableViewEdit
//
//  Created by csdc on 2017/8/18.
//  Copyright © 2017年 csdc. All rights reserved.
//

#import "MainViewController.h"
#import "FriendModel.h"

@interface MainViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *modelArray;
@property (nonatomic, strong) NSMutableArray *selectedIndexPath;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"删除操作";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(removeItems:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editTableView:)];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:self.tableView];
    
    self.selectedIndexPath = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 完成数组的懒加载
- (NSMutableArray *)modelArray {
    if (!_modelArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"friends" ofType:@"plist"];
        NSArray *dataArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dataDict in dataArray) {
            FriendModel *model = [FriendModel modelWithDict:dataDict];
            [tempArray addObject:model];
        }
        _modelArray = [tempArray mutableCopy];
    }
    return _modelArray;
}

#pragma mark - Actions - 
- (void)removeItems:(UIBarButtonItem *)sender {
    if (self.tableView.editing) {
        for (NSIndexPath *indexPath in self.selectedIndexPath) {
            [self.modelArray removeObjectAtIndex:indexPath.row];
        }
        [self.tableView deleteRowsAtIndexPaths:self.selectedIndexPath withRowAnimation:UITableViewRowAnimationFade];
        [self.selectedIndexPath removeAllObjects];
    }
}

// 实现对tableView编辑状态的打开和关闭
- (void)editTableView:(UIBarButtonItem *)sender {
    [self.tableView setEditing:!self.tableView.editing];
}

#pragma mark - Table view delegate - 
// 对多选项进行记录
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableView.editing) {
        [self.selectedIndexPath addObject:indexPath];
    }
}
// 进行反选操作
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableView.editing) {
        [self.selectedIndexPath removeObject:indexPath];
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 实现多选操作的关键一步
    return UITableViewCellEditingStyleInsert | UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 删除数据
    [self.modelArray removeObjectAtIndex:indexPath.row];
    
    // 删除对应的cell(默认是多行)
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

#pragma mark - Table view data source - 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    FriendModel *model = self.modelArray[indexPath.row];
    [cell.imageView setImage:[UIImage imageNamed:model.icon]];
    [cell.textLabel setText:model.name];
    return cell;
}
@end
