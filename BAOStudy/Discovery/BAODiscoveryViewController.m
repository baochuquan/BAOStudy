//
//  BAODiscoveryViewController.m
//  BAOStudy
//
//  Created by baochuquan on 2018/7/29.
//  Copyright © 2018年 Big Nerd Ranch. All rights reserved.
//

#import "BAODiscoveryViewController.h"
#import "BAOTableView.h"
#import "BAOTableViewModel.h"
#import "BAODiscoveryEntryCell.h"
#import "BAODiscoveryEntryCellViewModel.h"
#import "BAOARKitDemoViewController.h"

static const NSInteger SectionAugmentedReality = 0;

@interface BAODiscoveryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BAOTableViewModel *viewModel;

@end

@implementation BAODiscoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewModel];
    [self setupSubviews];
}

#pragma mark - Setup Methods

- (void)setupViewModel {
    self.viewModel = [[BAOTableViewModel alloc] init];

    BAOTableSectionViewModel *arSection = [[BAOTableSectionViewModel alloc] init];
    arSection.sectionId = SectionAugmentedReality;
    [self.viewModel.sectionViewModels addObject:arSection];

    arSection.cellViewModels = [[BAODiscoveryEntryCellViewModel defaultViewModels] mutableCopy];
}

- (void)setupSubviews {
    [self setupHeaderView];
    [self setupTableView];
}

- (void)setupHeaderView {
    self.headerView.title = @"发现";
    [self.headerView removeLeftButton];
}

- (void)setupTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = COLOR_BACKGROUND;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.contentView addSubview:self.tableView];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.tableView.superview);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.viewModel.sectionViewModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel sectionViewModelWithIndex:section].cellViewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BAOTableCellViewModel *viewModel = [self.viewModel cellViewModelWithIndexPath:indexPath];
    BAOTableViewCell *cell = [viewModel reusableCellWithTableView:tableView];
    [cell bindDataWithViewModel:viewModel];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BAOTableSectionViewModel *sectionVM = [self.viewModel sectionViewModelWithIndex:indexPath.section];
    BAOTableCellViewModel *cellVM = [self.viewModel cellViewModelWithIndexPath:indexPath];
    if (sectionVM.sectionId == SectionAugmentedReality) {
        if (cellVM.cellId == SectionAugmentedReality) {
            BAOARKitDemoViewController *vc = [[BAOARKitDemoViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel cellViewModelWithIndexPath:indexPath].cellHeight;
}

@end
