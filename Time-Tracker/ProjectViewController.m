//
//  TTProjectViewController.m
//  Time-Tracker
//
//  Created by Ross McIlwaine on 2/19/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "ProjectViewController.h"
#import "ProjectViewDataSource.h"
#import "DetailViewController.h"
#import "ProjectController.h"


@interface ProjectViewController () <UITableViewDelegate>

@property (nonatomic, strong) ProjectViewDataSource *dataSource;
@property (nonatomic, strong) UITableView *tableView;

@end

// View Controller containing project instances
@implementation ProjectViewController

- (instancetype) init {
    
    self = [super init];
    
    if (self) {
        self.dataSource = [ProjectViewDataSource new];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reef.png"]];
    
    [self.tableView reloadData];
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // ProjectView Title label
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:27.0];
    titleLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reef.png"]];
    self.navigationItem.titleView = titleLabel;
    titleLabel.text = @"Time Hero";
    [titleLabel sizeToFit];

    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.opaque = NO;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self.dataSource;
    
    [self.dataSource registerTableView:self.tableView];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newProject)];
    
    self.navigationItem.rightBarButtonItem = addButton;
    
}

- (void)newProject {
    
    Project *project = [Project new];
    [[ProjectController sharedInstance] addProject:project];
    
    DetailViewController *detailViewController = [DetailViewController new];
    detailViewController.project = project;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

// When project is selected, pushes to DetailViewController
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reef.png"]];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Project *project = [ProjectController sharedInstance].projects[indexPath.row];
    
    DetailViewController *viewController = [DetailViewController new];
    viewController.project = project;
    
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
