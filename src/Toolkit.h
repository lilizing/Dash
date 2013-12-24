//
//  Toolkit.h
//  TextKitDemo
//
//  Created by lili on 13-9-30.
//  Copyright (c) 2013年 kdanmobile. All rights reserved.
//

#include <dirent.h>
#include <sys/stat.h>
#ifndef LI_Toolkit_h
#define LI_Toolkit_h

static inline long long fileSize(NSString *filePath) {//c方法 文件大小
    struct stat st;
    if (lstat([filePath cStringUsingEncoding:NSUTF8StringEncoding], &st) == 0) {
        return st.st_size;
    }
    return 0;
}
static inline long long folderSize(const char *folderPath){//c 方法  目录大小
    long long dirSize = 0;
    DIR* dir = opendir(folderPath);
    if (dir == NULL) {
        return 0;
    }
    struct dirent* child;
    while ((child = readdir(dir)) != NULL) {
        if (child->d_type == DT_DIR
            && (child->d_name[0] == '.' && child->d_name[1] == 0)) {
            continue;
        }
        
        if (child->d_type == DT_DIR
            && (child->d_name[0] == '.' && child->d_name[1] == '.' && child->d_name[2] == 0)) {
            continue;
        }
        
        int folderPathLength = strlen(folderPath);
        char childPath[1024];
        stpcpy(childPath, folderPath);
        if (folderPath[folderPathLength - 1] != '/'){
            childPath[folderPathLength] = '/';
            folderPathLength++;
        }
        
        stpcpy(childPath + folderPathLength, child->d_name);
        childPath[folderPathLength + child->d_namlen] = 0;
        if (child->d_type == DT_DIR){
            dirSize += folderSize(childPath);
            struct stat st;
            if (lstat(childPath, &st) == 0) {
                dirSize += st.st_size;
            }
        } else if (child->d_type == DT_REG || child->d_type == DT_LNK){
            struct stat st;
            if (lstat(childPath, &st) == 0) {
                dirSize += st.st_size;
            }
        }
    }
    
    return dirSize;
}
#endif
