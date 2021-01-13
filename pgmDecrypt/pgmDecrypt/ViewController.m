//
//  ViewController.m
//  pgmDecrypt
//
//  Created by admin on 2021/1/7.
//

#import "ViewController.h"
#import "decrypt_PROM_PGM_1.h"
#import "decrypt_PROM_PGM_2.h"
#include "Header.h"
#import "DragDropView.h"

#define defaultDir [[NSUserDefaults standardUserDefaults] valueForKey:@"defaultDir"]

#define autoOpen [[NSUserDefaults standardUserDefaults] boolForKey:@"autoOpen"]

@interface ViewController () <DragDropViewDelegate>
@property (weak) IBOutlet NSComboBox *comboBox;
@property(nonatomic, assign) NSInteger selectIndex;
@property (unsafe_unretained) IBOutlet NSTextView *textView;
@property (nonatomic, strong) NSURL *filePathUrl;
@property (nonatomic, strong) NSString *fileName;
@property (unsafe_unretained) IBOutlet NSTextView *outputTextView;
@property (nonatomic, strong) DragDropView *dropView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectIndex = -1;
    [self setupViews];
}

- (void)setupViews {
    self.dropView = [[DragDropView alloc] initWithFrame:self.view.bounds];
    self.dropView.delegate = self;
    [self.view addSubview:self.dropView];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

- (IBAction)didClickComboBox:(NSComboBox *)sender {
    self.selectIndex = [sender indexOfSelectedItem];
    NSLog(@"%ld", self.selectIndex);
}

- (IBAction)openFileAction:(NSButton *)sender {
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
    [openPanel setPrompt: @"选择"];
    openPanel.allowsMultipleSelection = false;
    openPanel.directoryURL = nil;
    
    [openPanel beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse returnCode) {
        if (returnCode == 1) {
            NSURL *fileUrl = [[openPanel URLs] objectAtIndex:0];
            // 获取文件内容
            self.textView.string = fileUrl.path;
            self.filePathUrl = fileUrl.URLByDeletingLastPathComponent;
            self.fileName = fileUrl.lastPathComponent;
            NSLog(@"%@---%@", self.filePathUrl.path, self.fileName);
        }
    }];
}

- (IBAction)decryptAction:(NSButton *)sender {
    if (self.selectIndex == -1) {
        [self showWaringMessage:@"请选择需要解密的类型!" isOpen:false];
        return;
    }
    FILE *input = fopen([self.textView.string UTF8String], "rb");
    if (input == NULL) {
        [self showWaringMessage:@"需要解密的文件不存在!" isOpen:false];
        return;
    }
    fseek(input, 0, 2);
    int nf = (int)ftell(input);
    Handle hg = (Handle)malloc(nf);
    rewind(input);
    UINT16 *pus=(UINT16*)hg;
    fread(pus,2,nf/2,input);
    [self decryptFile:pus fileLength:nf isDecrypt:true];
    if (hg) {
        hg = 0;
        free(hg);
    }
    if (autoOpen) {
        [[NSWorkspace sharedWorkspace] openFile:([defaultDir length] ? defaultDir : self.filePathUrl.path)];
    }
}
- (IBAction)encryptAction:(NSButton *)sender {
    if (self.selectIndex == -1) {
        [self showWaringMessage:@"请选择需要加密的类型!" isOpen:false];
        return;
    }
    FILE *input = fopen([self.textView.string UTF8String], "rb");
    if (input == NULL) {
        [self showWaringMessage:@"需要加密的文件不存在!" isOpen:false];
        return;
    }
    fseek(input, 0, 2);
    int nf = (int)ftell(input);
    Handle hg = (Handle)malloc(nf);
    rewind(input);
    UINT16 *pus=(UINT16*)hg;
    fread(pus,2,nf/2,input);
    [self decryptFile:pus fileLength:nf isDecrypt:false];
    if (hg) {
        hg = 0;
        free(hg);
    }
    if (autoOpen) {
        [[NSWorkspace sharedWorkspace] openFile:([defaultDir length] ? defaultDir : self.filePathUrl.path)];
    }
}

- (void)decryptFile:(UINT16 *)pus fileLength:(int)nf isDecrypt:(BOOL)isDecrypt {
    switch (self.selectIndex) {
        case 0:
            pgm_decrypt_kov(pus,nf);
            break;
        case 1:
            pgm_decrypt_kovsh(pus,nf);
            break;
        case 2:
            pgm_decrypt_kovshp(pus,nf);
            break;
        case 3:
            pgm_decrypt_kov2(pus,nf);
            break;
        case 4:
            pgm_decrypt_kov2p(pus,nf);
            break;
        case 5:
            pgm_decrypt_theglad(pus,nf);
            break;
        case 6:
            pgm_decrypt_oldsplus(pus,nf);
            break;
        case 7:
            pgm_decrypt_photoy2k(pus,nf);
            break;
        case 8:
            pgm_decrypt_py2k2(pus,nf);
            break;
        case 9:
            pgm_decrypt_pstar(pus,nf);
            break;
        case 10:
            pgm_decrypt_dfront(pus,nf);
            break;
        case 11:
            pgm_decrypt_ddp2(pus,nf);
            break;
        case 12:
            pgm_decrypt_mm(pus,nf);
            break;
        case 13:
            pgm_decrypt_killbldp(pus,nf);
            break;
        case 14:
            pgm_decrypt_svg(pus,nf);
            break;
        case 15:
            pgm_decrypt_svgpcb(pus,nf);
            break;
        case 16:
            pgm_decrypt_ket(pus,nf);
            break;
        case 17:
            pgm_decrypt_espgal(pus,nf);
            break;
        case 18:
            pgm_decrypt_happy6in1(pus,nf);
            break;
        case 19:
            pgm_decrypt_puzzli2(pus,nf);
            break;
        case 20:
            pgm_decrypt_lhzb3(pus,nf);
            break;
        case 21:
            pgm_decrypt_lhzb4(pus,nf);
            break;
        case 22:
            pgm_decrypt_sddz(pus,nf);
            break;
        case 23:
            pgm_decrypt_sdwx(pus,nf);
            break;
        case 24:
            pgm_decrypt_chessc2(pus,nf);
            break;
        case 25:
            pgm_decrypt_kov(pus,nf);
            break;
        case 26:
            pgm_decrypt_klxyj(pus,nf);
            break;
        case 27:
            pgm_decrypt_gonefsh2(pus,nf);
            break;
        case 28:
            pgm_decrypt_mgfx(pus,nf);
            break;
        case 29:
            pgm_decrypt_fearless(pus,nf);
            break;
        case 30:
            pgm_decrypt_pgm3in1(pus,nf);
            break;
        case 31:
            rom=pus;
            size=nf;
            decrypter_rom(orleg2_key);
            break;
        case 32:
            rom=pus;
            size=nf;
            decrypter_rom(m312cn_key);
            break;
        case 33:
            rom=pus;
            size=nf;
            decrypter_rom(cjddzsp_key);
            break;
        case 34:
            rom=pus;
            size=nf;
            decrypter_rom(cjdh2_key);
            break;
        case 35:
            rom=pus;
            size=nf;
            decrypter_rom(kov3_key);
            break;
        case 36:
            rom=pus;
            size=nf;
            decrypter_rom(kov2_key);
            break;
        case 37:
            rom=pus;
            size=nf;
            decrypter_rom(ddpdoj_key);
            break;
        case 38:
            rom=pus;
            size=nf;
            decrypter_rom_encrypt(orleg2_key);
            break;
        case 39:
            rom=pus;
            size=nf;
            decrypter_rom_encrypt(m312cn_key);
            break;
        case 40:
            rom=pus;
            size=nf;
            decrypter_rom_encrypt(cjddzsp_key);
            break;
        case 41:
            rom=pus;
            size=nf;
            decrypter_rom_encrypt(cjdh2_key);
            break;
        case 42:
            rom=pus;
            size=nf;
            decrypter_rom_encrypt(kov3_key);
            break;
        case 43:
            rom=pus;
            size=nf;
            decrypter_rom_encrypt(kov2_key);
            break;
        case 44:
            rom=pus;
            size=nf;
            decrypter_rom_encrypt(ddpdoj_key);
            break;
        case 45:
            pgm_hack_ytzy(pus,nf);
            break;
        case 46:
            pgm_hack_ytzy1(pus,nf);
            break;
        case 47:
            pgm_hack_kov(pus,nf);
            break;
        case 48:
            pgm_hack_kov1(pus,nf);
            break;

        default:
            [self showWaringMessage:@"请选择游戏名称!" isOpen:false];
            return;
            break;
    }
    NSString *outputFileName;
    if (isDecrypt && ![self.fileName hasPrefix:@"de_"]) {
        outputFileName = [@"de_" stringByAppendingFormat:@"%@", self.fileName];
    } else {
        if ([self.fileName hasPrefix:@"de_"]) {
            outputFileName = [self.fileName stringByReplacingOccurrencesOfString:@"de_" withString:@"en_"];
        } else {
            outputFileName = [@"en_" stringByAppendingFormat:@"%@", self.fileName];
        }
    }
    NSString *outputPath = [defaultDir length] ? [defaultDir stringByAppendingPathComponent:outputFileName] : [self.filePathUrl.path stringByAppendingPathComponent:outputFileName];
    FILE *output = fopen([outputPath UTF8String], "wb");
    if (output == NULL) {
        [self showWaringMessage:@"无法创建解密的pgm的PROM文件!" isOpen:false];
        return;
    }
    rewind(output);
    fwrite(pus, 2, nf/2, output);
    fclose(output);
    self.outputTextView.string = outputFileName;
}

- (void)showWaringMessage:(NSString *)alertMessage isOpen:(BOOL)isopen {
    NSAlert *alert = [[NSAlert alloc] init];
    alert.alertStyle = NSAlertStyleWarning;
    alert.messageText = alertMessage;
    [alert addButtonWithTitle:@"确定"];
    [alert beginSheetModalForWindow:self.view.window completionHandler:nil];
}

- (void)dragDropViewFileDidReceiveList:(nonnull NSArray *)fileList {
    if (!fileList.count) {
        return;
    }
    NSURL *fileUrl = fileList.firstObject;
    self.textView.string = fileUrl.path;
    self.filePathUrl = fileUrl.URLByDeletingLastPathComponent;
    self.fileName = fileUrl.lastPathComponent;
    NSLog(@"%@---%@", self.filePathUrl.path, self.fileName);
}

- (NSDragOperation)quaryDragOperation:(NSArray *)fileList {
    return NSDragOperationCopy;
}

@end
