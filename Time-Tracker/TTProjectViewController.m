//
//  TTProjectViewController.m
//  Time-Tracker
//
//  Created by Ross McIlwaine on 2/19/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "TTProjectViewController.h"
#import "TTListTableViewDataSource.h"
#import "TTDetailViewController.h"
#import "TTProjectController.h"

@interface TTProjectViewController () <UITableViewDelegate>

@property (nonatomic, strong) TTListTableViewDataSource *dataSource;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TTProjectViewController

- (instancetype) init {
    
    self = [super init];
    
    if (self) {
        self.dataSource = [TTListTableViewDataSource new];
    }
    return self;
    
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self.dataSource;
    
    [self.dataSource registerTableView:self.tableView];
    
    
}

// When project is selected, pushes to DetailViewController
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TTProject *project = [TTProjectController sharedInstance].projects[indexPath.row];
    
    TTDetailViewController *viewController = [TTDetailViewController new];
    viewController.project = project;
    
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
