//
//  CSVDelegate.h
//  Noosh
//
//  Created by Maher Suboh on 4/15/14.
//  Copyright (c) 2014 Maher Suboh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHCSVParser.h"

@interface CSVDelegate : NSObject <CHCSVParserDelegate>

@property (readonly) NSArray *lines;


@end
