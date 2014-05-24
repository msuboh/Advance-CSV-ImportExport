//
//  MHSDetailViewController.m
//  AdvanceCSVImportExport
//
//  Created by Maher Suboh on 5/19/14.
//  Copyright (c) 2014 Maher Suboh. All rights reserved.
//

#import "MHSDetailViewController.h"

@interface MHSDetailViewController ()
- (void)configureView;
@end

@implementation MHSDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
//
//    if (self.detailItem) {
//        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"timeStamp"] description];
//    }
    
    
    if (self.detailItem) {
        //        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"timeStamp"] description];
        self.title = [[self.detailItem valueForKey:@"menuItemCategory"] description];
        self.detailDescriptionLabel.text = [NSString  stringWithFormat:@"%@\n\n%@\n\n%@\n%@\n%@\n\n%@",
                                            [[self.detailItem valueForKey:@"menuItemNumber"] description],
                                            [[self.detailItem valueForKey:@"menuItemCategoryOrderIncludes"] description],
                                            [[self.detailItem valueForKey:@"menuItemName"] description],
                                            [[self.detailItem valueForKey:@"menuItemBriefDescription"] description],
                                            [[self.detailItem valueForKey:@"menuItemDescription"] description],
                                            [[self.detailItem valueForKey:@"menuItemPrice"] description]
                                            ];
        
    }

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
