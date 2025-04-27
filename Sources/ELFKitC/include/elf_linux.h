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

// need to check for __musl__ or else:
// ELFKit/Sources/ELFKitC/include/elf_linux.h:17:8: error: redefinition of 'dl_phdr_info'
#ifndef __musl__
struct dl_phdr_info {
    ElfW(Addr)        dlpi_addr;
    const char       *dlpi_name;
    const ElfW(Phdr) *dlpi_phdr;
    ElfW(Half)        dlpi_phnum;
};
#endif

extern int dl_iterate_phdr(int (*callback) (struct dl_phdr_info *info, size_t size, void *data), void *data);

#endif /* __linux__ */

#endif /* elf_linux_h */
