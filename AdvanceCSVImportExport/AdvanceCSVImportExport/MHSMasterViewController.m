//
//  MHSMasterViewController.m
//  AdvanceCSVImportExport
//
//  Created by Maher Suboh on 5/19/14.
//  Copyright (c) 2014 Maher Suboh. All rights reserved.
//

/*
        Let’s configure our app so it gets OPEN when we tap on a CSV file email attachment.
        
        It’s a two step process:
 
        1.	First we have to register our application so it can handle files of a particular type (CSV in this case). 
            We’re doing this by adding CFBundleDocumentTypes key to our app’s Info.plist file.
 
        2.	For all non system-defined UTIs (Uniform Type Identifiers) we also need to setup UTExportedTypeDeclarations so system can be made aware of them.
        
 
 
        Let’s open application Info.plist file:
 
 
        - Let’s add CFBundleDocumentTypes. Click RMB on the white space below default settings and select Add Row:
        - From the drop down list select “Document types”. The key matches CFBundleDocumentTypes in XML file as we’ll see later.
 
         Together with our key one item – “Item 0” – is automatically created. It has two following sub keys:
         - Document Type Name
         - Handler Rank
         
         We have to add two more rows (use a small + icon, placed on the right hand side of the “Document Type” row) to create a new entry:
         - Role
         - Document Content Type UTIs
 
         <key>CFBundleDocumentTypes</key>
         <array>
         <dict>
         <key>CFBundleTypeName</key>
         <string>US Presidents File</string>
         <key>LSHandlerRank</key>
         <string>Owner</string>
         <key>CFBundleTypeRole</key>
         <string>Viewer</string>
         <key>LSItemContentTypes</key>
         <array>
         <string>Damian-s.${PRODUCT_NAME:rfc1034identifier}</string>
         </array>
         </dict>
         </array>
 
        - We have to set it up as shown on the screen below:
 
         <key>UTExportedTypeDeclarations</key>
         <array>
         <dict>
         <key>UTTypeDescription</key>
         <string>US Presidents File</string>
         <key>UTTypeConformsTo</key>
         <array>
         <string>public.data</string>
         </array>
         <key>UTTypeIdentifier</key>
         <string>Damian-s.${PRODUCT_NAME:rfc1034identifier}</string>
         <key>UTTypeTagSpecification</key>
         <dict>
         <key>public.filename-extension</key>
         <string>csv</string>
         <key>public.mime-type</key>
         <string>application/uspresidents</string>
         </dict>
         </dict>
         </array>
 
 
         <?xml version="1.0" encoding="UTF-8"?>
         <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
         <plist version="1.0">
         <array>
         <dict>
         <key>UTTypeConformsTo</key>
         <array>
         <string>public.data</string>
         </array>
         <key>UTTypeDescription</key>
         <string>US Presidents File</string>
         <key>UTTypeIdentifier</key>
         <string>Damian-s.${PRODUCT_NAME:rfc1034identifier}</string>
         <key>UTTypeTagSpecification</key>
         <dict>
         <key>public.filename-extension</key>
         <string>csv</string>
         <key>public.mime-type</key>
         <string>application/uspresidents</string>
         </dict>
         </dict>
         </array>
         </plist>
 
 
         <?xml version="1.0" encoding="UTF-8"?>
         <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
         <plist version="1.0">
         <array>
         <dict>
         <key>CFBundleTypeName</key>
         <string>US Presidents File</string>
         <key>CFBundleTypeRole</key>
         <string>Viewer</string>
         <key>LSHandlerRank</key>
         <string>Owner</string>
         <key>LSItemContentTypes</key>
         <array>
         <string>Damian-s.${PRODUCT_NAME:rfc1034identifier}</string>
         </array>
         </dict>
         </array>
         </plist>
 
 
 - CFBundleDocumentTypes - Array
 
 
 <?xml version="1.0" encoding="UTF-8"?>
 <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
 <plist version="1.0">
 <array>
 <dict>
 <key>CFBundleTypeName</key>
 <string>Kababish Menu File</string>
 <key>LSHandlerRank</key>
 <string>Owner</string>
 <key>CFBundleTypeRole</key>
 <string>Viewer</string>
 <key>LSItemContentTypes</key>
 <array>
 <string>com.MaherSuboh.${PRODUCT_NAME:rfc1034identifier}</string>
 </array>
 </dict>
 </array>
 </plist>

 
 
 
 - UTExportedTypeDeclarations

 
 <?xml version="1.0" encoding="UTF-8"?>
 <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
 <plist version="1.0">
 <array>
 <dict>
 <key>UTTypeDescription</key>
 <string>Kababish Menu File</string>
 <key>UTTypeConformsTo</key>
 <array>
 <string>public.data</string>
 </array>
 <key>UTTypeIdentifier</key>
 <string>com.MaherSuboh.${PRODUCT_NAME:rfc1034identifier}</string>
 <key>UTTypeTagSpecification</key>
 <dict>
 <key>public.mime-type</key>
 <string>application/AppDataBackup</string>
 <key>public.filename-extension</key>
 <string>csv</string>
 </dict>
 </dict>
 </array>
 </plist>

 
 */



#import "MHSMasterViewController.h"
#import "MHSDetailViewController.h"

#import "CHCSVParser.h"
#import "CSVDelegate.h"



typedef void(^myCompletion)(BOOL);


@interface MHSMasterViewController ()

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end




@implementation MHSMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    
    // To Change the image icon for the Bar Button to one of the preshipped with App programmingly, change initWithBarButtonSystemItem to one of (UIBarButtonSystemItemAction, UIBarButtonSystemItemAdd, ..., etc.)
    // like in the XIB file in storyboard in the identifier item in Bar Button Item Group/Section for the one you like.
    //
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionItem:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    
    //////////////////////////////////////////////
    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _spinner.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    _spinner.transform = CGAffineTransformMakeScale(1.5, 1.5);
    _spinner.center = self.view.center;
    [_spinner setColor:[UIColor blueColor]];
    [self.view addSubview:_spinner];
    [self.view bringSubviewToFront:_spinner];
    /////////////////////////////////////////////

    
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//      The following code is for importing the csv file from email
///
-(void) removeAllCSVFilesFromTmpDirectory
{
    NSFileManager  *manager = [NSFileManager defaultManager];
    
    //1. Way 1 work Good
    //    NSString *fileName = @"AppDataBackup.csv";
    //    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //    NSString *inboxDirectory = [documentsDirectory stringByAppendingPathComponent:@"Inbox"];
    //    NSString *filePath = [inboxDirectory stringByAppendingPathComponent:fileName];
    //    NSError *error;
    //    BOOL success = [manager removeItemAtPath:filePath error:&error];
    //    if (!success) {
    //        NSLog(@"error occured during removing the file");
    //    }
    //
    
    
    // 2. Way 2 ...?!
    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    if ([paths count] > 0)
    //    {
    //        NSError *error = nil;
    //        NSFileManager *fileManager = [NSFileManager defaultManager];
    //
    //        // Print out the path to verify we are in the right place
    //        NSString *directory = [paths objectAtIndex:0];
    //        NSLog(@"Directory: %@", directory);
    //
    //        // For each file in the directory, create full path and delete the file
    //        for (NSString *file in [fileManager contentsOfDirectoryAtPath:directory error:&error])
    //        {
    //            NSString *filePath = [directory stringByAppendingPathComponent:file];
    //            NSLog(@"File : %@", filePath);
    //
    //            BOOL fileDeleted = [fileManager removeItemAtPath:filePath error:&error];
    //
    //            if (fileDeleted != YES || error != nil)
    //            {
    //                // Deal with the error...
    //            }
    //        }
    //
    //    }
    
    
    // 3. Way 3... I like this one the best
    // the preferred way to get the apps documents directory
    // NSString *match = @"-*.csv";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingString:@"/Inbox"];
    // grab all the files in the documents dir
    NSArray *allFiles = [manager contentsOfDirectoryAtPath:documentsDirectory error:nil];
    
    // filter the array for only sqlite files
    NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self ENDSWITH '.csv'"];
    //NSPredicate *fltr = [NSPredicate predicateWithFormat:@"SELF like %@", match];
    NSArray *csvFiles = [allFiles filteredArrayUsingPredicate:fltr];
    
    // use fast enumeration to iterate the array and delete the files
    for (NSString *csvFile in csvFiles)
    {
        NSError *error = nil;
        [manager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:csvFile] error:&error];
        NSAssert(!error, @"Assertion: SQLite file deletion shall never throw an error.");
    }
    
    
    
}

- (BOOL) restoreMyBackupDataFrom:(NSURL *)url
{
    
    [self deleteAllRecords];
    [self.tableView reloadData];

    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    // 1.
    //    // This is when you want to read the CSV file from the server and have its contents in a NSSTring variabel
    //    //
    NSData *responseData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[url absoluteString] ]];
    NSString *fileString = [[NSString alloc] initWithData:responseData   encoding:NSUTF8StringEncoding];
    //	CHCSVParser * p = [[CHCSVParser alloc] initWithCSVString:fileString ];
    CHCSVParser *p = [[CHCSVParser alloc] initWithCSVString:fileString ];
    //    //
    //    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    [p setRecognizesBackslashesAsEscapes:YES];
    [p setSanitizesFields:YES];
		
	CSVDelegate * d = [[CSVDelegate alloc] init];
	[p setDelegate:d];
	
	NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
	[p parse];
    
    
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    
    
    NSArray *headerFieldsArray = [[d lines] objectAtIndex:0] ;

    
    
    for (int i=1; i < [d lines].count - 1; i++)
    {


        
        
        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
        
        for (NSInteger j=0; j < [headerFieldsArray count] - 1; j++)
            [newManagedObject setValue:[  [[d lines] objectAtIndex:i] objectAtIndex:j ] forKey: [headerFieldsArray objectAtIndex:j]  ];
        
        // this is not reqired, but because I found that the date format when Export/backed up not excepted when importing it back by email, I did this to make sure if it is nil or different
        [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
        
        
        // Save the context.
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        
    }
    
    
	NSTimeInterval end = [NSDate timeIntervalSinceReferenceDate];
	
	NSLog(@"raw difference: %f", (end-start));
    
    return true;
}

-(void) myBlockMethod:(NSURL *)url theCompleteStatus:(myCompletion)completionBlockStatus
{
    
    
    if (url)
    {
//        [[[UIAlertView alloc] initWithTitle:@"Action Status 2" message:[url absoluteString] delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil] show];

        [self restoreMyBackupDataFrom:url];
    }
    
    [self.tableView reloadData];

    
    
    completionBlockStatus(YES);
}

-(void)doA:(NSURL *)url
{
        // Here I am using my completion Custom Block
        [self myBlockMethod:url theCompleteStatus:^(BOOL finished)  {
            // myBlockMethod method just download or load the CSV file from the server to a NSString String variable and check if it is there and no error, before we Parse it into an array.


            if(finished)
            {
                [self removeAllCSVFilesFromTmpDirectory];
                NSLog(@"Success!");
            }
            else
            {
                NSLog(@"No Success!");
            }
        }];
 
}

- (void)handleOpenURL:(NSURL *)url
{
    
    [self.spinner startAnimating];
  
    [self performSelectorOnMainThread:@selector(doA:) withObject:url waitUntilDone:NO];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
        [self.spinner stopAnimating];
    });


//    // 5. My Custom Block method and GCD Way
//    // Why I am Using Both togther. Though my Custom completion Block is enough to handle the completion when loading the cvs file from the sever and handle the erro.
//    // Becuase, without the GCD way, when you run the App, the ViewControl view is Black, and can't do other things beside it like displaying the Activity View and/or scroll the Table view, ... etc..
//    dispatch_queue_t countQueue = dispatch_queue_create("counter", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(countQueue, ^{
//        
//        __block bool finishedOK = YES;
//        
//
//        
//        // Here I am using my completion Custom Block
//        [self myBlockMethod:url theCompleteStatus:^(BOOL finished)  {
//            // myBlockMethod method just download or load the CSV file from the server to a NSString String variable and check if it is there and no error, before we Parse it into an array.
//            
//            
//            if(finished)
//            {
//                NSLog(@"Success!");
////                [self removeAllCSVFilesFromTmpDirectory];
//                [self.tableView reloadData];
//                
////                [self.spinner stopAnimating];
//            }
//            else
//            {
//                finishedOK = NO;
//                NSLog(@"No Success!");
//                
//            }
//        }];
//        
//        
//        
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            if (finishedOK)
//            {
//                [self removeAllCSVFilesFromTmpDirectory];
////                [self.tableView reloadData];
//            }
//            else
//            {
//                NSLog(@"Display a message error 2");
//                [[[UIAlertView alloc] initWithTitle:@"Action Status" message:@"An Error Occurs!" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil] show];
//            }
//            
//            [self.tableView reloadData];
//
//            [self.spinner stopAnimating];
//            
//        });
//        
//        
//        NSLog(@"And out of the GCD Queue Block");
//        
//    });

    
    

}
//////////////////////////////////////////////////

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) readCSV_CHCSVParser:(int)readFrom
{
    
    
    CHCSVParser *p;
    
    
    switch (readFrom)
    {

        case 1:
        {
            // 1.
            //    // This is when you want to read the CSV file from the server and have its contents in a NSSTring variabel
            //    //
            NSData *responseData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://192.168.1.100/Kababish/KababishServerMenu.csv"]];
            NSString *fileString = [[NSString alloc] initWithData:responseData   encoding:NSUTF8StringEncoding];
            //	CHCSVParser * p = [[CHCSVParser alloc] initWithCSVString:fileString ];
            p = [[CHCSVParser alloc] initWithCSVString:fileString ];
            //    //
            //    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            break;
        }
        case 2:
        {
            // 2.
            NSStringEncoding encoding = 0;

            /////////////////////////////////////////////////////////////////////////////////////////////////////
            // The following Three lines work OK with the Simulator
            //
            //NSString *file = @(__FILE__);
            //file = [[file stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"KababishMenu.csv"];
            //NSInputStream *stream = [NSInputStream inputStreamWithFileAtPath: fle  ];
            //
            //////////////////
            //
            // BUT
            //
            //[[NSBundle mainBundle] pathForResource:@"KababishMenu" ofType:@"csv"] instead -file- Work on Both Simulator and iPhone
            //
            /////////////////////////////////////////////////////////////////////////////////////////////////////

            
            
            // SO use this all the time ... I don't know why he is using   //////// NSString *file = @(__FILE__); from the above..... It is good to know?!
            NSInputStream *stream = [NSInputStream inputStreamWithFileAtPath: [[NSBundle mainBundle] pathForResource:@"KababishMenu" ofType:@"csv"]  ];
            p = [[CHCSVParser alloc] initWithInputStream:stream usedEncoding:&encoding delimiter:','];
            break;
        }
        case 3:
        {
            //3.
            NSString *file = @(__FILE__);
            file = [[file stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"KababishMenu.csv"];

            //	CHCSVParser * p = [[CHCSVParser alloc] initWithContentsOfCSVFile:file];
            p = [[CHCSVParser alloc] initWithContentsOfCSVFile:file];
            break;
        }
        default:
        {
            return;
            break;
        }
    }
    
    
    
    [p setRecognizesBackslashesAsEscapes:YES];
    [p setSanitizesFields:YES];
	
	
	CSVDelegate * d = [[CSVDelegate alloc] init];
	[p setDelegate:d];
	
	NSTimeInterval start = [NSDate timeIntervalSinceReferenceDate];
	[p parse];
    
    
    [self deleteAllRecords];
    
    
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    
    for (int i=1; i < [d lines].count; i++)
    {
        
        NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
        
        
        [newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
        [newManagedObject setValue:[  [[d lines] objectAtIndex:i] objectAtIndex:0 ] forKey:@"menuItemNumber"];
        [newManagedObject setValue:[  [[d lines] objectAtIndex:i] objectAtIndex:1 ] forKey:@"menuItemCategory"];
        [newManagedObject setValue:[  [[d lines] objectAtIndex:i] objectAtIndex:2 ] forKey:@"menuItemName"];
        [newManagedObject setValue:[  [[d lines] objectAtIndex:i] objectAtIndex:3 ] forKey:@"menuItemBriefDescription"];
        [newManagedObject setValue:[  [[d lines] objectAtIndex:i] objectAtIndex:4 ] forKey:@"menuItemDescription"];
        [newManagedObject setValue:[  [[d lines] objectAtIndex:i] objectAtIndex:5 ] forKey:@"menuItemPrice"];
        [newManagedObject setValue:[  [[d lines] objectAtIndex:i] objectAtIndex:6 ] forKey:@"menuItemCategoryOrderIncludes"];
        [newManagedObject setValue:[  [[d lines] objectAtIndex:i] objectAtIndex:7 ] forKey:@"menuItemSideOrder"];
        
        
        // Save the context.
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        
        
    }
    
    
	NSTimeInterval end = [NSDate timeIntervalSinceReferenceDate];
	
	NSLog(@"raw difference: %f", (end-start));
    
}



- (void) writeCSVFile_CHCSVParser
{
    
    if ([self checkifThereAreRecords:@"Event"] == 0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Action Status" message:@"You are trying to export an Empty Entity!\nLoading/Importing Local CSV File." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil] show];

        [self readCSV_CHCSVParser:2];
    }
    
    
    
//    NSString *tempFileName = [NSString stringWithFormat:@"%d-test.csv", arc4random()];
    NSString *tempFileName = @"TheExportKababishMenu.csv";
	NSString *tempFile = [NSTemporaryDirectory() stringByAppendingPathComponent:tempFileName];
    
    
    // NSBundle mainBundle]
    NSOutputStream *output = [NSOutputStream outputStreamToFileAtPath:tempFile append:NO];
    CHCSVWriter *writer = [[CHCSVWriter alloc] initWithOutputStream:output encoding:NSUTF8StringEncoding delimiter:','];
    
    int i = 0;
    
    for (NSManagedObject *selectedObjects in [self kababishServerMenuRecords])
    {
        
        NSMutableArray *stringArrayFieldValues = [[NSMutableArray alloc] init];
        NSMutableArray *stringArrayFieldNames = [[NSMutableArray alloc] init];

        NSEntityDescription *personEntity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext: [self.fetchedResultsController managedObjectContext] ];
        for (NSPropertyDescription *property in personEntity)
        {
            NSDictionary *attributes = [personEntity attributesByName];
            NSAttributeDescription *fieldAttribute = [attributes objectForKey:property.name];
            
            if (i == 0)
                [stringArrayFieldNames addObject:property.name ];

            if ([fieldAttribute attributeType] == NSDateAttributeType)
            {
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"MM/dd/yyyy"];
                NSString *dateString = [dateFormat stringFromDate: [selectedObjects valueForKey:property.name]  ];
                [stringArrayFieldValues addObject:dateString ];
            }
            else
                [stringArrayFieldValues addObject:[selectedObjects valueForKey:property.name] ];
        }
        
        
        if (i == 0)
            [writer writeLineOfFields:stringArrayFieldNames  ];

        [writer writeLineOfFields:stringArrayFieldValues  ];
        i += 1;
        
        //
        // for a small set of data I'll use the following instead of the above, BUT I had it done this way just for the sake of knowledage
        //
        //        [writer writeLineOfFields:@[
        //                                    [selectedObjects valueForKey:@"menuItemNumber"],
        //                                    [selectedObjects valueForKey:@"menuItemCategory"],
        //                                    [selectedObjects valueForKey:@"menuItemCategoryOrderIncludes"],
        //                                    [selectedObjects valueForKey:@"menuItemName"],
        //                                    [selectedObjects valueForKey:@"menuItemBriefDescription"],
        //                                    [selectedObjects valueForKey:@"menuItemDescription"],
        //                                    [selectedObjects valueForKey:@"menuItemSideOrder"],
        //                                    [selectedObjects valueForKey:@"menuItemPrice"]
        //
        //                                    ]];
        
        
    }
    
    [writer closeStream];

    
}


- (NSArray *) kababishServerMenuRecords
{
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:context];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptorByAge = [[NSSortDescriptor alloc] initWithKey:@"menuItemNumber" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptorByAge, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    return [context executeFetchRequest:fetchRequest error:nil];
}

- (int) checkifThereAreRecords:(NSString *)forEntity
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *managedObjectContext = context;
    NSEntityDescription *entity = [NSEntityDescription entityForName:forEntity inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    NSError *error = nil;
    NSUInteger count = [managedObjectContext countForFetchRequest:request error:&error];
    
    if (!error){
        return count;
    }
    else
        return -1;
    
}



- (void) deleteAllRecords
{
    
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Event" inManagedObjectContext:context]];
    
    //    NSSortDescriptor *sortDescriptorByAge = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:YES];
    //    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptorByAge, nil];
    //
    //
    //    [request setSortDescriptors:sortDescriptors];
    //
    //
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"appDefault = 1"   ];
    //    [request setPredicate:predicate];
    
    
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if (objects == nil)
    {
        // handle error
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Save Error!"
                                  message:[NSString stringWithFormat:@"Unresolved error %@, %@", error, [error userInfo] ]
                                  delegate:self
                                  cancelButtonTitle:@"Ok"
                                  otherButtonTitles:nil, nil];
        [alertView show];
        
    }
    else
    {
        for (NSManagedObject *object in objects)
        {
            [context deleteObject:object];
        }
        [context save:&error];
    }
    
}

- (void)actionItem:(id)sender
{
    // Look for Localizable.strings file in [Supporting Files] group in the App main domain directory for NSLocalizedString(@"Cancel", @"") what those mean:
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"AlertTitle", @"")  delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"Cancel", @"")
                                         destructiveButtonTitle:NSLocalizedString(@"Delete", @"")
                                              otherButtonTitles:@"Import Local CSV File", @"Import Server CSV File", @"Export CSV File", @"Email CSV File", nil];
    [sheet showInView:[self.view window]];
}




- (void)emailCSVFile
{
    
    
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	
    
    if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			[self displayComposerSheet];
		}
		else
		{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email Failure"
                                                            message:@"Your device is not setup to send Email!\nPlease Activiate Email Through Settings."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
		}
	}
	else
	{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email Failure"
                                                        message:@"Your device is not setup to send Email!\nPlease Activiate Email Through Settings."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
	}
    
    
    
}


// Displays an email composition interface inside the application. Populates all the Mail fields.
-(void)displayComposerSheet
{
    
    
    // Attach The CSV File to the email
    NSString *tempFileName = @"TheExportKababishMenu.csv";
	NSString *tempFile = [NSTemporaryDirectory() stringByAppendingPathComponent:tempFileName];
    
    //    NSFileManager  *manager = [NSFileManager defaultManager];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:tempFile];
    if (!fileExists)
    {
        [[[UIAlertView alloc] initWithTitle:@"Action Status" message:@"You are trying to email an Empty CSV File!\nLoading/Importing and Creating Local CSV File to Email." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles: nil] show];
        NSLog(@"Does not Exists");
        [self writeCSVFile_CHCSVParser];
    }

    
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        
        [picker setSubject:@"Email CSV File for Backup"];
        
        NSString *locationEmailAddress1 =  @"xyz@hotmail.com";
        NSString *locationEmailAddress2 =  @"xyz@yahoo.com";
        
        // Set up recipients
        NSArray *toRecipients = [NSArray arrayWithObject:locationEmailAddress1];
        NSArray *ccRecipients = [NSArray arrayWithObjects:locationEmailAddress2,  nil];
        
        [picker setToRecipients:toRecipients];
        [picker setCcRecipients:ccRecipients];
        
        
        
         [picker addAttachmentData:[NSData dataWithContentsOfFile:tempFile]
                         mimeType:@"text/csv"
                         fileName:@"AppDataBackup.csv"];

        
        // Fill out the email body text
        NSString *emailBody = [NSString stringWithFormat:@"Emailing Your Data in CSV Format for Backup and Recovery reseaons.\nWe appreciate your opinion and/or any suggestions. We are looking forward to serving you."];
        [picker setMessageBody:emailBody isHTML:NO];
        
        [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark -
#pragma mark UIActionSheetDelegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //    //Get the name of the current pressed button
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];

    if ([buttonTitle isEqualToString:NSLocalizedString(@"Delete", @"") ])
    {
        NSLog(@"Destructive pressed --> Delete Something");
        [self deleteAllRecords];
    }
    if ([buttonTitle isEqualToString:@"Export CSV File"])
    {
        NSLog(@"Other Export pressed");
        [self writeCSVFile_CHCSVParser];
    }
    if ([buttonTitle isEqualToString:@"Import Server CSV File"])
    {
        NSLog(@"Other Import Server pressed");
        [self readCSV_CHCSVParser:1];
    }
    if ([buttonTitle isEqualToString:@"Import Local CSV File"])
    {
        NSLog(@"Other Import Local pressed");
        [self readCSV_CHCSVParser:2];
    }
    if ([buttonTitle isEqualToString:@"Email CSV File"]) {
        NSLog(@"Other Email pressed");
        [self emailCSVFile];
    }
    if ([buttonTitle isEqualToString:NSLocalizedString(@"Cancel", @"") ]) {
        NSLog(@"Cancel pressed --> Cancel ActionSheet");
    }
    
    
//  if (buttonIndex == actionSheet.cancelButtonIndex) { return; }
//	switch (buttonIndex) {
//		case 0:
//		{
////			NSLog(@"Item A Selected %@", actionSheet.address );
////            [self showDirectionByMailingAddress:actionSheet.address];
//            
//			break;
//		}
//		case 1:
//		{
//			NSLog(@"Item B Selected");
////            [[UIApplication sharedApplication] openURL:[NSURL URLWithString: [NSString stringWithFormat:@"telprompt://%@", actionSheet.phoneNumber ]    ]];
//            
//            //            NSURL *url = [NSURL URLWithString:@"tel://6788358352"];
//            //            [[UIApplication sharedApplication] openURL:url];
//			break;
//		}
//		case 2:
//		{
//			NSLog(@"Item C Selected");
////            [self performSegueWithIdentifier:@"ShowContactUS" sender:nil];
//            
//			break;
//		}
//	}
    
    
}

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	// Notifies users about errors associated with the interface
	NSString *emailMessage = @"Email Result: ";
    switch (result)
	{
		case MFMailComposeResultCancelled:
			emailMessage = [emailMessage stringByAppendingString: @"canceled"];
			break;
		case MFMailComposeResultSaved:
			emailMessage = [emailMessage stringByAppendingString: @"saved"];
			break;
		case MFMailComposeResultSent:
			emailMessage = [emailMessage stringByAppendingString: @"sent"];
			break;
		case MFMailComposeResultFailed:
			emailMessage = [emailMessage stringByAppendingString: @"failed"];
			break;
		default:
			emailMessage =[emailMessage stringByAppendingString: @"not sent"];
			break;
	}
//    _messageLabel.text = emailMessage;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return  [[[self.fetchedResultsController sections] objectAtIndex:section] name];;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
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
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }   
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"menuItemNumber" ascending:NO];
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"menuItemCategory" cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	     // Replace this implementation with code to handle the error appropriately.
	     // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return _fetchedResultsController;
}    

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [[object valueForKey:@"menuItemName"] description];
}

@end
