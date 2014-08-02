//
//  DetailViewController.m
//  MyNotes
//
//  Created by Wiley Wimberly on 7/28/14.
//  Copyright (c) 2014 Warm Fuzzy Apps, LLC. All rights reserved.
//

#import "DetailViewController.h"
#import "Note.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *modificationDateLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;

@end

@implementation DetailViewController

#pragma mark - view lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    if (!self.isNewNote) {
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.note) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateStyle:NSDateFormatterLongStyle];
        
        self.modificationDateLabel.text =
        [formatter stringFromDate:self.note.modificationDate];
        
        self.contentTextView.text = self.note.content;
    }
    
    if (self.isNewNote) {
        [self.contentTextView becomeFirstResponder];
    }

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (!self.isNewNote) {
        if (![self.note.content isEqualToString:self.contentTextView.text]) {
            self.note.content = self.contentTextView.text;
        }
    }
}

#pragma mark - actions

- (IBAction)doneTapped:(UIBarButtonItem *)sender
{
    self.note.content = self.contentTextView.text;
    
    if (self.completionBlock) {
        self.completionBlock();
    }
    
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:nil];
}

- (IBAction)cancelTapped:(UIBarButtonItem *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:nil];
}

@end
