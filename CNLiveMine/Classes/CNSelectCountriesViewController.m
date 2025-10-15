//
//  CNSelectCountriesViewController.m
//  CNLiveNetAddApp
//
//  Created by CNLive-zxw on 2018/11/20.
//  Copyright © 2018年 CNLive. All rights reserved.
//

#import "CNSelectCountriesViewController.h"
#import "CNSelectCountries.h"
#import "CNSelectCountriesTableViewCell.h"
#import "CNSelectCountriesHeadView.h"
#import "MJExtension.h"

#define kMainScreenWidth                     [[UIScreen mainScreen] bounds].size.width
#define kMainScreenHeight                    [[UIScreen mainScreen] bounds].size.height

#define kMainScale                           kMainScreenWidth/375.f
#define kMainHScale                          kMainScreenHeight/667.f

#define kStatusHeight (int)[UIApplication sharedApplication].statusBarFrame.size.height //x44 非x20
#define kNavigationBarHeight ((int)[UIApplication sharedApplication].statusBarFrame.size.height+44) //x88 非x64

@interface CNSelectCountriesViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *contactArray;//联系人一维数组
@property (nonatomic, strong) NSMutableArray *sortedArray;//排序后的联系人二维数组
@property (nonatomic, strong) NSMutableArray *letterArray;//需要显示的字母数组

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILocalizedIndexedCollation *collation;

@end

@implementation CNSelectCountriesViewController
#pragma mark - Data
- (void)getData{
    
    //获取所有字母A-Z
    self.collation = [UILocalizedIndexedCollation currentCollation];
    
    //创建存放相同首字母名字对象的二维数组
    //@[@[],@[],@[],@[]....]
    for (int i = 0; i < self.collation.sectionTitles.count; i++) {
        NSMutableArray *mutArray = [NSMutableArray array];
        [self.sortedArray addObject:mutArray];
    }
    //把各个联系人对象取出来，放到对应的数组中
    for (CNSelectCountries *contact in self.contactArray) {
        NSInteger position = [self.collation sectionForObject:contact collationStringSelector:@selector(name)];
        [self.sortedArray[position] addObject:contact];
    }
    //再把存放着各个相同首字母名字对象的数组取出来，将其中的联系人对象按照名称进行排序
    [self.sortedArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *array = [self.collation sortedArrayFromArray:obj collationStringSelector:@selector(name)];
        self.sortedArray[idx] = array;
    }];
   
    //获取所有字母A-Z
    __block NSMutableArray *letters = [NSMutableArray arrayWithArray:self.collation.sectionTitles];
    //在二维数组中删除没有联系人的数组
    [self.sortedArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *arr = (NSArray *)obj;
        if(arr.count == 0){
            [letters replaceObjectAtIndex:idx withObject:@"1"];
        }
    }];
    [letters removeObject:@"1"];
    //用于显示分组
    self.letterArray = letters;
    
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
    
}
- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    self.view.backgroundColor = [UIColor whiteColor];
    [self getData];
    [self setupNavigationBar];
    [self.view addSubview:self.tableView];
    
    NSArray *arr = @[@{@"name":@"中国大陆",@"code":@"86"}, @{@"name":@"中国台湾",@"code":@"886"}, @{@"name":@"中国香港",@"code":@"852"}, @{@"name":@"中国澳门",@"code":@"853"}];
    NSArray *contact = [CNSelectCountries mj_objectArrayWithKeyValuesArray:arr];
    CNSelectCountriesHeadView *view = [[CNSelectCountriesHeadView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth,  45*kMainScale*contact.count+30*kMainHScale)];
    view.data = contact;
    view.delegate = self;
    self.tableView.tableHeaderView = view;
    
//    [_footer setTitle:[NSString stringWithFormat:@"%lu个地区",(unsigned long)self.contactArray.count] forState:MJRefreshStateNoMoreData];
    
}
- (void)dealloc {
    NSLog(@"CNLiveAddressBookViewController - dealloc");
    
}
- (void)setupNavigationBar {

    // 创建假的导航栏
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, kStatusHeight, [UIScreen mainScreen].bounds.size.width, 44)];
    navView.backgroundColor = [UIColor whiteColor];
    [self.view bringSubviewToFront:navView];
    [self.view addSubview:navView];
    
    UIButton *left= [UIButton buttonWithType:UIButtonTypeSystem];
    left.frame = CGRectMake(0, 0, 44, 44);
    [left setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    left.titleLabel.font = [UIFont systemFontOfSize:16];
    
    NSBundle *currentBundle = [NSBundle bundleForClass:[CNSelectCountriesViewController class]];
    NSURL *url = [currentBundle URLForResource:@"CNLiveMine" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    NSString *path = [imageBundle pathForResource:@"close" ofType:@"png"];

    [left setImage:[[UIImage imageWithContentsOfFile:path] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:left];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake((kMainScreenWidth - 150)/2.0, kStatusHeight, 150, 44)];
    titleLbl.font = [UIFont systemFontOfSize:18];
    titleLbl.textColor = [UIColor colorWithRed:49/255.0 green:49/255.0 blue:49/255.0 alpha:1];
    titleLbl.text = @"选择国家或地区";
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLbl];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45*kMainScale;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSArray *arr = self.sortedArray[section];
    if (arr.count != 0) {
        return 30*kMainHScale;

    } else {
        return 0.00000001f;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00000001f;
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.collation.sectionTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.sortedArray[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CNSelectCountriesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CNSelectCountriesTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CNSelectCountries *contact = self.sortedArray[indexPath.section][indexPath.row];
    cell.model = contact;
    cell.isPadding = NO;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSArray *arr = self.sortedArray[section];
    if (arr.count != 0) {
        return self.collation.sectionTitles[section];
        
    } else {
        return nil;
    }
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.letterArray;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CNSelectCountries *contact = self.sortedArray[indexPath.section][indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectViewController:countryName:countryCode:)]) {
        [self goBack];
        [self.delegate selectViewController:self countryName:contact.name countryCode:contact.code];
    }
    
}
#pragma mark - SelectCountriesHeadViewDelegate
- (void)selectHeadView:(CNSelectCountriesHeadView *)view countryName:(NSString *)name countryCode:(NSString *)code{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectViewController:countryName:countryCode:)]) {
        [self goBack];
        [self.delegate selectViewController:self countryName:name countryCode:code];
    }

}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark - Lazy Laoding
- (NSMutableArray *)contactArray {
    if (!_contactArray) {
        _contactArray = [NSMutableArray array];
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"countries" ofType:@"plist"]];
        for (NSDictionary *dic in array) {
            CNSelectCountries *contact = [CNSelectCountries mj_objectWithKeyValues:dic];
            [_contactArray addObject:contact];
        }
    }
    return _contactArray;
}

- (NSMutableArray *)sortedArray {
    if (!_sortedArray) {
        _sortedArray = [NSMutableArray array];
        
    }
    return _sortedArray;
}
- (NSMutableArray *)letterArray {
    if (!_letterArray) {
        _letterArray = [NSMutableArray array];
        
    }
    return _letterArray;
}

- (UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationBarHeight, kMainScreenWidth, kMainScreenHeight-kNavigationBarHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        [_tableView registerClass:[CNSelectCountriesTableViewCell class] forCellReuseIdentifier:@"CNSelectCountriesTableViewCell"];
       
    }
    return _tableView;
}

#pragma mark - Action
- (void)goBack {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
