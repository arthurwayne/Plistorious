//
//  BAVDocument.m
//  Plistorious
//
//  Created by Bavarious on 01/10/2013.
//  Copyright (c) 2013 No Organisation. All rights reserved.
//

#import "BAVPlistDocument.h"
#import "BAVPlistNode.h"


@interface BAVPlistDocument () <NSOutlineViewDataSource>
@property (strong) BAVPlistNode *rootNode;
@property (weak) IBOutlet NSOutlineView *outlineView;
@end


@implementation BAVPlistDocument

- (NSString *)windowNibName
{
    return @"BAVPlistDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)windowController
{
    [super windowControllerDidLoadNib:windowController];

    [self.outlineView reloadData];
    [self.outlineView expandItem:self.rootNode];
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    id rootObject = ([typeName isEqualToString:@"PlistDocumentType"] ?
                     [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:outError] :
                     [NSJSONSerialization JSONObjectWithData:data options:0 error:outError]);

    if (rootObject == nil)
        return false;

    self.rootNode = [BAVPlistNode plistNodeFromObject:rootObject key:@"Root"];
    return true;
}

#pragma mark - NSOutlineViewDataSource

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(BAVPlistNode *)item
{
    if (item == nil)
        return self.rootNode;

    return item.children[index];
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(BAVPlistNode *)item
{
    if (item == nil)
        return 1;

    return item.children.count;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(BAVPlistNode *)item
{
    return item == nil || item.collection;
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(BAVPlistNode *)item
{
    NSString *columnId = tableColumn.identifier;

    if ([columnId isEqualToString:@"key"])
        return item.key;
    else if ([columnId isEqualToString:@"type"])
        return item.type;
    else if ([columnId isEqualToString:@"value"])
        return item.value;

    return nil;
}

@end
