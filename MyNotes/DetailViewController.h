//
//  DetailViewController.h
//  MyNotes
//
//  Created by Wiley Wimberly on 7/28/14.
//  Copyright (c) 2014 Warm Fuzzy Apps, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
