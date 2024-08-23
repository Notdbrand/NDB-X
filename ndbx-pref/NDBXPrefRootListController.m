#import <Foundation/Foundation.h>
#import "NDBXPrefRootListController.h"

@implementation NDBXPrefRootListController

- (NSArray *)specifiers {
    if (!_specifiers) {
        _specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
    }

    return _specifiers;
}

- (void)save {
    [self.view endEditing:YES];
}

- (void)apply {
    system("killall -9 SpringBoard");
}

@end

