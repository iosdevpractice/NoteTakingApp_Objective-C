//
//  MasterViewController.m
//  MyNotes
//
//  Created by Wiley Wimberly on 7/28/14.
//  Copyright (c) 2014 Warm Fuzzy Apps, LLC. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
#import "Note.h"
#import "NoteStore.h"

@interface MasterViewController ()

@property (nonatomic, strong) NoteStore *noteStore;
@property (nonatomic, readonly) NSMutableArray *notes;

@end

@implementation MasterViewController

#pragma mark - accessors

- (NoteStore *)noteStore {
    if (!_noteStore) {
        _noteStore = [[NoteStore alloc] init];
    }
    return _noteStore;
}

- (NSMutableArray *)notes
{
    return self.noteStore.notes;
}

#pragma mark - view lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.notes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSDateFormatter *formatter = nil;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateStyle:NSDateFormatterShortStyle];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Note *note = self.notes[indexPath.row];
    cell.textLabel.text = note.title;
    cell.detailTextLabel.text = [formatter stringFromDate:note.modificationDate];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.notes removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [self.notes exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
}

#pragma mark - segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Note *note = self.notes[indexPath.row];
        [[segue destinationViewController] setNote:note];
    
    } else if ([[segue identifier] isEqualToString:@"addNote"]) {
    
        Note *note = [[Note alloc] init];
        UINavigationController *nc = (UINavigationController *)segue.destinationViewController;
        DetailViewController *dvc = (DetailViewController *)nc.topViewController;
        dvc.note = note;
        dvc.newNote = YES;
        dvc.completionBlock = ^{
            [self.notes insertObject:note atIndex:0];
            NSIndexPath *first = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[first]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];
        };
    }
}

@end
