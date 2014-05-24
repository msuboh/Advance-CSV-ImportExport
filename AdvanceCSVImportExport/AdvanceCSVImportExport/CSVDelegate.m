//
//  CSVDelegate.m
//  Noosh
//
//  Created by Maher Suboh on 4/15/14.
//  Copyright (c) 2014 Maher Suboh. All rights reserved.
//

#import "CSVDelegate.h"

@implementation CSVDelegate
{
    NSMutableArray *_lines;
    NSMutableArray *_currentLine;
}


//- (void)dealloc {
//    [_lines release];
//    [super dealloc];
//}
- (void)parserDidBeginDocument:(CHCSVParser *)parser
{
//    [_lines release];
    _lines = [[NSMutableArray alloc] init];
}
- (void)parser:(CHCSVParser *)parser didBeginLine:(NSUInteger)recordNumber {
    _currentLine = [[NSMutableArray alloc] init];
}
- (void)parser:(CHCSVParser *)parser didReadField:(NSString *)field atIndex:(NSInteger)fieldIndex {
//    NSLog(@"%@", field);
    [_currentLine addObject:field];
}
- (void)parser:(CHCSVParser *)parser didEndLine:(NSUInteger)recordNumber {
    [_lines addObject:_currentLine];
//    [_currentLine release];
    _currentLine = nil;
}
- (void)parserDidEndDocument:(CHCSVParser *)parser {
    //	NSLog(@"parser ended: %@", csvFile);
}
- (void)parser:(CHCSVParser *)parser didFailWithError:(NSError *)error {
	NSLog(@"ERROR: %@", error);
    _lines = nil;
}




@end
