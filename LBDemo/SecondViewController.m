//
//  SecondViewController.m
//  LBDemo
//
//  Created by 训网高 on 2018/4/24.
//  Copyright © 2018年 训网高. All rights reserved.
//

#import "SecondViewController.h"
#import "PeopleModel.h"
#import "TableViewCell.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface SecondViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *selectNameArray;
@end

@implementation SecondViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    self.selectNameArray = [NSMutableArray array];
//    NSData *selectData = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectArray"];
//    NSArray *peopleArray = [NSKeyedUnarchiver unarchiveObjectWithData:selectData];
    //从本地获取存储的数组，用于数据对比
    NSArray *peopleArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectArray"];
    NSLog(@"%@",peopleArray);
    if (peopleArray.count != 0) {
        for (NSString *name in peopleArray) {
            
            [self.selectNameArray addObject:name];
        }
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"第二页";
    
    UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 10, 15)];
    if (@available(iOS 11, *)) {
        [backButton setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 5, 20)];
    }
    //设置UIButton的图像
//    [backButton setImage:[UIImage imageNamed:@"white_back_little"] forState:UIControlStateNormal];
    [backButton setTitle:@"确定" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //给UIButton绑定一个方法，在这个方法中进行popViewControllerAnimated
    [backButton addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    //然后通过系统给的自定义BarButtonItem的方法创建BarButtonItem
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    //覆盖返回按键
    self.navigationItem.rightBarButtonItem = backItem;
    
    //构造数据
    NSArray *nameArray = @[@"姓名1",@"姓名2",@"姓名3",@"姓名4",@"姓名5",@"姓名6",@"姓名7",@"姓名8",@"姓名9",@"姓名10",@"姓名11",@"姓名12",@"姓名13",@"姓名14",@"姓名15",@"姓名16",@"姓名17",@"姓名18",@"姓名19",@"姓名20"];
    NSArray *ageArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20"];
    NSArray *genderArray = @[@"男",@"女",@"男",@"男",@"男",@"女",@"女",@"男",@"女",@"女",@"女",@"女",@"男",@"男",@"女",@"男",@"男",@"女",@"女",@"女"];
    self.dataSource = [NSMutableArray array];
    for (int i = 0; i < nameArray.count; i++) {
        PeopleModel *model = [[PeopleModel alloc] init];
        model.name = nameArray[i];
        model.age = ageArray[i];
        model.gender = genderArray[i];
        [self.dataSource addObject:model];
    }
    
    [self creatTableView];
}

- (void)creatTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"TableViewCell"];
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if (!cell) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TableViewCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PeopleModel *model = self.dataSource[indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@    %@    %@",model.name, model.age, model.gender];
    //1. 先判断从本地获取的数组有没有数据
    //2. 如果没有  就是说  没有选中的状态
    if (self.selectNameArray.count == 0) {
        cell.colorImageView.backgroundColor = [UIColor cyanColor];
    } else {
        //3. 有数据，然后逐个对比，如果 self.selectNameArray 数组中包含model.name  则是选中状态，否则是未选中状态
        if ([self.selectNameArray containsObject:model.name]) {
            cell.colorImageView.backgroundColor = [UIColor redColor];
        } else {
            cell.colorImageView.backgroundColor = [UIColor cyanColor];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PeopleModel *model = self.dataSource[indexPath.row];
    TableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //同理，判断数组中是否有点击的那个cell所代表的数据，如果有则移除，没有则添加进去
    if([self.selectNameArray containsObject:model.name]) {
        [self.selectNameArray removeObject:model.name];
        cell.colorImageView.backgroundColor = [UIColor cyanColor];
    } else {
        [self.selectNameArray addObject:model.name];
        cell.colorImageView.backgroundColor = [UIColor redColor];
    }
}

- (void)rightItemClick {
    //将选中的数组保存到本地
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.selectNameArray];
    [[NSUserDefaults standardUserDefaults] setObject:self.selectNameArray forKey:@"selectArray"];
    [self.navigationController popViewControllerAnimated:YES];
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
