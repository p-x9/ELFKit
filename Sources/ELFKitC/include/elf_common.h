//
//  elf_common.h
//
//
//  Created by p-x9 on 2024/05/12
//
//

#ifndef elf_common_h
#define elf_common_h

#include <stdint.h>

#if __has_include(<elf.h>)
#include <elf.h>
#endif

// ref: https://github.com/freebsd/freebsd-src/blob/2f923a0cedb8db9b8bd042c5b457dee6333604fe/sys/sys/elf_common.h#L48
typedef struct {
    uint32_t    n_namesz;    /* Length of name. */
    uint32_t    n_descsz;    /* Length of descriptor. */
    uint32_t    n_type;        /* Type of this note. */
} Elf_Note;
typedef Elf_Note Elf_Nhdr;

// ref: https://github.com/freebsd/freebsd-src/blob/2f923a0cedb8db9b8bd042c5b457dee6333604fe/sys/sys/elf_common.h#L116
typedef struct {
    uint32_t    gh_nbuckets;    /* Number of hash buckets. */
    uint32_t    gh_symndx;    /* First visible symbol in .dynsym. */
    uint32_t    gh_maskwords;    /* #maskwords used in bloom filter. */
    uint32_t    gh_shift2;    /* Bloom filter shift count. */
} Elf_GNU_Hash_Header;

#undef EI_NIDENT
#define    EI_NIDENT    16

#endif /* elf_common_h */
