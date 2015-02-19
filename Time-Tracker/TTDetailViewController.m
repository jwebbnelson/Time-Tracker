//
//  TTDetailViewController.m
//  Time-Tracker
//
//  Created by Ross McIlwaine on 2/19/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "TTDetailViewController.h"
#import "TTProjectController.h"

@interface TTDetailViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;



@end

@implementation TTDetailViewController

-(instancetype)init {
    self = [super init];
    if(self){
        self.detailDataSource = [TTDetailViewControllerDataSource new];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self.detailDataSource;
    
    
}


- (IBAction)addAction:(id)sender {
    
    
}


- (IBAction)checkInAction:(id)sender {
    
    
}

- (IBAction)checkOutAction:(id)sender {
    
    
}

- (IBAction)reportAction:(id)sender {
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    self.project.text = textField.text;
    [[TTProjectController sharedInstance] storeDefaultsInProjects];
    
    return YES;
}

@end