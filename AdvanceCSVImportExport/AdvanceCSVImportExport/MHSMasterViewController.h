//
//  MHSMasterViewController.h
//  AdvanceCSVImportExport
//
//  Created by Maher Suboh on 5/19/14.
//  Copyright (c) 2014 Maher Suboh. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface MHSMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;




// The following code is for importing the csv file from email
- (void)handleOpenURL:(NSURL *)url;

@property (strong, nonatomic)  UIActivityIndicatorView *spinner;


@end
