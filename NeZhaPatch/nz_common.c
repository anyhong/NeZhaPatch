//
//  nz_common.c
//  NeZhaPatch
//
//  Created by anyhong on 2019/8/26.
//  Copyright © 2019 anyhong. All rights reserved.
//

#include "nz_common.h"
#import <Foundation/Foundation.h>

int yyerror(char const *str) {
    NSString *log = [NSString stringWithUTF8String:str];
    NSLog(@"error: %@\n", log);
    return 0;
}
