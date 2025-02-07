//
//  elf_linux.h
//  ELFKit
//
//  Created by p-x9 on 2025/02/07
//  
//

#ifndef elf_linux_h
#define elf_linux_h

#ifdef __linux__

#include <link.h>

struct dl_phdr_info {
    ElfW(Addr)        dlpi_addr;
    const char       *dlpi_name;
    const ElfW(Phdr) *dlpi_phdr;
    ElfW(Half)        dlpi_phnum;
};

extern int dl_iterate_phdr(int (*callback) (struct dl_phdr_info *info, size_t size, void *data), void *data);

#endif /* __linux__ */

#endif /* elf_linux_h */
