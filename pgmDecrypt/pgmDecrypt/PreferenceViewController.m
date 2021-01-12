//
//  PreferenceViewController.m
//  pgmDecrypt
//
//  Created by admin on 2021/1/12.
//

#import "PreferenceViewController.h"

@interface PreferenceViewController ()
@property (weak) IBOutlet NSTextField *defaultDirField;
@property (weak) IBOutlet NSButton *autoOpen;
@end

@implementation PreferenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *value = [[NSUserDefaults standardUserDefaults] valueForKey:@"defaultDir"];
    self.defaultDirField.stringValue = value.length ? value : @"";
    self.autoOpen.state = [[NSUserDefaults standardUserDefaults] boolForKey:@"autoOpen"];
}

- (IBAction)setDir:(NSButton *)sender {
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    [openPanel setPrompt: @"选择文件夹"];
    openPanel.canCreateDirectories = YES;
    openPanel.canChooseDirectories = YES;
    openPanel.allowsMultipleSelection = NO;
    openPanel.canChooseFiles = NO;
    
    [openPanel beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse returnCode) {
        if (returnCode == NSModalResponseOK) {
            NSString *pathString = [openPanel.URLs.firstObject path];
            self.defaultDirField.stringValue = pathString;
            [[NSUserDefaults standardUserDefaults] setValue:pathString forKey:@"defaultDir"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }];
}
- (IBAction)autoOpen:(NSButton *)sender {
    [[NSUserDefaults standardUserDefaults] setBool:sender.state forKey:@"autoOpen"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (IBAction)clearPath:(NSButton *)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"defaultDir"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.defaultDirField.stringValue = @"";
}

@end
