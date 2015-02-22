//
//  TTDetailViewController.m
//  Time-Tracker
//
//  Created by Ross McIlwaine on 2/19/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "DetailViewController.h"
#import "ProjectController.h"
#import "DetailViewDataSource.h"
#import "CustomEntryViewController.h"
#import <MessageUI/MessageUI.h>


@interface DetailViewController () <UITextFieldDelegate, UITextFieldDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (nonatomic, strong) DetailViewDataSource *dataSource;


@end

// View Controller for specific Project, keeps track of entries
@implementation DetailViewController

-(instancetype)init {
    self = [super init];
    if(self){
        self.detailDataSource = [DetailViewDataSource new];
      
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//  self.navigationController.navigationBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reef.png"]];
    [self.tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"reef.png"]]];
    
    self.titleTextField.text = self.project.title;
    self.titleTextField.delegate = self;
    self.timeLabel.text = [self.project projectTime];
    
    self.tableView.dataSource = self.detailDataSource;
    self.dataSource.project = self.project;
    
}

// Action method for add method, presents
- (IBAction)addAction:(id)sender {

    CustomEntryViewController *customViewController = [CustomEntryViewController new];
    customViewController.project = self.project;
    [self presentViewController:customViewController animated:YES completion:nil];
}

#pragma mark - checkIn/Out methods
- (IBAction)checkInAction:(id)sender {
    
    [self.project startNewEntry];
    [self.tableView reloadData];
}

- (IBAction)checkOutAction:(id)sender {
    
    [self.project endCurrentEntry];
    [self.tableView reloadData];
}

#pragma mark - reportAction (email)
- (IBAction)reportAction:(id)sender {
    
    MFMailComposeViewController *mailer = [MFMailComposeViewController new];
    mailer.mailComposeDelegate = self;
    
    NSString *entryTimes;
    
    for (Entry *entry in self.project.entries) {
        if (entryTimes) {
            entryTimes = [NSString stringWithFormat:@"%@\n%@ to %@\n", entryTimes, entry.startTime, entry.endTime];
        } else {
            entryTimes = [NSString stringWithFormat:@"\n%@ to %@\n", entry.startTime, entry.endTime];
        }
    }
    
    [mailer setMessageBody:entryTimes isHTML:NO];
    
    [self presentViewController:mailer animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - textField editing methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    self.project.text = textField.text;
    [[ProjectController sharedInstance] storeDefaultsInProjects];
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
