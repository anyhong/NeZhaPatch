//
//  ViewController.m
//  NeZhaPatch
//
//  Created by anyhong on 2019/8/23.
//  Copyright © 2019 anyhong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadLex];
}

- (void)loadLex {
    NSURL *URL = [[NSBundle mainBundle] URLForResource:@"demo" withExtension:@"nz"];
    NSError *error;
    NSString *string = [NSString stringWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:&error];
    extern void nz_set_source_string(char const *source);
    nz_set_source_string([string UTF8String]);
    
    extern void yyrestart (FILE *input_file);
    extern int yyparse(void);
    if (yyparse()) {
        yyrestart(NULL); /* 解析出错时，重置yylex */
        return;
    }
}

@end
