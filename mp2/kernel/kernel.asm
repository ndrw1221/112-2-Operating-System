
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	96013103          	ld	sp,-1696(sp) # 80008960 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	283050ef          	jal	ra,80005a98 <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    8000001c:	1101                	addi	sp,sp,-32
    8000001e:	ec06                	sd	ra,24(sp)
    80000020:	e822                	sd	s0,16(sp)
    80000022:	e426                	sd	s1,8(sp)
    80000024:	e04a                	sd	s2,0(sp)
    80000026:	1000                	addi	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80000028:	03451793          	slli	a5,a0,0x34
    8000002c:	ebb9                	bnez	a5,80000082 <kfree+0x66>
    8000002e:	84aa                	mv	s1,a0
    80000030:	00026797          	auipc	a5,0x26
    80000034:	21078793          	addi	a5,a5,528 # 80026240 <end>
    80000038:	04f56563          	bltu	a0,a5,80000082 <kfree+0x66>
    8000003c:	47c5                	li	a5,17
    8000003e:	07ee                	slli	a5,a5,0x1b
    80000040:	04f57163          	bgeu	a0,a5,80000082 <kfree+0x66>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80000044:	6605                	lui	a2,0x1
    80000046:	4585                	li	a1,1
    80000048:	00000097          	auipc	ra,0x0
    8000004c:	130080e7          	jalr	304(ra) # 80000178 <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80000050:	00009917          	auipc	s2,0x9
    80000054:	fe090913          	addi	s2,s2,-32 # 80009030 <kmem>
    80000058:	854a                	mv	a0,s2
    8000005a:	00006097          	auipc	ra,0x6
    8000005e:	438080e7          	jalr	1080(ra) # 80006492 <acquire>
  r->next = kmem.freelist;
    80000062:	01893783          	ld	a5,24(s2)
    80000066:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000068:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    8000006c:	854a                	mv	a0,s2
    8000006e:	00006097          	auipc	ra,0x6
    80000072:	4d8080e7          	jalr	1240(ra) # 80006546 <release>
}
    80000076:	60e2                	ld	ra,24(sp)
    80000078:	6442                	ld	s0,16(sp)
    8000007a:	64a2                	ld	s1,8(sp)
    8000007c:	6902                	ld	s2,0(sp)
    8000007e:	6105                	addi	sp,sp,32
    80000080:	8082                	ret
    panic("kfree");
    80000082:	00008517          	auipc	a0,0x8
    80000086:	f8e50513          	addi	a0,a0,-114 # 80008010 <etext+0x10>
    8000008a:	00006097          	auipc	ra,0x6
    8000008e:	ebe080e7          	jalr	-322(ra) # 80005f48 <panic>

0000000080000092 <freerange>:
{
    80000092:	7179                	addi	sp,sp,-48
    80000094:	f406                	sd	ra,40(sp)
    80000096:	f022                	sd	s0,32(sp)
    80000098:	ec26                	sd	s1,24(sp)
    8000009a:	e84a                	sd	s2,16(sp)
    8000009c:	e44e                	sd	s3,8(sp)
    8000009e:	e052                	sd	s4,0(sp)
    800000a0:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    800000a2:	6785                	lui	a5,0x1
    800000a4:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800000a8:	94aa                	add	s1,s1,a0
    800000aa:	757d                	lui	a0,0xfffff
    800000ac:	8ce9                	and	s1,s1,a0
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000ae:	94be                	add	s1,s1,a5
    800000b0:	0095ee63          	bltu	a1,s1,800000cc <freerange+0x3a>
    800000b4:	892e                	mv	s2,a1
    kfree(p);
    800000b6:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000b8:	6985                	lui	s3,0x1
    kfree(p);
    800000ba:	01448533          	add	a0,s1,s4
    800000be:	00000097          	auipc	ra,0x0
    800000c2:	f5e080e7          	jalr	-162(ra) # 8000001c <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000c6:	94ce                	add	s1,s1,s3
    800000c8:	fe9979e3          	bgeu	s2,s1,800000ba <freerange+0x28>
}
    800000cc:	70a2                	ld	ra,40(sp)
    800000ce:	7402                	ld	s0,32(sp)
    800000d0:	64e2                	ld	s1,24(sp)
    800000d2:	6942                	ld	s2,16(sp)
    800000d4:	69a2                	ld	s3,8(sp)
    800000d6:	6a02                	ld	s4,0(sp)
    800000d8:	6145                	addi	sp,sp,48
    800000da:	8082                	ret

00000000800000dc <kinit>:
{
    800000dc:	1141                	addi	sp,sp,-16
    800000de:	e406                	sd	ra,8(sp)
    800000e0:	e022                	sd	s0,0(sp)
    800000e2:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    800000e4:	00008597          	auipc	a1,0x8
    800000e8:	f3458593          	addi	a1,a1,-204 # 80008018 <etext+0x18>
    800000ec:	00009517          	auipc	a0,0x9
    800000f0:	f4450513          	addi	a0,a0,-188 # 80009030 <kmem>
    800000f4:	00006097          	auipc	ra,0x6
    800000f8:	30e080e7          	jalr	782(ra) # 80006402 <initlock>
  freerange(end, (void*)PHYSTOP);
    800000fc:	45c5                	li	a1,17
    800000fe:	05ee                	slli	a1,a1,0x1b
    80000100:	00026517          	auipc	a0,0x26
    80000104:	14050513          	addi	a0,a0,320 # 80026240 <end>
    80000108:	00000097          	auipc	ra,0x0
    8000010c:	f8a080e7          	jalr	-118(ra) # 80000092 <freerange>
}
    80000110:	60a2                	ld	ra,8(sp)
    80000112:	6402                	ld	s0,0(sp)
    80000114:	0141                	addi	sp,sp,16
    80000116:	8082                	ret

0000000080000118 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    80000118:	1101                	addi	sp,sp,-32
    8000011a:	ec06                	sd	ra,24(sp)
    8000011c:	e822                	sd	s0,16(sp)
    8000011e:	e426                	sd	s1,8(sp)
    80000120:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000122:	00009497          	auipc	s1,0x9
    80000126:	f0e48493          	addi	s1,s1,-242 # 80009030 <kmem>
    8000012a:	8526                	mv	a0,s1
    8000012c:	00006097          	auipc	ra,0x6
    80000130:	366080e7          	jalr	870(ra) # 80006492 <acquire>
  r = kmem.freelist;
    80000134:	6c84                	ld	s1,24(s1)
  if(r)
    80000136:	c885                	beqz	s1,80000166 <kalloc+0x4e>
    kmem.freelist = r->next;
    80000138:	609c                	ld	a5,0(s1)
    8000013a:	00009517          	auipc	a0,0x9
    8000013e:	ef650513          	addi	a0,a0,-266 # 80009030 <kmem>
    80000142:	ed1c                	sd	a5,24(a0)
  release(&kmem.lock);
    80000144:	00006097          	auipc	ra,0x6
    80000148:	402080e7          	jalr	1026(ra) # 80006546 <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    8000014c:	6605                	lui	a2,0x1
    8000014e:	4595                	li	a1,5
    80000150:	8526                	mv	a0,s1
    80000152:	00000097          	auipc	ra,0x0
    80000156:	026080e7          	jalr	38(ra) # 80000178 <memset>
  return (void*)r;
}
    8000015a:	8526                	mv	a0,s1
    8000015c:	60e2                	ld	ra,24(sp)
    8000015e:	6442                	ld	s0,16(sp)
    80000160:	64a2                	ld	s1,8(sp)
    80000162:	6105                	addi	sp,sp,32
    80000164:	8082                	ret
  release(&kmem.lock);
    80000166:	00009517          	auipc	a0,0x9
    8000016a:	eca50513          	addi	a0,a0,-310 # 80009030 <kmem>
    8000016e:	00006097          	auipc	ra,0x6
    80000172:	3d8080e7          	jalr	984(ra) # 80006546 <release>
  if(r)
    80000176:	b7d5                	j	8000015a <kalloc+0x42>

0000000080000178 <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    80000178:	1141                	addi	sp,sp,-16
    8000017a:	e422                	sd	s0,8(sp)
    8000017c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    8000017e:	ce09                	beqz	a2,80000198 <memset+0x20>
    80000180:	87aa                	mv	a5,a0
    80000182:	fff6071b          	addiw	a4,a2,-1
    80000186:	1702                	slli	a4,a4,0x20
    80000188:	9301                	srli	a4,a4,0x20
    8000018a:	0705                	addi	a4,a4,1
    8000018c:	972a                	add	a4,a4,a0
    cdst[i] = c;
    8000018e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80000192:	0785                	addi	a5,a5,1
    80000194:	fee79de3          	bne	a5,a4,8000018e <memset+0x16>
  }
  return dst;
}
    80000198:	6422                	ld	s0,8(sp)
    8000019a:	0141                	addi	sp,sp,16
    8000019c:	8082                	ret

000000008000019e <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    8000019e:	1141                	addi	sp,sp,-16
    800001a0:	e422                	sd	s0,8(sp)
    800001a2:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    800001a4:	ca05                	beqz	a2,800001d4 <memcmp+0x36>
    800001a6:	fff6069b          	addiw	a3,a2,-1
    800001aa:	1682                	slli	a3,a3,0x20
    800001ac:	9281                	srli	a3,a3,0x20
    800001ae:	0685                	addi	a3,a3,1
    800001b0:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    800001b2:	00054783          	lbu	a5,0(a0)
    800001b6:	0005c703          	lbu	a4,0(a1)
    800001ba:	00e79863          	bne	a5,a4,800001ca <memcmp+0x2c>
      return *s1 - *s2;
    s1++, s2++;
    800001be:	0505                	addi	a0,a0,1
    800001c0:	0585                	addi	a1,a1,1
  while(n-- > 0){
    800001c2:	fed518e3          	bne	a0,a3,800001b2 <memcmp+0x14>
  }

  return 0;
    800001c6:	4501                	li	a0,0
    800001c8:	a019                	j	800001ce <memcmp+0x30>
      return *s1 - *s2;
    800001ca:	40e7853b          	subw	a0,a5,a4
}
    800001ce:	6422                	ld	s0,8(sp)
    800001d0:	0141                	addi	sp,sp,16
    800001d2:	8082                	ret
  return 0;
    800001d4:	4501                	li	a0,0
    800001d6:	bfe5                	j	800001ce <memcmp+0x30>

00000000800001d8 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    800001d8:	1141                	addi	sp,sp,-16
    800001da:	e422                	sd	s0,8(sp)
    800001dc:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    800001de:	ca0d                	beqz	a2,80000210 <memmove+0x38>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    800001e0:	00a5f963          	bgeu	a1,a0,800001f2 <memmove+0x1a>
    800001e4:	02061693          	slli	a3,a2,0x20
    800001e8:	9281                	srli	a3,a3,0x20
    800001ea:	00d58733          	add	a4,a1,a3
    800001ee:	02e56463          	bltu	a0,a4,80000216 <memmove+0x3e>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    800001f2:	fff6079b          	addiw	a5,a2,-1
    800001f6:	1782                	slli	a5,a5,0x20
    800001f8:	9381                	srli	a5,a5,0x20
    800001fa:	0785                	addi	a5,a5,1
    800001fc:	97ae                	add	a5,a5,a1
    800001fe:	872a                	mv	a4,a0
      *d++ = *s++;
    80000200:	0585                	addi	a1,a1,1
    80000202:	0705                	addi	a4,a4,1
    80000204:	fff5c683          	lbu	a3,-1(a1)
    80000208:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    8000020c:	fef59ae3          	bne	a1,a5,80000200 <memmove+0x28>

  return dst;
}
    80000210:	6422                	ld	s0,8(sp)
    80000212:	0141                	addi	sp,sp,16
    80000214:	8082                	ret
    d += n;
    80000216:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    80000218:	fff6079b          	addiw	a5,a2,-1
    8000021c:	1782                	slli	a5,a5,0x20
    8000021e:	9381                	srli	a5,a5,0x20
    80000220:	fff7c793          	not	a5,a5
    80000224:	97ba                	add	a5,a5,a4
      *--d = *--s;
    80000226:	177d                	addi	a4,a4,-1
    80000228:	16fd                	addi	a3,a3,-1
    8000022a:	00074603          	lbu	a2,0(a4)
    8000022e:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    80000232:	fef71ae3          	bne	a4,a5,80000226 <memmove+0x4e>
    80000236:	bfe9                	j	80000210 <memmove+0x38>

0000000080000238 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80000238:	1141                	addi	sp,sp,-16
    8000023a:	e406                	sd	ra,8(sp)
    8000023c:	e022                	sd	s0,0(sp)
    8000023e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    80000240:	00000097          	auipc	ra,0x0
    80000244:	f98080e7          	jalr	-104(ra) # 800001d8 <memmove>
}
    80000248:	60a2                	ld	ra,8(sp)
    8000024a:	6402                	ld	s0,0(sp)
    8000024c:	0141                	addi	sp,sp,16
    8000024e:	8082                	ret

0000000080000250 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80000250:	1141                	addi	sp,sp,-16
    80000252:	e422                	sd	s0,8(sp)
    80000254:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    80000256:	ce11                	beqz	a2,80000272 <strncmp+0x22>
    80000258:	00054783          	lbu	a5,0(a0)
    8000025c:	cf89                	beqz	a5,80000276 <strncmp+0x26>
    8000025e:	0005c703          	lbu	a4,0(a1)
    80000262:	00f71a63          	bne	a4,a5,80000276 <strncmp+0x26>
    n--, p++, q++;
    80000266:	367d                	addiw	a2,a2,-1
    80000268:	0505                	addi	a0,a0,1
    8000026a:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    8000026c:	f675                	bnez	a2,80000258 <strncmp+0x8>
  if(n == 0)
    return 0;
    8000026e:	4501                	li	a0,0
    80000270:	a809                	j	80000282 <strncmp+0x32>
    80000272:	4501                	li	a0,0
    80000274:	a039                	j	80000282 <strncmp+0x32>
  if(n == 0)
    80000276:	ca09                	beqz	a2,80000288 <strncmp+0x38>
  return (uchar)*p - (uchar)*q;
    80000278:	00054503          	lbu	a0,0(a0)
    8000027c:	0005c783          	lbu	a5,0(a1)
    80000280:	9d1d                	subw	a0,a0,a5
}
    80000282:	6422                	ld	s0,8(sp)
    80000284:	0141                	addi	sp,sp,16
    80000286:	8082                	ret
    return 0;
    80000288:	4501                	li	a0,0
    8000028a:	bfe5                	j	80000282 <strncmp+0x32>

000000008000028c <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    8000028c:	1141                	addi	sp,sp,-16
    8000028e:	e422                	sd	s0,8(sp)
    80000290:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    80000292:	872a                	mv	a4,a0
    80000294:	8832                	mv	a6,a2
    80000296:	367d                	addiw	a2,a2,-1
    80000298:	01005963          	blez	a6,800002aa <strncpy+0x1e>
    8000029c:	0705                	addi	a4,a4,1
    8000029e:	0005c783          	lbu	a5,0(a1)
    800002a2:	fef70fa3          	sb	a5,-1(a4)
    800002a6:	0585                	addi	a1,a1,1
    800002a8:	f7f5                	bnez	a5,80000294 <strncpy+0x8>
    ;
  while(n-- > 0)
    800002aa:	00c05d63          	blez	a2,800002c4 <strncpy+0x38>
    800002ae:	86ba                	mv	a3,a4
    *s++ = 0;
    800002b0:	0685                	addi	a3,a3,1
    800002b2:	fe068fa3          	sb	zero,-1(a3)
  while(n-- > 0)
    800002b6:	fff6c793          	not	a5,a3
    800002ba:	9fb9                	addw	a5,a5,a4
    800002bc:	010787bb          	addw	a5,a5,a6
    800002c0:	fef048e3          	bgtz	a5,800002b0 <strncpy+0x24>
  return os;
}
    800002c4:	6422                	ld	s0,8(sp)
    800002c6:	0141                	addi	sp,sp,16
    800002c8:	8082                	ret

00000000800002ca <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    800002ca:	1141                	addi	sp,sp,-16
    800002cc:	e422                	sd	s0,8(sp)
    800002ce:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    800002d0:	02c05363          	blez	a2,800002f6 <safestrcpy+0x2c>
    800002d4:	fff6069b          	addiw	a3,a2,-1
    800002d8:	1682                	slli	a3,a3,0x20
    800002da:	9281                	srli	a3,a3,0x20
    800002dc:	96ae                	add	a3,a3,a1
    800002de:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    800002e0:	00d58963          	beq	a1,a3,800002f2 <safestrcpy+0x28>
    800002e4:	0585                	addi	a1,a1,1
    800002e6:	0785                	addi	a5,a5,1
    800002e8:	fff5c703          	lbu	a4,-1(a1)
    800002ec:	fee78fa3          	sb	a4,-1(a5)
    800002f0:	fb65                	bnez	a4,800002e0 <safestrcpy+0x16>
    ;
  *s = 0;
    800002f2:	00078023          	sb	zero,0(a5)
  return os;
}
    800002f6:	6422                	ld	s0,8(sp)
    800002f8:	0141                	addi	sp,sp,16
    800002fa:	8082                	ret

00000000800002fc <strlen>:

int
strlen(const char *s)
{
    800002fc:	1141                	addi	sp,sp,-16
    800002fe:	e422                	sd	s0,8(sp)
    80000300:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    80000302:	00054783          	lbu	a5,0(a0)
    80000306:	cf91                	beqz	a5,80000322 <strlen+0x26>
    80000308:	0505                	addi	a0,a0,1
    8000030a:	87aa                	mv	a5,a0
    8000030c:	4685                	li	a3,1
    8000030e:	9e89                	subw	a3,a3,a0
    80000310:	00f6853b          	addw	a0,a3,a5
    80000314:	0785                	addi	a5,a5,1
    80000316:	fff7c703          	lbu	a4,-1(a5)
    8000031a:	fb7d                	bnez	a4,80000310 <strlen+0x14>
    ;
  return n;
}
    8000031c:	6422                	ld	s0,8(sp)
    8000031e:	0141                	addi	sp,sp,16
    80000320:	8082                	ret
  for(n = 0; s[n]; n++)
    80000322:	4501                	li	a0,0
    80000324:	bfe5                	j	8000031c <strlen+0x20>

0000000080000326 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000326:	1141                	addi	sp,sp,-16
    80000328:	e406                	sd	ra,8(sp)
    8000032a:	e022                	sd	s0,0(sp)
    8000032c:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    8000032e:	00001097          	auipc	ra,0x1
    80000332:	bcc080e7          	jalr	-1076(ra) # 80000efa <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    80000336:	00009717          	auipc	a4,0x9
    8000033a:	cca70713          	addi	a4,a4,-822 # 80009000 <started>
  if(cpuid() == 0){
    8000033e:	c139                	beqz	a0,80000384 <main+0x5e>
    while(started == 0)
    80000340:	431c                	lw	a5,0(a4)
    80000342:	2781                	sext.w	a5,a5
    80000344:	dff5                	beqz	a5,80000340 <main+0x1a>
      ;
    __sync_synchronize();
    80000346:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    8000034a:	00001097          	auipc	ra,0x1
    8000034e:	bb0080e7          	jalr	-1104(ra) # 80000efa <cpuid>
    80000352:	85aa                	mv	a1,a0
    80000354:	00008517          	auipc	a0,0x8
    80000358:	ce450513          	addi	a0,a0,-796 # 80008038 <etext+0x38>
    8000035c:	00006097          	auipc	ra,0x6
    80000360:	c36080e7          	jalr	-970(ra) # 80005f92 <printf>
    kvminithart();    // turn on paging
    80000364:	00000097          	auipc	ra,0x0
    80000368:	0d8080e7          	jalr	216(ra) # 8000043c <kvminithart>
    trapinithart();   // install kernel trap vector
    8000036c:	00002097          	auipc	ra,0x2
    80000370:	806080e7          	jalr	-2042(ra) # 80001b72 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000374:	00005097          	auipc	ra,0x5
    80000378:	fac080e7          	jalr	-84(ra) # 80005320 <plicinithart>
  }

  scheduler();
    8000037c:	00001097          	auipc	ra,0x1
    80000380:	0b4080e7          	jalr	180(ra) # 80001430 <scheduler>
    consoleinit();
    80000384:	00006097          	auipc	ra,0x6
    80000388:	ad6080e7          	jalr	-1322(ra) # 80005e5a <consoleinit>
    printfinit();
    8000038c:	00006097          	auipc	ra,0x6
    80000390:	dec080e7          	jalr	-532(ra) # 80006178 <printfinit>
    printf("\n");
    80000394:	00008517          	auipc	a0,0x8
    80000398:	cb450513          	addi	a0,a0,-844 # 80008048 <etext+0x48>
    8000039c:	00006097          	auipc	ra,0x6
    800003a0:	bf6080e7          	jalr	-1034(ra) # 80005f92 <printf>
    printf("xv6 kernel is booting\n");
    800003a4:	00008517          	auipc	a0,0x8
    800003a8:	c7c50513          	addi	a0,a0,-900 # 80008020 <etext+0x20>
    800003ac:	00006097          	auipc	ra,0x6
    800003b0:	be6080e7          	jalr	-1050(ra) # 80005f92 <printf>
    printf("\n");
    800003b4:	00008517          	auipc	a0,0x8
    800003b8:	c9450513          	addi	a0,a0,-876 # 80008048 <etext+0x48>
    800003bc:	00006097          	auipc	ra,0x6
    800003c0:	bd6080e7          	jalr	-1066(ra) # 80005f92 <printf>
    kinit();         // physical page allocator
    800003c4:	00000097          	auipc	ra,0x0
    800003c8:	d18080e7          	jalr	-744(ra) # 800000dc <kinit>
    kvminit();       // create kernel page table
    800003cc:	00000097          	auipc	ra,0x0
    800003d0:	322080e7          	jalr	802(ra) # 800006ee <kvminit>
    kvminithart();   // turn on paging
    800003d4:	00000097          	auipc	ra,0x0
    800003d8:	068080e7          	jalr	104(ra) # 8000043c <kvminithart>
    procinit();      // process table
    800003dc:	00001097          	auipc	ra,0x1
    800003e0:	a70080e7          	jalr	-1424(ra) # 80000e4c <procinit>
    trapinit();      // trap vectors
    800003e4:	00001097          	auipc	ra,0x1
    800003e8:	766080e7          	jalr	1894(ra) # 80001b4a <trapinit>
    trapinithart();  // install kernel trap vector
    800003ec:	00001097          	auipc	ra,0x1
    800003f0:	786080e7          	jalr	1926(ra) # 80001b72 <trapinithart>
    plicinit();      // set up interrupt controller
    800003f4:	00005097          	auipc	ra,0x5
    800003f8:	f16080e7          	jalr	-234(ra) # 8000530a <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    800003fc:	00005097          	auipc	ra,0x5
    80000400:	f24080e7          	jalr	-220(ra) # 80005320 <plicinithart>
    binit();         // buffer cache
    80000404:	00002097          	auipc	ra,0x2
    80000408:	f9a080e7          	jalr	-102(ra) # 8000239e <binit>
    iinit();         // inode table
    8000040c:	00002097          	auipc	ra,0x2
    80000410:	61a080e7          	jalr	1562(ra) # 80002a26 <iinit>
    fileinit();      // file table
    80000414:	00003097          	auipc	ra,0x3
    80000418:	73a080e7          	jalr	1850(ra) # 80003b4e <fileinit>
    virtio_disk_init(); // emulated hard disk
    8000041c:	00005097          	auipc	ra,0x5
    80000420:	026080e7          	jalr	38(ra) # 80005442 <virtio_disk_init>
    userinit();      // first user process
    80000424:	00001097          	auipc	ra,0x1
    80000428:	dda080e7          	jalr	-550(ra) # 800011fe <userinit>
    __sync_synchronize();
    8000042c:	0ff0000f          	fence
    started = 1;
    80000430:	4785                	li	a5,1
    80000432:	00009717          	auipc	a4,0x9
    80000436:	bcf72723          	sw	a5,-1074(a4) # 80009000 <started>
    8000043a:	b789                	j	8000037c <main+0x56>

000000008000043c <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    8000043c:	1141                	addi	sp,sp,-16
    8000043e:	e422                	sd	s0,8(sp)
    80000440:	0800                	addi	s0,sp,16
  w_satp(MAKE_SATP(kernel_pagetable));
    80000442:	00009797          	auipc	a5,0x9
    80000446:	bc67b783          	ld	a5,-1082(a5) # 80009008 <kernel_pagetable>
    8000044a:	83b1                	srli	a5,a5,0xc
    8000044c:	577d                	li	a4,-1
    8000044e:	177e                	slli	a4,a4,0x3f
    80000450:	8fd9                	or	a5,a5,a4
// supervisor address translation and protection;
// holds the address of the page table.
static inline void
w_satp(uint64 x)
{
  asm volatile("csrw satp, %0" : : "r" (x));
    80000452:	18079073          	csrw	satp,a5
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80000456:	12000073          	sfence.vma
  sfence_vma();
}
    8000045a:	6422                	ld	s0,8(sp)
    8000045c:	0141                	addi	sp,sp,16
    8000045e:	8082                	ret

0000000080000460 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80000460:	7139                	addi	sp,sp,-64
    80000462:	fc06                	sd	ra,56(sp)
    80000464:	f822                	sd	s0,48(sp)
    80000466:	f426                	sd	s1,40(sp)
    80000468:	f04a                	sd	s2,32(sp)
    8000046a:	ec4e                	sd	s3,24(sp)
    8000046c:	e852                	sd	s4,16(sp)
    8000046e:	e456                	sd	s5,8(sp)
    80000470:	e05a                	sd	s6,0(sp)
    80000472:	0080                	addi	s0,sp,64
    80000474:	84aa                	mv	s1,a0
    80000476:	89ae                	mv	s3,a1
    80000478:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    8000047a:	57fd                	li	a5,-1
    8000047c:	83e9                	srli	a5,a5,0x1a
    8000047e:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    80000480:	4b31                	li	s6,12
  if(va >= MAXVA)
    80000482:	04b7f263          	bgeu	a5,a1,800004c6 <walk+0x66>
    panic("walk");
    80000486:	00008517          	auipc	a0,0x8
    8000048a:	bca50513          	addi	a0,a0,-1078 # 80008050 <etext+0x50>
    8000048e:	00006097          	auipc	ra,0x6
    80000492:	aba080e7          	jalr	-1350(ra) # 80005f48 <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80000496:	060a8663          	beqz	s5,80000502 <walk+0xa2>
    8000049a:	00000097          	auipc	ra,0x0
    8000049e:	c7e080e7          	jalr	-898(ra) # 80000118 <kalloc>
    800004a2:	84aa                	mv	s1,a0
    800004a4:	c529                	beqz	a0,800004ee <walk+0x8e>
        return 0;
      memset(pagetable, 0, PGSIZE);
    800004a6:	6605                	lui	a2,0x1
    800004a8:	4581                	li	a1,0
    800004aa:	00000097          	auipc	ra,0x0
    800004ae:	cce080e7          	jalr	-818(ra) # 80000178 <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    800004b2:	00c4d793          	srli	a5,s1,0xc
    800004b6:	07aa                	slli	a5,a5,0xa
    800004b8:	0017e793          	ori	a5,a5,1
    800004bc:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    800004c0:	3a5d                	addiw	s4,s4,-9
    800004c2:	036a0063          	beq	s4,s6,800004e2 <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    800004c6:	0149d933          	srl	s2,s3,s4
    800004ca:	1ff97913          	andi	s2,s2,511
    800004ce:	090e                	slli	s2,s2,0x3
    800004d0:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    800004d2:	00093483          	ld	s1,0(s2)
    800004d6:	0014f793          	andi	a5,s1,1
    800004da:	dfd5                	beqz	a5,80000496 <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    800004dc:	80a9                	srli	s1,s1,0xa
    800004de:	04b2                	slli	s1,s1,0xc
    800004e0:	b7c5                	j	800004c0 <walk+0x60>
    }
  }

  pte_t *pte = &pagetable[PX(0, va)];
    800004e2:	00c9d513          	srli	a0,s3,0xc
    800004e6:	1ff57513          	andi	a0,a0,511
    800004ea:	050e                	slli	a0,a0,0x3
    800004ec:	9526                	add	a0,a0,s1
// TODO
#elif defined(PG_REPLACEMENT_USE_FIFO)
// TODO
#endif
  return pte;
}
    800004ee:	70e2                	ld	ra,56(sp)
    800004f0:	7442                	ld	s0,48(sp)
    800004f2:	74a2                	ld	s1,40(sp)
    800004f4:	7902                	ld	s2,32(sp)
    800004f6:	69e2                	ld	s3,24(sp)
    800004f8:	6a42                	ld	s4,16(sp)
    800004fa:	6aa2                	ld	s5,8(sp)
    800004fc:	6b02                	ld	s6,0(sp)
    800004fe:	6121                	addi	sp,sp,64
    80000500:	8082                	ret
        return 0;
    80000502:	4501                	li	a0,0
    80000504:	b7ed                	j	800004ee <walk+0x8e>

0000000080000506 <walkaddr>:
uint64
walkaddr(pagetable_t pagetable, uint64 va) {
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    80000506:	57fd                	li	a5,-1
    80000508:	83e9                	srli	a5,a5,0x1a
    8000050a:	00b7f463          	bgeu	a5,a1,80000512 <walkaddr+0xc>
    return 0;
    8000050e:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    80000510:	8082                	ret
walkaddr(pagetable_t pagetable, uint64 va) {
    80000512:	1141                	addi	sp,sp,-16
    80000514:	e406                	sd	ra,8(sp)
    80000516:	e022                	sd	s0,0(sp)
    80000518:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    8000051a:	4601                	li	a2,0
    8000051c:	00000097          	auipc	ra,0x0
    80000520:	f44080e7          	jalr	-188(ra) # 80000460 <walk>
  if(pte == 0)
    80000524:	c105                	beqz	a0,80000544 <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    80000526:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    80000528:	0117f693          	andi	a3,a5,17
    8000052c:	4745                	li	a4,17
    return 0;
    8000052e:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    80000530:	00e68663          	beq	a3,a4,8000053c <walkaddr+0x36>
}
    80000534:	60a2                	ld	ra,8(sp)
    80000536:	6402                	ld	s0,0(sp)
    80000538:	0141                	addi	sp,sp,16
    8000053a:	8082                	ret
  pa = PTE2PA(*pte);
    8000053c:	00a7d513          	srli	a0,a5,0xa
    80000540:	0532                	slli	a0,a0,0xc
  return pa;
    80000542:	bfcd                	j	80000534 <walkaddr+0x2e>
    return 0;
    80000544:	4501                	li	a0,0
    80000546:	b7fd                	j	80000534 <walkaddr+0x2e>

0000000080000548 <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    80000548:	715d                	addi	sp,sp,-80
    8000054a:	e486                	sd	ra,72(sp)
    8000054c:	e0a2                	sd	s0,64(sp)
    8000054e:	fc26                	sd	s1,56(sp)
    80000550:	f84a                	sd	s2,48(sp)
    80000552:	f44e                	sd	s3,40(sp)
    80000554:	f052                	sd	s4,32(sp)
    80000556:	ec56                	sd	s5,24(sp)
    80000558:	e85a                	sd	s6,16(sp)
    8000055a:	e45e                	sd	s7,8(sp)
    8000055c:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if(size == 0)
    8000055e:	c205                	beqz	a2,8000057e <mappages+0x36>
    80000560:	8aaa                	mv	s5,a0
    80000562:	8b3a                	mv	s6,a4
    panic("mappages: size");
  a = PGROUNDDOWN(va);
    80000564:	77fd                	lui	a5,0xfffff
    80000566:	00f5fa33          	and	s4,a1,a5
  last = PGROUNDDOWN(va + size - 1);
    8000056a:	15fd                	addi	a1,a1,-1
    8000056c:	00c589b3          	add	s3,a1,a2
    80000570:	00f9f9b3          	and	s3,s3,a5
  a = PGROUNDDOWN(va);
    80000574:	8952                	mv	s2,s4
    80000576:	41468a33          	sub	s4,a3,s4
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    8000057a:	6b85                	lui	s7,0x1
    8000057c:	a015                	j	800005a0 <mappages+0x58>
    panic("mappages: size");
    8000057e:	00008517          	auipc	a0,0x8
    80000582:	ada50513          	addi	a0,a0,-1318 # 80008058 <etext+0x58>
    80000586:	00006097          	auipc	ra,0x6
    8000058a:	9c2080e7          	jalr	-1598(ra) # 80005f48 <panic>
      panic("mappages: remap");
    8000058e:	00008517          	auipc	a0,0x8
    80000592:	ada50513          	addi	a0,a0,-1318 # 80008068 <etext+0x68>
    80000596:	00006097          	auipc	ra,0x6
    8000059a:	9b2080e7          	jalr	-1614(ra) # 80005f48 <panic>
    a += PGSIZE;
    8000059e:	995e                	add	s2,s2,s7
  for(;;){
    800005a0:	012a04b3          	add	s1,s4,s2
    if((pte = walk(pagetable, a, 1)) == 0)
    800005a4:	4605                	li	a2,1
    800005a6:	85ca                	mv	a1,s2
    800005a8:	8556                	mv	a0,s5
    800005aa:	00000097          	auipc	ra,0x0
    800005ae:	eb6080e7          	jalr	-330(ra) # 80000460 <walk>
    800005b2:	cd19                	beqz	a0,800005d0 <mappages+0x88>
    if(*pte & PTE_V)
    800005b4:	611c                	ld	a5,0(a0)
    800005b6:	8b85                	andi	a5,a5,1
    800005b8:	fbf9                	bnez	a5,8000058e <mappages+0x46>
    *pte = PA2PTE(pa) | perm | PTE_V;
    800005ba:	80b1                	srli	s1,s1,0xc
    800005bc:	04aa                	slli	s1,s1,0xa
    800005be:	0164e4b3          	or	s1,s1,s6
    800005c2:	0014e493          	ori	s1,s1,1
    800005c6:	e104                	sd	s1,0(a0)
    if(a == last)
    800005c8:	fd391be3          	bne	s2,s3,8000059e <mappages+0x56>
    pa += PGSIZE;
  }
  return 0;
    800005cc:	4501                	li	a0,0
    800005ce:	a011                	j	800005d2 <mappages+0x8a>
      return -1;
    800005d0:	557d                	li	a0,-1
}
    800005d2:	60a6                	ld	ra,72(sp)
    800005d4:	6406                	ld	s0,64(sp)
    800005d6:	74e2                	ld	s1,56(sp)
    800005d8:	7942                	ld	s2,48(sp)
    800005da:	79a2                	ld	s3,40(sp)
    800005dc:	7a02                	ld	s4,32(sp)
    800005de:	6ae2                	ld	s5,24(sp)
    800005e0:	6b42                	ld	s6,16(sp)
    800005e2:	6ba2                	ld	s7,8(sp)
    800005e4:	6161                	addi	sp,sp,80
    800005e6:	8082                	ret

00000000800005e8 <kvmmap>:
{
    800005e8:	1141                	addi	sp,sp,-16
    800005ea:	e406                	sd	ra,8(sp)
    800005ec:	e022                	sd	s0,0(sp)
    800005ee:	0800                	addi	s0,sp,16
    800005f0:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    800005f2:	86b2                	mv	a3,a2
    800005f4:	863e                	mv	a2,a5
    800005f6:	00000097          	auipc	ra,0x0
    800005fa:	f52080e7          	jalr	-174(ra) # 80000548 <mappages>
    800005fe:	e509                	bnez	a0,80000608 <kvmmap+0x20>
}
    80000600:	60a2                	ld	ra,8(sp)
    80000602:	6402                	ld	s0,0(sp)
    80000604:	0141                	addi	sp,sp,16
    80000606:	8082                	ret
    panic("kvmmap");
    80000608:	00008517          	auipc	a0,0x8
    8000060c:	a7050513          	addi	a0,a0,-1424 # 80008078 <etext+0x78>
    80000610:	00006097          	auipc	ra,0x6
    80000614:	938080e7          	jalr	-1736(ra) # 80005f48 <panic>

0000000080000618 <kvmmake>:
{
    80000618:	1101                	addi	sp,sp,-32
    8000061a:	ec06                	sd	ra,24(sp)
    8000061c:	e822                	sd	s0,16(sp)
    8000061e:	e426                	sd	s1,8(sp)
    80000620:	e04a                	sd	s2,0(sp)
    80000622:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    80000624:	00000097          	auipc	ra,0x0
    80000628:	af4080e7          	jalr	-1292(ra) # 80000118 <kalloc>
    8000062c:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    8000062e:	6605                	lui	a2,0x1
    80000630:	4581                	li	a1,0
    80000632:	00000097          	auipc	ra,0x0
    80000636:	b46080e7          	jalr	-1210(ra) # 80000178 <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    8000063a:	4719                	li	a4,6
    8000063c:	6685                	lui	a3,0x1
    8000063e:	10000637          	lui	a2,0x10000
    80000642:	100005b7          	lui	a1,0x10000
    80000646:	8526                	mv	a0,s1
    80000648:	00000097          	auipc	ra,0x0
    8000064c:	fa0080e7          	jalr	-96(ra) # 800005e8 <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    80000650:	4719                	li	a4,6
    80000652:	6685                	lui	a3,0x1
    80000654:	10001637          	lui	a2,0x10001
    80000658:	100015b7          	lui	a1,0x10001
    8000065c:	8526                	mv	a0,s1
    8000065e:	00000097          	auipc	ra,0x0
    80000662:	f8a080e7          	jalr	-118(ra) # 800005e8 <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    80000666:	4719                	li	a4,6
    80000668:	004006b7          	lui	a3,0x400
    8000066c:	0c000637          	lui	a2,0xc000
    80000670:	0c0005b7          	lui	a1,0xc000
    80000674:	8526                	mv	a0,s1
    80000676:	00000097          	auipc	ra,0x0
    8000067a:	f72080e7          	jalr	-142(ra) # 800005e8 <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    8000067e:	00008917          	auipc	s2,0x8
    80000682:	98290913          	addi	s2,s2,-1662 # 80008000 <etext>
    80000686:	4729                	li	a4,10
    80000688:	80008697          	auipc	a3,0x80008
    8000068c:	97868693          	addi	a3,a3,-1672 # 8000 <_entry-0x7fff8000>
    80000690:	4605                	li	a2,1
    80000692:	067e                	slli	a2,a2,0x1f
    80000694:	85b2                	mv	a1,a2
    80000696:	8526                	mv	a0,s1
    80000698:	00000097          	auipc	ra,0x0
    8000069c:	f50080e7          	jalr	-176(ra) # 800005e8 <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800006a0:	4719                	li	a4,6
    800006a2:	46c5                	li	a3,17
    800006a4:	06ee                	slli	a3,a3,0x1b
    800006a6:	412686b3          	sub	a3,a3,s2
    800006aa:	864a                	mv	a2,s2
    800006ac:	85ca                	mv	a1,s2
    800006ae:	8526                	mv	a0,s1
    800006b0:	00000097          	auipc	ra,0x0
    800006b4:	f38080e7          	jalr	-200(ra) # 800005e8 <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    800006b8:	4729                	li	a4,10
    800006ba:	6685                	lui	a3,0x1
    800006bc:	00007617          	auipc	a2,0x7
    800006c0:	94460613          	addi	a2,a2,-1724 # 80007000 <_trampoline>
    800006c4:	040005b7          	lui	a1,0x4000
    800006c8:	15fd                	addi	a1,a1,-1
    800006ca:	05b2                	slli	a1,a1,0xc
    800006cc:	8526                	mv	a0,s1
    800006ce:	00000097          	auipc	ra,0x0
    800006d2:	f1a080e7          	jalr	-230(ra) # 800005e8 <kvmmap>
  proc_mapstacks(kpgtbl);
    800006d6:	8526                	mv	a0,s1
    800006d8:	00000097          	auipc	ra,0x0
    800006dc:	6e0080e7          	jalr	1760(ra) # 80000db8 <proc_mapstacks>
}
    800006e0:	8526                	mv	a0,s1
    800006e2:	60e2                	ld	ra,24(sp)
    800006e4:	6442                	ld	s0,16(sp)
    800006e6:	64a2                	ld	s1,8(sp)
    800006e8:	6902                	ld	s2,0(sp)
    800006ea:	6105                	addi	sp,sp,32
    800006ec:	8082                	ret

00000000800006ee <kvminit>:
{
    800006ee:	1141                	addi	sp,sp,-16
    800006f0:	e406                	sd	ra,8(sp)
    800006f2:	e022                	sd	s0,0(sp)
    800006f4:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    800006f6:	00000097          	auipc	ra,0x0
    800006fa:	f22080e7          	jalr	-222(ra) # 80000618 <kvmmake>
    800006fe:	00009797          	auipc	a5,0x9
    80000702:	90a7b523          	sd	a0,-1782(a5) # 80009008 <kernel_pagetable>
}
    80000706:	60a2                	ld	ra,8(sp)
    80000708:	6402                	ld	s0,0(sp)
    8000070a:	0141                	addi	sp,sp,16
    8000070c:	8082                	ret

000000008000070e <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    8000070e:	715d                	addi	sp,sp,-80
    80000710:	e486                	sd	ra,72(sp)
    80000712:	e0a2                	sd	s0,64(sp)
    80000714:	fc26                	sd	s1,56(sp)
    80000716:	f84a                	sd	s2,48(sp)
    80000718:	f44e                	sd	s3,40(sp)
    8000071a:	f052                	sd	s4,32(sp)
    8000071c:	ec56                	sd	s5,24(sp)
    8000071e:	e85a                	sd	s6,16(sp)
    80000720:	e45e                	sd	s7,8(sp)
    80000722:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80000724:	03459793          	slli	a5,a1,0x34
    80000728:	e795                	bnez	a5,80000754 <uvmunmap+0x46>
    8000072a:	8a2a                	mv	s4,a0
    8000072c:	892e                	mv	s2,a1
    8000072e:	8b36                	mv	s6,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000730:	0632                	slli	a2,a2,0xc
    80000732:	00b609b3          	add	s3,a2,a1
    }

    if((*pte & PTE_V) == 0)
      continue;

    if(PTE_FLAGS(*pte) == PTE_V)
    80000736:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000738:	6a85                	lui	s5,0x1
    8000073a:	0735e163          	bltu	a1,s3,8000079c <uvmunmap+0x8e>
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
  }
}
    8000073e:	60a6                	ld	ra,72(sp)
    80000740:	6406                	ld	s0,64(sp)
    80000742:	74e2                	ld	s1,56(sp)
    80000744:	7942                	ld	s2,48(sp)
    80000746:	79a2                	ld	s3,40(sp)
    80000748:	7a02                	ld	s4,32(sp)
    8000074a:	6ae2                	ld	s5,24(sp)
    8000074c:	6b42                	ld	s6,16(sp)
    8000074e:	6ba2                	ld	s7,8(sp)
    80000750:	6161                	addi	sp,sp,80
    80000752:	8082                	ret
    panic("uvmunmap: not aligned");
    80000754:	00008517          	auipc	a0,0x8
    80000758:	92c50513          	addi	a0,a0,-1748 # 80008080 <etext+0x80>
    8000075c:	00005097          	auipc	ra,0x5
    80000760:	7ec080e7          	jalr	2028(ra) # 80005f48 <panic>
      panic("uvmunmap: walk");
    80000764:	00008517          	auipc	a0,0x8
    80000768:	93450513          	addi	a0,a0,-1740 # 80008098 <etext+0x98>
    8000076c:	00005097          	auipc	ra,0x5
    80000770:	7dc080e7          	jalr	2012(ra) # 80005f48 <panic>
      panic("uvmunmap: not a leaf");
    80000774:	00008517          	auipc	a0,0x8
    80000778:	93450513          	addi	a0,a0,-1740 # 800080a8 <etext+0xa8>
    8000077c:	00005097          	auipc	ra,0x5
    80000780:	7cc080e7          	jalr	1996(ra) # 80005f48 <panic>
      uint64 pa = PTE2PA(*pte);
    80000784:	83a9                	srli	a5,a5,0xa
      kfree((void*)pa);
    80000786:	00c79513          	slli	a0,a5,0xc
    8000078a:	00000097          	auipc	ra,0x0
    8000078e:	892080e7          	jalr	-1902(ra) # 8000001c <kfree>
    *pte = 0;
    80000792:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000796:	9956                	add	s2,s2,s5
    80000798:	fb3973e3          	bgeu	s2,s3,8000073e <uvmunmap+0x30>
    if((pte = walk(pagetable, a, 0)) == 0)
    8000079c:	4601                	li	a2,0
    8000079e:	85ca                	mv	a1,s2
    800007a0:	8552                	mv	a0,s4
    800007a2:	00000097          	auipc	ra,0x0
    800007a6:	cbe080e7          	jalr	-834(ra) # 80000460 <walk>
    800007aa:	84aa                	mv	s1,a0
    800007ac:	dd45                	beqz	a0,80000764 <uvmunmap+0x56>
    if(*pte & PTE_S) {
    800007ae:	611c                	ld	a5,0(a0)
    800007b0:	2007f713          	andi	a4,a5,512
    800007b4:	f36d                	bnez	a4,80000796 <uvmunmap+0x88>
    if((*pte & PTE_V) == 0)
    800007b6:	0017f713          	andi	a4,a5,1
    800007ba:	df71                	beqz	a4,80000796 <uvmunmap+0x88>
    if(PTE_FLAGS(*pte) == PTE_V)
    800007bc:	3ff7f713          	andi	a4,a5,1023
    800007c0:	fb770ae3          	beq	a4,s7,80000774 <uvmunmap+0x66>
    if(do_free){
    800007c4:	fc0b07e3          	beqz	s6,80000792 <uvmunmap+0x84>
    800007c8:	bf75                	j	80000784 <uvmunmap+0x76>

00000000800007ca <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    800007ca:	1101                	addi	sp,sp,-32
    800007cc:	ec06                	sd	ra,24(sp)
    800007ce:	e822                	sd	s0,16(sp)
    800007d0:	e426                	sd	s1,8(sp)
    800007d2:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    800007d4:	00000097          	auipc	ra,0x0
    800007d8:	944080e7          	jalr	-1724(ra) # 80000118 <kalloc>
    800007dc:	84aa                	mv	s1,a0
  if(pagetable == 0)
    800007de:	c519                	beqz	a0,800007ec <uvmcreate+0x22>
    return 0;
  memset(pagetable, 0, PGSIZE);
    800007e0:	6605                	lui	a2,0x1
    800007e2:	4581                	li	a1,0
    800007e4:	00000097          	auipc	ra,0x0
    800007e8:	994080e7          	jalr	-1644(ra) # 80000178 <memset>
  return pagetable;
}
    800007ec:	8526                	mv	a0,s1
    800007ee:	60e2                	ld	ra,24(sp)
    800007f0:	6442                	ld	s0,16(sp)
    800007f2:	64a2                	ld	s1,8(sp)
    800007f4:	6105                	addi	sp,sp,32
    800007f6:	8082                	ret

00000000800007f8 <uvminit>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvminit(pagetable_t pagetable, uchar *src, uint sz)
{
    800007f8:	7179                	addi	sp,sp,-48
    800007fa:	f406                	sd	ra,40(sp)
    800007fc:	f022                	sd	s0,32(sp)
    800007fe:	ec26                	sd	s1,24(sp)
    80000800:	e84a                	sd	s2,16(sp)
    80000802:	e44e                	sd	s3,8(sp)
    80000804:	e052                	sd	s4,0(sp)
    80000806:	1800                	addi	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    80000808:	6785                	lui	a5,0x1
    8000080a:	04f67863          	bgeu	a2,a5,8000085a <uvminit+0x62>
    8000080e:	8a2a                	mv	s4,a0
    80000810:	89ae                	mv	s3,a1
    80000812:	84b2                	mv	s1,a2
    panic("inituvm: more than a page");
  mem = kalloc();
    80000814:	00000097          	auipc	ra,0x0
    80000818:	904080e7          	jalr	-1788(ra) # 80000118 <kalloc>
    8000081c:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    8000081e:	6605                	lui	a2,0x1
    80000820:	4581                	li	a1,0
    80000822:	00000097          	auipc	ra,0x0
    80000826:	956080e7          	jalr	-1706(ra) # 80000178 <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    8000082a:	4779                	li	a4,30
    8000082c:	86ca                	mv	a3,s2
    8000082e:	6605                	lui	a2,0x1
    80000830:	4581                	li	a1,0
    80000832:	8552                	mv	a0,s4
    80000834:	00000097          	auipc	ra,0x0
    80000838:	d14080e7          	jalr	-748(ra) # 80000548 <mappages>
  memmove(mem, src, sz);
    8000083c:	8626                	mv	a2,s1
    8000083e:	85ce                	mv	a1,s3
    80000840:	854a                	mv	a0,s2
    80000842:	00000097          	auipc	ra,0x0
    80000846:	996080e7          	jalr	-1642(ra) # 800001d8 <memmove>
}
    8000084a:	70a2                	ld	ra,40(sp)
    8000084c:	7402                	ld	s0,32(sp)
    8000084e:	64e2                	ld	s1,24(sp)
    80000850:	6942                	ld	s2,16(sp)
    80000852:	69a2                	ld	s3,8(sp)
    80000854:	6a02                	ld	s4,0(sp)
    80000856:	6145                	addi	sp,sp,48
    80000858:	8082                	ret
    panic("inituvm: more than a page");
    8000085a:	00008517          	auipc	a0,0x8
    8000085e:	86650513          	addi	a0,a0,-1946 # 800080c0 <etext+0xc0>
    80000862:	00005097          	auipc	ra,0x5
    80000866:	6e6080e7          	jalr	1766(ra) # 80005f48 <panic>

000000008000086a <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    8000086a:	1101                	addi	sp,sp,-32
    8000086c:	ec06                	sd	ra,24(sp)
    8000086e:	e822                	sd	s0,16(sp)
    80000870:	e426                	sd	s1,8(sp)
    80000872:	1000                	addi	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    80000874:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    80000876:	00b67d63          	bgeu	a2,a1,80000890 <uvmdealloc+0x26>
    8000087a:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    8000087c:	6785                	lui	a5,0x1
    8000087e:	17fd                	addi	a5,a5,-1
    80000880:	00f60733          	add	a4,a2,a5
    80000884:	767d                	lui	a2,0xfffff
    80000886:	8f71                	and	a4,a4,a2
    80000888:	97ae                	add	a5,a5,a1
    8000088a:	8ff1                	and	a5,a5,a2
    8000088c:	00f76863          	bltu	a4,a5,8000089c <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    80000890:	8526                	mv	a0,s1
    80000892:	60e2                	ld	ra,24(sp)
    80000894:	6442                	ld	s0,16(sp)
    80000896:	64a2                	ld	s1,8(sp)
    80000898:	6105                	addi	sp,sp,32
    8000089a:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    8000089c:	8f99                	sub	a5,a5,a4
    8000089e:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    800008a0:	4685                	li	a3,1
    800008a2:	0007861b          	sext.w	a2,a5
    800008a6:	85ba                	mv	a1,a4
    800008a8:	00000097          	auipc	ra,0x0
    800008ac:	e66080e7          	jalr	-410(ra) # 8000070e <uvmunmap>
    800008b0:	b7c5                	j	80000890 <uvmdealloc+0x26>

00000000800008b2 <uvmalloc>:
  if(newsz < oldsz)
    800008b2:	0ab66163          	bltu	a2,a1,80000954 <uvmalloc+0xa2>
{
    800008b6:	7139                	addi	sp,sp,-64
    800008b8:	fc06                	sd	ra,56(sp)
    800008ba:	f822                	sd	s0,48(sp)
    800008bc:	f426                	sd	s1,40(sp)
    800008be:	f04a                	sd	s2,32(sp)
    800008c0:	ec4e                	sd	s3,24(sp)
    800008c2:	e852                	sd	s4,16(sp)
    800008c4:	e456                	sd	s5,8(sp)
    800008c6:	0080                	addi	s0,sp,64
    800008c8:	8aaa                	mv	s5,a0
    800008ca:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    800008cc:	6985                	lui	s3,0x1
    800008ce:	19fd                	addi	s3,s3,-1
    800008d0:	95ce                	add	a1,a1,s3
    800008d2:	79fd                	lui	s3,0xfffff
    800008d4:	0135f9b3          	and	s3,a1,s3
  for(a = oldsz; a < newsz; a += PGSIZE){
    800008d8:	08c9f063          	bgeu	s3,a2,80000958 <uvmalloc+0xa6>
    800008dc:	894e                	mv	s2,s3
    mem = kalloc();
    800008de:	00000097          	auipc	ra,0x0
    800008e2:	83a080e7          	jalr	-1990(ra) # 80000118 <kalloc>
    800008e6:	84aa                	mv	s1,a0
    if(mem == 0){
    800008e8:	c51d                	beqz	a0,80000916 <uvmalloc+0x64>
    memset(mem, 0, PGSIZE);
    800008ea:	6605                	lui	a2,0x1
    800008ec:	4581                	li	a1,0
    800008ee:	00000097          	auipc	ra,0x0
    800008f2:	88a080e7          	jalr	-1910(ra) # 80000178 <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U) != 0){
    800008f6:	4779                	li	a4,30
    800008f8:	86a6                	mv	a3,s1
    800008fa:	6605                	lui	a2,0x1
    800008fc:	85ca                	mv	a1,s2
    800008fe:	8556                	mv	a0,s5
    80000900:	00000097          	auipc	ra,0x0
    80000904:	c48080e7          	jalr	-952(ra) # 80000548 <mappages>
    80000908:	e905                	bnez	a0,80000938 <uvmalloc+0x86>
  for(a = oldsz; a < newsz; a += PGSIZE){
    8000090a:	6785                	lui	a5,0x1
    8000090c:	993e                	add	s2,s2,a5
    8000090e:	fd4968e3          	bltu	s2,s4,800008de <uvmalloc+0x2c>
  return newsz;
    80000912:	8552                	mv	a0,s4
    80000914:	a809                	j	80000926 <uvmalloc+0x74>
      uvmdealloc(pagetable, a, oldsz);
    80000916:	864e                	mv	a2,s3
    80000918:	85ca                	mv	a1,s2
    8000091a:	8556                	mv	a0,s5
    8000091c:	00000097          	auipc	ra,0x0
    80000920:	f4e080e7          	jalr	-178(ra) # 8000086a <uvmdealloc>
      return 0;
    80000924:	4501                	li	a0,0
}
    80000926:	70e2                	ld	ra,56(sp)
    80000928:	7442                	ld	s0,48(sp)
    8000092a:	74a2                	ld	s1,40(sp)
    8000092c:	7902                	ld	s2,32(sp)
    8000092e:	69e2                	ld	s3,24(sp)
    80000930:	6a42                	ld	s4,16(sp)
    80000932:	6aa2                	ld	s5,8(sp)
    80000934:	6121                	addi	sp,sp,64
    80000936:	8082                	ret
      kfree(mem);
    80000938:	8526                	mv	a0,s1
    8000093a:	fffff097          	auipc	ra,0xfffff
    8000093e:	6e2080e7          	jalr	1762(ra) # 8000001c <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80000942:	864e                	mv	a2,s3
    80000944:	85ca                	mv	a1,s2
    80000946:	8556                	mv	a0,s5
    80000948:	00000097          	auipc	ra,0x0
    8000094c:	f22080e7          	jalr	-222(ra) # 8000086a <uvmdealloc>
      return 0;
    80000950:	4501                	li	a0,0
    80000952:	bfd1                	j	80000926 <uvmalloc+0x74>
    return oldsz;
    80000954:	852e                	mv	a0,a1
}
    80000956:	8082                	ret
  return newsz;
    80000958:	8532                	mv	a0,a2
    8000095a:	b7f1                	j	80000926 <uvmalloc+0x74>

000000008000095c <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    8000095c:	7179                	addi	sp,sp,-48
    8000095e:	f406                	sd	ra,40(sp)
    80000960:	f022                	sd	s0,32(sp)
    80000962:	ec26                	sd	s1,24(sp)
    80000964:	e84a                	sd	s2,16(sp)
    80000966:	e44e                	sd	s3,8(sp)
    80000968:	e052                	sd	s4,0(sp)
    8000096a:	1800                	addi	s0,sp,48
    8000096c:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    8000096e:	84aa                	mv	s1,a0
    80000970:	6905                	lui	s2,0x1
    80000972:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000974:	4985                	li	s3,1
    80000976:	a821                	j	8000098e <freewalk+0x32>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    80000978:	8129                	srli	a0,a0,0xa
      freewalk((pagetable_t)child);
    8000097a:	0532                	slli	a0,a0,0xc
    8000097c:	00000097          	auipc	ra,0x0
    80000980:	fe0080e7          	jalr	-32(ra) # 8000095c <freewalk>
      pagetable[i] = 0;
    80000984:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    80000988:	04a1                	addi	s1,s1,8
    8000098a:	03248163          	beq	s1,s2,800009ac <freewalk+0x50>
    pte_t pte = pagetable[i];
    8000098e:	6088                	ld	a0,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000990:	00f57793          	andi	a5,a0,15
    80000994:	ff3782e3          	beq	a5,s3,80000978 <freewalk+0x1c>
    } else if(pte & PTE_V){
    80000998:	8905                	andi	a0,a0,1
    8000099a:	d57d                	beqz	a0,80000988 <freewalk+0x2c>
      panic("freewalk: leaf");
    8000099c:	00007517          	auipc	a0,0x7
    800009a0:	74450513          	addi	a0,a0,1860 # 800080e0 <etext+0xe0>
    800009a4:	00005097          	auipc	ra,0x5
    800009a8:	5a4080e7          	jalr	1444(ra) # 80005f48 <panic>
    }
  }
  kfree((void*)pagetable);
    800009ac:	8552                	mv	a0,s4
    800009ae:	fffff097          	auipc	ra,0xfffff
    800009b2:	66e080e7          	jalr	1646(ra) # 8000001c <kfree>
}
    800009b6:	70a2                	ld	ra,40(sp)
    800009b8:	7402                	ld	s0,32(sp)
    800009ba:	64e2                	ld	s1,24(sp)
    800009bc:	6942                	ld	s2,16(sp)
    800009be:	69a2                	ld	s3,8(sp)
    800009c0:	6a02                	ld	s4,0(sp)
    800009c2:	6145                	addi	sp,sp,48
    800009c4:	8082                	ret

00000000800009c6 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    800009c6:	1101                	addi	sp,sp,-32
    800009c8:	ec06                	sd	ra,24(sp)
    800009ca:	e822                	sd	s0,16(sp)
    800009cc:	e426                	sd	s1,8(sp)
    800009ce:	1000                	addi	s0,sp,32
    800009d0:	84aa                	mv	s1,a0
  if(sz > 0)
    800009d2:	e999                	bnez	a1,800009e8 <uvmfree+0x22>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    800009d4:	8526                	mv	a0,s1
    800009d6:	00000097          	auipc	ra,0x0
    800009da:	f86080e7          	jalr	-122(ra) # 8000095c <freewalk>
}
    800009de:	60e2                	ld	ra,24(sp)
    800009e0:	6442                	ld	s0,16(sp)
    800009e2:	64a2                	ld	s1,8(sp)
    800009e4:	6105                	addi	sp,sp,32
    800009e6:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    800009e8:	6605                	lui	a2,0x1
    800009ea:	167d                	addi	a2,a2,-1
    800009ec:	962e                	add	a2,a2,a1
    800009ee:	4685                	li	a3,1
    800009f0:	8231                	srli	a2,a2,0xc
    800009f2:	4581                	li	a1,0
    800009f4:	00000097          	auipc	ra,0x0
    800009f8:	d1a080e7          	jalr	-742(ra) # 8000070e <uvmunmap>
    800009fc:	bfe1                	j	800009d4 <uvmfree+0xe>

00000000800009fe <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    800009fe:	c679                	beqz	a2,80000acc <uvmcopy+0xce>
{
    80000a00:	715d                	addi	sp,sp,-80
    80000a02:	e486                	sd	ra,72(sp)
    80000a04:	e0a2                	sd	s0,64(sp)
    80000a06:	fc26                	sd	s1,56(sp)
    80000a08:	f84a                	sd	s2,48(sp)
    80000a0a:	f44e                	sd	s3,40(sp)
    80000a0c:	f052                	sd	s4,32(sp)
    80000a0e:	ec56                	sd	s5,24(sp)
    80000a10:	e85a                	sd	s6,16(sp)
    80000a12:	e45e                	sd	s7,8(sp)
    80000a14:	0880                	addi	s0,sp,80
    80000a16:	8b2a                	mv	s6,a0
    80000a18:	8aae                	mv	s5,a1
    80000a1a:	8a32                	mv	s4,a2
  for(i = 0; i < sz; i += PGSIZE){
    80000a1c:	4981                	li	s3,0
    if((pte = walk(old, i, 0)) == 0)
    80000a1e:	4601                	li	a2,0
    80000a20:	85ce                	mv	a1,s3
    80000a22:	855a                	mv	a0,s6
    80000a24:	00000097          	auipc	ra,0x0
    80000a28:	a3c080e7          	jalr	-1476(ra) # 80000460 <walk>
    80000a2c:	c531                	beqz	a0,80000a78 <uvmcopy+0x7a>
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0)
    80000a2e:	6118                	ld	a4,0(a0)
    80000a30:	00177793          	andi	a5,a4,1
    80000a34:	cbb1                	beqz	a5,80000a88 <uvmcopy+0x8a>
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    80000a36:	00a75593          	srli	a1,a4,0xa
    80000a3a:	00c59b93          	slli	s7,a1,0xc
    flags = PTE_FLAGS(*pte);
    80000a3e:	3ff77493          	andi	s1,a4,1023
    if((mem = kalloc()) == 0)
    80000a42:	fffff097          	auipc	ra,0xfffff
    80000a46:	6d6080e7          	jalr	1750(ra) # 80000118 <kalloc>
    80000a4a:	892a                	mv	s2,a0
    80000a4c:	c939                	beqz	a0,80000aa2 <uvmcopy+0xa4>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    80000a4e:	6605                	lui	a2,0x1
    80000a50:	85de                	mv	a1,s7
    80000a52:	fffff097          	auipc	ra,0xfffff
    80000a56:	786080e7          	jalr	1926(ra) # 800001d8 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    80000a5a:	8726                	mv	a4,s1
    80000a5c:	86ca                	mv	a3,s2
    80000a5e:	6605                	lui	a2,0x1
    80000a60:	85ce                	mv	a1,s3
    80000a62:	8556                	mv	a0,s5
    80000a64:	00000097          	auipc	ra,0x0
    80000a68:	ae4080e7          	jalr	-1308(ra) # 80000548 <mappages>
    80000a6c:	e515                	bnez	a0,80000a98 <uvmcopy+0x9a>
  for(i = 0; i < sz; i += PGSIZE){
    80000a6e:	6785                	lui	a5,0x1
    80000a70:	99be                	add	s3,s3,a5
    80000a72:	fb49e6e3          	bltu	s3,s4,80000a1e <uvmcopy+0x20>
    80000a76:	a081                	j	80000ab6 <uvmcopy+0xb8>
      panic("uvmcopy: pte should exist");
    80000a78:	00007517          	auipc	a0,0x7
    80000a7c:	67850513          	addi	a0,a0,1656 # 800080f0 <etext+0xf0>
    80000a80:	00005097          	auipc	ra,0x5
    80000a84:	4c8080e7          	jalr	1224(ra) # 80005f48 <panic>
      panic("uvmcopy: page not present");
    80000a88:	00007517          	auipc	a0,0x7
    80000a8c:	68850513          	addi	a0,a0,1672 # 80008110 <etext+0x110>
    80000a90:	00005097          	auipc	ra,0x5
    80000a94:	4b8080e7          	jalr	1208(ra) # 80005f48 <panic>
      kfree(mem);
    80000a98:	854a                	mv	a0,s2
    80000a9a:	fffff097          	auipc	ra,0xfffff
    80000a9e:	582080e7          	jalr	1410(ra) # 8000001c <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    80000aa2:	4685                	li	a3,1
    80000aa4:	00c9d613          	srli	a2,s3,0xc
    80000aa8:	4581                	li	a1,0
    80000aaa:	8556                	mv	a0,s5
    80000aac:	00000097          	auipc	ra,0x0
    80000ab0:	c62080e7          	jalr	-926(ra) # 8000070e <uvmunmap>
  return -1;
    80000ab4:	557d                	li	a0,-1
}
    80000ab6:	60a6                	ld	ra,72(sp)
    80000ab8:	6406                	ld	s0,64(sp)
    80000aba:	74e2                	ld	s1,56(sp)
    80000abc:	7942                	ld	s2,48(sp)
    80000abe:	79a2                	ld	s3,40(sp)
    80000ac0:	7a02                	ld	s4,32(sp)
    80000ac2:	6ae2                	ld	s5,24(sp)
    80000ac4:	6b42                	ld	s6,16(sp)
    80000ac6:	6ba2                	ld	s7,8(sp)
    80000ac8:	6161                	addi	sp,sp,80
    80000aca:	8082                	ret
  return 0;
    80000acc:	4501                	li	a0,0
}
    80000ace:	8082                	ret

0000000080000ad0 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80000ad0:	1141                	addi	sp,sp,-16
    80000ad2:	e406                	sd	ra,8(sp)
    80000ad4:	e022                	sd	s0,0(sp)
    80000ad6:	0800                	addi	s0,sp,16
  pte_t *pte;
  pte = walk(pagetable, va, 0);
    80000ad8:	4601                	li	a2,0
    80000ada:	00000097          	auipc	ra,0x0
    80000ade:	986080e7          	jalr	-1658(ra) # 80000460 <walk>
  if(pte == 0)
    80000ae2:	c901                	beqz	a0,80000af2 <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    80000ae4:	611c                	ld	a5,0(a0)
    80000ae6:	9bbd                	andi	a5,a5,-17
    80000ae8:	e11c                	sd	a5,0(a0)
}
    80000aea:	60a2                	ld	ra,8(sp)
    80000aec:	6402                	ld	s0,0(sp)
    80000aee:	0141                	addi	sp,sp,16
    80000af0:	8082                	ret
    panic("uvmclear");
    80000af2:	00007517          	auipc	a0,0x7
    80000af6:	63e50513          	addi	a0,a0,1598 # 80008130 <etext+0x130>
    80000afa:	00005097          	auipc	ra,0x5
    80000afe:	44e080e7          	jalr	1102(ra) # 80005f48 <panic>

0000000080000b02 <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000b02:	c6bd                	beqz	a3,80000b70 <copyout+0x6e>
{
    80000b04:	715d                	addi	sp,sp,-80
    80000b06:	e486                	sd	ra,72(sp)
    80000b08:	e0a2                	sd	s0,64(sp)
    80000b0a:	fc26                	sd	s1,56(sp)
    80000b0c:	f84a                	sd	s2,48(sp)
    80000b0e:	f44e                	sd	s3,40(sp)
    80000b10:	f052                	sd	s4,32(sp)
    80000b12:	ec56                	sd	s5,24(sp)
    80000b14:	e85a                	sd	s6,16(sp)
    80000b16:	e45e                	sd	s7,8(sp)
    80000b18:	e062                	sd	s8,0(sp)
    80000b1a:	0880                	addi	s0,sp,80
    80000b1c:	8b2a                	mv	s6,a0
    80000b1e:	8c2e                	mv	s8,a1
    80000b20:	8a32                	mv	s4,a2
    80000b22:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    80000b24:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (dstva - va0);
    80000b26:	6a85                	lui	s5,0x1
    80000b28:	a015                	j	80000b4c <copyout+0x4a>
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000b2a:	9562                	add	a0,a0,s8
    80000b2c:	0004861b          	sext.w	a2,s1
    80000b30:	85d2                	mv	a1,s4
    80000b32:	41250533          	sub	a0,a0,s2
    80000b36:	fffff097          	auipc	ra,0xfffff
    80000b3a:	6a2080e7          	jalr	1698(ra) # 800001d8 <memmove>

    len -= n;
    80000b3e:	409989b3          	sub	s3,s3,s1
    src += n;
    80000b42:	9a26                	add	s4,s4,s1
    dstva = va0 + PGSIZE;
    80000b44:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000b48:	02098263          	beqz	s3,80000b6c <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    80000b4c:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000b50:	85ca                	mv	a1,s2
    80000b52:	855a                	mv	a0,s6
    80000b54:	00000097          	auipc	ra,0x0
    80000b58:	9b2080e7          	jalr	-1614(ra) # 80000506 <walkaddr>
    if(pa0 == 0)
    80000b5c:	cd01                	beqz	a0,80000b74 <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    80000b5e:	418904b3          	sub	s1,s2,s8
    80000b62:	94d6                	add	s1,s1,s5
    if(n > len)
    80000b64:	fc99f3e3          	bgeu	s3,s1,80000b2a <copyout+0x28>
    80000b68:	84ce                	mv	s1,s3
    80000b6a:	b7c1                	j	80000b2a <copyout+0x28>
  }
  return 0;
    80000b6c:	4501                	li	a0,0
    80000b6e:	a021                	j	80000b76 <copyout+0x74>
    80000b70:	4501                	li	a0,0
}
    80000b72:	8082                	ret
      return -1;
    80000b74:	557d                	li	a0,-1
}
    80000b76:	60a6                	ld	ra,72(sp)
    80000b78:	6406                	ld	s0,64(sp)
    80000b7a:	74e2                	ld	s1,56(sp)
    80000b7c:	7942                	ld	s2,48(sp)
    80000b7e:	79a2                	ld	s3,40(sp)
    80000b80:	7a02                	ld	s4,32(sp)
    80000b82:	6ae2                	ld	s5,24(sp)
    80000b84:	6b42                	ld	s6,16(sp)
    80000b86:	6ba2                	ld	s7,8(sp)
    80000b88:	6c02                	ld	s8,0(sp)
    80000b8a:	6161                	addi	sp,sp,80
    80000b8c:	8082                	ret

0000000080000b8e <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000b8e:	c6bd                	beqz	a3,80000bfc <copyin+0x6e>
{
    80000b90:	715d                	addi	sp,sp,-80
    80000b92:	e486                	sd	ra,72(sp)
    80000b94:	e0a2                	sd	s0,64(sp)
    80000b96:	fc26                	sd	s1,56(sp)
    80000b98:	f84a                	sd	s2,48(sp)
    80000b9a:	f44e                	sd	s3,40(sp)
    80000b9c:	f052                	sd	s4,32(sp)
    80000b9e:	ec56                	sd	s5,24(sp)
    80000ba0:	e85a                	sd	s6,16(sp)
    80000ba2:	e45e                	sd	s7,8(sp)
    80000ba4:	e062                	sd	s8,0(sp)
    80000ba6:	0880                	addi	s0,sp,80
    80000ba8:	8b2a                	mv	s6,a0
    80000baa:	8a2e                	mv	s4,a1
    80000bac:	8c32                	mv	s8,a2
    80000bae:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000bb0:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000bb2:	6a85                	lui	s5,0x1
    80000bb4:	a015                	j	80000bd8 <copyin+0x4a>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000bb6:	9562                	add	a0,a0,s8
    80000bb8:	0004861b          	sext.w	a2,s1
    80000bbc:	412505b3          	sub	a1,a0,s2
    80000bc0:	8552                	mv	a0,s4
    80000bc2:	fffff097          	auipc	ra,0xfffff
    80000bc6:	616080e7          	jalr	1558(ra) # 800001d8 <memmove>

    len -= n;
    80000bca:	409989b3          	sub	s3,s3,s1
    dst += n;
    80000bce:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    80000bd0:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000bd4:	02098263          	beqz	s3,80000bf8 <copyin+0x6a>
    va0 = PGROUNDDOWN(srcva);
    80000bd8:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000bdc:	85ca                	mv	a1,s2
    80000bde:	855a                	mv	a0,s6
    80000be0:	00000097          	auipc	ra,0x0
    80000be4:	926080e7          	jalr	-1754(ra) # 80000506 <walkaddr>
    if(pa0 == 0)
    80000be8:	cd01                	beqz	a0,80000c00 <copyin+0x72>
    n = PGSIZE - (srcva - va0);
    80000bea:	418904b3          	sub	s1,s2,s8
    80000bee:	94d6                	add	s1,s1,s5
    if(n > len)
    80000bf0:	fc99f3e3          	bgeu	s3,s1,80000bb6 <copyin+0x28>
    80000bf4:	84ce                	mv	s1,s3
    80000bf6:	b7c1                	j	80000bb6 <copyin+0x28>
  }
  return 0;
    80000bf8:	4501                	li	a0,0
    80000bfa:	a021                	j	80000c02 <copyin+0x74>
    80000bfc:	4501                	li	a0,0
}
    80000bfe:	8082                	ret
      return -1;
    80000c00:	557d                	li	a0,-1
}
    80000c02:	60a6                	ld	ra,72(sp)
    80000c04:	6406                	ld	s0,64(sp)
    80000c06:	74e2                	ld	s1,56(sp)
    80000c08:	7942                	ld	s2,48(sp)
    80000c0a:	79a2                	ld	s3,40(sp)
    80000c0c:	7a02                	ld	s4,32(sp)
    80000c0e:	6ae2                	ld	s5,24(sp)
    80000c10:	6b42                	ld	s6,16(sp)
    80000c12:	6ba2                	ld	s7,8(sp)
    80000c14:	6c02                	ld	s8,0(sp)
    80000c16:	6161                	addi	sp,sp,80
    80000c18:	8082                	ret

0000000080000c1a <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80000c1a:	c6c5                	beqz	a3,80000cc2 <copyinstr+0xa8>
{
    80000c1c:	715d                	addi	sp,sp,-80
    80000c1e:	e486                	sd	ra,72(sp)
    80000c20:	e0a2                	sd	s0,64(sp)
    80000c22:	fc26                	sd	s1,56(sp)
    80000c24:	f84a                	sd	s2,48(sp)
    80000c26:	f44e                	sd	s3,40(sp)
    80000c28:	f052                	sd	s4,32(sp)
    80000c2a:	ec56                	sd	s5,24(sp)
    80000c2c:	e85a                	sd	s6,16(sp)
    80000c2e:	e45e                	sd	s7,8(sp)
    80000c30:	0880                	addi	s0,sp,80
    80000c32:	8a2a                	mv	s4,a0
    80000c34:	8b2e                	mv	s6,a1
    80000c36:	8bb2                	mv	s7,a2
    80000c38:	84b6                	mv	s1,a3
    va0 = PGROUNDDOWN(srcva);
    80000c3a:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000c3c:	6985                	lui	s3,0x1
    80000c3e:	a035                	j	80000c6a <copyinstr+0x50>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    80000c40:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    80000c44:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    80000c46:	0017b793          	seqz	a5,a5
    80000c4a:	40f00533          	neg	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80000c4e:	60a6                	ld	ra,72(sp)
    80000c50:	6406                	ld	s0,64(sp)
    80000c52:	74e2                	ld	s1,56(sp)
    80000c54:	7942                	ld	s2,48(sp)
    80000c56:	79a2                	ld	s3,40(sp)
    80000c58:	7a02                	ld	s4,32(sp)
    80000c5a:	6ae2                	ld	s5,24(sp)
    80000c5c:	6b42                	ld	s6,16(sp)
    80000c5e:	6ba2                	ld	s7,8(sp)
    80000c60:	6161                	addi	sp,sp,80
    80000c62:	8082                	ret
    srcva = va0 + PGSIZE;
    80000c64:	01390bb3          	add	s7,s2,s3
  while(got_null == 0 && max > 0){
    80000c68:	c8a9                	beqz	s1,80000cba <copyinstr+0xa0>
    va0 = PGROUNDDOWN(srcva);
    80000c6a:	015bf933          	and	s2,s7,s5
    pa0 = walkaddr(pagetable, va0);
    80000c6e:	85ca                	mv	a1,s2
    80000c70:	8552                	mv	a0,s4
    80000c72:	00000097          	auipc	ra,0x0
    80000c76:	894080e7          	jalr	-1900(ra) # 80000506 <walkaddr>
    if(pa0 == 0)
    80000c7a:	c131                	beqz	a0,80000cbe <copyinstr+0xa4>
    n = PGSIZE - (srcva - va0);
    80000c7c:	41790833          	sub	a6,s2,s7
    80000c80:	984e                	add	a6,a6,s3
    if(n > max)
    80000c82:	0104f363          	bgeu	s1,a6,80000c88 <copyinstr+0x6e>
    80000c86:	8826                	mv	a6,s1
    char *p = (char *) (pa0 + (srcva - va0));
    80000c88:	955e                	add	a0,a0,s7
    80000c8a:	41250533          	sub	a0,a0,s2
    while(n > 0){
    80000c8e:	fc080be3          	beqz	a6,80000c64 <copyinstr+0x4a>
    80000c92:	985a                	add	a6,a6,s6
    80000c94:	87da                	mv	a5,s6
      if(*p == '\0'){
    80000c96:	41650633          	sub	a2,a0,s6
    80000c9a:	14fd                	addi	s1,s1,-1
    80000c9c:	9b26                	add	s6,s6,s1
    80000c9e:	00f60733          	add	a4,a2,a5
    80000ca2:	00074703          	lbu	a4,0(a4)
    80000ca6:	df49                	beqz	a4,80000c40 <copyinstr+0x26>
        *dst = *p;
    80000ca8:	00e78023          	sb	a4,0(a5)
      --max;
    80000cac:	40fb04b3          	sub	s1,s6,a5
      dst++;
    80000cb0:	0785                	addi	a5,a5,1
    while(n > 0){
    80000cb2:	ff0796e3          	bne	a5,a6,80000c9e <copyinstr+0x84>
      dst++;
    80000cb6:	8b42                	mv	s6,a6
    80000cb8:	b775                	j	80000c64 <copyinstr+0x4a>
    80000cba:	4781                	li	a5,0
    80000cbc:	b769                	j	80000c46 <copyinstr+0x2c>
      return -1;
    80000cbe:	557d                	li	a0,-1
    80000cc0:	b779                	j	80000c4e <copyinstr+0x34>
  int got_null = 0;
    80000cc2:	4781                	li	a5,0
  if(got_null){
    80000cc4:	0017b793          	seqz	a5,a5
    80000cc8:	40f00533          	neg	a0,a5
}
    80000ccc:	8082                	ret

0000000080000cce <madvise>:

/* NTU OS 2024 */
/* Map pages to physical memory or swap space. */
int madvise(uint64 base, uint64 len, int advice) {
    80000cce:	7179                	addi	sp,sp,-48
    80000cd0:	f406                	sd	ra,40(sp)
    80000cd2:	f022                	sd	s0,32(sp)
    80000cd4:	ec26                	sd	s1,24(sp)
    80000cd6:	e84a                	sd	s2,16(sp)
    80000cd8:	e44e                	sd	s3,8(sp)
    80000cda:	e052                	sd	s4,0(sp)
    80000cdc:	1800                	addi	s0,sp,48
    80000cde:	84aa                	mv	s1,a0
    80000ce0:	892e                	mv	s2,a1
    80000ce2:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80000ce4:	00000097          	auipc	ra,0x0
    80000ce8:	242080e7          	jalr	578(ra) # 80000f26 <myproc>
  pagetable_t pgtbl = p->pagetable;

  if (base > p->sz || (base + len) > p->sz) {
    80000cec:	6538                	ld	a4,72(a0)
    80000cee:	08976b63          	bltu	a4,s1,80000d84 <madvise+0xb6>
    80000cf2:	87aa                	mv	a5,a0
    80000cf4:	012486b3          	add	a3,s1,s2
    return -1;
    80000cf8:	557d                	li	a0,-1
  if (base > p->sz || (base + len) > p->sz) {
    80000cfa:	08d76663          	bltu	a4,a3,80000d86 <madvise+0xb8>
  }

  if (len == 0) {
    return 0;
    80000cfe:	4501                	li	a0,0
  if (len == 0) {
    80000d00:	08090363          	beqz	s2,80000d86 <madvise+0xb8>
  }

  uint64 begin = PGROUNDDOWN(base);
  uint64 last = PGROUNDDOWN(base + len - 1);

  if (advice == MADV_NORMAL) {
    80000d04:	0009871b          	sext.w	a4,s3
    80000d08:	4605                	li	a2,1
    80000d0a:	06e67e63          	bgeu	a2,a4,80000d86 <madvise+0xb8>
    // TODO
  } else if (advice == MADV_WILLNEED) {
    // TODO
  } else if (advice == MADV_DONTNEED) {
    80000d0e:	4609                	li	a2,2
    80000d10:	00c98663          	beq	s3,a2,80000d1c <madvise+0x4e>
      }
    }

    end_op();
    return 0;
  } else if(advice == MADV_PIN) {
    80000d14:	3775                	addiw	a4,a4,-3
    80000d16:	4785                	li	a5,1
    // TODO
  } else if(advice == MADV_UNPIN) {
    // TODO
  }
  else {
    return -1;
    80000d18:	557d                	li	a0,-1
    80000d1a:	a0b5                	j	80000d86 <madvise+0xb8>
  pagetable_t pgtbl = p->pagetable;
    80000d1c:	0507b983          	ld	s3,80(a5)
  uint64 begin = PGROUNDDOWN(base);
    80000d20:	797d                	lui	s2,0xfffff
    80000d22:	0124f4b3          	and	s1,s1,s2
  uint64 last = PGROUNDDOWN(base + len - 1);
    80000d26:	16fd                	addi	a3,a3,-1
    80000d28:	0126f933          	and	s2,a3,s2
    begin_op();
    80000d2c:	00003097          	auipc	ra,0x3
    80000d30:	a3a080e7          	jalr	-1478(ra) # 80003766 <begin_op>
    for (uint64 va = begin; va <= last; va += PGSIZE) {
    80000d34:	04996263          	bltu	s2,s1,80000d78 <madvise+0xaa>
    80000d38:	6a05                	lui	s4,0x1
    80000d3a:	a811                	j	80000d4e <madvise+0x80>
          end_op();
    80000d3c:	00003097          	auipc	ra,0x3
    80000d40:	aaa080e7          	jalr	-1366(ra) # 800037e6 <end_op>
          return -1;
    80000d44:	557d                	li	a0,-1
    80000d46:	a081                	j	80000d86 <madvise+0xb8>
    for (uint64 va = begin; va <= last; va += PGSIZE) {
    80000d48:	94d2                	add	s1,s1,s4
    80000d4a:	02996763          	bltu	s2,s1,80000d78 <madvise+0xaa>
      pte = walk(pgtbl, va, 0);
    80000d4e:	4601                	li	a2,0
    80000d50:	85a6                	mv	a1,s1
    80000d52:	854e                	mv	a0,s3
    80000d54:	fffff097          	auipc	ra,0xfffff
    80000d58:	70c080e7          	jalr	1804(ra) # 80000460 <walk>
      if (pte != 0 && (*pte & PTE_V)) {
    80000d5c:	d575                	beqz	a0,80000d48 <madvise+0x7a>
    80000d5e:	611c                	ld	a5,0(a0)
    80000d60:	8b85                	andi	a5,a5,1
    80000d62:	d3fd                	beqz	a5,80000d48 <madvise+0x7a>
        char *pa = (char*) swap_page_from_pte(pte);
    80000d64:	00005097          	auipc	ra,0x5
    80000d68:	bc2080e7          	jalr	-1086(ra) # 80005926 <swap_page_from_pte>
        if (pa == 0) {
    80000d6c:	d961                	beqz	a0,80000d3c <madvise+0x6e>
        kfree(pa);
    80000d6e:	fffff097          	auipc	ra,0xfffff
    80000d72:	2ae080e7          	jalr	686(ra) # 8000001c <kfree>
    80000d76:	bfc9                	j	80000d48 <madvise+0x7a>
    end_op();
    80000d78:	00003097          	auipc	ra,0x3
    80000d7c:	a6e080e7          	jalr	-1426(ra) # 800037e6 <end_op>
    return 0;
    80000d80:	4501                	li	a0,0
    80000d82:	a011                	j	80000d86 <madvise+0xb8>
    return -1;
    80000d84:	557d                	li	a0,-1
  }
}
    80000d86:	70a2                	ld	ra,40(sp)
    80000d88:	7402                	ld	s0,32(sp)
    80000d8a:	64e2                	ld	s1,24(sp)
    80000d8c:	6942                	ld	s2,16(sp)
    80000d8e:	69a2                	ld	s3,8(sp)
    80000d90:	6a02                	ld	s4,0(sp)
    80000d92:	6145                	addi	sp,sp,48
    80000d94:	8082                	ret

0000000080000d96 <vmprint>:
}
#endif

/* NTU OS 2024 */
/* Print multi layer page table. */
void vmprint(pagetable_t pagetable) {
    80000d96:	1141                	addi	sp,sp,-16
    80000d98:	e406                	sd	ra,8(sp)
    80000d9a:	e022                	sd	s0,0(sp)
    80000d9c:	0800                	addi	s0,sp,16
    80000d9e:	85aa                	mv	a1,a0
  /* TODO */
  printf("%p", pagetable);
    80000da0:	00007517          	auipc	a0,0x7
    80000da4:	3a050513          	addi	a0,a0,928 # 80008140 <etext+0x140>
    80000da8:	00005097          	auipc	ra,0x5
    80000dac:	1ea080e7          	jalr	490(ra) # 80005f92 <printf>
  // panic("not implemented yet\n");
}
    80000db0:	60a2                	ld	ra,8(sp)
    80000db2:	6402                	ld	s0,0(sp)
    80000db4:	0141                	addi	sp,sp,16
    80000db6:	8082                	ret

0000000080000db8 <proc_mapstacks>:

// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl) {
    80000db8:	7139                	addi	sp,sp,-64
    80000dba:	fc06                	sd	ra,56(sp)
    80000dbc:	f822                	sd	s0,48(sp)
    80000dbe:	f426                	sd	s1,40(sp)
    80000dc0:	f04a                	sd	s2,32(sp)
    80000dc2:	ec4e                	sd	s3,24(sp)
    80000dc4:	e852                	sd	s4,16(sp)
    80000dc6:	e456                	sd	s5,8(sp)
    80000dc8:	e05a                	sd	s6,0(sp)
    80000dca:	0080                	addi	s0,sp,64
    80000dcc:	89aa                	mv	s3,a0
  struct proc *p;
  for(p = proc; p < &proc[NPROC]; p++) {
    80000dce:	00008497          	auipc	s1,0x8
    80000dd2:	6b248493          	addi	s1,s1,1714 # 80009480 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80000dd6:	8b26                	mv	s6,s1
    80000dd8:	00007a97          	auipc	s5,0x7
    80000ddc:	228a8a93          	addi	s5,s5,552 # 80008000 <etext>
    80000de0:	01000937          	lui	s2,0x1000
    80000de4:	197d                	addi	s2,s2,-1
    80000de6:	093a                	slli	s2,s2,0xe
  for(p = proc; p < &proc[NPROC]; p++) {
    80000de8:	0000ea17          	auipc	s4,0xe
    80000dec:	098a0a13          	addi	s4,s4,152 # 8000ee80 <tickslock>
    char *pa = kalloc();
    80000df0:	fffff097          	auipc	ra,0xfffff
    80000df4:	328080e7          	jalr	808(ra) # 80000118 <kalloc>
    80000df8:	862a                	mv	a2,a0
    if(pa == 0)
    80000dfa:	c129                	beqz	a0,80000e3c <proc_mapstacks+0x84>
    uint64 va = KSTACK((int) (p - proc));
    80000dfc:	416485b3          	sub	a1,s1,s6
    80000e00:	858d                	srai	a1,a1,0x3
    80000e02:	000ab783          	ld	a5,0(s5)
    80000e06:	02f585b3          	mul	a1,a1,a5
    80000e0a:	00d5959b          	slliw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000e0e:	4719                	li	a4,6
    80000e10:	6685                	lui	a3,0x1
    80000e12:	40b905b3          	sub	a1,s2,a1
    80000e16:	854e                	mv	a0,s3
    80000e18:	fffff097          	auipc	ra,0xfffff
    80000e1c:	7d0080e7          	jalr	2000(ra) # 800005e8 <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000e20:	16848493          	addi	s1,s1,360
    80000e24:	fd4496e3          	bne	s1,s4,80000df0 <proc_mapstacks+0x38>
  }
}
    80000e28:	70e2                	ld	ra,56(sp)
    80000e2a:	7442                	ld	s0,48(sp)
    80000e2c:	74a2                	ld	s1,40(sp)
    80000e2e:	7902                	ld	s2,32(sp)
    80000e30:	69e2                	ld	s3,24(sp)
    80000e32:	6a42                	ld	s4,16(sp)
    80000e34:	6aa2                	ld	s5,8(sp)
    80000e36:	6b02                	ld	s6,0(sp)
    80000e38:	6121                	addi	sp,sp,64
    80000e3a:	8082                	ret
      panic("kalloc");
    80000e3c:	00007517          	auipc	a0,0x7
    80000e40:	30c50513          	addi	a0,a0,780 # 80008148 <etext+0x148>
    80000e44:	00005097          	auipc	ra,0x5
    80000e48:	104080e7          	jalr	260(ra) # 80005f48 <panic>

0000000080000e4c <procinit>:

// initialize the proc table at boot time.
void
procinit(void)
{
    80000e4c:	7139                	addi	sp,sp,-64
    80000e4e:	fc06                	sd	ra,56(sp)
    80000e50:	f822                	sd	s0,48(sp)
    80000e52:	f426                	sd	s1,40(sp)
    80000e54:	f04a                	sd	s2,32(sp)
    80000e56:	ec4e                	sd	s3,24(sp)
    80000e58:	e852                	sd	s4,16(sp)
    80000e5a:	e456                	sd	s5,8(sp)
    80000e5c:	e05a                	sd	s6,0(sp)
    80000e5e:	0080                	addi	s0,sp,64
  struct proc *p;
  initlock(&pid_lock, "nextpid");
    80000e60:	00007597          	auipc	a1,0x7
    80000e64:	2f058593          	addi	a1,a1,752 # 80008150 <etext+0x150>
    80000e68:	00008517          	auipc	a0,0x8
    80000e6c:	1e850513          	addi	a0,a0,488 # 80009050 <pid_lock>
    80000e70:	00005097          	auipc	ra,0x5
    80000e74:	592080e7          	jalr	1426(ra) # 80006402 <initlock>
  initlock(&wait_lock, "wait_lock");
    80000e78:	00007597          	auipc	a1,0x7
    80000e7c:	2e058593          	addi	a1,a1,736 # 80008158 <etext+0x158>
    80000e80:	00008517          	auipc	a0,0x8
    80000e84:	1e850513          	addi	a0,a0,488 # 80009068 <wait_lock>
    80000e88:	00005097          	auipc	ra,0x5
    80000e8c:	57a080e7          	jalr	1402(ra) # 80006402 <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000e90:	00008497          	auipc	s1,0x8
    80000e94:	5f048493          	addi	s1,s1,1520 # 80009480 <proc>
      initlock(&p->lock, "proc");
    80000e98:	00007b17          	auipc	s6,0x7
    80000e9c:	2d0b0b13          	addi	s6,s6,720 # 80008168 <etext+0x168>
      p->kstack = KSTACK((int) (p - proc));
    80000ea0:	8aa6                	mv	s5,s1
    80000ea2:	00007a17          	auipc	s4,0x7
    80000ea6:	15ea0a13          	addi	s4,s4,350 # 80008000 <etext>
    80000eaa:	01000937          	lui	s2,0x1000
    80000eae:	197d                	addi	s2,s2,-1
    80000eb0:	093a                	slli	s2,s2,0xe
  for(p = proc; p < &proc[NPROC]; p++) {
    80000eb2:	0000e997          	auipc	s3,0xe
    80000eb6:	fce98993          	addi	s3,s3,-50 # 8000ee80 <tickslock>
      initlock(&p->lock, "proc");
    80000eba:	85da                	mv	a1,s6
    80000ebc:	8526                	mv	a0,s1
    80000ebe:	00005097          	auipc	ra,0x5
    80000ec2:	544080e7          	jalr	1348(ra) # 80006402 <initlock>
      p->kstack = KSTACK((int) (p - proc));
    80000ec6:	415487b3          	sub	a5,s1,s5
    80000eca:	878d                	srai	a5,a5,0x3
    80000ecc:	000a3703          	ld	a4,0(s4)
    80000ed0:	02e787b3          	mul	a5,a5,a4
    80000ed4:	00d7979b          	slliw	a5,a5,0xd
    80000ed8:	40f907b3          	sub	a5,s2,a5
    80000edc:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80000ede:	16848493          	addi	s1,s1,360
    80000ee2:	fd349ce3          	bne	s1,s3,80000eba <procinit+0x6e>
  }
}
    80000ee6:	70e2                	ld	ra,56(sp)
    80000ee8:	7442                	ld	s0,48(sp)
    80000eea:	74a2                	ld	s1,40(sp)
    80000eec:	7902                	ld	s2,32(sp)
    80000eee:	69e2                	ld	s3,24(sp)
    80000ef0:	6a42                	ld	s4,16(sp)
    80000ef2:	6aa2                	ld	s5,8(sp)
    80000ef4:	6b02                	ld	s6,0(sp)
    80000ef6:	6121                	addi	sp,sp,64
    80000ef8:	8082                	ret

0000000080000efa <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80000efa:	1141                	addi	sp,sp,-16
    80000efc:	e422                	sd	s0,8(sp)
    80000efe:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80000f00:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    80000f02:	2501                	sext.w	a0,a0
    80000f04:	6422                	ld	s0,8(sp)
    80000f06:	0141                	addi	sp,sp,16
    80000f08:	8082                	ret

0000000080000f0a <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void) {
    80000f0a:	1141                	addi	sp,sp,-16
    80000f0c:	e422                	sd	s0,8(sp)
    80000f0e:	0800                	addi	s0,sp,16
    80000f10:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    80000f12:	2781                	sext.w	a5,a5
    80000f14:	079e                	slli	a5,a5,0x7
  return c;
}
    80000f16:	00008517          	auipc	a0,0x8
    80000f1a:	16a50513          	addi	a0,a0,362 # 80009080 <cpus>
    80000f1e:	953e                	add	a0,a0,a5
    80000f20:	6422                	ld	s0,8(sp)
    80000f22:	0141                	addi	sp,sp,16
    80000f24:	8082                	ret

0000000080000f26 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void) {
    80000f26:	1101                	addi	sp,sp,-32
    80000f28:	ec06                	sd	ra,24(sp)
    80000f2a:	e822                	sd	s0,16(sp)
    80000f2c:	e426                	sd	s1,8(sp)
    80000f2e:	1000                	addi	s0,sp,32
  push_off();
    80000f30:	00005097          	auipc	ra,0x5
    80000f34:	516080e7          	jalr	1302(ra) # 80006446 <push_off>
    80000f38:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80000f3a:	2781                	sext.w	a5,a5
    80000f3c:	079e                	slli	a5,a5,0x7
    80000f3e:	00008717          	auipc	a4,0x8
    80000f42:	11270713          	addi	a4,a4,274 # 80009050 <pid_lock>
    80000f46:	97ba                	add	a5,a5,a4
    80000f48:	7b84                	ld	s1,48(a5)
  pop_off();
    80000f4a:	00005097          	auipc	ra,0x5
    80000f4e:	59c080e7          	jalr	1436(ra) # 800064e6 <pop_off>
  return p;
}
    80000f52:	8526                	mv	a0,s1
    80000f54:	60e2                	ld	ra,24(sp)
    80000f56:	6442                	ld	s0,16(sp)
    80000f58:	64a2                	ld	s1,8(sp)
    80000f5a:	6105                	addi	sp,sp,32
    80000f5c:	8082                	ret

0000000080000f5e <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80000f5e:	1141                	addi	sp,sp,-16
    80000f60:	e406                	sd	ra,8(sp)
    80000f62:	e022                	sd	s0,0(sp)
    80000f64:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    80000f66:	00000097          	auipc	ra,0x0
    80000f6a:	fc0080e7          	jalr	-64(ra) # 80000f26 <myproc>
    80000f6e:	00005097          	auipc	ra,0x5
    80000f72:	5d8080e7          	jalr	1496(ra) # 80006546 <release>

  if (first) {
    80000f76:	00008797          	auipc	a5,0x8
    80000f7a:	99a7a783          	lw	a5,-1638(a5) # 80008910 <first.1768>
    80000f7e:	eb89                	bnez	a5,80000f90 <forkret+0x32>
    // be run from main().
    first = 0;
    fsinit(ROOTDEV);
  }

  usertrapret();
    80000f80:	00001097          	auipc	ra,0x1
    80000f84:	c0a080e7          	jalr	-1014(ra) # 80001b8a <usertrapret>
}
    80000f88:	60a2                	ld	ra,8(sp)
    80000f8a:	6402                	ld	s0,0(sp)
    80000f8c:	0141                	addi	sp,sp,16
    80000f8e:	8082                	ret
    first = 0;
    80000f90:	00008797          	auipc	a5,0x8
    80000f94:	9807a023          	sw	zero,-1664(a5) # 80008910 <first.1768>
    fsinit(ROOTDEV);
    80000f98:	4505                	li	a0,1
    80000f9a:	00002097          	auipc	ra,0x2
    80000f9e:	a0c080e7          	jalr	-1524(ra) # 800029a6 <fsinit>
    80000fa2:	bff9                	j	80000f80 <forkret+0x22>

0000000080000fa4 <allocpid>:
allocpid() {
    80000fa4:	1101                	addi	sp,sp,-32
    80000fa6:	ec06                	sd	ra,24(sp)
    80000fa8:	e822                	sd	s0,16(sp)
    80000faa:	e426                	sd	s1,8(sp)
    80000fac:	e04a                	sd	s2,0(sp)
    80000fae:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80000fb0:	00008917          	auipc	s2,0x8
    80000fb4:	0a090913          	addi	s2,s2,160 # 80009050 <pid_lock>
    80000fb8:	854a                	mv	a0,s2
    80000fba:	00005097          	auipc	ra,0x5
    80000fbe:	4d8080e7          	jalr	1240(ra) # 80006492 <acquire>
  pid = nextpid;
    80000fc2:	00008797          	auipc	a5,0x8
    80000fc6:	95278793          	addi	a5,a5,-1710 # 80008914 <nextpid>
    80000fca:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80000fcc:	0014871b          	addiw	a4,s1,1
    80000fd0:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80000fd2:	854a                	mv	a0,s2
    80000fd4:	00005097          	auipc	ra,0x5
    80000fd8:	572080e7          	jalr	1394(ra) # 80006546 <release>
}
    80000fdc:	8526                	mv	a0,s1
    80000fde:	60e2                	ld	ra,24(sp)
    80000fe0:	6442                	ld	s0,16(sp)
    80000fe2:	64a2                	ld	s1,8(sp)
    80000fe4:	6902                	ld	s2,0(sp)
    80000fe6:	6105                	addi	sp,sp,32
    80000fe8:	8082                	ret

0000000080000fea <proc_pagetable>:
{
    80000fea:	1101                	addi	sp,sp,-32
    80000fec:	ec06                	sd	ra,24(sp)
    80000fee:	e822                	sd	s0,16(sp)
    80000ff0:	e426                	sd	s1,8(sp)
    80000ff2:	e04a                	sd	s2,0(sp)
    80000ff4:	1000                	addi	s0,sp,32
    80000ff6:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80000ff8:	fffff097          	auipc	ra,0xfffff
    80000ffc:	7d2080e7          	jalr	2002(ra) # 800007ca <uvmcreate>
    80001000:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80001002:	c121                	beqz	a0,80001042 <proc_pagetable+0x58>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80001004:	4729                	li	a4,10
    80001006:	00006697          	auipc	a3,0x6
    8000100a:	ffa68693          	addi	a3,a3,-6 # 80007000 <_trampoline>
    8000100e:	6605                	lui	a2,0x1
    80001010:	040005b7          	lui	a1,0x4000
    80001014:	15fd                	addi	a1,a1,-1
    80001016:	05b2                	slli	a1,a1,0xc
    80001018:	fffff097          	auipc	ra,0xfffff
    8000101c:	530080e7          	jalr	1328(ra) # 80000548 <mappages>
    80001020:	02054863          	bltz	a0,80001050 <proc_pagetable+0x66>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80001024:	4719                	li	a4,6
    80001026:	05893683          	ld	a3,88(s2)
    8000102a:	6605                	lui	a2,0x1
    8000102c:	020005b7          	lui	a1,0x2000
    80001030:	15fd                	addi	a1,a1,-1
    80001032:	05b6                	slli	a1,a1,0xd
    80001034:	8526                	mv	a0,s1
    80001036:	fffff097          	auipc	ra,0xfffff
    8000103a:	512080e7          	jalr	1298(ra) # 80000548 <mappages>
    8000103e:	02054163          	bltz	a0,80001060 <proc_pagetable+0x76>
}
    80001042:	8526                	mv	a0,s1
    80001044:	60e2                	ld	ra,24(sp)
    80001046:	6442                	ld	s0,16(sp)
    80001048:	64a2                	ld	s1,8(sp)
    8000104a:	6902                	ld	s2,0(sp)
    8000104c:	6105                	addi	sp,sp,32
    8000104e:	8082                	ret
    uvmfree(pagetable, 0);
    80001050:	4581                	li	a1,0
    80001052:	8526                	mv	a0,s1
    80001054:	00000097          	auipc	ra,0x0
    80001058:	972080e7          	jalr	-1678(ra) # 800009c6 <uvmfree>
    return 0;
    8000105c:	4481                	li	s1,0
    8000105e:	b7d5                	j	80001042 <proc_pagetable+0x58>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001060:	4681                	li	a3,0
    80001062:	4605                	li	a2,1
    80001064:	040005b7          	lui	a1,0x4000
    80001068:	15fd                	addi	a1,a1,-1
    8000106a:	05b2                	slli	a1,a1,0xc
    8000106c:	8526                	mv	a0,s1
    8000106e:	fffff097          	auipc	ra,0xfffff
    80001072:	6a0080e7          	jalr	1696(ra) # 8000070e <uvmunmap>
    uvmfree(pagetable, 0);
    80001076:	4581                	li	a1,0
    80001078:	8526                	mv	a0,s1
    8000107a:	00000097          	auipc	ra,0x0
    8000107e:	94c080e7          	jalr	-1716(ra) # 800009c6 <uvmfree>
    return 0;
    80001082:	4481                	li	s1,0
    80001084:	bf7d                	j	80001042 <proc_pagetable+0x58>

0000000080001086 <proc_freepagetable>:
{
    80001086:	1101                	addi	sp,sp,-32
    80001088:	ec06                	sd	ra,24(sp)
    8000108a:	e822                	sd	s0,16(sp)
    8000108c:	e426                	sd	s1,8(sp)
    8000108e:	e04a                	sd	s2,0(sp)
    80001090:	1000                	addi	s0,sp,32
    80001092:	84aa                	mv	s1,a0
    80001094:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001096:	4681                	li	a3,0
    80001098:	4605                	li	a2,1
    8000109a:	040005b7          	lui	a1,0x4000
    8000109e:	15fd                	addi	a1,a1,-1
    800010a0:	05b2                	slli	a1,a1,0xc
    800010a2:	fffff097          	auipc	ra,0xfffff
    800010a6:	66c080e7          	jalr	1644(ra) # 8000070e <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    800010aa:	4681                	li	a3,0
    800010ac:	4605                	li	a2,1
    800010ae:	020005b7          	lui	a1,0x2000
    800010b2:	15fd                	addi	a1,a1,-1
    800010b4:	05b6                	slli	a1,a1,0xd
    800010b6:	8526                	mv	a0,s1
    800010b8:	fffff097          	auipc	ra,0xfffff
    800010bc:	656080e7          	jalr	1622(ra) # 8000070e <uvmunmap>
  uvmfree(pagetable, sz);
    800010c0:	85ca                	mv	a1,s2
    800010c2:	8526                	mv	a0,s1
    800010c4:	00000097          	auipc	ra,0x0
    800010c8:	902080e7          	jalr	-1790(ra) # 800009c6 <uvmfree>
}
    800010cc:	60e2                	ld	ra,24(sp)
    800010ce:	6442                	ld	s0,16(sp)
    800010d0:	64a2                	ld	s1,8(sp)
    800010d2:	6902                	ld	s2,0(sp)
    800010d4:	6105                	addi	sp,sp,32
    800010d6:	8082                	ret

00000000800010d8 <freeproc>:
{
    800010d8:	1101                	addi	sp,sp,-32
    800010da:	ec06                	sd	ra,24(sp)
    800010dc:	e822                	sd	s0,16(sp)
    800010de:	e426                	sd	s1,8(sp)
    800010e0:	1000                	addi	s0,sp,32
    800010e2:	84aa                	mv	s1,a0
  if(p->trapframe)
    800010e4:	6d28                	ld	a0,88(a0)
    800010e6:	c509                	beqz	a0,800010f0 <freeproc+0x18>
    kfree((void*)p->trapframe);
    800010e8:	fffff097          	auipc	ra,0xfffff
    800010ec:	f34080e7          	jalr	-204(ra) # 8000001c <kfree>
  p->trapframe = 0;
    800010f0:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    800010f4:	68a8                	ld	a0,80(s1)
    800010f6:	c511                	beqz	a0,80001102 <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    800010f8:	64ac                	ld	a1,72(s1)
    800010fa:	00000097          	auipc	ra,0x0
    800010fe:	f8c080e7          	jalr	-116(ra) # 80001086 <proc_freepagetable>
  p->pagetable = 0;
    80001102:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    80001106:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    8000110a:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    8000110e:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    80001112:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    80001116:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    8000111a:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    8000111e:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    80001122:	0004ac23          	sw	zero,24(s1)
}
    80001126:	60e2                	ld	ra,24(sp)
    80001128:	6442                	ld	s0,16(sp)
    8000112a:	64a2                	ld	s1,8(sp)
    8000112c:	6105                	addi	sp,sp,32
    8000112e:	8082                	ret

0000000080001130 <allocproc>:
{
    80001130:	1101                	addi	sp,sp,-32
    80001132:	ec06                	sd	ra,24(sp)
    80001134:	e822                	sd	s0,16(sp)
    80001136:	e426                	sd	s1,8(sp)
    80001138:	e04a                	sd	s2,0(sp)
    8000113a:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    8000113c:	00008497          	auipc	s1,0x8
    80001140:	34448493          	addi	s1,s1,836 # 80009480 <proc>
    80001144:	0000e917          	auipc	s2,0xe
    80001148:	d3c90913          	addi	s2,s2,-708 # 8000ee80 <tickslock>
    acquire(&p->lock);
    8000114c:	8526                	mv	a0,s1
    8000114e:	00005097          	auipc	ra,0x5
    80001152:	344080e7          	jalr	836(ra) # 80006492 <acquire>
    if(p->state == UNUSED) {
    80001156:	4c9c                	lw	a5,24(s1)
    80001158:	cf81                	beqz	a5,80001170 <allocproc+0x40>
      release(&p->lock);
    8000115a:	8526                	mv	a0,s1
    8000115c:	00005097          	auipc	ra,0x5
    80001160:	3ea080e7          	jalr	1002(ra) # 80006546 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001164:	16848493          	addi	s1,s1,360
    80001168:	ff2492e3          	bne	s1,s2,8000114c <allocproc+0x1c>
  return 0;
    8000116c:	4481                	li	s1,0
    8000116e:	a889                	j	800011c0 <allocproc+0x90>
  p->pid = allocpid();
    80001170:	00000097          	auipc	ra,0x0
    80001174:	e34080e7          	jalr	-460(ra) # 80000fa4 <allocpid>
    80001178:	d888                	sw	a0,48(s1)
  p->state = USED;
    8000117a:	4785                	li	a5,1
    8000117c:	cc9c                	sw	a5,24(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    8000117e:	fffff097          	auipc	ra,0xfffff
    80001182:	f9a080e7          	jalr	-102(ra) # 80000118 <kalloc>
    80001186:	892a                	mv	s2,a0
    80001188:	eca8                	sd	a0,88(s1)
    8000118a:	c131                	beqz	a0,800011ce <allocproc+0x9e>
  p->pagetable = proc_pagetable(p);
    8000118c:	8526                	mv	a0,s1
    8000118e:	00000097          	auipc	ra,0x0
    80001192:	e5c080e7          	jalr	-420(ra) # 80000fea <proc_pagetable>
    80001196:	892a                	mv	s2,a0
    80001198:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    8000119a:	c531                	beqz	a0,800011e6 <allocproc+0xb6>
  memset(&p->context, 0, sizeof(p->context));
    8000119c:	07000613          	li	a2,112
    800011a0:	4581                	li	a1,0
    800011a2:	06048513          	addi	a0,s1,96
    800011a6:	fffff097          	auipc	ra,0xfffff
    800011aa:	fd2080e7          	jalr	-46(ra) # 80000178 <memset>
  p->context.ra = (uint64)forkret;
    800011ae:	00000797          	auipc	a5,0x0
    800011b2:	db078793          	addi	a5,a5,-592 # 80000f5e <forkret>
    800011b6:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    800011b8:	60bc                	ld	a5,64(s1)
    800011ba:	6705                	lui	a4,0x1
    800011bc:	97ba                	add	a5,a5,a4
    800011be:	f4bc                	sd	a5,104(s1)
}
    800011c0:	8526                	mv	a0,s1
    800011c2:	60e2                	ld	ra,24(sp)
    800011c4:	6442                	ld	s0,16(sp)
    800011c6:	64a2                	ld	s1,8(sp)
    800011c8:	6902                	ld	s2,0(sp)
    800011ca:	6105                	addi	sp,sp,32
    800011cc:	8082                	ret
    freeproc(p);
    800011ce:	8526                	mv	a0,s1
    800011d0:	00000097          	auipc	ra,0x0
    800011d4:	f08080e7          	jalr	-248(ra) # 800010d8 <freeproc>
    release(&p->lock);
    800011d8:	8526                	mv	a0,s1
    800011da:	00005097          	auipc	ra,0x5
    800011de:	36c080e7          	jalr	876(ra) # 80006546 <release>
    return 0;
    800011e2:	84ca                	mv	s1,s2
    800011e4:	bff1                	j	800011c0 <allocproc+0x90>
    freeproc(p);
    800011e6:	8526                	mv	a0,s1
    800011e8:	00000097          	auipc	ra,0x0
    800011ec:	ef0080e7          	jalr	-272(ra) # 800010d8 <freeproc>
    release(&p->lock);
    800011f0:	8526                	mv	a0,s1
    800011f2:	00005097          	auipc	ra,0x5
    800011f6:	354080e7          	jalr	852(ra) # 80006546 <release>
    return 0;
    800011fa:	84ca                	mv	s1,s2
    800011fc:	b7d1                	j	800011c0 <allocproc+0x90>

00000000800011fe <userinit>:
{
    800011fe:	1101                	addi	sp,sp,-32
    80001200:	ec06                	sd	ra,24(sp)
    80001202:	e822                	sd	s0,16(sp)
    80001204:	e426                	sd	s1,8(sp)
    80001206:	1000                	addi	s0,sp,32
  p = allocproc();
    80001208:	00000097          	auipc	ra,0x0
    8000120c:	f28080e7          	jalr	-216(ra) # 80001130 <allocproc>
    80001210:	84aa                	mv	s1,a0
  initproc = p;
    80001212:	00008797          	auipc	a5,0x8
    80001216:	dea7bf23          	sd	a0,-514(a5) # 80009010 <initproc>
  uvminit(p->pagetable, initcode, sizeof(initcode));
    8000121a:	03400613          	li	a2,52
    8000121e:	00007597          	auipc	a1,0x7
    80001222:	70258593          	addi	a1,a1,1794 # 80008920 <initcode>
    80001226:	6928                	ld	a0,80(a0)
    80001228:	fffff097          	auipc	ra,0xfffff
    8000122c:	5d0080e7          	jalr	1488(ra) # 800007f8 <uvminit>
  p->sz = PGSIZE;
    80001230:	6785                	lui	a5,0x1
    80001232:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;      // user program counter
    80001234:	6cb8                	ld	a4,88(s1)
    80001236:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    8000123a:	6cb8                	ld	a4,88(s1)
    8000123c:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    8000123e:	4641                	li	a2,16
    80001240:	00007597          	auipc	a1,0x7
    80001244:	f3058593          	addi	a1,a1,-208 # 80008170 <etext+0x170>
    80001248:	15848513          	addi	a0,s1,344
    8000124c:	fffff097          	auipc	ra,0xfffff
    80001250:	07e080e7          	jalr	126(ra) # 800002ca <safestrcpy>
  p->cwd = namei("/");
    80001254:	00007517          	auipc	a0,0x7
    80001258:	f2c50513          	addi	a0,a0,-212 # 80008180 <etext+0x180>
    8000125c:	00002097          	auipc	ra,0x2
    80001260:	15c080e7          	jalr	348(ra) # 800033b8 <namei>
    80001264:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    80001268:	478d                	li	a5,3
    8000126a:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    8000126c:	8526                	mv	a0,s1
    8000126e:	00005097          	auipc	ra,0x5
    80001272:	2d8080e7          	jalr	728(ra) # 80006546 <release>
}
    80001276:	60e2                	ld	ra,24(sp)
    80001278:	6442                	ld	s0,16(sp)
    8000127a:	64a2                	ld	s1,8(sp)
    8000127c:	6105                	addi	sp,sp,32
    8000127e:	8082                	ret

0000000080001280 <growproc>:
{
    80001280:	1101                	addi	sp,sp,-32
    80001282:	ec06                	sd	ra,24(sp)
    80001284:	e822                	sd	s0,16(sp)
    80001286:	e426                	sd	s1,8(sp)
    80001288:	e04a                	sd	s2,0(sp)
    8000128a:	1000                	addi	s0,sp,32
    8000128c:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    8000128e:	00000097          	auipc	ra,0x0
    80001292:	c98080e7          	jalr	-872(ra) # 80000f26 <myproc>
    80001296:	892a                	mv	s2,a0
  sz = p->sz;
    80001298:	652c                	ld	a1,72(a0)
    8000129a:	0005861b          	sext.w	a2,a1
  if(n > 0){
    8000129e:	00904f63          	bgtz	s1,800012bc <growproc+0x3c>
  } else if(n < 0){
    800012a2:	0204cc63          	bltz	s1,800012da <growproc+0x5a>
  p->sz = sz;
    800012a6:	1602                	slli	a2,a2,0x20
    800012a8:	9201                	srli	a2,a2,0x20
    800012aa:	04c93423          	sd	a2,72(s2)
  return 0;
    800012ae:	4501                	li	a0,0
}
    800012b0:	60e2                	ld	ra,24(sp)
    800012b2:	6442                	ld	s0,16(sp)
    800012b4:	64a2                	ld	s1,8(sp)
    800012b6:	6902                	ld	s2,0(sp)
    800012b8:	6105                	addi	sp,sp,32
    800012ba:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    800012bc:	9e25                	addw	a2,a2,s1
    800012be:	1602                	slli	a2,a2,0x20
    800012c0:	9201                	srli	a2,a2,0x20
    800012c2:	1582                	slli	a1,a1,0x20
    800012c4:	9181                	srli	a1,a1,0x20
    800012c6:	6928                	ld	a0,80(a0)
    800012c8:	fffff097          	auipc	ra,0xfffff
    800012cc:	5ea080e7          	jalr	1514(ra) # 800008b2 <uvmalloc>
    800012d0:	0005061b          	sext.w	a2,a0
    800012d4:	fa69                	bnez	a2,800012a6 <growproc+0x26>
      return -1;
    800012d6:	557d                	li	a0,-1
    800012d8:	bfe1                	j	800012b0 <growproc+0x30>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    800012da:	9e25                	addw	a2,a2,s1
    800012dc:	1602                	slli	a2,a2,0x20
    800012de:	9201                	srli	a2,a2,0x20
    800012e0:	1582                	slli	a1,a1,0x20
    800012e2:	9181                	srli	a1,a1,0x20
    800012e4:	6928                	ld	a0,80(a0)
    800012e6:	fffff097          	auipc	ra,0xfffff
    800012ea:	584080e7          	jalr	1412(ra) # 8000086a <uvmdealloc>
    800012ee:	0005061b          	sext.w	a2,a0
    800012f2:	bf55                	j	800012a6 <growproc+0x26>

00000000800012f4 <fork>:
{
    800012f4:	7179                	addi	sp,sp,-48
    800012f6:	f406                	sd	ra,40(sp)
    800012f8:	f022                	sd	s0,32(sp)
    800012fa:	ec26                	sd	s1,24(sp)
    800012fc:	e84a                	sd	s2,16(sp)
    800012fe:	e44e                	sd	s3,8(sp)
    80001300:	e052                	sd	s4,0(sp)
    80001302:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80001304:	00000097          	auipc	ra,0x0
    80001308:	c22080e7          	jalr	-990(ra) # 80000f26 <myproc>
    8000130c:	892a                	mv	s2,a0
  if((np = allocproc()) == 0){
    8000130e:	00000097          	auipc	ra,0x0
    80001312:	e22080e7          	jalr	-478(ra) # 80001130 <allocproc>
    80001316:	10050b63          	beqz	a0,8000142c <fork+0x138>
    8000131a:	89aa                	mv	s3,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    8000131c:	04893603          	ld	a2,72(s2)
    80001320:	692c                	ld	a1,80(a0)
    80001322:	05093503          	ld	a0,80(s2)
    80001326:	fffff097          	auipc	ra,0xfffff
    8000132a:	6d8080e7          	jalr	1752(ra) # 800009fe <uvmcopy>
    8000132e:	04054663          	bltz	a0,8000137a <fork+0x86>
  np->sz = p->sz;
    80001332:	04893783          	ld	a5,72(s2)
    80001336:	04f9b423          	sd	a5,72(s3)
  *(np->trapframe) = *(p->trapframe);
    8000133a:	05893683          	ld	a3,88(s2)
    8000133e:	87b6                	mv	a5,a3
    80001340:	0589b703          	ld	a4,88(s3)
    80001344:	12068693          	addi	a3,a3,288
    80001348:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    8000134c:	6788                	ld	a0,8(a5)
    8000134e:	6b8c                	ld	a1,16(a5)
    80001350:	6f90                	ld	a2,24(a5)
    80001352:	01073023          	sd	a6,0(a4)
    80001356:	e708                	sd	a0,8(a4)
    80001358:	eb0c                	sd	a1,16(a4)
    8000135a:	ef10                	sd	a2,24(a4)
    8000135c:	02078793          	addi	a5,a5,32
    80001360:	02070713          	addi	a4,a4,32
    80001364:	fed792e3          	bne	a5,a3,80001348 <fork+0x54>
  np->trapframe->a0 = 0;
    80001368:	0589b783          	ld	a5,88(s3)
    8000136c:	0607b823          	sd	zero,112(a5)
    80001370:	0d000493          	li	s1,208
  for(i = 0; i < NOFILE; i++)
    80001374:	15000a13          	li	s4,336
    80001378:	a03d                	j	800013a6 <fork+0xb2>
    freeproc(np);
    8000137a:	854e                	mv	a0,s3
    8000137c:	00000097          	auipc	ra,0x0
    80001380:	d5c080e7          	jalr	-676(ra) # 800010d8 <freeproc>
    release(&np->lock);
    80001384:	854e                	mv	a0,s3
    80001386:	00005097          	auipc	ra,0x5
    8000138a:	1c0080e7          	jalr	448(ra) # 80006546 <release>
    return -1;
    8000138e:	5a7d                	li	s4,-1
    80001390:	a069                	j	8000141a <fork+0x126>
      np->ofile[i] = filedup(p->ofile[i]);
    80001392:	00003097          	auipc	ra,0x3
    80001396:	84e080e7          	jalr	-1970(ra) # 80003be0 <filedup>
    8000139a:	009987b3          	add	a5,s3,s1
    8000139e:	e388                	sd	a0,0(a5)
  for(i = 0; i < NOFILE; i++)
    800013a0:	04a1                	addi	s1,s1,8
    800013a2:	01448763          	beq	s1,s4,800013b0 <fork+0xbc>
    if(p->ofile[i])
    800013a6:	009907b3          	add	a5,s2,s1
    800013aa:	6388                	ld	a0,0(a5)
    800013ac:	f17d                	bnez	a0,80001392 <fork+0x9e>
    800013ae:	bfcd                	j	800013a0 <fork+0xac>
  np->cwd = idup(p->cwd);
    800013b0:	15093503          	ld	a0,336(s2)
    800013b4:	00002097          	auipc	ra,0x2
    800013b8:	81a080e7          	jalr	-2022(ra) # 80002bce <idup>
    800013bc:	14a9b823          	sd	a0,336(s3)
  safestrcpy(np->name, p->name, sizeof(p->name));
    800013c0:	4641                	li	a2,16
    800013c2:	15890593          	addi	a1,s2,344
    800013c6:	15898513          	addi	a0,s3,344
    800013ca:	fffff097          	auipc	ra,0xfffff
    800013ce:	f00080e7          	jalr	-256(ra) # 800002ca <safestrcpy>
  pid = np->pid;
    800013d2:	0309aa03          	lw	s4,48(s3)
  release(&np->lock);
    800013d6:	854e                	mv	a0,s3
    800013d8:	00005097          	auipc	ra,0x5
    800013dc:	16e080e7          	jalr	366(ra) # 80006546 <release>
  acquire(&wait_lock);
    800013e0:	00008497          	auipc	s1,0x8
    800013e4:	c8848493          	addi	s1,s1,-888 # 80009068 <wait_lock>
    800013e8:	8526                	mv	a0,s1
    800013ea:	00005097          	auipc	ra,0x5
    800013ee:	0a8080e7          	jalr	168(ra) # 80006492 <acquire>
  np->parent = p;
    800013f2:	0329bc23          	sd	s2,56(s3)
  release(&wait_lock);
    800013f6:	8526                	mv	a0,s1
    800013f8:	00005097          	auipc	ra,0x5
    800013fc:	14e080e7          	jalr	334(ra) # 80006546 <release>
  acquire(&np->lock);
    80001400:	854e                	mv	a0,s3
    80001402:	00005097          	auipc	ra,0x5
    80001406:	090080e7          	jalr	144(ra) # 80006492 <acquire>
  np->state = RUNNABLE;
    8000140a:	478d                	li	a5,3
    8000140c:	00f9ac23          	sw	a5,24(s3)
  release(&np->lock);
    80001410:	854e                	mv	a0,s3
    80001412:	00005097          	auipc	ra,0x5
    80001416:	134080e7          	jalr	308(ra) # 80006546 <release>
}
    8000141a:	8552                	mv	a0,s4
    8000141c:	70a2                	ld	ra,40(sp)
    8000141e:	7402                	ld	s0,32(sp)
    80001420:	64e2                	ld	s1,24(sp)
    80001422:	6942                	ld	s2,16(sp)
    80001424:	69a2                	ld	s3,8(sp)
    80001426:	6a02                	ld	s4,0(sp)
    80001428:	6145                	addi	sp,sp,48
    8000142a:	8082                	ret
    return -1;
    8000142c:	5a7d                	li	s4,-1
    8000142e:	b7f5                	j	8000141a <fork+0x126>

0000000080001430 <scheduler>:
{
    80001430:	7139                	addi	sp,sp,-64
    80001432:	fc06                	sd	ra,56(sp)
    80001434:	f822                	sd	s0,48(sp)
    80001436:	f426                	sd	s1,40(sp)
    80001438:	f04a                	sd	s2,32(sp)
    8000143a:	ec4e                	sd	s3,24(sp)
    8000143c:	e852                	sd	s4,16(sp)
    8000143e:	e456                	sd	s5,8(sp)
    80001440:	e05a                	sd	s6,0(sp)
    80001442:	0080                	addi	s0,sp,64
    80001444:	8792                	mv	a5,tp
  int id = r_tp();
    80001446:	2781                	sext.w	a5,a5
  c->proc = 0;
    80001448:	00779a93          	slli	s5,a5,0x7
    8000144c:	00008717          	auipc	a4,0x8
    80001450:	c0470713          	addi	a4,a4,-1020 # 80009050 <pid_lock>
    80001454:	9756                	add	a4,a4,s5
    80001456:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    8000145a:	00008717          	auipc	a4,0x8
    8000145e:	c2e70713          	addi	a4,a4,-978 # 80009088 <cpus+0x8>
    80001462:	9aba                	add	s5,s5,a4
      if(p->state == RUNNABLE) {
    80001464:	498d                	li	s3,3
        p->state = RUNNING;
    80001466:	4b11                	li	s6,4
        c->proc = p;
    80001468:	079e                	slli	a5,a5,0x7
    8000146a:	00008a17          	auipc	s4,0x8
    8000146e:	be6a0a13          	addi	s4,s4,-1050 # 80009050 <pid_lock>
    80001472:	9a3e                	add	s4,s4,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    80001474:	0000e917          	auipc	s2,0xe
    80001478:	a0c90913          	addi	s2,s2,-1524 # 8000ee80 <tickslock>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000147c:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001480:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001484:	10079073          	csrw	sstatus,a5
    80001488:	00008497          	auipc	s1,0x8
    8000148c:	ff848493          	addi	s1,s1,-8 # 80009480 <proc>
    80001490:	a03d                	j	800014be <scheduler+0x8e>
        p->state = RUNNING;
    80001492:	0164ac23          	sw	s6,24(s1)
        c->proc = p;
    80001496:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    8000149a:	06048593          	addi	a1,s1,96
    8000149e:	8556                	mv	a0,s5
    800014a0:	00000097          	auipc	ra,0x0
    800014a4:	640080e7          	jalr	1600(ra) # 80001ae0 <swtch>
        c->proc = 0;
    800014a8:	020a3823          	sd	zero,48(s4)
      release(&p->lock);
    800014ac:	8526                	mv	a0,s1
    800014ae:	00005097          	auipc	ra,0x5
    800014b2:	098080e7          	jalr	152(ra) # 80006546 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    800014b6:	16848493          	addi	s1,s1,360
    800014ba:	fd2481e3          	beq	s1,s2,8000147c <scheduler+0x4c>
      acquire(&p->lock);
    800014be:	8526                	mv	a0,s1
    800014c0:	00005097          	auipc	ra,0x5
    800014c4:	fd2080e7          	jalr	-46(ra) # 80006492 <acquire>
      if(p->state == RUNNABLE) {
    800014c8:	4c9c                	lw	a5,24(s1)
    800014ca:	ff3791e3          	bne	a5,s3,800014ac <scheduler+0x7c>
    800014ce:	b7d1                	j	80001492 <scheduler+0x62>

00000000800014d0 <sched>:
{
    800014d0:	7179                	addi	sp,sp,-48
    800014d2:	f406                	sd	ra,40(sp)
    800014d4:	f022                	sd	s0,32(sp)
    800014d6:	ec26                	sd	s1,24(sp)
    800014d8:	e84a                	sd	s2,16(sp)
    800014da:	e44e                	sd	s3,8(sp)
    800014dc:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    800014de:	00000097          	auipc	ra,0x0
    800014e2:	a48080e7          	jalr	-1464(ra) # 80000f26 <myproc>
    800014e6:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    800014e8:	00005097          	auipc	ra,0x5
    800014ec:	f30080e7          	jalr	-208(ra) # 80006418 <holding>
    800014f0:	c93d                	beqz	a0,80001566 <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    800014f2:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    800014f4:	2781                	sext.w	a5,a5
    800014f6:	079e                	slli	a5,a5,0x7
    800014f8:	00008717          	auipc	a4,0x8
    800014fc:	b5870713          	addi	a4,a4,-1192 # 80009050 <pid_lock>
    80001500:	97ba                	add	a5,a5,a4
    80001502:	0a87a703          	lw	a4,168(a5)
    80001506:	4785                	li	a5,1
    80001508:	06f71763          	bne	a4,a5,80001576 <sched+0xa6>
  if(p->state == RUNNING)
    8000150c:	4c98                	lw	a4,24(s1)
    8000150e:	4791                	li	a5,4
    80001510:	06f70b63          	beq	a4,a5,80001586 <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001514:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001518:	8b89                	andi	a5,a5,2
  if(intr_get())
    8000151a:	efb5                	bnez	a5,80001596 <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    8000151c:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    8000151e:	00008917          	auipc	s2,0x8
    80001522:	b3290913          	addi	s2,s2,-1230 # 80009050 <pid_lock>
    80001526:	2781                	sext.w	a5,a5
    80001528:	079e                	slli	a5,a5,0x7
    8000152a:	97ca                	add	a5,a5,s2
    8000152c:	0ac7a983          	lw	s3,172(a5)
    80001530:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    80001532:	2781                	sext.w	a5,a5
    80001534:	079e                	slli	a5,a5,0x7
    80001536:	00008597          	auipc	a1,0x8
    8000153a:	b5258593          	addi	a1,a1,-1198 # 80009088 <cpus+0x8>
    8000153e:	95be                	add	a1,a1,a5
    80001540:	06048513          	addi	a0,s1,96
    80001544:	00000097          	auipc	ra,0x0
    80001548:	59c080e7          	jalr	1436(ra) # 80001ae0 <swtch>
    8000154c:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    8000154e:	2781                	sext.w	a5,a5
    80001550:	079e                	slli	a5,a5,0x7
    80001552:	97ca                	add	a5,a5,s2
    80001554:	0b37a623          	sw	s3,172(a5)
}
    80001558:	70a2                	ld	ra,40(sp)
    8000155a:	7402                	ld	s0,32(sp)
    8000155c:	64e2                	ld	s1,24(sp)
    8000155e:	6942                	ld	s2,16(sp)
    80001560:	69a2                	ld	s3,8(sp)
    80001562:	6145                	addi	sp,sp,48
    80001564:	8082                	ret
    panic("sched p->lock");
    80001566:	00007517          	auipc	a0,0x7
    8000156a:	c2250513          	addi	a0,a0,-990 # 80008188 <etext+0x188>
    8000156e:	00005097          	auipc	ra,0x5
    80001572:	9da080e7          	jalr	-1574(ra) # 80005f48 <panic>
    panic("sched locks");
    80001576:	00007517          	auipc	a0,0x7
    8000157a:	c2250513          	addi	a0,a0,-990 # 80008198 <etext+0x198>
    8000157e:	00005097          	auipc	ra,0x5
    80001582:	9ca080e7          	jalr	-1590(ra) # 80005f48 <panic>
    panic("sched running");
    80001586:	00007517          	auipc	a0,0x7
    8000158a:	c2250513          	addi	a0,a0,-990 # 800081a8 <etext+0x1a8>
    8000158e:	00005097          	auipc	ra,0x5
    80001592:	9ba080e7          	jalr	-1606(ra) # 80005f48 <panic>
    panic("sched interruptible");
    80001596:	00007517          	auipc	a0,0x7
    8000159a:	c2250513          	addi	a0,a0,-990 # 800081b8 <etext+0x1b8>
    8000159e:	00005097          	auipc	ra,0x5
    800015a2:	9aa080e7          	jalr	-1622(ra) # 80005f48 <panic>

00000000800015a6 <yield>:
{
    800015a6:	1101                	addi	sp,sp,-32
    800015a8:	ec06                	sd	ra,24(sp)
    800015aa:	e822                	sd	s0,16(sp)
    800015ac:	e426                	sd	s1,8(sp)
    800015ae:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    800015b0:	00000097          	auipc	ra,0x0
    800015b4:	976080e7          	jalr	-1674(ra) # 80000f26 <myproc>
    800015b8:	84aa                	mv	s1,a0
  acquire(&p->lock);
    800015ba:	00005097          	auipc	ra,0x5
    800015be:	ed8080e7          	jalr	-296(ra) # 80006492 <acquire>
  p->state = RUNNABLE;
    800015c2:	478d                	li	a5,3
    800015c4:	cc9c                	sw	a5,24(s1)
  sched();
    800015c6:	00000097          	auipc	ra,0x0
    800015ca:	f0a080e7          	jalr	-246(ra) # 800014d0 <sched>
  release(&p->lock);
    800015ce:	8526                	mv	a0,s1
    800015d0:	00005097          	auipc	ra,0x5
    800015d4:	f76080e7          	jalr	-138(ra) # 80006546 <release>
}
    800015d8:	60e2                	ld	ra,24(sp)
    800015da:	6442                	ld	s0,16(sp)
    800015dc:	64a2                	ld	s1,8(sp)
    800015de:	6105                	addi	sp,sp,32
    800015e0:	8082                	ret

00000000800015e2 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    800015e2:	7179                	addi	sp,sp,-48
    800015e4:	f406                	sd	ra,40(sp)
    800015e6:	f022                	sd	s0,32(sp)
    800015e8:	ec26                	sd	s1,24(sp)
    800015ea:	e84a                	sd	s2,16(sp)
    800015ec:	e44e                	sd	s3,8(sp)
    800015ee:	1800                	addi	s0,sp,48
    800015f0:	89aa                	mv	s3,a0
    800015f2:	892e                	mv	s2,a1
  struct proc *p = myproc();
    800015f4:	00000097          	auipc	ra,0x0
    800015f8:	932080e7          	jalr	-1742(ra) # 80000f26 <myproc>
    800015fc:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    800015fe:	00005097          	auipc	ra,0x5
    80001602:	e94080e7          	jalr	-364(ra) # 80006492 <acquire>
  release(lk);
    80001606:	854a                	mv	a0,s2
    80001608:	00005097          	auipc	ra,0x5
    8000160c:	f3e080e7          	jalr	-194(ra) # 80006546 <release>

  // Go to sleep.
  p->chan = chan;
    80001610:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    80001614:	4789                	li	a5,2
    80001616:	cc9c                	sw	a5,24(s1)

  sched();
    80001618:	00000097          	auipc	ra,0x0
    8000161c:	eb8080e7          	jalr	-328(ra) # 800014d0 <sched>

  // Tidy up.
  p->chan = 0;
    80001620:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    80001624:	8526                	mv	a0,s1
    80001626:	00005097          	auipc	ra,0x5
    8000162a:	f20080e7          	jalr	-224(ra) # 80006546 <release>
  acquire(lk);
    8000162e:	854a                	mv	a0,s2
    80001630:	00005097          	auipc	ra,0x5
    80001634:	e62080e7          	jalr	-414(ra) # 80006492 <acquire>
}
    80001638:	70a2                	ld	ra,40(sp)
    8000163a:	7402                	ld	s0,32(sp)
    8000163c:	64e2                	ld	s1,24(sp)
    8000163e:	6942                	ld	s2,16(sp)
    80001640:	69a2                	ld	s3,8(sp)
    80001642:	6145                	addi	sp,sp,48
    80001644:	8082                	ret

0000000080001646 <wait>:
{
    80001646:	715d                	addi	sp,sp,-80
    80001648:	e486                	sd	ra,72(sp)
    8000164a:	e0a2                	sd	s0,64(sp)
    8000164c:	fc26                	sd	s1,56(sp)
    8000164e:	f84a                	sd	s2,48(sp)
    80001650:	f44e                	sd	s3,40(sp)
    80001652:	f052                	sd	s4,32(sp)
    80001654:	ec56                	sd	s5,24(sp)
    80001656:	e85a                	sd	s6,16(sp)
    80001658:	e45e                	sd	s7,8(sp)
    8000165a:	e062                	sd	s8,0(sp)
    8000165c:	0880                	addi	s0,sp,80
    8000165e:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    80001660:	00000097          	auipc	ra,0x0
    80001664:	8c6080e7          	jalr	-1850(ra) # 80000f26 <myproc>
    80001668:	892a                	mv	s2,a0
  acquire(&wait_lock);
    8000166a:	00008517          	auipc	a0,0x8
    8000166e:	9fe50513          	addi	a0,a0,-1538 # 80009068 <wait_lock>
    80001672:	00005097          	auipc	ra,0x5
    80001676:	e20080e7          	jalr	-480(ra) # 80006492 <acquire>
    havekids = 0;
    8000167a:	4b81                	li	s7,0
        if(np->state == ZOMBIE){
    8000167c:	4a15                	li	s4,5
    for(np = proc; np < &proc[NPROC]; np++){
    8000167e:	0000e997          	auipc	s3,0xe
    80001682:	80298993          	addi	s3,s3,-2046 # 8000ee80 <tickslock>
        havekids = 1;
    80001686:	4a85                	li	s5,1
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001688:	00008c17          	auipc	s8,0x8
    8000168c:	9e0c0c13          	addi	s8,s8,-1568 # 80009068 <wait_lock>
    havekids = 0;
    80001690:	875e                	mv	a4,s7
    for(np = proc; np < &proc[NPROC]; np++){
    80001692:	00008497          	auipc	s1,0x8
    80001696:	dee48493          	addi	s1,s1,-530 # 80009480 <proc>
    8000169a:	a0bd                	j	80001708 <wait+0xc2>
          pid = np->pid;
    8000169c:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&np->xstate,
    800016a0:	000b0e63          	beqz	s6,800016bc <wait+0x76>
    800016a4:	4691                	li	a3,4
    800016a6:	02c48613          	addi	a2,s1,44
    800016aa:	85da                	mv	a1,s6
    800016ac:	05093503          	ld	a0,80(s2)
    800016b0:	fffff097          	auipc	ra,0xfffff
    800016b4:	452080e7          	jalr	1106(ra) # 80000b02 <copyout>
    800016b8:	02054563          	bltz	a0,800016e2 <wait+0x9c>
          freeproc(np);
    800016bc:	8526                	mv	a0,s1
    800016be:	00000097          	auipc	ra,0x0
    800016c2:	a1a080e7          	jalr	-1510(ra) # 800010d8 <freeproc>
          release(&np->lock);
    800016c6:	8526                	mv	a0,s1
    800016c8:	00005097          	auipc	ra,0x5
    800016cc:	e7e080e7          	jalr	-386(ra) # 80006546 <release>
          release(&wait_lock);
    800016d0:	00008517          	auipc	a0,0x8
    800016d4:	99850513          	addi	a0,a0,-1640 # 80009068 <wait_lock>
    800016d8:	00005097          	auipc	ra,0x5
    800016dc:	e6e080e7          	jalr	-402(ra) # 80006546 <release>
          return pid;
    800016e0:	a09d                	j	80001746 <wait+0x100>
            release(&np->lock);
    800016e2:	8526                	mv	a0,s1
    800016e4:	00005097          	auipc	ra,0x5
    800016e8:	e62080e7          	jalr	-414(ra) # 80006546 <release>
            release(&wait_lock);
    800016ec:	00008517          	auipc	a0,0x8
    800016f0:	97c50513          	addi	a0,a0,-1668 # 80009068 <wait_lock>
    800016f4:	00005097          	auipc	ra,0x5
    800016f8:	e52080e7          	jalr	-430(ra) # 80006546 <release>
            return -1;
    800016fc:	59fd                	li	s3,-1
    800016fe:	a0a1                	j	80001746 <wait+0x100>
    for(np = proc; np < &proc[NPROC]; np++){
    80001700:	16848493          	addi	s1,s1,360
    80001704:	03348463          	beq	s1,s3,8000172c <wait+0xe6>
      if(np->parent == p){
    80001708:	7c9c                	ld	a5,56(s1)
    8000170a:	ff279be3          	bne	a5,s2,80001700 <wait+0xba>
        acquire(&np->lock);
    8000170e:	8526                	mv	a0,s1
    80001710:	00005097          	auipc	ra,0x5
    80001714:	d82080e7          	jalr	-638(ra) # 80006492 <acquire>
        if(np->state == ZOMBIE){
    80001718:	4c9c                	lw	a5,24(s1)
    8000171a:	f94781e3          	beq	a5,s4,8000169c <wait+0x56>
        release(&np->lock);
    8000171e:	8526                	mv	a0,s1
    80001720:	00005097          	auipc	ra,0x5
    80001724:	e26080e7          	jalr	-474(ra) # 80006546 <release>
        havekids = 1;
    80001728:	8756                	mv	a4,s5
    8000172a:	bfd9                	j	80001700 <wait+0xba>
    if(!havekids || p->killed){
    8000172c:	c701                	beqz	a4,80001734 <wait+0xee>
    8000172e:	02892783          	lw	a5,40(s2)
    80001732:	c79d                	beqz	a5,80001760 <wait+0x11a>
      release(&wait_lock);
    80001734:	00008517          	auipc	a0,0x8
    80001738:	93450513          	addi	a0,a0,-1740 # 80009068 <wait_lock>
    8000173c:	00005097          	auipc	ra,0x5
    80001740:	e0a080e7          	jalr	-502(ra) # 80006546 <release>
      return -1;
    80001744:	59fd                	li	s3,-1
}
    80001746:	854e                	mv	a0,s3
    80001748:	60a6                	ld	ra,72(sp)
    8000174a:	6406                	ld	s0,64(sp)
    8000174c:	74e2                	ld	s1,56(sp)
    8000174e:	7942                	ld	s2,48(sp)
    80001750:	79a2                	ld	s3,40(sp)
    80001752:	7a02                	ld	s4,32(sp)
    80001754:	6ae2                	ld	s5,24(sp)
    80001756:	6b42                	ld	s6,16(sp)
    80001758:	6ba2                	ld	s7,8(sp)
    8000175a:	6c02                	ld	s8,0(sp)
    8000175c:	6161                	addi	sp,sp,80
    8000175e:	8082                	ret
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001760:	85e2                	mv	a1,s8
    80001762:	854a                	mv	a0,s2
    80001764:	00000097          	auipc	ra,0x0
    80001768:	e7e080e7          	jalr	-386(ra) # 800015e2 <sleep>
    havekids = 0;
    8000176c:	b715                	j	80001690 <wait+0x4a>

000000008000176e <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    8000176e:	7139                	addi	sp,sp,-64
    80001770:	fc06                	sd	ra,56(sp)
    80001772:	f822                	sd	s0,48(sp)
    80001774:	f426                	sd	s1,40(sp)
    80001776:	f04a                	sd	s2,32(sp)
    80001778:	ec4e                	sd	s3,24(sp)
    8000177a:	e852                	sd	s4,16(sp)
    8000177c:	e456                	sd	s5,8(sp)
    8000177e:	0080                	addi	s0,sp,64
    80001780:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    80001782:	00008497          	auipc	s1,0x8
    80001786:	cfe48493          	addi	s1,s1,-770 # 80009480 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    8000178a:	4989                	li	s3,2
        p->state = RUNNABLE;
    8000178c:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    8000178e:	0000d917          	auipc	s2,0xd
    80001792:	6f290913          	addi	s2,s2,1778 # 8000ee80 <tickslock>
    80001796:	a821                	j	800017ae <wakeup+0x40>
        p->state = RUNNABLE;
    80001798:	0154ac23          	sw	s5,24(s1)
      }
      release(&p->lock);
    8000179c:	8526                	mv	a0,s1
    8000179e:	00005097          	auipc	ra,0x5
    800017a2:	da8080e7          	jalr	-600(ra) # 80006546 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800017a6:	16848493          	addi	s1,s1,360
    800017aa:	03248463          	beq	s1,s2,800017d2 <wakeup+0x64>
    if(p != myproc()){
    800017ae:	fffff097          	auipc	ra,0xfffff
    800017b2:	778080e7          	jalr	1912(ra) # 80000f26 <myproc>
    800017b6:	fea488e3          	beq	s1,a0,800017a6 <wakeup+0x38>
      acquire(&p->lock);
    800017ba:	8526                	mv	a0,s1
    800017bc:	00005097          	auipc	ra,0x5
    800017c0:	cd6080e7          	jalr	-810(ra) # 80006492 <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    800017c4:	4c9c                	lw	a5,24(s1)
    800017c6:	fd379be3          	bne	a5,s3,8000179c <wakeup+0x2e>
    800017ca:	709c                	ld	a5,32(s1)
    800017cc:	fd4798e3          	bne	a5,s4,8000179c <wakeup+0x2e>
    800017d0:	b7e1                	j	80001798 <wakeup+0x2a>
    }
  }
}
    800017d2:	70e2                	ld	ra,56(sp)
    800017d4:	7442                	ld	s0,48(sp)
    800017d6:	74a2                	ld	s1,40(sp)
    800017d8:	7902                	ld	s2,32(sp)
    800017da:	69e2                	ld	s3,24(sp)
    800017dc:	6a42                	ld	s4,16(sp)
    800017de:	6aa2                	ld	s5,8(sp)
    800017e0:	6121                	addi	sp,sp,64
    800017e2:	8082                	ret

00000000800017e4 <reparent>:
{
    800017e4:	7179                	addi	sp,sp,-48
    800017e6:	f406                	sd	ra,40(sp)
    800017e8:	f022                	sd	s0,32(sp)
    800017ea:	ec26                	sd	s1,24(sp)
    800017ec:	e84a                	sd	s2,16(sp)
    800017ee:	e44e                	sd	s3,8(sp)
    800017f0:	e052                	sd	s4,0(sp)
    800017f2:	1800                	addi	s0,sp,48
    800017f4:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    800017f6:	00008497          	auipc	s1,0x8
    800017fa:	c8a48493          	addi	s1,s1,-886 # 80009480 <proc>
      pp->parent = initproc;
    800017fe:	00008a17          	auipc	s4,0x8
    80001802:	812a0a13          	addi	s4,s4,-2030 # 80009010 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    80001806:	0000d997          	auipc	s3,0xd
    8000180a:	67a98993          	addi	s3,s3,1658 # 8000ee80 <tickslock>
    8000180e:	a029                	j	80001818 <reparent+0x34>
    80001810:	16848493          	addi	s1,s1,360
    80001814:	01348d63          	beq	s1,s3,8000182e <reparent+0x4a>
    if(pp->parent == p){
    80001818:	7c9c                	ld	a5,56(s1)
    8000181a:	ff279be3          	bne	a5,s2,80001810 <reparent+0x2c>
      pp->parent = initproc;
    8000181e:	000a3503          	ld	a0,0(s4)
    80001822:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    80001824:	00000097          	auipc	ra,0x0
    80001828:	f4a080e7          	jalr	-182(ra) # 8000176e <wakeup>
    8000182c:	b7d5                	j	80001810 <reparent+0x2c>
}
    8000182e:	70a2                	ld	ra,40(sp)
    80001830:	7402                	ld	s0,32(sp)
    80001832:	64e2                	ld	s1,24(sp)
    80001834:	6942                	ld	s2,16(sp)
    80001836:	69a2                	ld	s3,8(sp)
    80001838:	6a02                	ld	s4,0(sp)
    8000183a:	6145                	addi	sp,sp,48
    8000183c:	8082                	ret

000000008000183e <exit>:
{
    8000183e:	7179                	addi	sp,sp,-48
    80001840:	f406                	sd	ra,40(sp)
    80001842:	f022                	sd	s0,32(sp)
    80001844:	ec26                	sd	s1,24(sp)
    80001846:	e84a                	sd	s2,16(sp)
    80001848:	e44e                	sd	s3,8(sp)
    8000184a:	e052                	sd	s4,0(sp)
    8000184c:	1800                	addi	s0,sp,48
    8000184e:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    80001850:	fffff097          	auipc	ra,0xfffff
    80001854:	6d6080e7          	jalr	1750(ra) # 80000f26 <myproc>
    80001858:	89aa                	mv	s3,a0
  if(p == initproc)
    8000185a:	00007797          	auipc	a5,0x7
    8000185e:	7b67b783          	ld	a5,1974(a5) # 80009010 <initproc>
    80001862:	0d050493          	addi	s1,a0,208
    80001866:	15050913          	addi	s2,a0,336
    8000186a:	02a79363          	bne	a5,a0,80001890 <exit+0x52>
    panic("init exiting");
    8000186e:	00007517          	auipc	a0,0x7
    80001872:	96250513          	addi	a0,a0,-1694 # 800081d0 <etext+0x1d0>
    80001876:	00004097          	auipc	ra,0x4
    8000187a:	6d2080e7          	jalr	1746(ra) # 80005f48 <panic>
      fileclose(f);
    8000187e:	00002097          	auipc	ra,0x2
    80001882:	3b4080e7          	jalr	948(ra) # 80003c32 <fileclose>
      p->ofile[fd] = 0;
    80001886:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    8000188a:	04a1                	addi	s1,s1,8
    8000188c:	01248563          	beq	s1,s2,80001896 <exit+0x58>
    if(p->ofile[fd]){
    80001890:	6088                	ld	a0,0(s1)
    80001892:	f575                	bnez	a0,8000187e <exit+0x40>
    80001894:	bfdd                	j	8000188a <exit+0x4c>
  begin_op();
    80001896:	00002097          	auipc	ra,0x2
    8000189a:	ed0080e7          	jalr	-304(ra) # 80003766 <begin_op>
  iput(p->cwd);
    8000189e:	1509b503          	ld	a0,336(s3)
    800018a2:	00001097          	auipc	ra,0x1
    800018a6:	524080e7          	jalr	1316(ra) # 80002dc6 <iput>
  end_op();
    800018aa:	00002097          	auipc	ra,0x2
    800018ae:	f3c080e7          	jalr	-196(ra) # 800037e6 <end_op>
  p->cwd = 0;
    800018b2:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    800018b6:	00007497          	auipc	s1,0x7
    800018ba:	7b248493          	addi	s1,s1,1970 # 80009068 <wait_lock>
    800018be:	8526                	mv	a0,s1
    800018c0:	00005097          	auipc	ra,0x5
    800018c4:	bd2080e7          	jalr	-1070(ra) # 80006492 <acquire>
  reparent(p);
    800018c8:	854e                	mv	a0,s3
    800018ca:	00000097          	auipc	ra,0x0
    800018ce:	f1a080e7          	jalr	-230(ra) # 800017e4 <reparent>
  wakeup(p->parent);
    800018d2:	0389b503          	ld	a0,56(s3)
    800018d6:	00000097          	auipc	ra,0x0
    800018da:	e98080e7          	jalr	-360(ra) # 8000176e <wakeup>
  acquire(&p->lock);
    800018de:	854e                	mv	a0,s3
    800018e0:	00005097          	auipc	ra,0x5
    800018e4:	bb2080e7          	jalr	-1102(ra) # 80006492 <acquire>
  p->xstate = status;
    800018e8:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    800018ec:	4795                	li	a5,5
    800018ee:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    800018f2:	8526                	mv	a0,s1
    800018f4:	00005097          	auipc	ra,0x5
    800018f8:	c52080e7          	jalr	-942(ra) # 80006546 <release>
  sched();
    800018fc:	00000097          	auipc	ra,0x0
    80001900:	bd4080e7          	jalr	-1068(ra) # 800014d0 <sched>
  panic("zombie exit");
    80001904:	00007517          	auipc	a0,0x7
    80001908:	8dc50513          	addi	a0,a0,-1828 # 800081e0 <etext+0x1e0>
    8000190c:	00004097          	auipc	ra,0x4
    80001910:	63c080e7          	jalr	1596(ra) # 80005f48 <panic>

0000000080001914 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    80001914:	7179                	addi	sp,sp,-48
    80001916:	f406                	sd	ra,40(sp)
    80001918:	f022                	sd	s0,32(sp)
    8000191a:	ec26                	sd	s1,24(sp)
    8000191c:	e84a                	sd	s2,16(sp)
    8000191e:	e44e                	sd	s3,8(sp)
    80001920:	1800                	addi	s0,sp,48
    80001922:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    80001924:	00008497          	auipc	s1,0x8
    80001928:	b5c48493          	addi	s1,s1,-1188 # 80009480 <proc>
    8000192c:	0000d997          	auipc	s3,0xd
    80001930:	55498993          	addi	s3,s3,1364 # 8000ee80 <tickslock>
    acquire(&p->lock);
    80001934:	8526                	mv	a0,s1
    80001936:	00005097          	auipc	ra,0x5
    8000193a:	b5c080e7          	jalr	-1188(ra) # 80006492 <acquire>
    if(p->pid == pid){
    8000193e:	589c                	lw	a5,48(s1)
    80001940:	01278d63          	beq	a5,s2,8000195a <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    80001944:	8526                	mv	a0,s1
    80001946:	00005097          	auipc	ra,0x5
    8000194a:	c00080e7          	jalr	-1024(ra) # 80006546 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    8000194e:	16848493          	addi	s1,s1,360
    80001952:	ff3491e3          	bne	s1,s3,80001934 <kill+0x20>
  }
  return -1;
    80001956:	557d                	li	a0,-1
    80001958:	a829                	j	80001972 <kill+0x5e>
      p->killed = 1;
    8000195a:	4785                	li	a5,1
    8000195c:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    8000195e:	4c98                	lw	a4,24(s1)
    80001960:	4789                	li	a5,2
    80001962:	00f70f63          	beq	a4,a5,80001980 <kill+0x6c>
      release(&p->lock);
    80001966:	8526                	mv	a0,s1
    80001968:	00005097          	auipc	ra,0x5
    8000196c:	bde080e7          	jalr	-1058(ra) # 80006546 <release>
      return 0;
    80001970:	4501                	li	a0,0
}
    80001972:	70a2                	ld	ra,40(sp)
    80001974:	7402                	ld	s0,32(sp)
    80001976:	64e2                	ld	s1,24(sp)
    80001978:	6942                	ld	s2,16(sp)
    8000197a:	69a2                	ld	s3,8(sp)
    8000197c:	6145                	addi	sp,sp,48
    8000197e:	8082                	ret
        p->state = RUNNABLE;
    80001980:	478d                	li	a5,3
    80001982:	cc9c                	sw	a5,24(s1)
    80001984:	b7cd                	j	80001966 <kill+0x52>

0000000080001986 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80001986:	7179                	addi	sp,sp,-48
    80001988:	f406                	sd	ra,40(sp)
    8000198a:	f022                	sd	s0,32(sp)
    8000198c:	ec26                	sd	s1,24(sp)
    8000198e:	e84a                	sd	s2,16(sp)
    80001990:	e44e                	sd	s3,8(sp)
    80001992:	e052                	sd	s4,0(sp)
    80001994:	1800                	addi	s0,sp,48
    80001996:	84aa                	mv	s1,a0
    80001998:	892e                	mv	s2,a1
    8000199a:	89b2                	mv	s3,a2
    8000199c:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    8000199e:	fffff097          	auipc	ra,0xfffff
    800019a2:	588080e7          	jalr	1416(ra) # 80000f26 <myproc>
  if(user_dst){
    800019a6:	c08d                	beqz	s1,800019c8 <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    800019a8:	86d2                	mv	a3,s4
    800019aa:	864e                	mv	a2,s3
    800019ac:	85ca                	mv	a1,s2
    800019ae:	6928                	ld	a0,80(a0)
    800019b0:	fffff097          	auipc	ra,0xfffff
    800019b4:	152080e7          	jalr	338(ra) # 80000b02 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    800019b8:	70a2                	ld	ra,40(sp)
    800019ba:	7402                	ld	s0,32(sp)
    800019bc:	64e2                	ld	s1,24(sp)
    800019be:	6942                	ld	s2,16(sp)
    800019c0:	69a2                	ld	s3,8(sp)
    800019c2:	6a02                	ld	s4,0(sp)
    800019c4:	6145                	addi	sp,sp,48
    800019c6:	8082                	ret
    memmove((char *)dst, src, len);
    800019c8:	000a061b          	sext.w	a2,s4
    800019cc:	85ce                	mv	a1,s3
    800019ce:	854a                	mv	a0,s2
    800019d0:	fffff097          	auipc	ra,0xfffff
    800019d4:	808080e7          	jalr	-2040(ra) # 800001d8 <memmove>
    return 0;
    800019d8:	8526                	mv	a0,s1
    800019da:	bff9                	j	800019b8 <either_copyout+0x32>

00000000800019dc <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    800019dc:	7179                	addi	sp,sp,-48
    800019de:	f406                	sd	ra,40(sp)
    800019e0:	f022                	sd	s0,32(sp)
    800019e2:	ec26                	sd	s1,24(sp)
    800019e4:	e84a                	sd	s2,16(sp)
    800019e6:	e44e                	sd	s3,8(sp)
    800019e8:	e052                	sd	s4,0(sp)
    800019ea:	1800                	addi	s0,sp,48
    800019ec:	892a                	mv	s2,a0
    800019ee:	84ae                	mv	s1,a1
    800019f0:	89b2                	mv	s3,a2
    800019f2:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    800019f4:	fffff097          	auipc	ra,0xfffff
    800019f8:	532080e7          	jalr	1330(ra) # 80000f26 <myproc>
  if(user_src){
    800019fc:	c08d                	beqz	s1,80001a1e <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    800019fe:	86d2                	mv	a3,s4
    80001a00:	864e                	mv	a2,s3
    80001a02:	85ca                	mv	a1,s2
    80001a04:	6928                	ld	a0,80(a0)
    80001a06:	fffff097          	auipc	ra,0xfffff
    80001a0a:	188080e7          	jalr	392(ra) # 80000b8e <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80001a0e:	70a2                	ld	ra,40(sp)
    80001a10:	7402                	ld	s0,32(sp)
    80001a12:	64e2                	ld	s1,24(sp)
    80001a14:	6942                	ld	s2,16(sp)
    80001a16:	69a2                	ld	s3,8(sp)
    80001a18:	6a02                	ld	s4,0(sp)
    80001a1a:	6145                	addi	sp,sp,48
    80001a1c:	8082                	ret
    memmove(dst, (char*)src, len);
    80001a1e:	000a061b          	sext.w	a2,s4
    80001a22:	85ce                	mv	a1,s3
    80001a24:	854a                	mv	a0,s2
    80001a26:	ffffe097          	auipc	ra,0xffffe
    80001a2a:	7b2080e7          	jalr	1970(ra) # 800001d8 <memmove>
    return 0;
    80001a2e:	8526                	mv	a0,s1
    80001a30:	bff9                	j	80001a0e <either_copyin+0x32>

0000000080001a32 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80001a32:	715d                	addi	sp,sp,-80
    80001a34:	e486                	sd	ra,72(sp)
    80001a36:	e0a2                	sd	s0,64(sp)
    80001a38:	fc26                	sd	s1,56(sp)
    80001a3a:	f84a                	sd	s2,48(sp)
    80001a3c:	f44e                	sd	s3,40(sp)
    80001a3e:	f052                	sd	s4,32(sp)
    80001a40:	ec56                	sd	s5,24(sp)
    80001a42:	e85a                	sd	s6,16(sp)
    80001a44:	e45e                	sd	s7,8(sp)
    80001a46:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    80001a48:	00006517          	auipc	a0,0x6
    80001a4c:	60050513          	addi	a0,a0,1536 # 80008048 <etext+0x48>
    80001a50:	00004097          	auipc	ra,0x4
    80001a54:	542080e7          	jalr	1346(ra) # 80005f92 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001a58:	00008497          	auipc	s1,0x8
    80001a5c:	b8048493          	addi	s1,s1,-1152 # 800095d8 <proc+0x158>
    80001a60:	0000d917          	auipc	s2,0xd
    80001a64:	57890913          	addi	s2,s2,1400 # 8000efd8 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001a68:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    80001a6a:	00006997          	auipc	s3,0x6
    80001a6e:	78698993          	addi	s3,s3,1926 # 800081f0 <etext+0x1f0>
    printf("%d %s %s", p->pid, state, p->name);
    80001a72:	00006a97          	auipc	s5,0x6
    80001a76:	786a8a93          	addi	s5,s5,1926 # 800081f8 <etext+0x1f8>
    printf("\n");
    80001a7a:	00006a17          	auipc	s4,0x6
    80001a7e:	5cea0a13          	addi	s4,s4,1486 # 80008048 <etext+0x48>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001a82:	00006b97          	auipc	s7,0x6
    80001a86:	7aeb8b93          	addi	s7,s7,1966 # 80008230 <states.1805>
    80001a8a:	a00d                	j	80001aac <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    80001a8c:	ed86a583          	lw	a1,-296(a3)
    80001a90:	8556                	mv	a0,s5
    80001a92:	00004097          	auipc	ra,0x4
    80001a96:	500080e7          	jalr	1280(ra) # 80005f92 <printf>
    printf("\n");
    80001a9a:	8552                	mv	a0,s4
    80001a9c:	00004097          	auipc	ra,0x4
    80001aa0:	4f6080e7          	jalr	1270(ra) # 80005f92 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001aa4:	16848493          	addi	s1,s1,360
    80001aa8:	03248163          	beq	s1,s2,80001aca <procdump+0x98>
    if(p->state == UNUSED)
    80001aac:	86a6                	mv	a3,s1
    80001aae:	ec04a783          	lw	a5,-320(s1)
    80001ab2:	dbed                	beqz	a5,80001aa4 <procdump+0x72>
      state = "???";
    80001ab4:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001ab6:	fcfb6be3          	bltu	s6,a5,80001a8c <procdump+0x5a>
    80001aba:	1782                	slli	a5,a5,0x20
    80001abc:	9381                	srli	a5,a5,0x20
    80001abe:	078e                	slli	a5,a5,0x3
    80001ac0:	97de                	add	a5,a5,s7
    80001ac2:	6390                	ld	a2,0(a5)
    80001ac4:	f661                	bnez	a2,80001a8c <procdump+0x5a>
      state = "???";
    80001ac6:	864e                	mv	a2,s3
    80001ac8:	b7d1                	j	80001a8c <procdump+0x5a>
  }
}
    80001aca:	60a6                	ld	ra,72(sp)
    80001acc:	6406                	ld	s0,64(sp)
    80001ace:	74e2                	ld	s1,56(sp)
    80001ad0:	7942                	ld	s2,48(sp)
    80001ad2:	79a2                	ld	s3,40(sp)
    80001ad4:	7a02                	ld	s4,32(sp)
    80001ad6:	6ae2                	ld	s5,24(sp)
    80001ad8:	6b42                	ld	s6,16(sp)
    80001ada:	6ba2                	ld	s7,8(sp)
    80001adc:	6161                	addi	sp,sp,80
    80001ade:	8082                	ret

0000000080001ae0 <swtch>:
    80001ae0:	00153023          	sd	ra,0(a0)
    80001ae4:	00253423          	sd	sp,8(a0)
    80001ae8:	e900                	sd	s0,16(a0)
    80001aea:	ed04                	sd	s1,24(a0)
    80001aec:	03253023          	sd	s2,32(a0)
    80001af0:	03353423          	sd	s3,40(a0)
    80001af4:	03453823          	sd	s4,48(a0)
    80001af8:	03553c23          	sd	s5,56(a0)
    80001afc:	05653023          	sd	s6,64(a0)
    80001b00:	05753423          	sd	s7,72(a0)
    80001b04:	05853823          	sd	s8,80(a0)
    80001b08:	05953c23          	sd	s9,88(a0)
    80001b0c:	07a53023          	sd	s10,96(a0)
    80001b10:	07b53423          	sd	s11,104(a0)
    80001b14:	0005b083          	ld	ra,0(a1)
    80001b18:	0085b103          	ld	sp,8(a1)
    80001b1c:	6980                	ld	s0,16(a1)
    80001b1e:	6d84                	ld	s1,24(a1)
    80001b20:	0205b903          	ld	s2,32(a1)
    80001b24:	0285b983          	ld	s3,40(a1)
    80001b28:	0305ba03          	ld	s4,48(a1)
    80001b2c:	0385ba83          	ld	s5,56(a1)
    80001b30:	0405bb03          	ld	s6,64(a1)
    80001b34:	0485bb83          	ld	s7,72(a1)
    80001b38:	0505bc03          	ld	s8,80(a1)
    80001b3c:	0585bc83          	ld	s9,88(a1)
    80001b40:	0605bd03          	ld	s10,96(a1)
    80001b44:	0685bd83          	ld	s11,104(a1)
    80001b48:	8082                	ret

0000000080001b4a <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80001b4a:	1141                	addi	sp,sp,-16
    80001b4c:	e406                	sd	ra,8(sp)
    80001b4e:	e022                	sd	s0,0(sp)
    80001b50:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80001b52:	00006597          	auipc	a1,0x6
    80001b56:	70e58593          	addi	a1,a1,1806 # 80008260 <states.1805+0x30>
    80001b5a:	0000d517          	auipc	a0,0xd
    80001b5e:	32650513          	addi	a0,a0,806 # 8000ee80 <tickslock>
    80001b62:	00005097          	auipc	ra,0x5
    80001b66:	8a0080e7          	jalr	-1888(ra) # 80006402 <initlock>
}
    80001b6a:	60a2                	ld	ra,8(sp)
    80001b6c:	6402                	ld	s0,0(sp)
    80001b6e:	0141                	addi	sp,sp,16
    80001b70:	8082                	ret

0000000080001b72 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80001b72:	1141                	addi	sp,sp,-16
    80001b74:	e422                	sd	s0,8(sp)
    80001b76:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001b78:	00003797          	auipc	a5,0x3
    80001b7c:	6d878793          	addi	a5,a5,1752 # 80005250 <kernelvec>
    80001b80:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80001b84:	6422                	ld	s0,8(sp)
    80001b86:	0141                	addi	sp,sp,16
    80001b88:	8082                	ret

0000000080001b8a <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80001b8a:	1141                	addi	sp,sp,-16
    80001b8c:	e406                	sd	ra,8(sp)
    80001b8e:	e022                	sd	s0,0(sp)
    80001b90:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80001b92:	fffff097          	auipc	ra,0xfffff
    80001b96:	394080e7          	jalr	916(ra) # 80000f26 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001b9a:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80001b9e:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001ba0:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    80001ba4:	00005617          	auipc	a2,0x5
    80001ba8:	45c60613          	addi	a2,a2,1116 # 80007000 <_trampoline>
    80001bac:	00005697          	auipc	a3,0x5
    80001bb0:	45468693          	addi	a3,a3,1108 # 80007000 <_trampoline>
    80001bb4:	8e91                	sub	a3,a3,a2
    80001bb6:	040007b7          	lui	a5,0x4000
    80001bba:	17fd                	addi	a5,a5,-1
    80001bbc:	07b2                	slli	a5,a5,0xc
    80001bbe:	96be                	add	a3,a3,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001bc0:	10569073          	csrw	stvec,a3

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80001bc4:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80001bc6:	180026f3          	csrr	a3,satp
    80001bca:	e314                	sd	a3,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80001bcc:	6d38                	ld	a4,88(a0)
    80001bce:	6134                	ld	a3,64(a0)
    80001bd0:	6585                	lui	a1,0x1
    80001bd2:	96ae                	add	a3,a3,a1
    80001bd4:	e714                	sd	a3,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80001bd6:	6d38                	ld	a4,88(a0)
    80001bd8:	00000697          	auipc	a3,0x0
    80001bdc:	13868693          	addi	a3,a3,312 # 80001d10 <usertrap>
    80001be0:	eb14                	sd	a3,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80001be2:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80001be4:	8692                	mv	a3,tp
    80001be6:	f314                	sd	a3,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001be8:	100026f3          	csrr	a3,sstatus

  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80001bec:	eff6f693          	andi	a3,a3,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80001bf0:	0206e693          	ori	a3,a3,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001bf4:	10069073          	csrw	sstatus,a3
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80001bf8:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001bfa:	6f18                	ld	a4,24(a4)
    80001bfc:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80001c00:	692c                	ld	a1,80(a0)
    80001c02:	81b1                	srli	a1,a1,0xc

  // jump to trampoline.S at the top of memory, which
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    80001c04:	00005717          	auipc	a4,0x5
    80001c08:	48c70713          	addi	a4,a4,1164 # 80007090 <userret>
    80001c0c:	8f11                	sub	a4,a4,a2
    80001c0e:	97ba                	add	a5,a5,a4
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    80001c10:	577d                	li	a4,-1
    80001c12:	177e                	slli	a4,a4,0x3f
    80001c14:	8dd9                	or	a1,a1,a4
    80001c16:	02000537          	lui	a0,0x2000
    80001c1a:	157d                	addi	a0,a0,-1
    80001c1c:	0536                	slli	a0,a0,0xd
    80001c1e:	9782                	jalr	a5
}
    80001c20:	60a2                	ld	ra,8(sp)
    80001c22:	6402                	ld	s0,0(sp)
    80001c24:	0141                	addi	sp,sp,16
    80001c26:	8082                	ret

0000000080001c28 <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    80001c28:	1101                	addi	sp,sp,-32
    80001c2a:	ec06                	sd	ra,24(sp)
    80001c2c:	e822                	sd	s0,16(sp)
    80001c2e:	e426                	sd	s1,8(sp)
    80001c30:	1000                	addi	s0,sp,32
  acquire(&tickslock);
    80001c32:	0000d497          	auipc	s1,0xd
    80001c36:	24e48493          	addi	s1,s1,590 # 8000ee80 <tickslock>
    80001c3a:	8526                	mv	a0,s1
    80001c3c:	00005097          	auipc	ra,0x5
    80001c40:	856080e7          	jalr	-1962(ra) # 80006492 <acquire>
  ticks++;
    80001c44:	00007517          	auipc	a0,0x7
    80001c48:	3d450513          	addi	a0,a0,980 # 80009018 <ticks>
    80001c4c:	411c                	lw	a5,0(a0)
    80001c4e:	2785                	addiw	a5,a5,1
    80001c50:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    80001c52:	00000097          	auipc	ra,0x0
    80001c56:	b1c080e7          	jalr	-1252(ra) # 8000176e <wakeup>
  release(&tickslock);
    80001c5a:	8526                	mv	a0,s1
    80001c5c:	00005097          	auipc	ra,0x5
    80001c60:	8ea080e7          	jalr	-1814(ra) # 80006546 <release>
}
    80001c64:	60e2                	ld	ra,24(sp)
    80001c66:	6442                	ld	s0,16(sp)
    80001c68:	64a2                	ld	s1,8(sp)
    80001c6a:	6105                	addi	sp,sp,32
    80001c6c:	8082                	ret

0000000080001c6e <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    80001c6e:	1101                	addi	sp,sp,-32
    80001c70:	ec06                	sd	ra,24(sp)
    80001c72:	e822                	sd	s0,16(sp)
    80001c74:	e426                	sd	s1,8(sp)
    80001c76:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001c78:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if((scause & 0x8000000000000000L) &&
    80001c7c:	00074d63          	bltz	a4,80001c96 <devintr+0x28>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000001L){
    80001c80:	57fd                	li	a5,-1
    80001c82:	17fe                	slli	a5,a5,0x3f
    80001c84:	0785                	addi	a5,a5,1
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    80001c86:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80001c88:	06f70363          	beq	a4,a5,80001cee <devintr+0x80>
  }
}
    80001c8c:	60e2                	ld	ra,24(sp)
    80001c8e:	6442                	ld	s0,16(sp)
    80001c90:	64a2                	ld	s1,8(sp)
    80001c92:	6105                	addi	sp,sp,32
    80001c94:	8082                	ret
     (scause & 0xff) == 9){
    80001c96:	0ff77793          	andi	a5,a4,255
  if((scause & 0x8000000000000000L) &&
    80001c9a:	46a5                	li	a3,9
    80001c9c:	fed792e3          	bne	a5,a3,80001c80 <devintr+0x12>
    int irq = plic_claim();
    80001ca0:	00003097          	auipc	ra,0x3
    80001ca4:	6b8080e7          	jalr	1720(ra) # 80005358 <plic_claim>
    80001ca8:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80001caa:	47a9                	li	a5,10
    80001cac:	02f50763          	beq	a0,a5,80001cda <devintr+0x6c>
    } else if(irq == VIRTIO0_IRQ){
    80001cb0:	4785                	li	a5,1
    80001cb2:	02f50963          	beq	a0,a5,80001ce4 <devintr+0x76>
    return 1;
    80001cb6:	4505                	li	a0,1
    } else if(irq){
    80001cb8:	d8f1                	beqz	s1,80001c8c <devintr+0x1e>
      printf("unexpected interrupt irq=%d\n", irq);
    80001cba:	85a6                	mv	a1,s1
    80001cbc:	00006517          	auipc	a0,0x6
    80001cc0:	5ac50513          	addi	a0,a0,1452 # 80008268 <states.1805+0x38>
    80001cc4:	00004097          	auipc	ra,0x4
    80001cc8:	2ce080e7          	jalr	718(ra) # 80005f92 <printf>
      plic_complete(irq);
    80001ccc:	8526                	mv	a0,s1
    80001cce:	00003097          	auipc	ra,0x3
    80001cd2:	6ae080e7          	jalr	1710(ra) # 8000537c <plic_complete>
    return 1;
    80001cd6:	4505                	li	a0,1
    80001cd8:	bf55                	j	80001c8c <devintr+0x1e>
      uartintr();
    80001cda:	00004097          	auipc	ra,0x4
    80001cde:	6d8080e7          	jalr	1752(ra) # 800063b2 <uartintr>
    80001ce2:	b7ed                	j	80001ccc <devintr+0x5e>
      virtio_disk_intr();
    80001ce4:	00004097          	auipc	ra,0x4
    80001ce8:	b78080e7          	jalr	-1160(ra) # 8000585c <virtio_disk_intr>
    80001cec:	b7c5                	j	80001ccc <devintr+0x5e>
    if(cpuid() == 0){
    80001cee:	fffff097          	auipc	ra,0xfffff
    80001cf2:	20c080e7          	jalr	524(ra) # 80000efa <cpuid>
    80001cf6:	c901                	beqz	a0,80001d06 <devintr+0x98>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80001cf8:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80001cfc:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80001cfe:	14479073          	csrw	sip,a5
    return 2;
    80001d02:	4509                	li	a0,2
    80001d04:	b761                	j	80001c8c <devintr+0x1e>
      clockintr();
    80001d06:	00000097          	auipc	ra,0x0
    80001d0a:	f22080e7          	jalr	-222(ra) # 80001c28 <clockintr>
    80001d0e:	b7ed                	j	80001cf8 <devintr+0x8a>

0000000080001d10 <usertrap>:
{
    80001d10:	1101                	addi	sp,sp,-32
    80001d12:	ec06                	sd	ra,24(sp)
    80001d14:	e822                	sd	s0,16(sp)
    80001d16:	e426                	sd	s1,8(sp)
    80001d18:	e04a                	sd	s2,0(sp)
    80001d1a:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001d1c:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80001d20:	1007f793          	andi	a5,a5,256
    80001d24:	e3ad                	bnez	a5,80001d86 <usertrap+0x76>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001d26:	00003797          	auipc	a5,0x3
    80001d2a:	52a78793          	addi	a5,a5,1322 # 80005250 <kernelvec>
    80001d2e:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80001d32:	fffff097          	auipc	ra,0xfffff
    80001d36:	1f4080e7          	jalr	500(ra) # 80000f26 <myproc>
    80001d3a:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80001d3c:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001d3e:	14102773          	csrr	a4,sepc
    80001d42:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001d44:	14202773          	csrr	a4,scause
  if(scause == 8) {
    80001d48:	47a1                	li	a5,8
    80001d4a:	04f71c63          	bne	a4,a5,80001da2 <usertrap+0x92>
    if(p->killed)
    80001d4e:	551c                	lw	a5,40(a0)
    80001d50:	e3b9                	bnez	a5,80001d96 <usertrap+0x86>
    p->trapframe->epc += 4;
    80001d52:	6cb8                	ld	a4,88(s1)
    80001d54:	6f1c                	ld	a5,24(a4)
    80001d56:	0791                	addi	a5,a5,4
    80001d58:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001d5a:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001d5e:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001d62:	10079073          	csrw	sstatus,a5
    syscall();
    80001d66:	00000097          	auipc	ra,0x0
    80001d6a:	2e0080e7          	jalr	736(ra) # 80002046 <syscall>
  if(p->killed)
    80001d6e:	549c                	lw	a5,40(s1)
    80001d70:	ebc1                	bnez	a5,80001e00 <usertrap+0xf0>
  usertrapret();
    80001d72:	00000097          	auipc	ra,0x0
    80001d76:	e18080e7          	jalr	-488(ra) # 80001b8a <usertrapret>
}
    80001d7a:	60e2                	ld	ra,24(sp)
    80001d7c:	6442                	ld	s0,16(sp)
    80001d7e:	64a2                	ld	s1,8(sp)
    80001d80:	6902                	ld	s2,0(sp)
    80001d82:	6105                	addi	sp,sp,32
    80001d84:	8082                	ret
    panic("usertrap: not from user mode");
    80001d86:	00006517          	auipc	a0,0x6
    80001d8a:	50250513          	addi	a0,a0,1282 # 80008288 <states.1805+0x58>
    80001d8e:	00004097          	auipc	ra,0x4
    80001d92:	1ba080e7          	jalr	442(ra) # 80005f48 <panic>
      exit(-1);
    80001d96:	557d                	li	a0,-1
    80001d98:	00000097          	auipc	ra,0x0
    80001d9c:	aa6080e7          	jalr	-1370(ra) # 8000183e <exit>
    80001da0:	bf4d                	j	80001d52 <usertrap+0x42>
  } else if ((which_dev = devintr()) != 0) {
    80001da2:	00000097          	auipc	ra,0x0
    80001da6:	ecc080e7          	jalr	-308(ra) # 80001c6e <devintr>
    80001daa:	892a                	mv	s2,a0
    80001dac:	c501                	beqz	a0,80001db4 <usertrap+0xa4>
  if(p->killed)
    80001dae:	549c                	lw	a5,40(s1)
    80001db0:	c3a1                	beqz	a5,80001df0 <usertrap+0xe0>
    80001db2:	a815                	j	80001de6 <usertrap+0xd6>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001db4:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80001db8:	5890                	lw	a2,48(s1)
    80001dba:	00006517          	auipc	a0,0x6
    80001dbe:	4ee50513          	addi	a0,a0,1262 # 800082a8 <states.1805+0x78>
    80001dc2:	00004097          	auipc	ra,0x4
    80001dc6:	1d0080e7          	jalr	464(ra) # 80005f92 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001dca:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001dce:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001dd2:	00006517          	auipc	a0,0x6
    80001dd6:	50650513          	addi	a0,a0,1286 # 800082d8 <states.1805+0xa8>
    80001dda:	00004097          	auipc	ra,0x4
    80001dde:	1b8080e7          	jalr	440(ra) # 80005f92 <printf>
    p->killed = 1;
    80001de2:	4785                	li	a5,1
    80001de4:	d49c                	sw	a5,40(s1)
    exit(-1);
    80001de6:	557d                	li	a0,-1
    80001de8:	00000097          	auipc	ra,0x0
    80001dec:	a56080e7          	jalr	-1450(ra) # 8000183e <exit>
  if(which_dev == 2)
    80001df0:	4789                	li	a5,2
    80001df2:	f8f910e3          	bne	s2,a5,80001d72 <usertrap+0x62>
    yield();
    80001df6:	fffff097          	auipc	ra,0xfffff
    80001dfa:	7b0080e7          	jalr	1968(ra) # 800015a6 <yield>
    80001dfe:	bf95                	j	80001d72 <usertrap+0x62>
  int which_dev = 0;
    80001e00:	4901                	li	s2,0
    80001e02:	b7d5                	j	80001de6 <usertrap+0xd6>

0000000080001e04 <kerneltrap>:
{
    80001e04:	7179                	addi	sp,sp,-48
    80001e06:	f406                	sd	ra,40(sp)
    80001e08:	f022                	sd	s0,32(sp)
    80001e0a:	ec26                	sd	s1,24(sp)
    80001e0c:	e84a                	sd	s2,16(sp)
    80001e0e:	e44e                	sd	s3,8(sp)
    80001e10:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001e12:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001e16:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001e1a:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80001e1e:	1004f793          	andi	a5,s1,256
    80001e22:	cb85                	beqz	a5,80001e52 <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001e24:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001e28:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80001e2a:	ef85                	bnez	a5,80001e62 <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    80001e2c:	00000097          	auipc	ra,0x0
    80001e30:	e42080e7          	jalr	-446(ra) # 80001c6e <devintr>
    80001e34:	cd1d                	beqz	a0,80001e72 <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001e36:	4789                	li	a5,2
    80001e38:	06f50a63          	beq	a0,a5,80001eac <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001e3c:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001e40:	10049073          	csrw	sstatus,s1
}
    80001e44:	70a2                	ld	ra,40(sp)
    80001e46:	7402                	ld	s0,32(sp)
    80001e48:	64e2                	ld	s1,24(sp)
    80001e4a:	6942                	ld	s2,16(sp)
    80001e4c:	69a2                	ld	s3,8(sp)
    80001e4e:	6145                	addi	sp,sp,48
    80001e50:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80001e52:	00006517          	auipc	a0,0x6
    80001e56:	4a650513          	addi	a0,a0,1190 # 800082f8 <states.1805+0xc8>
    80001e5a:	00004097          	auipc	ra,0x4
    80001e5e:	0ee080e7          	jalr	238(ra) # 80005f48 <panic>
    panic("kerneltrap: interrupts enabled");
    80001e62:	00006517          	auipc	a0,0x6
    80001e66:	4be50513          	addi	a0,a0,1214 # 80008320 <states.1805+0xf0>
    80001e6a:	00004097          	auipc	ra,0x4
    80001e6e:	0de080e7          	jalr	222(ra) # 80005f48 <panic>
    printf("scause %p\n", scause);
    80001e72:	85ce                	mv	a1,s3
    80001e74:	00006517          	auipc	a0,0x6
    80001e78:	4cc50513          	addi	a0,a0,1228 # 80008340 <states.1805+0x110>
    80001e7c:	00004097          	auipc	ra,0x4
    80001e80:	116080e7          	jalr	278(ra) # 80005f92 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001e84:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001e88:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001e8c:	00006517          	auipc	a0,0x6
    80001e90:	4c450513          	addi	a0,a0,1220 # 80008350 <states.1805+0x120>
    80001e94:	00004097          	auipc	ra,0x4
    80001e98:	0fe080e7          	jalr	254(ra) # 80005f92 <printf>
    panic("kerneltrap");
    80001e9c:	00006517          	auipc	a0,0x6
    80001ea0:	4cc50513          	addi	a0,a0,1228 # 80008368 <states.1805+0x138>
    80001ea4:	00004097          	auipc	ra,0x4
    80001ea8:	0a4080e7          	jalr	164(ra) # 80005f48 <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001eac:	fffff097          	auipc	ra,0xfffff
    80001eb0:	07a080e7          	jalr	122(ra) # 80000f26 <myproc>
    80001eb4:	d541                	beqz	a0,80001e3c <kerneltrap+0x38>
    80001eb6:	fffff097          	auipc	ra,0xfffff
    80001eba:	070080e7          	jalr	112(ra) # 80000f26 <myproc>
    80001ebe:	4d18                	lw	a4,24(a0)
    80001ec0:	4791                	li	a5,4
    80001ec2:	f6f71de3          	bne	a4,a5,80001e3c <kerneltrap+0x38>
    yield();
    80001ec6:	fffff097          	auipc	ra,0xfffff
    80001eca:	6e0080e7          	jalr	1760(ra) # 800015a6 <yield>
    80001ece:	b7bd                	j	80001e3c <kerneltrap+0x38>

0000000080001ed0 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80001ed0:	1101                	addi	sp,sp,-32
    80001ed2:	ec06                	sd	ra,24(sp)
    80001ed4:	e822                	sd	s0,16(sp)
    80001ed6:	e426                	sd	s1,8(sp)
    80001ed8:	1000                	addi	s0,sp,32
    80001eda:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001edc:	fffff097          	auipc	ra,0xfffff
    80001ee0:	04a080e7          	jalr	74(ra) # 80000f26 <myproc>
  switch (n) {
    80001ee4:	4795                	li	a5,5
    80001ee6:	0497e163          	bltu	a5,s1,80001f28 <argraw+0x58>
    80001eea:	048a                	slli	s1,s1,0x2
    80001eec:	00006717          	auipc	a4,0x6
    80001ef0:	4b470713          	addi	a4,a4,1204 # 800083a0 <states.1805+0x170>
    80001ef4:	94ba                	add	s1,s1,a4
    80001ef6:	409c                	lw	a5,0(s1)
    80001ef8:	97ba                	add	a5,a5,a4
    80001efa:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80001efc:	6d3c                	ld	a5,88(a0)
    80001efe:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80001f00:	60e2                	ld	ra,24(sp)
    80001f02:	6442                	ld	s0,16(sp)
    80001f04:	64a2                	ld	s1,8(sp)
    80001f06:	6105                	addi	sp,sp,32
    80001f08:	8082                	ret
    return p->trapframe->a1;
    80001f0a:	6d3c                	ld	a5,88(a0)
    80001f0c:	7fa8                	ld	a0,120(a5)
    80001f0e:	bfcd                	j	80001f00 <argraw+0x30>
    return p->trapframe->a2;
    80001f10:	6d3c                	ld	a5,88(a0)
    80001f12:	63c8                	ld	a0,128(a5)
    80001f14:	b7f5                	j	80001f00 <argraw+0x30>
    return p->trapframe->a3;
    80001f16:	6d3c                	ld	a5,88(a0)
    80001f18:	67c8                	ld	a0,136(a5)
    80001f1a:	b7dd                	j	80001f00 <argraw+0x30>
    return p->trapframe->a4;
    80001f1c:	6d3c                	ld	a5,88(a0)
    80001f1e:	6bc8                	ld	a0,144(a5)
    80001f20:	b7c5                	j	80001f00 <argraw+0x30>
    return p->trapframe->a5;
    80001f22:	6d3c                	ld	a5,88(a0)
    80001f24:	6fc8                	ld	a0,152(a5)
    80001f26:	bfe9                	j	80001f00 <argraw+0x30>
  panic("argraw");
    80001f28:	00006517          	auipc	a0,0x6
    80001f2c:	45050513          	addi	a0,a0,1104 # 80008378 <states.1805+0x148>
    80001f30:	00004097          	auipc	ra,0x4
    80001f34:	018080e7          	jalr	24(ra) # 80005f48 <panic>

0000000080001f38 <fetchaddr>:
{
    80001f38:	1101                	addi	sp,sp,-32
    80001f3a:	ec06                	sd	ra,24(sp)
    80001f3c:	e822                	sd	s0,16(sp)
    80001f3e:	e426                	sd	s1,8(sp)
    80001f40:	e04a                	sd	s2,0(sp)
    80001f42:	1000                	addi	s0,sp,32
    80001f44:	84aa                	mv	s1,a0
    80001f46:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001f48:	fffff097          	auipc	ra,0xfffff
    80001f4c:	fde080e7          	jalr	-34(ra) # 80000f26 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    80001f50:	653c                	ld	a5,72(a0)
    80001f52:	02f4f863          	bgeu	s1,a5,80001f82 <fetchaddr+0x4a>
    80001f56:	00848713          	addi	a4,s1,8
    80001f5a:	02e7e663          	bltu	a5,a4,80001f86 <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80001f5e:	46a1                	li	a3,8
    80001f60:	8626                	mv	a2,s1
    80001f62:	85ca                	mv	a1,s2
    80001f64:	6928                	ld	a0,80(a0)
    80001f66:	fffff097          	auipc	ra,0xfffff
    80001f6a:	c28080e7          	jalr	-984(ra) # 80000b8e <copyin>
    80001f6e:	00a03533          	snez	a0,a0
    80001f72:	40a00533          	neg	a0,a0
}
    80001f76:	60e2                	ld	ra,24(sp)
    80001f78:	6442                	ld	s0,16(sp)
    80001f7a:	64a2                	ld	s1,8(sp)
    80001f7c:	6902                	ld	s2,0(sp)
    80001f7e:	6105                	addi	sp,sp,32
    80001f80:	8082                	ret
    return -1;
    80001f82:	557d                	li	a0,-1
    80001f84:	bfcd                	j	80001f76 <fetchaddr+0x3e>
    80001f86:	557d                	li	a0,-1
    80001f88:	b7fd                	j	80001f76 <fetchaddr+0x3e>

0000000080001f8a <fetchstr>:
{
    80001f8a:	7179                	addi	sp,sp,-48
    80001f8c:	f406                	sd	ra,40(sp)
    80001f8e:	f022                	sd	s0,32(sp)
    80001f90:	ec26                	sd	s1,24(sp)
    80001f92:	e84a                	sd	s2,16(sp)
    80001f94:	e44e                	sd	s3,8(sp)
    80001f96:	1800                	addi	s0,sp,48
    80001f98:	892a                	mv	s2,a0
    80001f9a:	84ae                	mv	s1,a1
    80001f9c:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80001f9e:	fffff097          	auipc	ra,0xfffff
    80001fa2:	f88080e7          	jalr	-120(ra) # 80000f26 <myproc>
  int err = copyinstr(p->pagetable, buf, addr, max);
    80001fa6:	86ce                	mv	a3,s3
    80001fa8:	864a                	mv	a2,s2
    80001faa:	85a6                	mv	a1,s1
    80001fac:	6928                	ld	a0,80(a0)
    80001fae:	fffff097          	auipc	ra,0xfffff
    80001fb2:	c6c080e7          	jalr	-916(ra) # 80000c1a <copyinstr>
  if(err < 0)
    80001fb6:	00054763          	bltz	a0,80001fc4 <fetchstr+0x3a>
  return strlen(buf);
    80001fba:	8526                	mv	a0,s1
    80001fbc:	ffffe097          	auipc	ra,0xffffe
    80001fc0:	340080e7          	jalr	832(ra) # 800002fc <strlen>
}
    80001fc4:	70a2                	ld	ra,40(sp)
    80001fc6:	7402                	ld	s0,32(sp)
    80001fc8:	64e2                	ld	s1,24(sp)
    80001fca:	6942                	ld	s2,16(sp)
    80001fcc:	69a2                	ld	s3,8(sp)
    80001fce:	6145                	addi	sp,sp,48
    80001fd0:	8082                	ret

0000000080001fd2 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
    80001fd2:	1101                	addi	sp,sp,-32
    80001fd4:	ec06                	sd	ra,24(sp)
    80001fd6:	e822                	sd	s0,16(sp)
    80001fd8:	e426                	sd	s1,8(sp)
    80001fda:	1000                	addi	s0,sp,32
    80001fdc:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80001fde:	00000097          	auipc	ra,0x0
    80001fe2:	ef2080e7          	jalr	-270(ra) # 80001ed0 <argraw>
    80001fe6:	c088                	sw	a0,0(s1)
  return 0;
}
    80001fe8:	4501                	li	a0,0
    80001fea:	60e2                	ld	ra,24(sp)
    80001fec:	6442                	ld	s0,16(sp)
    80001fee:	64a2                	ld	s1,8(sp)
    80001ff0:	6105                	addi	sp,sp,32
    80001ff2:	8082                	ret

0000000080001ff4 <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int
argaddr(int n, uint64 *ip)
{
    80001ff4:	1101                	addi	sp,sp,-32
    80001ff6:	ec06                	sd	ra,24(sp)
    80001ff8:	e822                	sd	s0,16(sp)
    80001ffa:	e426                	sd	s1,8(sp)
    80001ffc:	1000                	addi	s0,sp,32
    80001ffe:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002000:	00000097          	auipc	ra,0x0
    80002004:	ed0080e7          	jalr	-304(ra) # 80001ed0 <argraw>
    80002008:	e088                	sd	a0,0(s1)
  return 0;
}
    8000200a:	4501                	li	a0,0
    8000200c:	60e2                	ld	ra,24(sp)
    8000200e:	6442                	ld	s0,16(sp)
    80002010:	64a2                	ld	s1,8(sp)
    80002012:	6105                	addi	sp,sp,32
    80002014:	8082                	ret

0000000080002016 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80002016:	1101                	addi	sp,sp,-32
    80002018:	ec06                	sd	ra,24(sp)
    8000201a:	e822                	sd	s0,16(sp)
    8000201c:	e426                	sd	s1,8(sp)
    8000201e:	e04a                	sd	s2,0(sp)
    80002020:	1000                	addi	s0,sp,32
    80002022:	84ae                	mv	s1,a1
    80002024:	8932                	mv	s2,a2
  *ip = argraw(n);
    80002026:	00000097          	auipc	ra,0x0
    8000202a:	eaa080e7          	jalr	-342(ra) # 80001ed0 <argraw>
  uint64 addr;
  if(argaddr(n, &addr) < 0)
    return -1;
  return fetchstr(addr, buf, max);
    8000202e:	864a                	mv	a2,s2
    80002030:	85a6                	mv	a1,s1
    80002032:	00000097          	auipc	ra,0x0
    80002036:	f58080e7          	jalr	-168(ra) # 80001f8a <fetchstr>
}
    8000203a:	60e2                	ld	ra,24(sp)
    8000203c:	6442                	ld	s0,16(sp)
    8000203e:	64a2                	ld	s1,8(sp)
    80002040:	6902                	ld	s2,0(sp)
    80002042:	6105                	addi	sp,sp,32
    80002044:	8082                	ret

0000000080002046 <syscall>:



void
syscall(void)
{
    80002046:	1101                	addi	sp,sp,-32
    80002048:	ec06                	sd	ra,24(sp)
    8000204a:	e822                	sd	s0,16(sp)
    8000204c:	e426                	sd	s1,8(sp)
    8000204e:	e04a                	sd	s2,0(sp)
    80002050:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    80002052:	fffff097          	auipc	ra,0xfffff
    80002056:	ed4080e7          	jalr	-300(ra) # 80000f26 <myproc>
    8000205a:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    8000205c:	05853903          	ld	s2,88(a0)
    80002060:	0a893783          	ld	a5,168(s2)
    80002064:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80002068:	37fd                	addiw	a5,a5,-1
    8000206a:	477d                	li	a4,31
    8000206c:	00f76f63          	bltu	a4,a5,8000208a <syscall+0x44>
    80002070:	00369713          	slli	a4,a3,0x3
    80002074:	00006797          	auipc	a5,0x6
    80002078:	34478793          	addi	a5,a5,836 # 800083b8 <syscalls>
    8000207c:	97ba                	add	a5,a5,a4
    8000207e:	639c                	ld	a5,0(a5)
    80002080:	c789                	beqz	a5,8000208a <syscall+0x44>
    p->trapframe->a0 = syscalls[num]();
    80002082:	9782                	jalr	a5
    80002084:	06a93823          	sd	a0,112(s2)
    80002088:	a839                	j	800020a6 <syscall+0x60>
  } else {
    printf("%d %s: unknown sys call %d\n",
    8000208a:	15848613          	addi	a2,s1,344
    8000208e:	588c                	lw	a1,48(s1)
    80002090:	00006517          	auipc	a0,0x6
    80002094:	2f050513          	addi	a0,a0,752 # 80008380 <states.1805+0x150>
    80002098:	00004097          	auipc	ra,0x4
    8000209c:	efa080e7          	jalr	-262(ra) # 80005f92 <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    800020a0:	6cbc                	ld	a5,88(s1)
    800020a2:	577d                	li	a4,-1
    800020a4:	fbb8                	sd	a4,112(a5)
  }
}
    800020a6:	60e2                	ld	ra,24(sp)
    800020a8:	6442                	ld	s0,16(sp)
    800020aa:	64a2                	ld	s1,8(sp)
    800020ac:	6902                	ld	s2,0(sp)
    800020ae:	6105                	addi	sp,sp,32
    800020b0:	8082                	ret

00000000800020b2 <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    800020b2:	1101                	addi	sp,sp,-32
    800020b4:	ec06                	sd	ra,24(sp)
    800020b6:	e822                	sd	s0,16(sp)
    800020b8:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    800020ba:	fec40593          	addi	a1,s0,-20
    800020be:	4501                	li	a0,0
    800020c0:	00000097          	auipc	ra,0x0
    800020c4:	f12080e7          	jalr	-238(ra) # 80001fd2 <argint>
    return -1;
    800020c8:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    800020ca:	00054963          	bltz	a0,800020dc <sys_exit+0x2a>
  exit(n);
    800020ce:	fec42503          	lw	a0,-20(s0)
    800020d2:	fffff097          	auipc	ra,0xfffff
    800020d6:	76c080e7          	jalr	1900(ra) # 8000183e <exit>
  return 0;  // not reached
    800020da:	4781                	li	a5,0
}
    800020dc:	853e                	mv	a0,a5
    800020de:	60e2                	ld	ra,24(sp)
    800020e0:	6442                	ld	s0,16(sp)
    800020e2:	6105                	addi	sp,sp,32
    800020e4:	8082                	ret

00000000800020e6 <sys_getpid>:

uint64
sys_getpid(void)
{
    800020e6:	1141                	addi	sp,sp,-16
    800020e8:	e406                	sd	ra,8(sp)
    800020ea:	e022                	sd	s0,0(sp)
    800020ec:	0800                	addi	s0,sp,16
  return myproc()->pid;
    800020ee:	fffff097          	auipc	ra,0xfffff
    800020f2:	e38080e7          	jalr	-456(ra) # 80000f26 <myproc>
}
    800020f6:	5908                	lw	a0,48(a0)
    800020f8:	60a2                	ld	ra,8(sp)
    800020fa:	6402                	ld	s0,0(sp)
    800020fc:	0141                	addi	sp,sp,16
    800020fe:	8082                	ret

0000000080002100 <sys_fork>:

uint64
sys_fork(void)
{
    80002100:	1141                	addi	sp,sp,-16
    80002102:	e406                	sd	ra,8(sp)
    80002104:	e022                	sd	s0,0(sp)
    80002106:	0800                	addi	s0,sp,16
  return fork();
    80002108:	fffff097          	auipc	ra,0xfffff
    8000210c:	1ec080e7          	jalr	492(ra) # 800012f4 <fork>
}
    80002110:	60a2                	ld	ra,8(sp)
    80002112:	6402                	ld	s0,0(sp)
    80002114:	0141                	addi	sp,sp,16
    80002116:	8082                	ret

0000000080002118 <sys_wait>:

uint64
sys_wait(void)
{
    80002118:	1101                	addi	sp,sp,-32
    8000211a:	ec06                	sd	ra,24(sp)
    8000211c:	e822                	sd	s0,16(sp)
    8000211e:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    80002120:	fe840593          	addi	a1,s0,-24
    80002124:	4501                	li	a0,0
    80002126:	00000097          	auipc	ra,0x0
    8000212a:	ece080e7          	jalr	-306(ra) # 80001ff4 <argaddr>
    8000212e:	87aa                	mv	a5,a0
    return -1;
    80002130:	557d                	li	a0,-1
  if(argaddr(0, &p) < 0)
    80002132:	0007c863          	bltz	a5,80002142 <sys_wait+0x2a>
  return wait(p);
    80002136:	fe843503          	ld	a0,-24(s0)
    8000213a:	fffff097          	auipc	ra,0xfffff
    8000213e:	50c080e7          	jalr	1292(ra) # 80001646 <wait>
}
    80002142:	60e2                	ld	ra,24(sp)
    80002144:	6442                	ld	s0,16(sp)
    80002146:	6105                	addi	sp,sp,32
    80002148:	8082                	ret

000000008000214a <sys_sbrk>:

uint64
sys_sbrk(void)
{
    8000214a:	7179                	addi	sp,sp,-48
    8000214c:	f406                	sd	ra,40(sp)
    8000214e:	f022                	sd	s0,32(sp)
    80002150:	ec26                	sd	s1,24(sp)
    80002152:	1800                	addi	s0,sp,48
  int addr;
  int n;

  if(argint(0, &n) < 0)
    80002154:	fdc40593          	addi	a1,s0,-36
    80002158:	4501                	li	a0,0
    8000215a:	00000097          	auipc	ra,0x0
    8000215e:	e78080e7          	jalr	-392(ra) # 80001fd2 <argint>
    80002162:	87aa                	mv	a5,a0
    return -1;
    80002164:	557d                	li	a0,-1
  if(argint(0, &n) < 0)
    80002166:	0207c063          	bltz	a5,80002186 <sys_sbrk+0x3c>
  
  addr = myproc()->sz;
    8000216a:	fffff097          	auipc	ra,0xfffff
    8000216e:	dbc080e7          	jalr	-580(ra) # 80000f26 <myproc>
    80002172:	4524                	lw	s1,72(a0)
  if(growproc(n) < 0)
    80002174:	fdc42503          	lw	a0,-36(s0)
    80002178:	fffff097          	auipc	ra,0xfffff
    8000217c:	108080e7          	jalr	264(ra) # 80001280 <growproc>
    80002180:	00054863          	bltz	a0,80002190 <sys_sbrk+0x46>
    return -1;
  return addr;
    80002184:	8526                	mv	a0,s1
}
    80002186:	70a2                	ld	ra,40(sp)
    80002188:	7402                	ld	s0,32(sp)
    8000218a:	64e2                	ld	s1,24(sp)
    8000218c:	6145                	addi	sp,sp,48
    8000218e:	8082                	ret
    return -1;
    80002190:	557d                	li	a0,-1
    80002192:	bfd5                	j	80002186 <sys_sbrk+0x3c>

0000000080002194 <sys_sleep>:

uint64
sys_sleep(void)
{
    80002194:	7139                	addi	sp,sp,-64
    80002196:	fc06                	sd	ra,56(sp)
    80002198:	f822                	sd	s0,48(sp)
    8000219a:	f426                	sd	s1,40(sp)
    8000219c:	f04a                	sd	s2,32(sp)
    8000219e:	ec4e                	sd	s3,24(sp)
    800021a0:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;


  if(argint(0, &n) < 0)
    800021a2:	fcc40593          	addi	a1,s0,-52
    800021a6:	4501                	li	a0,0
    800021a8:	00000097          	auipc	ra,0x0
    800021ac:	e2a080e7          	jalr	-470(ra) # 80001fd2 <argint>
    return -1;
    800021b0:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    800021b2:	06054563          	bltz	a0,8000221c <sys_sleep+0x88>
  acquire(&tickslock);
    800021b6:	0000d517          	auipc	a0,0xd
    800021ba:	cca50513          	addi	a0,a0,-822 # 8000ee80 <tickslock>
    800021be:	00004097          	auipc	ra,0x4
    800021c2:	2d4080e7          	jalr	724(ra) # 80006492 <acquire>
  ticks0 = ticks;
    800021c6:	00007917          	auipc	s2,0x7
    800021ca:	e5292903          	lw	s2,-430(s2) # 80009018 <ticks>
  while(ticks - ticks0 < n){
    800021ce:	fcc42783          	lw	a5,-52(s0)
    800021d2:	cf85                	beqz	a5,8000220a <sys_sleep+0x76>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    800021d4:	0000d997          	auipc	s3,0xd
    800021d8:	cac98993          	addi	s3,s3,-852 # 8000ee80 <tickslock>
    800021dc:	00007497          	auipc	s1,0x7
    800021e0:	e3c48493          	addi	s1,s1,-452 # 80009018 <ticks>
    if(myproc()->killed){
    800021e4:	fffff097          	auipc	ra,0xfffff
    800021e8:	d42080e7          	jalr	-702(ra) # 80000f26 <myproc>
    800021ec:	551c                	lw	a5,40(a0)
    800021ee:	ef9d                	bnez	a5,8000222c <sys_sleep+0x98>
    sleep(&ticks, &tickslock);
    800021f0:	85ce                	mv	a1,s3
    800021f2:	8526                	mv	a0,s1
    800021f4:	fffff097          	auipc	ra,0xfffff
    800021f8:	3ee080e7          	jalr	1006(ra) # 800015e2 <sleep>
  while(ticks - ticks0 < n){
    800021fc:	409c                	lw	a5,0(s1)
    800021fe:	412787bb          	subw	a5,a5,s2
    80002202:	fcc42703          	lw	a4,-52(s0)
    80002206:	fce7efe3          	bltu	a5,a4,800021e4 <sys_sleep+0x50>
  }
  release(&tickslock);
    8000220a:	0000d517          	auipc	a0,0xd
    8000220e:	c7650513          	addi	a0,a0,-906 # 8000ee80 <tickslock>
    80002212:	00004097          	auipc	ra,0x4
    80002216:	334080e7          	jalr	820(ra) # 80006546 <release>
  return 0;
    8000221a:	4781                	li	a5,0
}
    8000221c:	853e                	mv	a0,a5
    8000221e:	70e2                	ld	ra,56(sp)
    80002220:	7442                	ld	s0,48(sp)
    80002222:	74a2                	ld	s1,40(sp)
    80002224:	7902                	ld	s2,32(sp)
    80002226:	69e2                	ld	s3,24(sp)
    80002228:	6121                	addi	sp,sp,64
    8000222a:	8082                	ret
      release(&tickslock);
    8000222c:	0000d517          	auipc	a0,0xd
    80002230:	c5450513          	addi	a0,a0,-940 # 8000ee80 <tickslock>
    80002234:	00004097          	auipc	ra,0x4
    80002238:	312080e7          	jalr	786(ra) # 80006546 <release>
      return -1;
    8000223c:	57fd                	li	a5,-1
    8000223e:	bff9                	j	8000221c <sys_sleep+0x88>

0000000080002240 <sys_pgaccess>:


#ifdef LAB_PGTBL
int
sys_pgaccess(void)
{
    80002240:	1141                	addi	sp,sp,-16
    80002242:	e422                	sd	s0,8(sp)
    80002244:	0800                	addi	s0,sp,16
  // lab pgtbl: your code here.
  return 0;
}
    80002246:	4501                	li	a0,0
    80002248:	6422                	ld	s0,8(sp)
    8000224a:	0141                	addi	sp,sp,16
    8000224c:	8082                	ret

000000008000224e <sys_kill>:
#endif

uint64
sys_kill(void)
{
    8000224e:	1101                	addi	sp,sp,-32
    80002250:	ec06                	sd	ra,24(sp)
    80002252:	e822                	sd	s0,16(sp)
    80002254:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    80002256:	fec40593          	addi	a1,s0,-20
    8000225a:	4501                	li	a0,0
    8000225c:	00000097          	auipc	ra,0x0
    80002260:	d76080e7          	jalr	-650(ra) # 80001fd2 <argint>
    80002264:	87aa                	mv	a5,a0
    return -1;
    80002266:	557d                	li	a0,-1
  if(argint(0, &pid) < 0)
    80002268:	0007c863          	bltz	a5,80002278 <sys_kill+0x2a>
  return kill(pid);
    8000226c:	fec42503          	lw	a0,-20(s0)
    80002270:	fffff097          	auipc	ra,0xfffff
    80002274:	6a4080e7          	jalr	1700(ra) # 80001914 <kill>
}
    80002278:	60e2                	ld	ra,24(sp)
    8000227a:	6442                	ld	s0,16(sp)
    8000227c:	6105                	addi	sp,sp,32
    8000227e:	8082                	ret

0000000080002280 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80002280:	1101                	addi	sp,sp,-32
    80002282:	ec06                	sd	ra,24(sp)
    80002284:	e822                	sd	s0,16(sp)
    80002286:	e426                	sd	s1,8(sp)
    80002288:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    8000228a:	0000d517          	auipc	a0,0xd
    8000228e:	bf650513          	addi	a0,a0,-1034 # 8000ee80 <tickslock>
    80002292:	00004097          	auipc	ra,0x4
    80002296:	200080e7          	jalr	512(ra) # 80006492 <acquire>
  xticks = ticks;
    8000229a:	00007497          	auipc	s1,0x7
    8000229e:	d7e4a483          	lw	s1,-642(s1) # 80009018 <ticks>
  release(&tickslock);
    800022a2:	0000d517          	auipc	a0,0xd
    800022a6:	bde50513          	addi	a0,a0,-1058 # 8000ee80 <tickslock>
    800022aa:	00004097          	auipc	ra,0x4
    800022ae:	29c080e7          	jalr	668(ra) # 80006546 <release>
  return xticks;
}
    800022b2:	02049513          	slli	a0,s1,0x20
    800022b6:	9101                	srli	a0,a0,0x20
    800022b8:	60e2                	ld	ra,24(sp)
    800022ba:	6442                	ld	s0,16(sp)
    800022bc:	64a2                	ld	s1,8(sp)
    800022be:	6105                	addi	sp,sp,32
    800022c0:	8082                	ret

00000000800022c2 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
    800022c2:	7179                	addi	sp,sp,-48
    800022c4:	f406                	sd	ra,40(sp)
    800022c6:	f022                	sd	s0,32(sp)
    800022c8:	ec26                	sd	s1,24(sp)
    800022ca:	e84a                	sd	s2,16(sp)
    800022cc:	e44e                	sd	s3,8(sp)
    800022ce:	1800                	addi	s0,sp,48
    800022d0:	892a                	mv	s2,a0
    800022d2:	89ae                	mv	s3,a1
  struct buf *b;

  acquire(&bcache.lock);
    800022d4:	0000d517          	auipc	a0,0xd
    800022d8:	bc450513          	addi	a0,a0,-1084 # 8000ee98 <bcache>
    800022dc:	00004097          	auipc	ra,0x4
    800022e0:	1b6080e7          	jalr	438(ra) # 80006492 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    800022e4:	00015497          	auipc	s1,0x15
    800022e8:	e6c4b483          	ld	s1,-404(s1) # 80017150 <bcache+0x82b8>
    800022ec:	00015797          	auipc	a5,0x15
    800022f0:	e1478793          	addi	a5,a5,-492 # 80017100 <bcache+0x8268>
    800022f4:	02f48f63          	beq	s1,a5,80002332 <bget+0x70>
    800022f8:	873e                	mv	a4,a5
    800022fa:	a021                	j	80002302 <bget+0x40>
    800022fc:	68a4                	ld	s1,80(s1)
    800022fe:	02e48a63          	beq	s1,a4,80002332 <bget+0x70>
    if(b->dev == dev && b->blockno == blockno){
    80002302:	449c                	lw	a5,8(s1)
    80002304:	ff279ce3          	bne	a5,s2,800022fc <bget+0x3a>
    80002308:	44dc                	lw	a5,12(s1)
    8000230a:	ff3799e3          	bne	a5,s3,800022fc <bget+0x3a>
      b->refcnt++;
    8000230e:	40bc                	lw	a5,64(s1)
    80002310:	2785                	addiw	a5,a5,1
    80002312:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002314:	0000d517          	auipc	a0,0xd
    80002318:	b8450513          	addi	a0,a0,-1148 # 8000ee98 <bcache>
    8000231c:	00004097          	auipc	ra,0x4
    80002320:	22a080e7          	jalr	554(ra) # 80006546 <release>
      acquiresleep(&b->lock);
    80002324:	01048513          	addi	a0,s1,16
    80002328:	00001097          	auipc	ra,0x1
    8000232c:	736080e7          	jalr	1846(ra) # 80003a5e <acquiresleep>
      return b;
    80002330:	a8b9                	j	8000238e <bget+0xcc>
    }
  }

  // Not cached.
  // Recycle the least recently used (LRU) unused buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002332:	00015497          	auipc	s1,0x15
    80002336:	e164b483          	ld	s1,-490(s1) # 80017148 <bcache+0x82b0>
    8000233a:	00015797          	auipc	a5,0x15
    8000233e:	dc678793          	addi	a5,a5,-570 # 80017100 <bcache+0x8268>
    80002342:	00f48863          	beq	s1,a5,80002352 <bget+0x90>
    80002346:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    80002348:	40bc                	lw	a5,64(s1)
    8000234a:	cf81                	beqz	a5,80002362 <bget+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    8000234c:	64a4                	ld	s1,72(s1)
    8000234e:	fee49de3          	bne	s1,a4,80002348 <bget+0x86>
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
    80002352:	00006517          	auipc	a0,0x6
    80002356:	16e50513          	addi	a0,a0,366 # 800084c0 <syscalls+0x108>
    8000235a:	00004097          	auipc	ra,0x4
    8000235e:	bee080e7          	jalr	-1042(ra) # 80005f48 <panic>
      b->dev = dev;
    80002362:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    80002366:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    8000236a:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    8000236e:	4785                	li	a5,1
    80002370:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002372:	0000d517          	auipc	a0,0xd
    80002376:	b2650513          	addi	a0,a0,-1242 # 8000ee98 <bcache>
    8000237a:	00004097          	auipc	ra,0x4
    8000237e:	1cc080e7          	jalr	460(ra) # 80006546 <release>
      acquiresleep(&b->lock);
    80002382:	01048513          	addi	a0,s1,16
    80002386:	00001097          	auipc	ra,0x1
    8000238a:	6d8080e7          	jalr	1752(ra) # 80003a5e <acquiresleep>
}
    8000238e:	8526                	mv	a0,s1
    80002390:	70a2                	ld	ra,40(sp)
    80002392:	7402                	ld	s0,32(sp)
    80002394:	64e2                	ld	s1,24(sp)
    80002396:	6942                	ld	s2,16(sp)
    80002398:	69a2                	ld	s3,8(sp)
    8000239a:	6145                	addi	sp,sp,48
    8000239c:	8082                	ret

000000008000239e <binit>:
{
    8000239e:	7179                	addi	sp,sp,-48
    800023a0:	f406                	sd	ra,40(sp)
    800023a2:	f022                	sd	s0,32(sp)
    800023a4:	ec26                	sd	s1,24(sp)
    800023a6:	e84a                	sd	s2,16(sp)
    800023a8:	e44e                	sd	s3,8(sp)
    800023aa:	e052                	sd	s4,0(sp)
    800023ac:	1800                	addi	s0,sp,48
  initlock(&bcache.lock, "bcache");
    800023ae:	00006597          	auipc	a1,0x6
    800023b2:	12a58593          	addi	a1,a1,298 # 800084d8 <syscalls+0x120>
    800023b6:	0000d517          	auipc	a0,0xd
    800023ba:	ae250513          	addi	a0,a0,-1310 # 8000ee98 <bcache>
    800023be:	00004097          	auipc	ra,0x4
    800023c2:	044080e7          	jalr	68(ra) # 80006402 <initlock>
  bcache.head.prev = &bcache.head;
    800023c6:	00015797          	auipc	a5,0x15
    800023ca:	ad278793          	addi	a5,a5,-1326 # 80016e98 <bcache+0x8000>
    800023ce:	00015717          	auipc	a4,0x15
    800023d2:	d3270713          	addi	a4,a4,-718 # 80017100 <bcache+0x8268>
    800023d6:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    800023da:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    800023de:	0000d497          	auipc	s1,0xd
    800023e2:	ad248493          	addi	s1,s1,-1326 # 8000eeb0 <bcache+0x18>
    b->next = bcache.head.next;
    800023e6:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    800023e8:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    800023ea:	00006a17          	auipc	s4,0x6
    800023ee:	0f6a0a13          	addi	s4,s4,246 # 800084e0 <syscalls+0x128>
    b->next = bcache.head.next;
    800023f2:	2b893783          	ld	a5,696(s2)
    800023f6:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    800023f8:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    800023fc:	85d2                	mv	a1,s4
    800023fe:	01048513          	addi	a0,s1,16
    80002402:	00001097          	auipc	ra,0x1
    80002406:	622080e7          	jalr	1570(ra) # 80003a24 <initsleeplock>
    bcache.head.next->prev = b;
    8000240a:	2b893783          	ld	a5,696(s2)
    8000240e:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80002410:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002414:	45848493          	addi	s1,s1,1112
    80002418:	fd349de3          	bne	s1,s3,800023f2 <binit+0x54>
}
    8000241c:	70a2                	ld	ra,40(sp)
    8000241e:	7402                	ld	s0,32(sp)
    80002420:	64e2                	ld	s1,24(sp)
    80002422:	6942                	ld	s2,16(sp)
    80002424:	69a2                	ld	s3,8(sp)
    80002426:	6a02                	ld	s4,0(sp)
    80002428:	6145                	addi	sp,sp,48
    8000242a:	8082                	ret

000000008000242c <bread>:

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    8000242c:	1101                	addi	sp,sp,-32
    8000242e:	ec06                	sd	ra,24(sp)
    80002430:	e822                	sd	s0,16(sp)
    80002432:	e426                	sd	s1,8(sp)
    80002434:	1000                	addi	s0,sp,32
  struct buf *b;

  b = bget(dev, blockno);
    80002436:	00000097          	auipc	ra,0x0
    8000243a:	e8c080e7          	jalr	-372(ra) # 800022c2 <bget>
    8000243e:	84aa                	mv	s1,a0
  if(!b->valid) {
    80002440:	411c                	lw	a5,0(a0)
    80002442:	c799                	beqz	a5,80002450 <bread+0x24>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    80002444:	8526                	mv	a0,s1
    80002446:	60e2                	ld	ra,24(sp)
    80002448:	6442                	ld	s0,16(sp)
    8000244a:	64a2                	ld	s1,8(sp)
    8000244c:	6105                	addi	sp,sp,32
    8000244e:	8082                	ret
    virtio_disk_rw(b, 0);
    80002450:	4581                	li	a1,0
    80002452:	00003097          	auipc	ra,0x3
    80002456:	134080e7          	jalr	308(ra) # 80005586 <virtio_disk_rw>
    b->valid = 1;
    8000245a:	4785                	li	a5,1
    8000245c:	c09c                	sw	a5,0(s1)
  return b;
    8000245e:	b7dd                	j	80002444 <bread+0x18>

0000000080002460 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    80002460:	1101                	addi	sp,sp,-32
    80002462:	ec06                	sd	ra,24(sp)
    80002464:	e822                	sd	s0,16(sp)
    80002466:	e426                	sd	s1,8(sp)
    80002468:	1000                	addi	s0,sp,32
    8000246a:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    8000246c:	0541                	addi	a0,a0,16
    8000246e:	00001097          	auipc	ra,0x1
    80002472:	68a080e7          	jalr	1674(ra) # 80003af8 <holdingsleep>
    80002476:	cd01                	beqz	a0,8000248e <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    80002478:	4585                	li	a1,1
    8000247a:	8526                	mv	a0,s1
    8000247c:	00003097          	auipc	ra,0x3
    80002480:	10a080e7          	jalr	266(ra) # 80005586 <virtio_disk_rw>
}
    80002484:	60e2                	ld	ra,24(sp)
    80002486:	6442                	ld	s0,16(sp)
    80002488:	64a2                	ld	s1,8(sp)
    8000248a:	6105                	addi	sp,sp,32
    8000248c:	8082                	ret
    panic("bwrite");
    8000248e:	00006517          	auipc	a0,0x6
    80002492:	05a50513          	addi	a0,a0,90 # 800084e8 <syscalls+0x130>
    80002496:	00004097          	auipc	ra,0x4
    8000249a:	ab2080e7          	jalr	-1358(ra) # 80005f48 <panic>

000000008000249e <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    8000249e:	1101                	addi	sp,sp,-32
    800024a0:	ec06                	sd	ra,24(sp)
    800024a2:	e822                	sd	s0,16(sp)
    800024a4:	e426                	sd	s1,8(sp)
    800024a6:	e04a                	sd	s2,0(sp)
    800024a8:	1000                	addi	s0,sp,32
    800024aa:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800024ac:	01050913          	addi	s2,a0,16
    800024b0:	854a                	mv	a0,s2
    800024b2:	00001097          	auipc	ra,0x1
    800024b6:	646080e7          	jalr	1606(ra) # 80003af8 <holdingsleep>
    800024ba:	c92d                	beqz	a0,8000252c <brelse+0x8e>
    panic("brelse");

  releasesleep(&b->lock);
    800024bc:	854a                	mv	a0,s2
    800024be:	00001097          	auipc	ra,0x1
    800024c2:	5f6080e7          	jalr	1526(ra) # 80003ab4 <releasesleep>

  acquire(&bcache.lock);
    800024c6:	0000d517          	auipc	a0,0xd
    800024ca:	9d250513          	addi	a0,a0,-1582 # 8000ee98 <bcache>
    800024ce:	00004097          	auipc	ra,0x4
    800024d2:	fc4080e7          	jalr	-60(ra) # 80006492 <acquire>
  b->refcnt--;
    800024d6:	40bc                	lw	a5,64(s1)
    800024d8:	37fd                	addiw	a5,a5,-1
    800024da:	0007871b          	sext.w	a4,a5
    800024de:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    800024e0:	eb05                	bnez	a4,80002510 <brelse+0x72>
    // no one is waiting for it.
    b->next->prev = b->prev;
    800024e2:	68bc                	ld	a5,80(s1)
    800024e4:	64b8                	ld	a4,72(s1)
    800024e6:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    800024e8:	64bc                	ld	a5,72(s1)
    800024ea:	68b8                	ld	a4,80(s1)
    800024ec:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    800024ee:	00015797          	auipc	a5,0x15
    800024f2:	9aa78793          	addi	a5,a5,-1622 # 80016e98 <bcache+0x8000>
    800024f6:	2b87b703          	ld	a4,696(a5)
    800024fa:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    800024fc:	00015717          	auipc	a4,0x15
    80002500:	c0470713          	addi	a4,a4,-1020 # 80017100 <bcache+0x8268>
    80002504:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    80002506:	2b87b703          	ld	a4,696(a5)
    8000250a:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    8000250c:	2a97bc23          	sd	s1,696(a5)
  }

  release(&bcache.lock);
    80002510:	0000d517          	auipc	a0,0xd
    80002514:	98850513          	addi	a0,a0,-1656 # 8000ee98 <bcache>
    80002518:	00004097          	auipc	ra,0x4
    8000251c:	02e080e7          	jalr	46(ra) # 80006546 <release>
}
    80002520:	60e2                	ld	ra,24(sp)
    80002522:	6442                	ld	s0,16(sp)
    80002524:	64a2                	ld	s1,8(sp)
    80002526:	6902                	ld	s2,0(sp)
    80002528:	6105                	addi	sp,sp,32
    8000252a:	8082                	ret
    panic("brelse");
    8000252c:	00006517          	auipc	a0,0x6
    80002530:	fc450513          	addi	a0,a0,-60 # 800084f0 <syscalls+0x138>
    80002534:	00004097          	auipc	ra,0x4
    80002538:	a14080e7          	jalr	-1516(ra) # 80005f48 <panic>

000000008000253c <bpin>:

void
bpin(struct buf *b) {
    8000253c:	1101                	addi	sp,sp,-32
    8000253e:	ec06                	sd	ra,24(sp)
    80002540:	e822                	sd	s0,16(sp)
    80002542:	e426                	sd	s1,8(sp)
    80002544:	1000                	addi	s0,sp,32
    80002546:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002548:	0000d517          	auipc	a0,0xd
    8000254c:	95050513          	addi	a0,a0,-1712 # 8000ee98 <bcache>
    80002550:	00004097          	auipc	ra,0x4
    80002554:	f42080e7          	jalr	-190(ra) # 80006492 <acquire>
  b->refcnt++;
    80002558:	40bc                	lw	a5,64(s1)
    8000255a:	2785                	addiw	a5,a5,1
    8000255c:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    8000255e:	0000d517          	auipc	a0,0xd
    80002562:	93a50513          	addi	a0,a0,-1734 # 8000ee98 <bcache>
    80002566:	00004097          	auipc	ra,0x4
    8000256a:	fe0080e7          	jalr	-32(ra) # 80006546 <release>
}
    8000256e:	60e2                	ld	ra,24(sp)
    80002570:	6442                	ld	s0,16(sp)
    80002572:	64a2                	ld	s1,8(sp)
    80002574:	6105                	addi	sp,sp,32
    80002576:	8082                	ret

0000000080002578 <bunpin>:

void
bunpin(struct buf *b) {
    80002578:	1101                	addi	sp,sp,-32
    8000257a:	ec06                	sd	ra,24(sp)
    8000257c:	e822                	sd	s0,16(sp)
    8000257e:	e426                	sd	s1,8(sp)
    80002580:	1000                	addi	s0,sp,32
    80002582:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002584:	0000d517          	auipc	a0,0xd
    80002588:	91450513          	addi	a0,a0,-1772 # 8000ee98 <bcache>
    8000258c:	00004097          	auipc	ra,0x4
    80002590:	f06080e7          	jalr	-250(ra) # 80006492 <acquire>
  b->refcnt--;
    80002594:	40bc                	lw	a5,64(s1)
    80002596:	37fd                	addiw	a5,a5,-1
    80002598:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    8000259a:	0000d517          	auipc	a0,0xd
    8000259e:	8fe50513          	addi	a0,a0,-1794 # 8000ee98 <bcache>
    800025a2:	00004097          	auipc	ra,0x4
    800025a6:	fa4080e7          	jalr	-92(ra) # 80006546 <release>
}
    800025aa:	60e2                	ld	ra,24(sp)
    800025ac:	6442                	ld	s0,16(sp)
    800025ae:	64a2                	ld	s1,8(sp)
    800025b0:	6105                	addi	sp,sp,32
    800025b2:	8082                	ret

00000000800025b4 <write_page_to_disk>:

/* NTU OS 2024 */
/* Write 4096 bytes page to the eight consecutive 512-byte blocks starting at blk. */
void write_page_to_disk(uint dev, char *page, uint blk) {
    800025b4:	7179                	addi	sp,sp,-48
    800025b6:	f406                	sd	ra,40(sp)
    800025b8:	f022                	sd	s0,32(sp)
    800025ba:	ec26                	sd	s1,24(sp)
    800025bc:	e84a                	sd	s2,16(sp)
    800025be:	e44e                	sd	s3,8(sp)
    800025c0:	e052                	sd	s4,0(sp)
    800025c2:	1800                	addi	s0,sp,48
    800025c4:	89b2                	mv	s3,a2
  for (int i = 0; i < 8; i++) {
    800025c6:	892e                	mv	s2,a1
    800025c8:	6a05                	lui	s4,0x1
    800025ca:	9a2e                	add	s4,s4,a1
    // disk
    int offset = i * 512;
    int blk_idx = blk + i;
    struct buf *buffer = bget(ROOTDEV, blk_idx);
    800025cc:	85ce                	mv	a1,s3
    800025ce:	4505                	li	a0,1
    800025d0:	00000097          	auipc	ra,0x0
    800025d4:	cf2080e7          	jalr	-782(ra) # 800022c2 <bget>
    800025d8:	84aa                	mv	s1,a0
    memmove(buffer->data, page + offset, 512);
    800025da:	20000613          	li	a2,512
    800025de:	85ca                	mv	a1,s2
    800025e0:	05850513          	addi	a0,a0,88
    800025e4:	ffffe097          	auipc	ra,0xffffe
    800025e8:	bf4080e7          	jalr	-1036(ra) # 800001d8 <memmove>
    bwrite(buffer);
    800025ec:	8526                	mv	a0,s1
    800025ee:	00000097          	auipc	ra,0x0
    800025f2:	e72080e7          	jalr	-398(ra) # 80002460 <bwrite>
    brelse(buffer);
    800025f6:	8526                	mv	a0,s1
    800025f8:	00000097          	auipc	ra,0x0
    800025fc:	ea6080e7          	jalr	-346(ra) # 8000249e <brelse>
  for (int i = 0; i < 8; i++) {
    80002600:	2985                	addiw	s3,s3,1
    80002602:	20090913          	addi	s2,s2,512
    80002606:	fd4913e3          	bne	s2,s4,800025cc <write_page_to_disk+0x18>
  }
}
    8000260a:	70a2                	ld	ra,40(sp)
    8000260c:	7402                	ld	s0,32(sp)
    8000260e:	64e2                	ld	s1,24(sp)
    80002610:	6942                	ld	s2,16(sp)
    80002612:	69a2                	ld	s3,8(sp)
    80002614:	6a02                	ld	s4,0(sp)
    80002616:	6145                	addi	sp,sp,48
    80002618:	8082                	ret

000000008000261a <read_page_from_disk>:

/* NTU OS 2024 */
/* Read 4096 bytes from the eight consecutive 512-byte blocks starting at blk into page. */
void read_page_from_disk(uint dev, char *page, uint blk) {
    8000261a:	7179                	addi	sp,sp,-48
    8000261c:	f406                	sd	ra,40(sp)
    8000261e:	f022                	sd	s0,32(sp)
    80002620:	ec26                	sd	s1,24(sp)
    80002622:	e84a                	sd	s2,16(sp)
    80002624:	e44e                	sd	s3,8(sp)
    80002626:	e052                	sd	s4,0(sp)
    80002628:	1800                	addi	s0,sp,48
    8000262a:	89b2                	mv	s3,a2
  for (int i = 0; i < 8; i++) {
    8000262c:	892e                	mv	s2,a1
    8000262e:	6a05                	lui	s4,0x1
    80002630:	9a2e                	add	s4,s4,a1
    int offset = i * 512;
    int blk_idx = blk + i;
    struct buf *buffer = bread(ROOTDEV, blk_idx);
    80002632:	85ce                	mv	a1,s3
    80002634:	4505                	li	a0,1
    80002636:	00000097          	auipc	ra,0x0
    8000263a:	df6080e7          	jalr	-522(ra) # 8000242c <bread>
    8000263e:	84aa                	mv	s1,a0
    memmove(page + offset, buffer->data, 512);
    80002640:	20000613          	li	a2,512
    80002644:	05850593          	addi	a1,a0,88
    80002648:	854a                	mv	a0,s2
    8000264a:	ffffe097          	auipc	ra,0xffffe
    8000264e:	b8e080e7          	jalr	-1138(ra) # 800001d8 <memmove>
    brelse(buffer);
    80002652:	8526                	mv	a0,s1
    80002654:	00000097          	auipc	ra,0x0
    80002658:	e4a080e7          	jalr	-438(ra) # 8000249e <brelse>
  for (int i = 0; i < 8; i++) {
    8000265c:	2985                	addiw	s3,s3,1
    8000265e:	20090913          	addi	s2,s2,512
    80002662:	fd4918e3          	bne	s2,s4,80002632 <read_page_from_disk+0x18>
  }
}
    80002666:	70a2                	ld	ra,40(sp)
    80002668:	7402                	ld	s0,32(sp)
    8000266a:	64e2                	ld	s1,24(sp)
    8000266c:	6942                	ld	s2,16(sp)
    8000266e:	69a2                	ld	s3,8(sp)
    80002670:	6a02                	ld	s4,0(sp)
    80002672:	6145                	addi	sp,sp,48
    80002674:	8082                	ret

0000000080002676 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80002676:	1101                	addi	sp,sp,-32
    80002678:	ec06                	sd	ra,24(sp)
    8000267a:	e822                	sd	s0,16(sp)
    8000267c:	e426                	sd	s1,8(sp)
    8000267e:	1000                	addi	s0,sp,32
    80002680:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    80002682:	00d5d59b          	srliw	a1,a1,0xd
    80002686:	00015797          	auipc	a5,0x15
    8000268a:	eee7a783          	lw	a5,-274(a5) # 80017574 <sb+0x1c>
    8000268e:	9dbd                	addw	a1,a1,a5
    80002690:	00000097          	auipc	ra,0x0
    80002694:	d9c080e7          	jalr	-612(ra) # 8000242c <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    80002698:	0074f713          	andi	a4,s1,7
    8000269c:	4785                	li	a5,1
    8000269e:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    800026a2:	14ce                	slli	s1,s1,0x33
    800026a4:	90d9                	srli	s1,s1,0x36
    800026a6:	00950733          	add	a4,a0,s1
    800026aa:	05874703          	lbu	a4,88(a4)
    800026ae:	00e7f6b3          	and	a3,a5,a4
    800026b2:	c285                	beqz	a3,800026d2 <bfree+0x5c>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    800026b4:	94aa                	add	s1,s1,a0
    800026b6:	fff7c793          	not	a5,a5
    800026ba:	8ff9                	and	a5,a5,a4
    800026bc:	04f48c23          	sb	a5,88(s1)
  //log_write(bp);
  brelse(bp);
    800026c0:	00000097          	auipc	ra,0x0
    800026c4:	dde080e7          	jalr	-546(ra) # 8000249e <brelse>
}
    800026c8:	60e2                	ld	ra,24(sp)
    800026ca:	6442                	ld	s0,16(sp)
    800026cc:	64a2                	ld	s1,8(sp)
    800026ce:	6105                	addi	sp,sp,32
    800026d0:	8082                	ret
    panic("freeing free block");
    800026d2:	00006517          	auipc	a0,0x6
    800026d6:	e2650513          	addi	a0,a0,-474 # 800084f8 <syscalls+0x140>
    800026da:	00004097          	auipc	ra,0x4
    800026de:	86e080e7          	jalr	-1938(ra) # 80005f48 <panic>

00000000800026e2 <bzero>:
{
    800026e2:	1101                	addi	sp,sp,-32
    800026e4:	ec06                	sd	ra,24(sp)
    800026e6:	e822                	sd	s0,16(sp)
    800026e8:	e426                	sd	s1,8(sp)
    800026ea:	1000                	addi	s0,sp,32
  bp = bread(dev, bno);
    800026ec:	00000097          	auipc	ra,0x0
    800026f0:	d40080e7          	jalr	-704(ra) # 8000242c <bread>
    800026f4:	84aa                	mv	s1,a0
  memset(bp->data, 0, BSIZE);
    800026f6:	40000613          	li	a2,1024
    800026fa:	4581                	li	a1,0
    800026fc:	05850513          	addi	a0,a0,88
    80002700:	ffffe097          	auipc	ra,0xffffe
    80002704:	a78080e7          	jalr	-1416(ra) # 80000178 <memset>
  brelse(bp);
    80002708:	8526                	mv	a0,s1
    8000270a:	00000097          	auipc	ra,0x0
    8000270e:	d94080e7          	jalr	-620(ra) # 8000249e <brelse>
}
    80002712:	60e2                	ld	ra,24(sp)
    80002714:	6442                	ld	s0,16(sp)
    80002716:	64a2                	ld	s1,8(sp)
    80002718:	6105                	addi	sp,sp,32
    8000271a:	8082                	ret

000000008000271c <balloc>:
{
    8000271c:	711d                	addi	sp,sp,-96
    8000271e:	ec86                	sd	ra,88(sp)
    80002720:	e8a2                	sd	s0,80(sp)
    80002722:	e4a6                	sd	s1,72(sp)
    80002724:	e0ca                	sd	s2,64(sp)
    80002726:	fc4e                	sd	s3,56(sp)
    80002728:	f852                	sd	s4,48(sp)
    8000272a:	f456                	sd	s5,40(sp)
    8000272c:	f05a                	sd	s6,32(sp)
    8000272e:	ec5e                	sd	s7,24(sp)
    80002730:	e862                	sd	s8,16(sp)
    80002732:	e466                	sd	s9,8(sp)
    80002734:	1080                	addi	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    80002736:	00015797          	auipc	a5,0x15
    8000273a:	e267a783          	lw	a5,-474(a5) # 8001755c <sb+0x4>
    8000273e:	cbd1                	beqz	a5,800027d2 <balloc+0xb6>
    80002740:	8baa                	mv	s7,a0
    80002742:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80002744:	00015b17          	auipc	s6,0x15
    80002748:	e14b0b13          	addi	s6,s6,-492 # 80017558 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000274c:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    8000274e:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002750:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    80002752:	6c89                	lui	s9,0x2
    80002754:	a829                	j	8000276e <balloc+0x52>
    brelse(bp);
    80002756:	00000097          	auipc	ra,0x0
    8000275a:	d48080e7          	jalr	-696(ra) # 8000249e <brelse>
  for(b = 0; b < sb.size; b += BPB){
    8000275e:	015c87bb          	addw	a5,s9,s5
    80002762:	00078a9b          	sext.w	s5,a5
    80002766:	004b2703          	lw	a4,4(s6)
    8000276a:	06eaf463          	bgeu	s5,a4,800027d2 <balloc+0xb6>
    bp = bread(dev, BBLOCK(b, sb));
    8000276e:	41fad79b          	sraiw	a5,s5,0x1f
    80002772:	0137d79b          	srliw	a5,a5,0x13
    80002776:	015787bb          	addw	a5,a5,s5
    8000277a:	40d7d79b          	sraiw	a5,a5,0xd
    8000277e:	01cb2583          	lw	a1,28(s6)
    80002782:	9dbd                	addw	a1,a1,a5
    80002784:	855e                	mv	a0,s7
    80002786:	00000097          	auipc	ra,0x0
    8000278a:	ca6080e7          	jalr	-858(ra) # 8000242c <bread>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000278e:	004b2803          	lw	a6,4(s6)
    80002792:	000a849b          	sext.w	s1,s5
    80002796:	8662                	mv	a2,s8
    80002798:	0004891b          	sext.w	s2,s1
    8000279c:	fb04fde3          	bgeu	s1,a6,80002756 <balloc+0x3a>
      m = 1 << (bi % 8);
    800027a0:	41f6579b          	sraiw	a5,a2,0x1f
    800027a4:	01d7d69b          	srliw	a3,a5,0x1d
    800027a8:	00c6873b          	addw	a4,a3,a2
    800027ac:	00777793          	andi	a5,a4,7
    800027b0:	9f95                	subw	a5,a5,a3
    800027b2:	00f997bb          	sllw	a5,s3,a5
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    800027b6:	4037571b          	sraiw	a4,a4,0x3
    800027ba:	00e506b3          	add	a3,a0,a4
    800027be:	0586c683          	lbu	a3,88(a3)
    800027c2:	00d7f5b3          	and	a1,a5,a3
    800027c6:	cd91                	beqz	a1,800027e2 <balloc+0xc6>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800027c8:	2605                	addiw	a2,a2,1
    800027ca:	2485                	addiw	s1,s1,1
    800027cc:	fd4616e3          	bne	a2,s4,80002798 <balloc+0x7c>
    800027d0:	b759                	j	80002756 <balloc+0x3a>
  panic("balloc: out of blocks");
    800027d2:	00006517          	auipc	a0,0x6
    800027d6:	d3e50513          	addi	a0,a0,-706 # 80008510 <syscalls+0x158>
    800027da:	00003097          	auipc	ra,0x3
    800027de:	76e080e7          	jalr	1902(ra) # 80005f48 <panic>
        bp->data[bi/8] |= m;  // Mark block in use.
    800027e2:	972a                	add	a4,a4,a0
    800027e4:	8fd5                	or	a5,a5,a3
    800027e6:	04f70c23          	sb	a5,88(a4)
        brelse(bp);
    800027ea:	00000097          	auipc	ra,0x0
    800027ee:	cb4080e7          	jalr	-844(ra) # 8000249e <brelse>
        bzero(dev, b + bi);
    800027f2:	85ca                	mv	a1,s2
    800027f4:	855e                	mv	a0,s7
    800027f6:	00000097          	auipc	ra,0x0
    800027fa:	eec080e7          	jalr	-276(ra) # 800026e2 <bzero>
}
    800027fe:	8526                	mv	a0,s1
    80002800:	60e6                	ld	ra,88(sp)
    80002802:	6446                	ld	s0,80(sp)
    80002804:	64a6                	ld	s1,72(sp)
    80002806:	6906                	ld	s2,64(sp)
    80002808:	79e2                	ld	s3,56(sp)
    8000280a:	7a42                	ld	s4,48(sp)
    8000280c:	7aa2                	ld	s5,40(sp)
    8000280e:	7b02                	ld	s6,32(sp)
    80002810:	6be2                	ld	s7,24(sp)
    80002812:	6c42                	ld	s8,16(sp)
    80002814:	6ca2                	ld	s9,8(sp)
    80002816:	6125                	addi	sp,sp,96
    80002818:	8082                	ret

000000008000281a <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
    8000281a:	7179                	addi	sp,sp,-48
    8000281c:	f406                	sd	ra,40(sp)
    8000281e:	f022                	sd	s0,32(sp)
    80002820:	ec26                	sd	s1,24(sp)
    80002822:	e84a                	sd	s2,16(sp)
    80002824:	e44e                	sd	s3,8(sp)
    80002826:	e052                	sd	s4,0(sp)
    80002828:	1800                	addi	s0,sp,48
    8000282a:	892a                	mv	s2,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    8000282c:	47ad                	li	a5,11
    8000282e:	04b7fe63          	bgeu	a5,a1,8000288a <bmap+0x70>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
    80002832:	ff45849b          	addiw	s1,a1,-12
    80002836:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    8000283a:	0ff00793          	li	a5,255
    8000283e:	08e7ee63          	bltu	a5,a4,800028da <bmap+0xc0>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
    80002842:	08052583          	lw	a1,128(a0)
    80002846:	c5ad                	beqz	a1,800028b0 <bmap+0x96>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    80002848:	00092503          	lw	a0,0(s2)
    8000284c:	00000097          	auipc	ra,0x0
    80002850:	be0080e7          	jalr	-1056(ra) # 8000242c <bread>
    80002854:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    80002856:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    8000285a:	02049593          	slli	a1,s1,0x20
    8000285e:	9181                	srli	a1,a1,0x20
    80002860:	058a                	slli	a1,a1,0x2
    80002862:	00b784b3          	add	s1,a5,a1
    80002866:	0004a983          	lw	s3,0(s1)
    8000286a:	04098d63          	beqz	s3,800028c4 <bmap+0xaa>
      a[bn] = addr = balloc(ip->dev);
      //log_write(bp);
    }
    brelse(bp);
    8000286e:	8552                	mv	a0,s4
    80002870:	00000097          	auipc	ra,0x0
    80002874:	c2e080e7          	jalr	-978(ra) # 8000249e <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
    80002878:	854e                	mv	a0,s3
    8000287a:	70a2                	ld	ra,40(sp)
    8000287c:	7402                	ld	s0,32(sp)
    8000287e:	64e2                	ld	s1,24(sp)
    80002880:	6942                	ld	s2,16(sp)
    80002882:	69a2                	ld	s3,8(sp)
    80002884:	6a02                	ld	s4,0(sp)
    80002886:	6145                	addi	sp,sp,48
    80002888:	8082                	ret
    if((addr = ip->addrs[bn]) == 0)
    8000288a:	02059493          	slli	s1,a1,0x20
    8000288e:	9081                	srli	s1,s1,0x20
    80002890:	048a                	slli	s1,s1,0x2
    80002892:	94aa                	add	s1,s1,a0
    80002894:	0504a983          	lw	s3,80(s1)
    80002898:	fe0990e3          	bnez	s3,80002878 <bmap+0x5e>
      ip->addrs[bn] = addr = balloc(ip->dev);
    8000289c:	4108                	lw	a0,0(a0)
    8000289e:	00000097          	auipc	ra,0x0
    800028a2:	e7e080e7          	jalr	-386(ra) # 8000271c <balloc>
    800028a6:	0005099b          	sext.w	s3,a0
    800028aa:	0534a823          	sw	s3,80(s1)
    800028ae:	b7e9                	j	80002878 <bmap+0x5e>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    800028b0:	4108                	lw	a0,0(a0)
    800028b2:	00000097          	auipc	ra,0x0
    800028b6:	e6a080e7          	jalr	-406(ra) # 8000271c <balloc>
    800028ba:	0005059b          	sext.w	a1,a0
    800028be:	08b92023          	sw	a1,128(s2)
    800028c2:	b759                	j	80002848 <bmap+0x2e>
      a[bn] = addr = balloc(ip->dev);
    800028c4:	00092503          	lw	a0,0(s2)
    800028c8:	00000097          	auipc	ra,0x0
    800028cc:	e54080e7          	jalr	-428(ra) # 8000271c <balloc>
    800028d0:	0005099b          	sext.w	s3,a0
    800028d4:	0134a023          	sw	s3,0(s1)
    800028d8:	bf59                	j	8000286e <bmap+0x54>
  panic("bmap: out of range");
    800028da:	00006517          	auipc	a0,0x6
    800028de:	c4e50513          	addi	a0,a0,-946 # 80008528 <syscalls+0x170>
    800028e2:	00003097          	auipc	ra,0x3
    800028e6:	666080e7          	jalr	1638(ra) # 80005f48 <panic>

00000000800028ea <iget>:
{
    800028ea:	7179                	addi	sp,sp,-48
    800028ec:	f406                	sd	ra,40(sp)
    800028ee:	f022                	sd	s0,32(sp)
    800028f0:	ec26                	sd	s1,24(sp)
    800028f2:	e84a                	sd	s2,16(sp)
    800028f4:	e44e                	sd	s3,8(sp)
    800028f6:	e052                	sd	s4,0(sp)
    800028f8:	1800                	addi	s0,sp,48
    800028fa:	89aa                	mv	s3,a0
    800028fc:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    800028fe:	00015517          	auipc	a0,0x15
    80002902:	c7a50513          	addi	a0,a0,-902 # 80017578 <itable>
    80002906:	00004097          	auipc	ra,0x4
    8000290a:	b8c080e7          	jalr	-1140(ra) # 80006492 <acquire>
  empty = 0;
    8000290e:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002910:	00015497          	auipc	s1,0x15
    80002914:	c8048493          	addi	s1,s1,-896 # 80017590 <itable+0x18>
    80002918:	00016697          	auipc	a3,0x16
    8000291c:	70868693          	addi	a3,a3,1800 # 80019020 <log>
    80002920:	a039                	j	8000292e <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002922:	02090b63          	beqz	s2,80002958 <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80002926:	08848493          	addi	s1,s1,136
    8000292a:	02d48a63          	beq	s1,a3,8000295e <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    8000292e:	449c                	lw	a5,8(s1)
    80002930:	fef059e3          	blez	a5,80002922 <iget+0x38>
    80002934:	4098                	lw	a4,0(s1)
    80002936:	ff3716e3          	bne	a4,s3,80002922 <iget+0x38>
    8000293a:	40d8                	lw	a4,4(s1)
    8000293c:	ff4713e3          	bne	a4,s4,80002922 <iget+0x38>
      ip->ref++;
    80002940:	2785                	addiw	a5,a5,1
    80002942:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    80002944:	00015517          	auipc	a0,0x15
    80002948:	c3450513          	addi	a0,a0,-972 # 80017578 <itable>
    8000294c:	00004097          	auipc	ra,0x4
    80002950:	bfa080e7          	jalr	-1030(ra) # 80006546 <release>
      return ip;
    80002954:	8926                	mv	s2,s1
    80002956:	a03d                	j	80002984 <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    80002958:	f7f9                	bnez	a5,80002926 <iget+0x3c>
    8000295a:	8926                	mv	s2,s1
    8000295c:	b7e9                	j	80002926 <iget+0x3c>
  if(empty == 0)
    8000295e:	02090c63          	beqz	s2,80002996 <iget+0xac>
  ip->dev = dev;
    80002962:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    80002966:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    8000296a:	4785                	li	a5,1
    8000296c:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    80002970:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    80002974:	00015517          	auipc	a0,0x15
    80002978:	c0450513          	addi	a0,a0,-1020 # 80017578 <itable>
    8000297c:	00004097          	auipc	ra,0x4
    80002980:	bca080e7          	jalr	-1078(ra) # 80006546 <release>
}
    80002984:	854a                	mv	a0,s2
    80002986:	70a2                	ld	ra,40(sp)
    80002988:	7402                	ld	s0,32(sp)
    8000298a:	64e2                	ld	s1,24(sp)
    8000298c:	6942                	ld	s2,16(sp)
    8000298e:	69a2                	ld	s3,8(sp)
    80002990:	6a02                	ld	s4,0(sp)
    80002992:	6145                	addi	sp,sp,48
    80002994:	8082                	ret
    panic("iget: no inodes");
    80002996:	00006517          	auipc	a0,0x6
    8000299a:	baa50513          	addi	a0,a0,-1110 # 80008540 <syscalls+0x188>
    8000299e:	00003097          	auipc	ra,0x3
    800029a2:	5aa080e7          	jalr	1450(ra) # 80005f48 <panic>

00000000800029a6 <fsinit>:
fsinit(int dev) {
    800029a6:	7179                	addi	sp,sp,-48
    800029a8:	f406                	sd	ra,40(sp)
    800029aa:	f022                	sd	s0,32(sp)
    800029ac:	ec26                	sd	s1,24(sp)
    800029ae:	e84a                	sd	s2,16(sp)
    800029b0:	e44e                	sd	s3,8(sp)
    800029b2:	1800                	addi	s0,sp,48
    800029b4:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    800029b6:	4585                	li	a1,1
    800029b8:	00000097          	auipc	ra,0x0
    800029bc:	a74080e7          	jalr	-1420(ra) # 8000242c <bread>
    800029c0:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    800029c2:	00015997          	auipc	s3,0x15
    800029c6:	b9698993          	addi	s3,s3,-1130 # 80017558 <sb>
    800029ca:	02000613          	li	a2,32
    800029ce:	05850593          	addi	a1,a0,88
    800029d2:	854e                	mv	a0,s3
    800029d4:	ffffe097          	auipc	ra,0xffffe
    800029d8:	804080e7          	jalr	-2044(ra) # 800001d8 <memmove>
  brelse(bp);
    800029dc:	8526                	mv	a0,s1
    800029de:	00000097          	auipc	ra,0x0
    800029e2:	ac0080e7          	jalr	-1344(ra) # 8000249e <brelse>
  if(sb.magic != FSMAGIC)
    800029e6:	0009a703          	lw	a4,0(s3)
    800029ea:	102037b7          	lui	a5,0x10203
    800029ee:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    800029f2:	02f71263          	bne	a4,a5,80002a16 <fsinit+0x70>
  initlog(dev, &sb);
    800029f6:	00015597          	auipc	a1,0x15
    800029fa:	b6258593          	addi	a1,a1,-1182 # 80017558 <sb>
    800029fe:	854a                	mv	a0,s2
    80002a00:	00001097          	auipc	ra,0x1
    80002a04:	cc2080e7          	jalr	-830(ra) # 800036c2 <initlog>
}
    80002a08:	70a2                	ld	ra,40(sp)
    80002a0a:	7402                	ld	s0,32(sp)
    80002a0c:	64e2                	ld	s1,24(sp)
    80002a0e:	6942                	ld	s2,16(sp)
    80002a10:	69a2                	ld	s3,8(sp)
    80002a12:	6145                	addi	sp,sp,48
    80002a14:	8082                	ret
    panic("invalid file system");
    80002a16:	00006517          	auipc	a0,0x6
    80002a1a:	b3a50513          	addi	a0,a0,-1222 # 80008550 <syscalls+0x198>
    80002a1e:	00003097          	auipc	ra,0x3
    80002a22:	52a080e7          	jalr	1322(ra) # 80005f48 <panic>

0000000080002a26 <iinit>:
{
    80002a26:	7179                	addi	sp,sp,-48
    80002a28:	f406                	sd	ra,40(sp)
    80002a2a:	f022                	sd	s0,32(sp)
    80002a2c:	ec26                	sd	s1,24(sp)
    80002a2e:	e84a                	sd	s2,16(sp)
    80002a30:	e44e                	sd	s3,8(sp)
    80002a32:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    80002a34:	00006597          	auipc	a1,0x6
    80002a38:	b3458593          	addi	a1,a1,-1228 # 80008568 <syscalls+0x1b0>
    80002a3c:	00015517          	auipc	a0,0x15
    80002a40:	b3c50513          	addi	a0,a0,-1220 # 80017578 <itable>
    80002a44:	00004097          	auipc	ra,0x4
    80002a48:	9be080e7          	jalr	-1602(ra) # 80006402 <initlock>
  for(i = 0; i < NINODE; i++) {
    80002a4c:	00015497          	auipc	s1,0x15
    80002a50:	b5448493          	addi	s1,s1,-1196 # 800175a0 <itable+0x28>
    80002a54:	00016997          	auipc	s3,0x16
    80002a58:	5dc98993          	addi	s3,s3,1500 # 80019030 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    80002a5c:	00006917          	auipc	s2,0x6
    80002a60:	b1490913          	addi	s2,s2,-1260 # 80008570 <syscalls+0x1b8>
    80002a64:	85ca                	mv	a1,s2
    80002a66:	8526                	mv	a0,s1
    80002a68:	00001097          	auipc	ra,0x1
    80002a6c:	fbc080e7          	jalr	-68(ra) # 80003a24 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80002a70:	08848493          	addi	s1,s1,136
    80002a74:	ff3498e3          	bne	s1,s3,80002a64 <iinit+0x3e>
}
    80002a78:	70a2                	ld	ra,40(sp)
    80002a7a:	7402                	ld	s0,32(sp)
    80002a7c:	64e2                	ld	s1,24(sp)
    80002a7e:	6942                	ld	s2,16(sp)
    80002a80:	69a2                	ld	s3,8(sp)
    80002a82:	6145                	addi	sp,sp,48
    80002a84:	8082                	ret

0000000080002a86 <ialloc>:
{
    80002a86:	715d                	addi	sp,sp,-80
    80002a88:	e486                	sd	ra,72(sp)
    80002a8a:	e0a2                	sd	s0,64(sp)
    80002a8c:	fc26                	sd	s1,56(sp)
    80002a8e:	f84a                	sd	s2,48(sp)
    80002a90:	f44e                	sd	s3,40(sp)
    80002a92:	f052                	sd	s4,32(sp)
    80002a94:	ec56                	sd	s5,24(sp)
    80002a96:	e85a                	sd	s6,16(sp)
    80002a98:	e45e                	sd	s7,8(sp)
    80002a9a:	0880                	addi	s0,sp,80
  for(inum = 1; inum < sb.ninodes; inum++){
    80002a9c:	00015717          	auipc	a4,0x15
    80002aa0:	ac872703          	lw	a4,-1336(a4) # 80017564 <sb+0xc>
    80002aa4:	4785                	li	a5,1
    80002aa6:	04e7fa63          	bgeu	a5,a4,80002afa <ialloc+0x74>
    80002aaa:	8aaa                	mv	s5,a0
    80002aac:	8bae                	mv	s7,a1
    80002aae:	4485                	li	s1,1
    bp = bread(dev, IBLOCK(inum, sb));
    80002ab0:	00015a17          	auipc	s4,0x15
    80002ab4:	aa8a0a13          	addi	s4,s4,-1368 # 80017558 <sb>
    80002ab8:	00048b1b          	sext.w	s6,s1
    80002abc:	0044d593          	srli	a1,s1,0x4
    80002ac0:	018a2783          	lw	a5,24(s4)
    80002ac4:	9dbd                	addw	a1,a1,a5
    80002ac6:	8556                	mv	a0,s5
    80002ac8:	00000097          	auipc	ra,0x0
    80002acc:	964080e7          	jalr	-1692(ra) # 8000242c <bread>
    80002ad0:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80002ad2:	05850993          	addi	s3,a0,88
    80002ad6:	00f4f793          	andi	a5,s1,15
    80002ada:	079a                	slli	a5,a5,0x6
    80002adc:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    80002ade:	00099783          	lh	a5,0(s3)
    80002ae2:	c785                	beqz	a5,80002b0a <ialloc+0x84>
    brelse(bp);
    80002ae4:	00000097          	auipc	ra,0x0
    80002ae8:	9ba080e7          	jalr	-1606(ra) # 8000249e <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80002aec:	0485                	addi	s1,s1,1
    80002aee:	00ca2703          	lw	a4,12(s4)
    80002af2:	0004879b          	sext.w	a5,s1
    80002af6:	fce7e1e3          	bltu	a5,a4,80002ab8 <ialloc+0x32>
  panic("ialloc: no inodes");
    80002afa:	00006517          	auipc	a0,0x6
    80002afe:	a7e50513          	addi	a0,a0,-1410 # 80008578 <syscalls+0x1c0>
    80002b02:	00003097          	auipc	ra,0x3
    80002b06:	446080e7          	jalr	1094(ra) # 80005f48 <panic>
      memset(dip, 0, sizeof(*dip));
    80002b0a:	04000613          	li	a2,64
    80002b0e:	4581                	li	a1,0
    80002b10:	854e                	mv	a0,s3
    80002b12:	ffffd097          	auipc	ra,0xffffd
    80002b16:	666080e7          	jalr	1638(ra) # 80000178 <memset>
      dip->type = type;
    80002b1a:	01799023          	sh	s7,0(s3)
      brelse(bp);
    80002b1e:	854a                	mv	a0,s2
    80002b20:	00000097          	auipc	ra,0x0
    80002b24:	97e080e7          	jalr	-1666(ra) # 8000249e <brelse>
      return iget(dev, inum);
    80002b28:	85da                	mv	a1,s6
    80002b2a:	8556                	mv	a0,s5
    80002b2c:	00000097          	auipc	ra,0x0
    80002b30:	dbe080e7          	jalr	-578(ra) # 800028ea <iget>
}
    80002b34:	60a6                	ld	ra,72(sp)
    80002b36:	6406                	ld	s0,64(sp)
    80002b38:	74e2                	ld	s1,56(sp)
    80002b3a:	7942                	ld	s2,48(sp)
    80002b3c:	79a2                	ld	s3,40(sp)
    80002b3e:	7a02                	ld	s4,32(sp)
    80002b40:	6ae2                	ld	s5,24(sp)
    80002b42:	6b42                	ld	s6,16(sp)
    80002b44:	6ba2                	ld	s7,8(sp)
    80002b46:	6161                	addi	sp,sp,80
    80002b48:	8082                	ret

0000000080002b4a <iupdate>:
{
    80002b4a:	1101                	addi	sp,sp,-32
    80002b4c:	ec06                	sd	ra,24(sp)
    80002b4e:	e822                	sd	s0,16(sp)
    80002b50:	e426                	sd	s1,8(sp)
    80002b52:	e04a                	sd	s2,0(sp)
    80002b54:	1000                	addi	s0,sp,32
    80002b56:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002b58:	415c                	lw	a5,4(a0)
    80002b5a:	0047d79b          	srliw	a5,a5,0x4
    80002b5e:	00015597          	auipc	a1,0x15
    80002b62:	a125a583          	lw	a1,-1518(a1) # 80017570 <sb+0x18>
    80002b66:	9dbd                	addw	a1,a1,a5
    80002b68:	4108                	lw	a0,0(a0)
    80002b6a:	00000097          	auipc	ra,0x0
    80002b6e:	8c2080e7          	jalr	-1854(ra) # 8000242c <bread>
    80002b72:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002b74:	05850793          	addi	a5,a0,88
    80002b78:	40d8                	lw	a4,4(s1)
    80002b7a:	8b3d                	andi	a4,a4,15
    80002b7c:	071a                	slli	a4,a4,0x6
    80002b7e:	97ba                	add	a5,a5,a4
  dip->type = ip->type;
    80002b80:	04449703          	lh	a4,68(s1)
    80002b84:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    80002b88:	04649703          	lh	a4,70(s1)
    80002b8c:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    80002b90:	04849703          	lh	a4,72(s1)
    80002b94:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    80002b98:	04a49703          	lh	a4,74(s1)
    80002b9c:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    80002ba0:	44f8                	lw	a4,76(s1)
    80002ba2:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80002ba4:	03400613          	li	a2,52
    80002ba8:	05048593          	addi	a1,s1,80
    80002bac:	00c78513          	addi	a0,a5,12
    80002bb0:	ffffd097          	auipc	ra,0xffffd
    80002bb4:	628080e7          	jalr	1576(ra) # 800001d8 <memmove>
  brelse(bp);
    80002bb8:	854a                	mv	a0,s2
    80002bba:	00000097          	auipc	ra,0x0
    80002bbe:	8e4080e7          	jalr	-1820(ra) # 8000249e <brelse>
}
    80002bc2:	60e2                	ld	ra,24(sp)
    80002bc4:	6442                	ld	s0,16(sp)
    80002bc6:	64a2                	ld	s1,8(sp)
    80002bc8:	6902                	ld	s2,0(sp)
    80002bca:	6105                	addi	sp,sp,32
    80002bcc:	8082                	ret

0000000080002bce <idup>:
{
    80002bce:	1101                	addi	sp,sp,-32
    80002bd0:	ec06                	sd	ra,24(sp)
    80002bd2:	e822                	sd	s0,16(sp)
    80002bd4:	e426                	sd	s1,8(sp)
    80002bd6:	1000                	addi	s0,sp,32
    80002bd8:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002bda:	00015517          	auipc	a0,0x15
    80002bde:	99e50513          	addi	a0,a0,-1634 # 80017578 <itable>
    80002be2:	00004097          	auipc	ra,0x4
    80002be6:	8b0080e7          	jalr	-1872(ra) # 80006492 <acquire>
  ip->ref++;
    80002bea:	449c                	lw	a5,8(s1)
    80002bec:	2785                	addiw	a5,a5,1
    80002bee:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002bf0:	00015517          	auipc	a0,0x15
    80002bf4:	98850513          	addi	a0,a0,-1656 # 80017578 <itable>
    80002bf8:	00004097          	auipc	ra,0x4
    80002bfc:	94e080e7          	jalr	-1714(ra) # 80006546 <release>
}
    80002c00:	8526                	mv	a0,s1
    80002c02:	60e2                	ld	ra,24(sp)
    80002c04:	6442                	ld	s0,16(sp)
    80002c06:	64a2                	ld	s1,8(sp)
    80002c08:	6105                	addi	sp,sp,32
    80002c0a:	8082                	ret

0000000080002c0c <ilock>:
{
    80002c0c:	1101                	addi	sp,sp,-32
    80002c0e:	ec06                	sd	ra,24(sp)
    80002c10:	e822                	sd	s0,16(sp)
    80002c12:	e426                	sd	s1,8(sp)
    80002c14:	e04a                	sd	s2,0(sp)
    80002c16:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    80002c18:	c115                	beqz	a0,80002c3c <ilock+0x30>
    80002c1a:	84aa                	mv	s1,a0
    80002c1c:	451c                	lw	a5,8(a0)
    80002c1e:	00f05f63          	blez	a5,80002c3c <ilock+0x30>
  acquiresleep(&ip->lock);
    80002c22:	0541                	addi	a0,a0,16
    80002c24:	00001097          	auipc	ra,0x1
    80002c28:	e3a080e7          	jalr	-454(ra) # 80003a5e <acquiresleep>
  if(ip->valid == 0){
    80002c2c:	40bc                	lw	a5,64(s1)
    80002c2e:	cf99                	beqz	a5,80002c4c <ilock+0x40>
}
    80002c30:	60e2                	ld	ra,24(sp)
    80002c32:	6442                	ld	s0,16(sp)
    80002c34:	64a2                	ld	s1,8(sp)
    80002c36:	6902                	ld	s2,0(sp)
    80002c38:	6105                	addi	sp,sp,32
    80002c3a:	8082                	ret
    panic("ilock");
    80002c3c:	00006517          	auipc	a0,0x6
    80002c40:	95450513          	addi	a0,a0,-1708 # 80008590 <syscalls+0x1d8>
    80002c44:	00003097          	auipc	ra,0x3
    80002c48:	304080e7          	jalr	772(ra) # 80005f48 <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002c4c:	40dc                	lw	a5,4(s1)
    80002c4e:	0047d79b          	srliw	a5,a5,0x4
    80002c52:	00015597          	auipc	a1,0x15
    80002c56:	91e5a583          	lw	a1,-1762(a1) # 80017570 <sb+0x18>
    80002c5a:	9dbd                	addw	a1,a1,a5
    80002c5c:	4088                	lw	a0,0(s1)
    80002c5e:	fffff097          	auipc	ra,0xfffff
    80002c62:	7ce080e7          	jalr	1998(ra) # 8000242c <bread>
    80002c66:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002c68:	05850593          	addi	a1,a0,88
    80002c6c:	40dc                	lw	a5,4(s1)
    80002c6e:	8bbd                	andi	a5,a5,15
    80002c70:	079a                	slli	a5,a5,0x6
    80002c72:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    80002c74:	00059783          	lh	a5,0(a1)
    80002c78:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80002c7c:	00259783          	lh	a5,2(a1)
    80002c80:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    80002c84:	00459783          	lh	a5,4(a1)
    80002c88:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    80002c8c:	00659783          	lh	a5,6(a1)
    80002c90:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    80002c94:	459c                	lw	a5,8(a1)
    80002c96:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80002c98:	03400613          	li	a2,52
    80002c9c:	05b1                	addi	a1,a1,12
    80002c9e:	05048513          	addi	a0,s1,80
    80002ca2:	ffffd097          	auipc	ra,0xffffd
    80002ca6:	536080e7          	jalr	1334(ra) # 800001d8 <memmove>
    brelse(bp);
    80002caa:	854a                	mv	a0,s2
    80002cac:	fffff097          	auipc	ra,0xfffff
    80002cb0:	7f2080e7          	jalr	2034(ra) # 8000249e <brelse>
    ip->valid = 1;
    80002cb4:	4785                	li	a5,1
    80002cb6:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    80002cb8:	04449783          	lh	a5,68(s1)
    80002cbc:	fbb5                	bnez	a5,80002c30 <ilock+0x24>
      panic("ilock: no type");
    80002cbe:	00006517          	auipc	a0,0x6
    80002cc2:	8da50513          	addi	a0,a0,-1830 # 80008598 <syscalls+0x1e0>
    80002cc6:	00003097          	auipc	ra,0x3
    80002cca:	282080e7          	jalr	642(ra) # 80005f48 <panic>

0000000080002cce <iunlock>:
{
    80002cce:	1101                	addi	sp,sp,-32
    80002cd0:	ec06                	sd	ra,24(sp)
    80002cd2:	e822                	sd	s0,16(sp)
    80002cd4:	e426                	sd	s1,8(sp)
    80002cd6:	e04a                	sd	s2,0(sp)
    80002cd8:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80002cda:	c905                	beqz	a0,80002d0a <iunlock+0x3c>
    80002cdc:	84aa                	mv	s1,a0
    80002cde:	01050913          	addi	s2,a0,16
    80002ce2:	854a                	mv	a0,s2
    80002ce4:	00001097          	auipc	ra,0x1
    80002ce8:	e14080e7          	jalr	-492(ra) # 80003af8 <holdingsleep>
    80002cec:	cd19                	beqz	a0,80002d0a <iunlock+0x3c>
    80002cee:	449c                	lw	a5,8(s1)
    80002cf0:	00f05d63          	blez	a5,80002d0a <iunlock+0x3c>
  releasesleep(&ip->lock);
    80002cf4:	854a                	mv	a0,s2
    80002cf6:	00001097          	auipc	ra,0x1
    80002cfa:	dbe080e7          	jalr	-578(ra) # 80003ab4 <releasesleep>
}
    80002cfe:	60e2                	ld	ra,24(sp)
    80002d00:	6442                	ld	s0,16(sp)
    80002d02:	64a2                	ld	s1,8(sp)
    80002d04:	6902                	ld	s2,0(sp)
    80002d06:	6105                	addi	sp,sp,32
    80002d08:	8082                	ret
    panic("iunlock");
    80002d0a:	00006517          	auipc	a0,0x6
    80002d0e:	89e50513          	addi	a0,a0,-1890 # 800085a8 <syscalls+0x1f0>
    80002d12:	00003097          	auipc	ra,0x3
    80002d16:	236080e7          	jalr	566(ra) # 80005f48 <panic>

0000000080002d1a <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80002d1a:	7179                	addi	sp,sp,-48
    80002d1c:	f406                	sd	ra,40(sp)
    80002d1e:	f022                	sd	s0,32(sp)
    80002d20:	ec26                	sd	s1,24(sp)
    80002d22:	e84a                	sd	s2,16(sp)
    80002d24:	e44e                	sd	s3,8(sp)
    80002d26:	e052                	sd	s4,0(sp)
    80002d28:	1800                	addi	s0,sp,48
    80002d2a:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80002d2c:	05050493          	addi	s1,a0,80
    80002d30:	08050913          	addi	s2,a0,128
    80002d34:	a021                	j	80002d3c <itrunc+0x22>
    80002d36:	0491                	addi	s1,s1,4
    80002d38:	01248d63          	beq	s1,s2,80002d52 <itrunc+0x38>
    if(ip->addrs[i]){
    80002d3c:	408c                	lw	a1,0(s1)
    80002d3e:	dde5                	beqz	a1,80002d36 <itrunc+0x1c>
      bfree(ip->dev, ip->addrs[i]);
    80002d40:	0009a503          	lw	a0,0(s3)
    80002d44:	00000097          	auipc	ra,0x0
    80002d48:	932080e7          	jalr	-1742(ra) # 80002676 <bfree>
      ip->addrs[i] = 0;
    80002d4c:	0004a023          	sw	zero,0(s1)
    80002d50:	b7dd                	j	80002d36 <itrunc+0x1c>
    }
  }

  if(ip->addrs[NDIRECT]){
    80002d52:	0809a583          	lw	a1,128(s3)
    80002d56:	e185                	bnez	a1,80002d76 <itrunc+0x5c>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    80002d58:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80002d5c:	854e                	mv	a0,s3
    80002d5e:	00000097          	auipc	ra,0x0
    80002d62:	dec080e7          	jalr	-532(ra) # 80002b4a <iupdate>
}
    80002d66:	70a2                	ld	ra,40(sp)
    80002d68:	7402                	ld	s0,32(sp)
    80002d6a:	64e2                	ld	s1,24(sp)
    80002d6c:	6942                	ld	s2,16(sp)
    80002d6e:	69a2                	ld	s3,8(sp)
    80002d70:	6a02                	ld	s4,0(sp)
    80002d72:	6145                	addi	sp,sp,48
    80002d74:	8082                	ret
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80002d76:	0009a503          	lw	a0,0(s3)
    80002d7a:	fffff097          	auipc	ra,0xfffff
    80002d7e:	6b2080e7          	jalr	1714(ra) # 8000242c <bread>
    80002d82:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    80002d84:	05850493          	addi	s1,a0,88
    80002d88:	45850913          	addi	s2,a0,1112
    80002d8c:	a811                	j	80002da0 <itrunc+0x86>
        bfree(ip->dev, a[j]);
    80002d8e:	0009a503          	lw	a0,0(s3)
    80002d92:	00000097          	auipc	ra,0x0
    80002d96:	8e4080e7          	jalr	-1820(ra) # 80002676 <bfree>
    for(j = 0; j < NINDIRECT; j++){
    80002d9a:	0491                	addi	s1,s1,4
    80002d9c:	01248563          	beq	s1,s2,80002da6 <itrunc+0x8c>
      if(a[j])
    80002da0:	408c                	lw	a1,0(s1)
    80002da2:	dde5                	beqz	a1,80002d9a <itrunc+0x80>
    80002da4:	b7ed                	j	80002d8e <itrunc+0x74>
    brelse(bp);
    80002da6:	8552                	mv	a0,s4
    80002da8:	fffff097          	auipc	ra,0xfffff
    80002dac:	6f6080e7          	jalr	1782(ra) # 8000249e <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80002db0:	0809a583          	lw	a1,128(s3)
    80002db4:	0009a503          	lw	a0,0(s3)
    80002db8:	00000097          	auipc	ra,0x0
    80002dbc:	8be080e7          	jalr	-1858(ra) # 80002676 <bfree>
    ip->addrs[NDIRECT] = 0;
    80002dc0:	0809a023          	sw	zero,128(s3)
    80002dc4:	bf51                	j	80002d58 <itrunc+0x3e>

0000000080002dc6 <iput>:
{
    80002dc6:	1101                	addi	sp,sp,-32
    80002dc8:	ec06                	sd	ra,24(sp)
    80002dca:	e822                	sd	s0,16(sp)
    80002dcc:	e426                	sd	s1,8(sp)
    80002dce:	e04a                	sd	s2,0(sp)
    80002dd0:	1000                	addi	s0,sp,32
    80002dd2:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002dd4:	00014517          	auipc	a0,0x14
    80002dd8:	7a450513          	addi	a0,a0,1956 # 80017578 <itable>
    80002ddc:	00003097          	auipc	ra,0x3
    80002de0:	6b6080e7          	jalr	1718(ra) # 80006492 <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002de4:	4498                	lw	a4,8(s1)
    80002de6:	4785                	li	a5,1
    80002de8:	02f70363          	beq	a4,a5,80002e0e <iput+0x48>
  ip->ref--;
    80002dec:	449c                	lw	a5,8(s1)
    80002dee:	37fd                	addiw	a5,a5,-1
    80002df0:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002df2:	00014517          	auipc	a0,0x14
    80002df6:	78650513          	addi	a0,a0,1926 # 80017578 <itable>
    80002dfa:	00003097          	auipc	ra,0x3
    80002dfe:	74c080e7          	jalr	1868(ra) # 80006546 <release>
}
    80002e02:	60e2                	ld	ra,24(sp)
    80002e04:	6442                	ld	s0,16(sp)
    80002e06:	64a2                	ld	s1,8(sp)
    80002e08:	6902                	ld	s2,0(sp)
    80002e0a:	6105                	addi	sp,sp,32
    80002e0c:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002e0e:	40bc                	lw	a5,64(s1)
    80002e10:	dff1                	beqz	a5,80002dec <iput+0x26>
    80002e12:	04a49783          	lh	a5,74(s1)
    80002e16:	fbf9                	bnez	a5,80002dec <iput+0x26>
    acquiresleep(&ip->lock);
    80002e18:	01048913          	addi	s2,s1,16
    80002e1c:	854a                	mv	a0,s2
    80002e1e:	00001097          	auipc	ra,0x1
    80002e22:	c40080e7          	jalr	-960(ra) # 80003a5e <acquiresleep>
    release(&itable.lock);
    80002e26:	00014517          	auipc	a0,0x14
    80002e2a:	75250513          	addi	a0,a0,1874 # 80017578 <itable>
    80002e2e:	00003097          	auipc	ra,0x3
    80002e32:	718080e7          	jalr	1816(ra) # 80006546 <release>
    itrunc(ip);
    80002e36:	8526                	mv	a0,s1
    80002e38:	00000097          	auipc	ra,0x0
    80002e3c:	ee2080e7          	jalr	-286(ra) # 80002d1a <itrunc>
    ip->type = 0;
    80002e40:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    80002e44:	8526                	mv	a0,s1
    80002e46:	00000097          	auipc	ra,0x0
    80002e4a:	d04080e7          	jalr	-764(ra) # 80002b4a <iupdate>
    ip->valid = 0;
    80002e4e:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    80002e52:	854a                	mv	a0,s2
    80002e54:	00001097          	auipc	ra,0x1
    80002e58:	c60080e7          	jalr	-928(ra) # 80003ab4 <releasesleep>
    acquire(&itable.lock);
    80002e5c:	00014517          	auipc	a0,0x14
    80002e60:	71c50513          	addi	a0,a0,1820 # 80017578 <itable>
    80002e64:	00003097          	auipc	ra,0x3
    80002e68:	62e080e7          	jalr	1582(ra) # 80006492 <acquire>
    80002e6c:	b741                	j	80002dec <iput+0x26>

0000000080002e6e <iunlockput>:
{
    80002e6e:	1101                	addi	sp,sp,-32
    80002e70:	ec06                	sd	ra,24(sp)
    80002e72:	e822                	sd	s0,16(sp)
    80002e74:	e426                	sd	s1,8(sp)
    80002e76:	1000                	addi	s0,sp,32
    80002e78:	84aa                	mv	s1,a0
  iunlock(ip);
    80002e7a:	00000097          	auipc	ra,0x0
    80002e7e:	e54080e7          	jalr	-428(ra) # 80002cce <iunlock>
  iput(ip);
    80002e82:	8526                	mv	a0,s1
    80002e84:	00000097          	auipc	ra,0x0
    80002e88:	f42080e7          	jalr	-190(ra) # 80002dc6 <iput>
}
    80002e8c:	60e2                	ld	ra,24(sp)
    80002e8e:	6442                	ld	s0,16(sp)
    80002e90:	64a2                	ld	s1,8(sp)
    80002e92:	6105                	addi	sp,sp,32
    80002e94:	8082                	ret

0000000080002e96 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80002e96:	1141                	addi	sp,sp,-16
    80002e98:	e422                	sd	s0,8(sp)
    80002e9a:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    80002e9c:	411c                	lw	a5,0(a0)
    80002e9e:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80002ea0:	415c                	lw	a5,4(a0)
    80002ea2:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80002ea4:	04451783          	lh	a5,68(a0)
    80002ea8:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80002eac:	04a51783          	lh	a5,74(a0)
    80002eb0:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80002eb4:	04c56783          	lwu	a5,76(a0)
    80002eb8:	e99c                	sd	a5,16(a1)
}
    80002eba:	6422                	ld	s0,8(sp)
    80002ebc:	0141                	addi	sp,sp,16
    80002ebe:	8082                	ret

0000000080002ec0 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80002ec0:	457c                	lw	a5,76(a0)
    80002ec2:	0ed7e963          	bltu	a5,a3,80002fb4 <readi+0xf4>
{
    80002ec6:	7159                	addi	sp,sp,-112
    80002ec8:	f486                	sd	ra,104(sp)
    80002eca:	f0a2                	sd	s0,96(sp)
    80002ecc:	eca6                	sd	s1,88(sp)
    80002ece:	e8ca                	sd	s2,80(sp)
    80002ed0:	e4ce                	sd	s3,72(sp)
    80002ed2:	e0d2                	sd	s4,64(sp)
    80002ed4:	fc56                	sd	s5,56(sp)
    80002ed6:	f85a                	sd	s6,48(sp)
    80002ed8:	f45e                	sd	s7,40(sp)
    80002eda:	f062                	sd	s8,32(sp)
    80002edc:	ec66                	sd	s9,24(sp)
    80002ede:	e86a                	sd	s10,16(sp)
    80002ee0:	e46e                	sd	s11,8(sp)
    80002ee2:	1880                	addi	s0,sp,112
    80002ee4:	8baa                	mv	s7,a0
    80002ee6:	8c2e                	mv	s8,a1
    80002ee8:	8ab2                	mv	s5,a2
    80002eea:	84b6                	mv	s1,a3
    80002eec:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80002eee:	9f35                	addw	a4,a4,a3
    return 0;
    80002ef0:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80002ef2:	0ad76063          	bltu	a4,a3,80002f92 <readi+0xd2>
  if(off + n > ip->size)
    80002ef6:	00e7f463          	bgeu	a5,a4,80002efe <readi+0x3e>
    n = ip->size - off;
    80002efa:	40d78b3b          	subw	s6,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002efe:	0a0b0963          	beqz	s6,80002fb0 <readi+0xf0>
    80002f02:	4981                	li	s3,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80002f04:	40000d13          	li	s10,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80002f08:	5cfd                	li	s9,-1
    80002f0a:	a82d                	j	80002f44 <readi+0x84>
    80002f0c:	020a1d93          	slli	s11,s4,0x20
    80002f10:	020ddd93          	srli	s11,s11,0x20
    80002f14:	05890613          	addi	a2,s2,88
    80002f18:	86ee                	mv	a3,s11
    80002f1a:	963a                	add	a2,a2,a4
    80002f1c:	85d6                	mv	a1,s5
    80002f1e:	8562                	mv	a0,s8
    80002f20:	fffff097          	auipc	ra,0xfffff
    80002f24:	a66080e7          	jalr	-1434(ra) # 80001986 <either_copyout>
    80002f28:	05950d63          	beq	a0,s9,80002f82 <readi+0xc2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80002f2c:	854a                	mv	a0,s2
    80002f2e:	fffff097          	auipc	ra,0xfffff
    80002f32:	570080e7          	jalr	1392(ra) # 8000249e <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002f36:	013a09bb          	addw	s3,s4,s3
    80002f3a:	009a04bb          	addw	s1,s4,s1
    80002f3e:	9aee                	add	s5,s5,s11
    80002f40:	0569f763          	bgeu	s3,s6,80002f8e <readi+0xce>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80002f44:	000ba903          	lw	s2,0(s7)
    80002f48:	00a4d59b          	srliw	a1,s1,0xa
    80002f4c:	855e                	mv	a0,s7
    80002f4e:	00000097          	auipc	ra,0x0
    80002f52:	8cc080e7          	jalr	-1844(ra) # 8000281a <bmap>
    80002f56:	0005059b          	sext.w	a1,a0
    80002f5a:	854a                	mv	a0,s2
    80002f5c:	fffff097          	auipc	ra,0xfffff
    80002f60:	4d0080e7          	jalr	1232(ra) # 8000242c <bread>
    80002f64:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80002f66:	3ff4f713          	andi	a4,s1,1023
    80002f6a:	40ed07bb          	subw	a5,s10,a4
    80002f6e:	413b06bb          	subw	a3,s6,s3
    80002f72:	8a3e                	mv	s4,a5
    80002f74:	2781                	sext.w	a5,a5
    80002f76:	0006861b          	sext.w	a2,a3
    80002f7a:	f8f679e3          	bgeu	a2,a5,80002f0c <readi+0x4c>
    80002f7e:	8a36                	mv	s4,a3
    80002f80:	b771                	j	80002f0c <readi+0x4c>
      brelse(bp);
    80002f82:	854a                	mv	a0,s2
    80002f84:	fffff097          	auipc	ra,0xfffff
    80002f88:	51a080e7          	jalr	1306(ra) # 8000249e <brelse>
      tot = -1;
    80002f8c:	59fd                	li	s3,-1
  }
  return tot;
    80002f8e:	0009851b          	sext.w	a0,s3
}
    80002f92:	70a6                	ld	ra,104(sp)
    80002f94:	7406                	ld	s0,96(sp)
    80002f96:	64e6                	ld	s1,88(sp)
    80002f98:	6946                	ld	s2,80(sp)
    80002f9a:	69a6                	ld	s3,72(sp)
    80002f9c:	6a06                	ld	s4,64(sp)
    80002f9e:	7ae2                	ld	s5,56(sp)
    80002fa0:	7b42                	ld	s6,48(sp)
    80002fa2:	7ba2                	ld	s7,40(sp)
    80002fa4:	7c02                	ld	s8,32(sp)
    80002fa6:	6ce2                	ld	s9,24(sp)
    80002fa8:	6d42                	ld	s10,16(sp)
    80002faa:	6da2                	ld	s11,8(sp)
    80002fac:	6165                	addi	sp,sp,112
    80002fae:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002fb0:	89da                	mv	s3,s6
    80002fb2:	bff1                	j	80002f8e <readi+0xce>
    return 0;
    80002fb4:	4501                	li	a0,0
}
    80002fb6:	8082                	ret

0000000080002fb8 <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80002fb8:	457c                	lw	a5,76(a0)
    80002fba:	10d7e363          	bltu	a5,a3,800030c0 <writei+0x108>
{
    80002fbe:	7159                	addi	sp,sp,-112
    80002fc0:	f486                	sd	ra,104(sp)
    80002fc2:	f0a2                	sd	s0,96(sp)
    80002fc4:	eca6                	sd	s1,88(sp)
    80002fc6:	e8ca                	sd	s2,80(sp)
    80002fc8:	e4ce                	sd	s3,72(sp)
    80002fca:	e0d2                	sd	s4,64(sp)
    80002fcc:	fc56                	sd	s5,56(sp)
    80002fce:	f85a                	sd	s6,48(sp)
    80002fd0:	f45e                	sd	s7,40(sp)
    80002fd2:	f062                	sd	s8,32(sp)
    80002fd4:	ec66                	sd	s9,24(sp)
    80002fd6:	e86a                	sd	s10,16(sp)
    80002fd8:	e46e                	sd	s11,8(sp)
    80002fda:	1880                	addi	s0,sp,112
    80002fdc:	8b2a                	mv	s6,a0
    80002fde:	8c2e                	mv	s8,a1
    80002fe0:	8ab2                	mv	s5,a2
    80002fe2:	8936                	mv	s2,a3
    80002fe4:	8bba                	mv	s7,a4
  if(off > ip->size || off + n < off)
    80002fe6:	00e687bb          	addw	a5,a3,a4
    80002fea:	0cd7ed63          	bltu	a5,a3,800030c4 <writei+0x10c>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80002fee:	00043737          	lui	a4,0x43
    80002ff2:	0cf76b63          	bltu	a4,a5,800030c8 <writei+0x110>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002ff6:	0c0b8363          	beqz	s7,800030bc <writei+0x104>
    80002ffa:	4a01                	li	s4,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80002ffc:	40000d13          	li	s10,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80003000:	5cfd                	li	s9,-1
    80003002:	a82d                	j	8000303c <writei+0x84>
    80003004:	02099d93          	slli	s11,s3,0x20
    80003008:	020ddd93          	srli	s11,s11,0x20
    8000300c:	05848513          	addi	a0,s1,88
    80003010:	86ee                	mv	a3,s11
    80003012:	8656                	mv	a2,s5
    80003014:	85e2                	mv	a1,s8
    80003016:	953a                	add	a0,a0,a4
    80003018:	fffff097          	auipc	ra,0xfffff
    8000301c:	9c4080e7          	jalr	-1596(ra) # 800019dc <either_copyin>
    80003020:	05950d63          	beq	a0,s9,8000307a <writei+0xc2>
      brelse(bp);
      break;
    }
    //log_write(bp);
    brelse(bp);
    80003024:	8526                	mv	a0,s1
    80003026:	fffff097          	auipc	ra,0xfffff
    8000302a:	478080e7          	jalr	1144(ra) # 8000249e <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    8000302e:	01498a3b          	addw	s4,s3,s4
    80003032:	0129893b          	addw	s2,s3,s2
    80003036:	9aee                	add	s5,s5,s11
    80003038:	057a7663          	bgeu	s4,s7,80003084 <writei+0xcc>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    8000303c:	000b2483          	lw	s1,0(s6)
    80003040:	00a9559b          	srliw	a1,s2,0xa
    80003044:	855a                	mv	a0,s6
    80003046:	fffff097          	auipc	ra,0xfffff
    8000304a:	7d4080e7          	jalr	2004(ra) # 8000281a <bmap>
    8000304e:	0005059b          	sext.w	a1,a0
    80003052:	8526                	mv	a0,s1
    80003054:	fffff097          	auipc	ra,0xfffff
    80003058:	3d8080e7          	jalr	984(ra) # 8000242c <bread>
    8000305c:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    8000305e:	3ff97713          	andi	a4,s2,1023
    80003062:	40ed07bb          	subw	a5,s10,a4
    80003066:	414b86bb          	subw	a3,s7,s4
    8000306a:	89be                	mv	s3,a5
    8000306c:	2781                	sext.w	a5,a5
    8000306e:	0006861b          	sext.w	a2,a3
    80003072:	f8f679e3          	bgeu	a2,a5,80003004 <writei+0x4c>
    80003076:	89b6                	mv	s3,a3
    80003078:	b771                	j	80003004 <writei+0x4c>
      brelse(bp);
    8000307a:	8526                	mv	a0,s1
    8000307c:	fffff097          	auipc	ra,0xfffff
    80003080:	422080e7          	jalr	1058(ra) # 8000249e <brelse>
  }

  if(off > ip->size)
    80003084:	04cb2783          	lw	a5,76(s6)
    80003088:	0127f463          	bgeu	a5,s2,80003090 <writei+0xd8>
    ip->size = off;
    8000308c:	052b2623          	sw	s2,76(s6)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80003090:	855a                	mv	a0,s6
    80003092:	00000097          	auipc	ra,0x0
    80003096:	ab8080e7          	jalr	-1352(ra) # 80002b4a <iupdate>

  return tot;
    8000309a:	000a051b          	sext.w	a0,s4
}
    8000309e:	70a6                	ld	ra,104(sp)
    800030a0:	7406                	ld	s0,96(sp)
    800030a2:	64e6                	ld	s1,88(sp)
    800030a4:	6946                	ld	s2,80(sp)
    800030a6:	69a6                	ld	s3,72(sp)
    800030a8:	6a06                	ld	s4,64(sp)
    800030aa:	7ae2                	ld	s5,56(sp)
    800030ac:	7b42                	ld	s6,48(sp)
    800030ae:	7ba2                	ld	s7,40(sp)
    800030b0:	7c02                	ld	s8,32(sp)
    800030b2:	6ce2                	ld	s9,24(sp)
    800030b4:	6d42                	ld	s10,16(sp)
    800030b6:	6da2                	ld	s11,8(sp)
    800030b8:	6165                	addi	sp,sp,112
    800030ba:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    800030bc:	8a5e                	mv	s4,s7
    800030be:	bfc9                	j	80003090 <writei+0xd8>
    return -1;
    800030c0:	557d                	li	a0,-1
}
    800030c2:	8082                	ret
    return -1;
    800030c4:	557d                	li	a0,-1
    800030c6:	bfe1                	j	8000309e <writei+0xe6>
    return -1;
    800030c8:	557d                	li	a0,-1
    800030ca:	bfd1                	j	8000309e <writei+0xe6>

00000000800030cc <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    800030cc:	1141                	addi	sp,sp,-16
    800030ce:	e406                	sd	ra,8(sp)
    800030d0:	e022                	sd	s0,0(sp)
    800030d2:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    800030d4:	4639                	li	a2,14
    800030d6:	ffffd097          	auipc	ra,0xffffd
    800030da:	17a080e7          	jalr	378(ra) # 80000250 <strncmp>
}
    800030de:	60a2                	ld	ra,8(sp)
    800030e0:	6402                	ld	s0,0(sp)
    800030e2:	0141                	addi	sp,sp,16
    800030e4:	8082                	ret

00000000800030e6 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    800030e6:	7139                	addi	sp,sp,-64
    800030e8:	fc06                	sd	ra,56(sp)
    800030ea:	f822                	sd	s0,48(sp)
    800030ec:	f426                	sd	s1,40(sp)
    800030ee:	f04a                	sd	s2,32(sp)
    800030f0:	ec4e                	sd	s3,24(sp)
    800030f2:	e852                	sd	s4,16(sp)
    800030f4:	0080                	addi	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    800030f6:	04451703          	lh	a4,68(a0)
    800030fa:	4785                	li	a5,1
    800030fc:	00f71a63          	bne	a4,a5,80003110 <dirlookup+0x2a>
    80003100:	892a                	mv	s2,a0
    80003102:	89ae                	mv	s3,a1
    80003104:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    80003106:	457c                	lw	a5,76(a0)
    80003108:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    8000310a:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    8000310c:	e79d                	bnez	a5,8000313a <dirlookup+0x54>
    8000310e:	a8a5                	j	80003186 <dirlookup+0xa0>
    panic("dirlookup not DIR");
    80003110:	00005517          	auipc	a0,0x5
    80003114:	4a050513          	addi	a0,a0,1184 # 800085b0 <syscalls+0x1f8>
    80003118:	00003097          	auipc	ra,0x3
    8000311c:	e30080e7          	jalr	-464(ra) # 80005f48 <panic>
      panic("dirlookup read");
    80003120:	00005517          	auipc	a0,0x5
    80003124:	4a850513          	addi	a0,a0,1192 # 800085c8 <syscalls+0x210>
    80003128:	00003097          	auipc	ra,0x3
    8000312c:	e20080e7          	jalr	-480(ra) # 80005f48 <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003130:	24c1                	addiw	s1,s1,16
    80003132:	04c92783          	lw	a5,76(s2)
    80003136:	04f4f763          	bgeu	s1,a5,80003184 <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000313a:	4741                	li	a4,16
    8000313c:	86a6                	mv	a3,s1
    8000313e:	fc040613          	addi	a2,s0,-64
    80003142:	4581                	li	a1,0
    80003144:	854a                	mv	a0,s2
    80003146:	00000097          	auipc	ra,0x0
    8000314a:	d7a080e7          	jalr	-646(ra) # 80002ec0 <readi>
    8000314e:	47c1                	li	a5,16
    80003150:	fcf518e3          	bne	a0,a5,80003120 <dirlookup+0x3a>
    if(de.inum == 0)
    80003154:	fc045783          	lhu	a5,-64(s0)
    80003158:	dfe1                	beqz	a5,80003130 <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    8000315a:	fc240593          	addi	a1,s0,-62
    8000315e:	854e                	mv	a0,s3
    80003160:	00000097          	auipc	ra,0x0
    80003164:	f6c080e7          	jalr	-148(ra) # 800030cc <namecmp>
    80003168:	f561                	bnez	a0,80003130 <dirlookup+0x4a>
      if(poff)
    8000316a:	000a0463          	beqz	s4,80003172 <dirlookup+0x8c>
        *poff = off;
    8000316e:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    80003172:	fc045583          	lhu	a1,-64(s0)
    80003176:	00092503          	lw	a0,0(s2)
    8000317a:	fffff097          	auipc	ra,0xfffff
    8000317e:	770080e7          	jalr	1904(ra) # 800028ea <iget>
    80003182:	a011                	j	80003186 <dirlookup+0xa0>
  return 0;
    80003184:	4501                	li	a0,0
}
    80003186:	70e2                	ld	ra,56(sp)
    80003188:	7442                	ld	s0,48(sp)
    8000318a:	74a2                	ld	s1,40(sp)
    8000318c:	7902                	ld	s2,32(sp)
    8000318e:	69e2                	ld	s3,24(sp)
    80003190:	6a42                	ld	s4,16(sp)
    80003192:	6121                	addi	sp,sp,64
    80003194:	8082                	ret

0000000080003196 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80003196:	711d                	addi	sp,sp,-96
    80003198:	ec86                	sd	ra,88(sp)
    8000319a:	e8a2                	sd	s0,80(sp)
    8000319c:	e4a6                	sd	s1,72(sp)
    8000319e:	e0ca                	sd	s2,64(sp)
    800031a0:	fc4e                	sd	s3,56(sp)
    800031a2:	f852                	sd	s4,48(sp)
    800031a4:	f456                	sd	s5,40(sp)
    800031a6:	f05a                	sd	s6,32(sp)
    800031a8:	ec5e                	sd	s7,24(sp)
    800031aa:	e862                	sd	s8,16(sp)
    800031ac:	e466                	sd	s9,8(sp)
    800031ae:	1080                	addi	s0,sp,96
    800031b0:	84aa                	mv	s1,a0
    800031b2:	8b2e                	mv	s6,a1
    800031b4:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    800031b6:	00054703          	lbu	a4,0(a0)
    800031ba:	02f00793          	li	a5,47
    800031be:	02f70363          	beq	a4,a5,800031e4 <namex+0x4e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    800031c2:	ffffe097          	auipc	ra,0xffffe
    800031c6:	d64080e7          	jalr	-668(ra) # 80000f26 <myproc>
    800031ca:	15053503          	ld	a0,336(a0)
    800031ce:	00000097          	auipc	ra,0x0
    800031d2:	a00080e7          	jalr	-1536(ra) # 80002bce <idup>
    800031d6:	89aa                	mv	s3,a0
  while(*path == '/')
    800031d8:	02f00913          	li	s2,47
  len = path - s;
    800031dc:	4b81                	li	s7,0
  if(len >= DIRSIZ)
    800031de:	4cb5                	li	s9,13

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    800031e0:	4c05                	li	s8,1
    800031e2:	a865                	j	8000329a <namex+0x104>
    ip = iget(ROOTDEV, ROOTINO);
    800031e4:	4585                	li	a1,1
    800031e6:	4505                	li	a0,1
    800031e8:	fffff097          	auipc	ra,0xfffff
    800031ec:	702080e7          	jalr	1794(ra) # 800028ea <iget>
    800031f0:	89aa                	mv	s3,a0
    800031f2:	b7dd                	j	800031d8 <namex+0x42>
      iunlockput(ip);
    800031f4:	854e                	mv	a0,s3
    800031f6:	00000097          	auipc	ra,0x0
    800031fa:	c78080e7          	jalr	-904(ra) # 80002e6e <iunlockput>
      return 0;
    800031fe:	4981                	li	s3,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    80003200:	854e                	mv	a0,s3
    80003202:	60e6                	ld	ra,88(sp)
    80003204:	6446                	ld	s0,80(sp)
    80003206:	64a6                	ld	s1,72(sp)
    80003208:	6906                	ld	s2,64(sp)
    8000320a:	79e2                	ld	s3,56(sp)
    8000320c:	7a42                	ld	s4,48(sp)
    8000320e:	7aa2                	ld	s5,40(sp)
    80003210:	7b02                	ld	s6,32(sp)
    80003212:	6be2                	ld	s7,24(sp)
    80003214:	6c42                	ld	s8,16(sp)
    80003216:	6ca2                	ld	s9,8(sp)
    80003218:	6125                	addi	sp,sp,96
    8000321a:	8082                	ret
      iunlock(ip);
    8000321c:	854e                	mv	a0,s3
    8000321e:	00000097          	auipc	ra,0x0
    80003222:	ab0080e7          	jalr	-1360(ra) # 80002cce <iunlock>
      return ip;
    80003226:	bfe9                	j	80003200 <namex+0x6a>
      iunlockput(ip);
    80003228:	854e                	mv	a0,s3
    8000322a:	00000097          	auipc	ra,0x0
    8000322e:	c44080e7          	jalr	-956(ra) # 80002e6e <iunlockput>
      return 0;
    80003232:	89d2                	mv	s3,s4
    80003234:	b7f1                	j	80003200 <namex+0x6a>
  len = path - s;
    80003236:	40b48633          	sub	a2,s1,a1
    8000323a:	00060a1b          	sext.w	s4,a2
  if(len >= DIRSIZ)
    8000323e:	094cd463          	bge	s9,s4,800032c6 <namex+0x130>
    memmove(name, s, DIRSIZ);
    80003242:	4639                	li	a2,14
    80003244:	8556                	mv	a0,s5
    80003246:	ffffd097          	auipc	ra,0xffffd
    8000324a:	f92080e7          	jalr	-110(ra) # 800001d8 <memmove>
  while(*path == '/')
    8000324e:	0004c783          	lbu	a5,0(s1)
    80003252:	01279763          	bne	a5,s2,80003260 <namex+0xca>
    path++;
    80003256:	0485                	addi	s1,s1,1
  while(*path == '/')
    80003258:	0004c783          	lbu	a5,0(s1)
    8000325c:	ff278de3          	beq	a5,s2,80003256 <namex+0xc0>
    ilock(ip);
    80003260:	854e                	mv	a0,s3
    80003262:	00000097          	auipc	ra,0x0
    80003266:	9aa080e7          	jalr	-1622(ra) # 80002c0c <ilock>
    if(ip->type != T_DIR){
    8000326a:	04499783          	lh	a5,68(s3)
    8000326e:	f98793e3          	bne	a5,s8,800031f4 <namex+0x5e>
    if(nameiparent && *path == '\0'){
    80003272:	000b0563          	beqz	s6,8000327c <namex+0xe6>
    80003276:	0004c783          	lbu	a5,0(s1)
    8000327a:	d3cd                	beqz	a5,8000321c <namex+0x86>
    if((next = dirlookup(ip, name, 0)) == 0){
    8000327c:	865e                	mv	a2,s7
    8000327e:	85d6                	mv	a1,s5
    80003280:	854e                	mv	a0,s3
    80003282:	00000097          	auipc	ra,0x0
    80003286:	e64080e7          	jalr	-412(ra) # 800030e6 <dirlookup>
    8000328a:	8a2a                	mv	s4,a0
    8000328c:	dd51                	beqz	a0,80003228 <namex+0x92>
    iunlockput(ip);
    8000328e:	854e                	mv	a0,s3
    80003290:	00000097          	auipc	ra,0x0
    80003294:	bde080e7          	jalr	-1058(ra) # 80002e6e <iunlockput>
    ip = next;
    80003298:	89d2                	mv	s3,s4
  while(*path == '/')
    8000329a:	0004c783          	lbu	a5,0(s1)
    8000329e:	05279763          	bne	a5,s2,800032ec <namex+0x156>
    path++;
    800032a2:	0485                	addi	s1,s1,1
  while(*path == '/')
    800032a4:	0004c783          	lbu	a5,0(s1)
    800032a8:	ff278de3          	beq	a5,s2,800032a2 <namex+0x10c>
  if(*path == 0)
    800032ac:	c79d                	beqz	a5,800032da <namex+0x144>
    path++;
    800032ae:	85a6                	mv	a1,s1
  len = path - s;
    800032b0:	8a5e                	mv	s4,s7
    800032b2:	865e                	mv	a2,s7
  while(*path != '/' && *path != 0)
    800032b4:	01278963          	beq	a5,s2,800032c6 <namex+0x130>
    800032b8:	dfbd                	beqz	a5,80003236 <namex+0xa0>
    path++;
    800032ba:	0485                	addi	s1,s1,1
  while(*path != '/' && *path != 0)
    800032bc:	0004c783          	lbu	a5,0(s1)
    800032c0:	ff279ce3          	bne	a5,s2,800032b8 <namex+0x122>
    800032c4:	bf8d                	j	80003236 <namex+0xa0>
    memmove(name, s, len);
    800032c6:	2601                	sext.w	a2,a2
    800032c8:	8556                	mv	a0,s5
    800032ca:	ffffd097          	auipc	ra,0xffffd
    800032ce:	f0e080e7          	jalr	-242(ra) # 800001d8 <memmove>
    name[len] = 0;
    800032d2:	9a56                	add	s4,s4,s5
    800032d4:	000a0023          	sb	zero,0(s4)
    800032d8:	bf9d                	j	8000324e <namex+0xb8>
  if(nameiparent){
    800032da:	f20b03e3          	beqz	s6,80003200 <namex+0x6a>
    iput(ip);
    800032de:	854e                	mv	a0,s3
    800032e0:	00000097          	auipc	ra,0x0
    800032e4:	ae6080e7          	jalr	-1306(ra) # 80002dc6 <iput>
    return 0;
    800032e8:	4981                	li	s3,0
    800032ea:	bf19                	j	80003200 <namex+0x6a>
  if(*path == 0)
    800032ec:	d7fd                	beqz	a5,800032da <namex+0x144>
  while(*path != '/' && *path != 0)
    800032ee:	0004c783          	lbu	a5,0(s1)
    800032f2:	85a6                	mv	a1,s1
    800032f4:	b7d1                	j	800032b8 <namex+0x122>

00000000800032f6 <dirlink>:
{
    800032f6:	7139                	addi	sp,sp,-64
    800032f8:	fc06                	sd	ra,56(sp)
    800032fa:	f822                	sd	s0,48(sp)
    800032fc:	f426                	sd	s1,40(sp)
    800032fe:	f04a                	sd	s2,32(sp)
    80003300:	ec4e                	sd	s3,24(sp)
    80003302:	e852                	sd	s4,16(sp)
    80003304:	0080                	addi	s0,sp,64
    80003306:	892a                	mv	s2,a0
    80003308:	8a2e                	mv	s4,a1
    8000330a:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    8000330c:	4601                	li	a2,0
    8000330e:	00000097          	auipc	ra,0x0
    80003312:	dd8080e7          	jalr	-552(ra) # 800030e6 <dirlookup>
    80003316:	e93d                	bnez	a0,8000338c <dirlink+0x96>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003318:	04c92483          	lw	s1,76(s2)
    8000331c:	c49d                	beqz	s1,8000334a <dirlink+0x54>
    8000331e:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003320:	4741                	li	a4,16
    80003322:	86a6                	mv	a3,s1
    80003324:	fc040613          	addi	a2,s0,-64
    80003328:	4581                	li	a1,0
    8000332a:	854a                	mv	a0,s2
    8000332c:	00000097          	auipc	ra,0x0
    80003330:	b94080e7          	jalr	-1132(ra) # 80002ec0 <readi>
    80003334:	47c1                	li	a5,16
    80003336:	06f51163          	bne	a0,a5,80003398 <dirlink+0xa2>
    if(de.inum == 0)
    8000333a:	fc045783          	lhu	a5,-64(s0)
    8000333e:	c791                	beqz	a5,8000334a <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003340:	24c1                	addiw	s1,s1,16
    80003342:	04c92783          	lw	a5,76(s2)
    80003346:	fcf4ede3          	bltu	s1,a5,80003320 <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    8000334a:	4639                	li	a2,14
    8000334c:	85d2                	mv	a1,s4
    8000334e:	fc240513          	addi	a0,s0,-62
    80003352:	ffffd097          	auipc	ra,0xffffd
    80003356:	f3a080e7          	jalr	-198(ra) # 8000028c <strncpy>
  de.inum = inum;
    8000335a:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000335e:	4741                	li	a4,16
    80003360:	86a6                	mv	a3,s1
    80003362:	fc040613          	addi	a2,s0,-64
    80003366:	4581                	li	a1,0
    80003368:	854a                	mv	a0,s2
    8000336a:	00000097          	auipc	ra,0x0
    8000336e:	c4e080e7          	jalr	-946(ra) # 80002fb8 <writei>
    80003372:	872a                	mv	a4,a0
    80003374:	47c1                	li	a5,16
  return 0;
    80003376:	4501                	li	a0,0
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003378:	02f71863          	bne	a4,a5,800033a8 <dirlink+0xb2>
}
    8000337c:	70e2                	ld	ra,56(sp)
    8000337e:	7442                	ld	s0,48(sp)
    80003380:	74a2                	ld	s1,40(sp)
    80003382:	7902                	ld	s2,32(sp)
    80003384:	69e2                	ld	s3,24(sp)
    80003386:	6a42                	ld	s4,16(sp)
    80003388:	6121                	addi	sp,sp,64
    8000338a:	8082                	ret
    iput(ip);
    8000338c:	00000097          	auipc	ra,0x0
    80003390:	a3a080e7          	jalr	-1478(ra) # 80002dc6 <iput>
    return -1;
    80003394:	557d                	li	a0,-1
    80003396:	b7dd                	j	8000337c <dirlink+0x86>
      panic("dirlink read");
    80003398:	00005517          	auipc	a0,0x5
    8000339c:	24050513          	addi	a0,a0,576 # 800085d8 <syscalls+0x220>
    800033a0:	00003097          	auipc	ra,0x3
    800033a4:	ba8080e7          	jalr	-1112(ra) # 80005f48 <panic>
    panic("dirlink");
    800033a8:	00005517          	auipc	a0,0x5
    800033ac:	3d850513          	addi	a0,a0,984 # 80008780 <syscalls+0x3c8>
    800033b0:	00003097          	auipc	ra,0x3
    800033b4:	b98080e7          	jalr	-1128(ra) # 80005f48 <panic>

00000000800033b8 <namei>:

struct inode*
namei(char *path)
{
    800033b8:	1101                	addi	sp,sp,-32
    800033ba:	ec06                	sd	ra,24(sp)
    800033bc:	e822                	sd	s0,16(sp)
    800033be:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    800033c0:	fe040613          	addi	a2,s0,-32
    800033c4:	4581                	li	a1,0
    800033c6:	00000097          	auipc	ra,0x0
    800033ca:	dd0080e7          	jalr	-560(ra) # 80003196 <namex>
}
    800033ce:	60e2                	ld	ra,24(sp)
    800033d0:	6442                	ld	s0,16(sp)
    800033d2:	6105                	addi	sp,sp,32
    800033d4:	8082                	ret

00000000800033d6 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    800033d6:	1141                	addi	sp,sp,-16
    800033d8:	e406                	sd	ra,8(sp)
    800033da:	e022                	sd	s0,0(sp)
    800033dc:	0800                	addi	s0,sp,16
    800033de:	862e                	mv	a2,a1
  return namex(path, 1, name);
    800033e0:	4585                	li	a1,1
    800033e2:	00000097          	auipc	ra,0x0
    800033e6:	db4080e7          	jalr	-588(ra) # 80003196 <namex>
}
    800033ea:	60a2                	ld	ra,8(sp)
    800033ec:	6402                	ld	s0,0(sp)
    800033ee:	0141                	addi	sp,sp,16
    800033f0:	8082                	ret

00000000800033f2 <balloc_page>:

/* NTU OS 2024 */
/* Similar to balloc, except allocates eight consecutive free blocks. */
uint balloc_page(uint dev) {
    800033f2:	715d                	addi	sp,sp,-80
    800033f4:	e486                	sd	ra,72(sp)
    800033f6:	e0a2                	sd	s0,64(sp)
    800033f8:	fc26                	sd	s1,56(sp)
    800033fa:	f84a                	sd	s2,48(sp)
    800033fc:	f44e                	sd	s3,40(sp)
    800033fe:	f052                	sd	s4,32(sp)
    80003400:	ec56                	sd	s5,24(sp)
    80003402:	e85a                	sd	s6,16(sp)
    80003404:	e45e                	sd	s7,8(sp)
    80003406:	0880                	addi	s0,sp,80
  for (int b = 0; b < sb.size; b += BPB) {
    80003408:	00014797          	auipc	a5,0x14
    8000340c:	1547a783          	lw	a5,340(a5) # 8001755c <sb+0x4>
    80003410:	c3e9                	beqz	a5,800034d2 <balloc_page+0xe0>
    80003412:	89aa                	mv	s3,a0
    80003414:	4a01                	li	s4,0
    struct buf *bp = bread(dev, BBLOCK(b, sb));
    80003416:	00014a97          	auipc	s5,0x14
    8000341a:	142a8a93          	addi	s5,s5,322 # 80017558 <sb>

    for (int bi = 0; bi < BPB && b + bi < sb.size; bi += 8) {
    8000341e:	4b01                	li	s6,0
    80003420:	6909                	lui	s2,0x2
  for (int b = 0; b < sb.size; b += BPB) {
    80003422:	6b89                	lui	s7,0x2
    80003424:	a8b9                	j	80003482 <balloc_page+0x90>
      uchar *bits = &bp->data[bi / 8];
      if (*bits == 0) {
        *bits |= 0xff; // Mark 8 consecutive blocks in use.
    80003426:	97aa                	add	a5,a5,a0
    80003428:	577d                	li	a4,-1
    8000342a:	04e78c23          	sb	a4,88(a5)
        //log_write(bp);
        brelse(bp);
    8000342e:	fffff097          	auipc	ra,0xfffff
    80003432:	070080e7          	jalr	112(ra) # 8000249e <brelse>

        for (int i = 0; i < 8; i += 1) {
    80003436:	00848a1b          	addiw	s4,s1,8
        brelse(bp);
    8000343a:	8926                	mv	s2,s1
          bzero(dev, b + bi + i);
    8000343c:	2981                	sext.w	s3,s3
    8000343e:	0009059b          	sext.w	a1,s2
    80003442:	854e                	mv	a0,s3
    80003444:	fffff097          	auipc	ra,0xfffff
    80003448:	29e080e7          	jalr	670(ra) # 800026e2 <bzero>
        for (int i = 0; i < 8; i += 1) {
    8000344c:	2905                	addiw	s2,s2,1
    8000344e:	ff4918e3          	bne	s2,s4,8000343e <balloc_page+0x4c>
    }

    brelse(bp);
  }
  panic("balloc_page: out of blocks");
}
    80003452:	8526                	mv	a0,s1
    80003454:	60a6                	ld	ra,72(sp)
    80003456:	6406                	ld	s0,64(sp)
    80003458:	74e2                	ld	s1,56(sp)
    8000345a:	7942                	ld	s2,48(sp)
    8000345c:	79a2                	ld	s3,40(sp)
    8000345e:	7a02                	ld	s4,32(sp)
    80003460:	6ae2                	ld	s5,24(sp)
    80003462:	6b42                	ld	s6,16(sp)
    80003464:	6ba2                	ld	s7,8(sp)
    80003466:	6161                	addi	sp,sp,80
    80003468:	8082                	ret
    brelse(bp);
    8000346a:	fffff097          	auipc	ra,0xfffff
    8000346e:	034080e7          	jalr	52(ra) # 8000249e <brelse>
  for (int b = 0; b < sb.size; b += BPB) {
    80003472:	014b87bb          	addw	a5,s7,s4
    80003476:	00078a1b          	sext.w	s4,a5
    8000347a:	004aa703          	lw	a4,4(s5)
    8000347e:	04ea7a63          	bgeu	s4,a4,800034d2 <balloc_page+0xe0>
    struct buf *bp = bread(dev, BBLOCK(b, sb));
    80003482:	41fa579b          	sraiw	a5,s4,0x1f
    80003486:	0137d79b          	srliw	a5,a5,0x13
    8000348a:	014787bb          	addw	a5,a5,s4
    8000348e:	40d7d79b          	sraiw	a5,a5,0xd
    80003492:	01caa583          	lw	a1,28(s5)
    80003496:	9dbd                	addw	a1,a1,a5
    80003498:	854e                	mv	a0,s3
    8000349a:	fffff097          	auipc	ra,0xfffff
    8000349e:	f92080e7          	jalr	-110(ra) # 8000242c <bread>
    for (int bi = 0; bi < BPB && b + bi < sb.size; bi += 8) {
    800034a2:	004aa603          	lw	a2,4(s5)
    800034a6:	000a049b          	sext.w	s1,s4
    800034aa:	875a                	mv	a4,s6
    800034ac:	fac4ffe3          	bgeu	s1,a2,8000346a <balloc_page+0x78>
      uchar *bits = &bp->data[bi / 8];
    800034b0:	41f7579b          	sraiw	a5,a4,0x1f
    800034b4:	01d7d79b          	srliw	a5,a5,0x1d
    800034b8:	9fb9                	addw	a5,a5,a4
    800034ba:	4037d79b          	sraiw	a5,a5,0x3
      if (*bits == 0) {
    800034be:	00f506b3          	add	a3,a0,a5
    800034c2:	0586c683          	lbu	a3,88(a3)
    800034c6:	d2a5                	beqz	a3,80003426 <balloc_page+0x34>
    for (int bi = 0; bi < BPB && b + bi < sb.size; bi += 8) {
    800034c8:	2721                	addiw	a4,a4,8
    800034ca:	24a1                	addiw	s1,s1,8
    800034cc:	ff2710e3          	bne	a4,s2,800034ac <balloc_page+0xba>
    800034d0:	bf69                	j	8000346a <balloc_page+0x78>
  panic("balloc_page: out of blocks");
    800034d2:	00005517          	auipc	a0,0x5
    800034d6:	11650513          	addi	a0,a0,278 # 800085e8 <syscalls+0x230>
    800034da:	00003097          	auipc	ra,0x3
    800034de:	a6e080e7          	jalr	-1426(ra) # 80005f48 <panic>

00000000800034e2 <bfree_page>:

/* NTU OS 2024 */
/* Free 8 disk blocks allocated from balloc_page(). */
void bfree_page(int dev, uint blockno) {
    800034e2:	1101                	addi	sp,sp,-32
    800034e4:	ec06                	sd	ra,24(sp)
    800034e6:	e822                	sd	s0,16(sp)
    800034e8:	e426                	sd	s1,8(sp)
    800034ea:	1000                	addi	s0,sp,32
  if (blockno + 8 > sb.size) {
    800034ec:	0085871b          	addiw	a4,a1,8
    800034f0:	00014797          	auipc	a5,0x14
    800034f4:	06c7a783          	lw	a5,108(a5) # 8001755c <sb+0x4>
    800034f8:	04e7ee63          	bltu	a5,a4,80003554 <bfree_page+0x72>
    panic("bfree_page: blockno out of bound");
  }

  if ((blockno % 8) != 0) {
    800034fc:	0075f793          	andi	a5,a1,7
    80003500:	e3b5                	bnez	a5,80003564 <bfree_page+0x82>
    panic("bfree_page: blockno is not aligned");
  }

  int bi = blockno % BPB;
    80003502:	03359493          	slli	s1,a1,0x33
    80003506:	90cd                	srli	s1,s1,0x33
  int b = blockno - bi;
    80003508:	9d85                	subw	a1,a1,s1
  struct buf *bp = bread(dev, BBLOCK(b, sb));
    8000350a:	41f5d79b          	sraiw	a5,a1,0x1f
    8000350e:	0137d79b          	srliw	a5,a5,0x13
    80003512:	9dbd                	addw	a1,a1,a5
    80003514:	40d5d59b          	sraiw	a1,a1,0xd
    80003518:	00014797          	auipc	a5,0x14
    8000351c:	05c7a783          	lw	a5,92(a5) # 80017574 <sb+0x1c>
    80003520:	9dbd                	addw	a1,a1,a5
    80003522:	fffff097          	auipc	ra,0xfffff
    80003526:	f0a080e7          	jalr	-246(ra) # 8000242c <bread>
  uchar *bits = &bp->data[bi / 8];
    8000352a:	808d                	srli	s1,s1,0x3

  if (*bits != 0xff) {
    8000352c:	009507b3          	add	a5,a0,s1
    80003530:	0587c703          	lbu	a4,88(a5)
    80003534:	0ff00793          	li	a5,255
    80003538:	02f71e63          	bne	a4,a5,80003574 <bfree_page+0x92>
    panic("bfree_page: data bits are invalid");
  }

  *bits = 0;
    8000353c:	94aa                	add	s1,s1,a0
    8000353e:	04048c23          	sb	zero,88(s1)
  //log_write(bp);
  brelse(bp);
    80003542:	fffff097          	auipc	ra,0xfffff
    80003546:	f5c080e7          	jalr	-164(ra) # 8000249e <brelse>
}
    8000354a:	60e2                	ld	ra,24(sp)
    8000354c:	6442                	ld	s0,16(sp)
    8000354e:	64a2                	ld	s1,8(sp)
    80003550:	6105                	addi	sp,sp,32
    80003552:	8082                	ret
    panic("bfree_page: blockno out of bound");
    80003554:	00005517          	auipc	a0,0x5
    80003558:	0b450513          	addi	a0,a0,180 # 80008608 <syscalls+0x250>
    8000355c:	00003097          	auipc	ra,0x3
    80003560:	9ec080e7          	jalr	-1556(ra) # 80005f48 <panic>
    panic("bfree_page: blockno is not aligned");
    80003564:	00005517          	auipc	a0,0x5
    80003568:	0cc50513          	addi	a0,a0,204 # 80008630 <syscalls+0x278>
    8000356c:	00003097          	auipc	ra,0x3
    80003570:	9dc080e7          	jalr	-1572(ra) # 80005f48 <panic>
    panic("bfree_page: data bits are invalid");
    80003574:	00005517          	auipc	a0,0x5
    80003578:	0e450513          	addi	a0,a0,228 # 80008658 <syscalls+0x2a0>
    8000357c:	00003097          	auipc	ra,0x3
    80003580:	9cc080e7          	jalr	-1588(ra) # 80005f48 <panic>

0000000080003584 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    80003584:	1101                	addi	sp,sp,-32
    80003586:	ec06                	sd	ra,24(sp)
    80003588:	e822                	sd	s0,16(sp)
    8000358a:	e426                	sd	s1,8(sp)
    8000358c:	e04a                	sd	s2,0(sp)
    8000358e:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    80003590:	00016917          	auipc	s2,0x16
    80003594:	a9090913          	addi	s2,s2,-1392 # 80019020 <log>
    80003598:	01892583          	lw	a1,24(s2)
    8000359c:	02892503          	lw	a0,40(s2)
    800035a0:	fffff097          	auipc	ra,0xfffff
    800035a4:	e8c080e7          	jalr	-372(ra) # 8000242c <bread>
    800035a8:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    800035aa:	02c92683          	lw	a3,44(s2)
    800035ae:	cd34                	sw	a3,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    800035b0:	02d05763          	blez	a3,800035de <write_head+0x5a>
    800035b4:	00016797          	auipc	a5,0x16
    800035b8:	a9c78793          	addi	a5,a5,-1380 # 80019050 <log+0x30>
    800035bc:	05c50713          	addi	a4,a0,92
    800035c0:	36fd                	addiw	a3,a3,-1
    800035c2:	1682                	slli	a3,a3,0x20
    800035c4:	9281                	srli	a3,a3,0x20
    800035c6:	068a                	slli	a3,a3,0x2
    800035c8:	00016617          	auipc	a2,0x16
    800035cc:	a8c60613          	addi	a2,a2,-1396 # 80019054 <log+0x34>
    800035d0:	96b2                	add	a3,a3,a2
    hb->block[i] = log.lh.block[i];
    800035d2:	4390                	lw	a2,0(a5)
    800035d4:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    800035d6:	0791                	addi	a5,a5,4
    800035d8:	0711                	addi	a4,a4,4
    800035da:	fed79ce3          	bne	a5,a3,800035d2 <write_head+0x4e>
  }
  bwrite(buf);
    800035de:	8526                	mv	a0,s1
    800035e0:	fffff097          	auipc	ra,0xfffff
    800035e4:	e80080e7          	jalr	-384(ra) # 80002460 <bwrite>
  brelse(buf);
    800035e8:	8526                	mv	a0,s1
    800035ea:	fffff097          	auipc	ra,0xfffff
    800035ee:	eb4080e7          	jalr	-332(ra) # 8000249e <brelse>
}
    800035f2:	60e2                	ld	ra,24(sp)
    800035f4:	6442                	ld	s0,16(sp)
    800035f6:	64a2                	ld	s1,8(sp)
    800035f8:	6902                	ld	s2,0(sp)
    800035fa:	6105                	addi	sp,sp,32
    800035fc:	8082                	ret

00000000800035fe <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    800035fe:	00016797          	auipc	a5,0x16
    80003602:	a4e7a783          	lw	a5,-1458(a5) # 8001904c <log+0x2c>
    80003606:	0af05d63          	blez	a5,800036c0 <install_trans+0xc2>
{
    8000360a:	7139                	addi	sp,sp,-64
    8000360c:	fc06                	sd	ra,56(sp)
    8000360e:	f822                	sd	s0,48(sp)
    80003610:	f426                	sd	s1,40(sp)
    80003612:	f04a                	sd	s2,32(sp)
    80003614:	ec4e                	sd	s3,24(sp)
    80003616:	e852                	sd	s4,16(sp)
    80003618:	e456                	sd	s5,8(sp)
    8000361a:	e05a                	sd	s6,0(sp)
    8000361c:	0080                	addi	s0,sp,64
    8000361e:	8b2a                	mv	s6,a0
    80003620:	00016a97          	auipc	s5,0x16
    80003624:	a30a8a93          	addi	s5,s5,-1488 # 80019050 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003628:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    8000362a:	00016997          	auipc	s3,0x16
    8000362e:	9f698993          	addi	s3,s3,-1546 # 80019020 <log>
    80003632:	a035                	j	8000365e <install_trans+0x60>
      bunpin(dbuf);
    80003634:	8526                	mv	a0,s1
    80003636:	fffff097          	auipc	ra,0xfffff
    8000363a:	f42080e7          	jalr	-190(ra) # 80002578 <bunpin>
    brelse(lbuf);
    8000363e:	854a                	mv	a0,s2
    80003640:	fffff097          	auipc	ra,0xfffff
    80003644:	e5e080e7          	jalr	-418(ra) # 8000249e <brelse>
    brelse(dbuf);
    80003648:	8526                	mv	a0,s1
    8000364a:	fffff097          	auipc	ra,0xfffff
    8000364e:	e54080e7          	jalr	-428(ra) # 8000249e <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003652:	2a05                	addiw	s4,s4,1
    80003654:	0a91                	addi	s5,s5,4
    80003656:	02c9a783          	lw	a5,44(s3)
    8000365a:	04fa5963          	bge	s4,a5,800036ac <install_trans+0xae>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    8000365e:	0189a583          	lw	a1,24(s3)
    80003662:	014585bb          	addw	a1,a1,s4
    80003666:	2585                	addiw	a1,a1,1
    80003668:	0289a503          	lw	a0,40(s3)
    8000366c:	fffff097          	auipc	ra,0xfffff
    80003670:	dc0080e7          	jalr	-576(ra) # 8000242c <bread>
    80003674:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    80003676:	000aa583          	lw	a1,0(s5)
    8000367a:	0289a503          	lw	a0,40(s3)
    8000367e:	fffff097          	auipc	ra,0xfffff
    80003682:	dae080e7          	jalr	-594(ra) # 8000242c <bread>
    80003686:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80003688:	40000613          	li	a2,1024
    8000368c:	05890593          	addi	a1,s2,88
    80003690:	05850513          	addi	a0,a0,88
    80003694:	ffffd097          	auipc	ra,0xffffd
    80003698:	b44080e7          	jalr	-1212(ra) # 800001d8 <memmove>
    bwrite(dbuf);  // write dst to disk
    8000369c:	8526                	mv	a0,s1
    8000369e:	fffff097          	auipc	ra,0xfffff
    800036a2:	dc2080e7          	jalr	-574(ra) # 80002460 <bwrite>
    if(recovering == 0)
    800036a6:	f80b1ce3          	bnez	s6,8000363e <install_trans+0x40>
    800036aa:	b769                	j	80003634 <install_trans+0x36>
}
    800036ac:	70e2                	ld	ra,56(sp)
    800036ae:	7442                	ld	s0,48(sp)
    800036b0:	74a2                	ld	s1,40(sp)
    800036b2:	7902                	ld	s2,32(sp)
    800036b4:	69e2                	ld	s3,24(sp)
    800036b6:	6a42                	ld	s4,16(sp)
    800036b8:	6aa2                	ld	s5,8(sp)
    800036ba:	6b02                	ld	s6,0(sp)
    800036bc:	6121                	addi	sp,sp,64
    800036be:	8082                	ret
    800036c0:	8082                	ret

00000000800036c2 <initlog>:
{
    800036c2:	7179                	addi	sp,sp,-48
    800036c4:	f406                	sd	ra,40(sp)
    800036c6:	f022                	sd	s0,32(sp)
    800036c8:	ec26                	sd	s1,24(sp)
    800036ca:	e84a                	sd	s2,16(sp)
    800036cc:	e44e                	sd	s3,8(sp)
    800036ce:	1800                	addi	s0,sp,48
    800036d0:	892a                	mv	s2,a0
    800036d2:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    800036d4:	00016497          	auipc	s1,0x16
    800036d8:	94c48493          	addi	s1,s1,-1716 # 80019020 <log>
    800036dc:	00005597          	auipc	a1,0x5
    800036e0:	fa458593          	addi	a1,a1,-92 # 80008680 <syscalls+0x2c8>
    800036e4:	8526                	mv	a0,s1
    800036e6:	00003097          	auipc	ra,0x3
    800036ea:	d1c080e7          	jalr	-740(ra) # 80006402 <initlock>
  log.start = sb->logstart;
    800036ee:	0149a583          	lw	a1,20(s3)
    800036f2:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    800036f4:	0109a783          	lw	a5,16(s3)
    800036f8:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    800036fa:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    800036fe:	854a                	mv	a0,s2
    80003700:	fffff097          	auipc	ra,0xfffff
    80003704:	d2c080e7          	jalr	-724(ra) # 8000242c <bread>
  log.lh.n = lh->n;
    80003708:	4d3c                	lw	a5,88(a0)
    8000370a:	d4dc                	sw	a5,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    8000370c:	02f05563          	blez	a5,80003736 <initlog+0x74>
    80003710:	05c50713          	addi	a4,a0,92
    80003714:	00016697          	auipc	a3,0x16
    80003718:	93c68693          	addi	a3,a3,-1732 # 80019050 <log+0x30>
    8000371c:	37fd                	addiw	a5,a5,-1
    8000371e:	1782                	slli	a5,a5,0x20
    80003720:	9381                	srli	a5,a5,0x20
    80003722:	078a                	slli	a5,a5,0x2
    80003724:	06050613          	addi	a2,a0,96
    80003728:	97b2                	add	a5,a5,a2
    log.lh.block[i] = lh->block[i];
    8000372a:	4310                	lw	a2,0(a4)
    8000372c:	c290                	sw	a2,0(a3)
  for (i = 0; i < log.lh.n; i++) {
    8000372e:	0711                	addi	a4,a4,4
    80003730:	0691                	addi	a3,a3,4
    80003732:	fef71ce3          	bne	a4,a5,8000372a <initlog+0x68>
  brelse(buf);
    80003736:	fffff097          	auipc	ra,0xfffff
    8000373a:	d68080e7          	jalr	-664(ra) # 8000249e <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    8000373e:	4505                	li	a0,1
    80003740:	00000097          	auipc	ra,0x0
    80003744:	ebe080e7          	jalr	-322(ra) # 800035fe <install_trans>
  log.lh.n = 0;
    80003748:	00016797          	auipc	a5,0x16
    8000374c:	9007a223          	sw	zero,-1788(a5) # 8001904c <log+0x2c>
  write_head(); // clear the log
    80003750:	00000097          	auipc	ra,0x0
    80003754:	e34080e7          	jalr	-460(ra) # 80003584 <write_head>
}
    80003758:	70a2                	ld	ra,40(sp)
    8000375a:	7402                	ld	s0,32(sp)
    8000375c:	64e2                	ld	s1,24(sp)
    8000375e:	6942                	ld	s2,16(sp)
    80003760:	69a2                	ld	s3,8(sp)
    80003762:	6145                	addi	sp,sp,48
    80003764:	8082                	ret

0000000080003766 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    80003766:	1101                	addi	sp,sp,-32
    80003768:	ec06                	sd	ra,24(sp)
    8000376a:	e822                	sd	s0,16(sp)
    8000376c:	e426                	sd	s1,8(sp)
    8000376e:	e04a                	sd	s2,0(sp)
    80003770:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    80003772:	00016517          	auipc	a0,0x16
    80003776:	8ae50513          	addi	a0,a0,-1874 # 80019020 <log>
    8000377a:	00003097          	auipc	ra,0x3
    8000377e:	d18080e7          	jalr	-744(ra) # 80006492 <acquire>
  while(1){
    if(log.committing){
    80003782:	00016497          	auipc	s1,0x16
    80003786:	89e48493          	addi	s1,s1,-1890 # 80019020 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    8000378a:	4979                	li	s2,30
    8000378c:	a039                	j	8000379a <begin_op+0x34>
      sleep(&log, &log.lock);
    8000378e:	85a6                	mv	a1,s1
    80003790:	8526                	mv	a0,s1
    80003792:	ffffe097          	auipc	ra,0xffffe
    80003796:	e50080e7          	jalr	-432(ra) # 800015e2 <sleep>
    if(log.committing){
    8000379a:	50dc                	lw	a5,36(s1)
    8000379c:	fbed                	bnez	a5,8000378e <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    8000379e:	509c                	lw	a5,32(s1)
    800037a0:	0017871b          	addiw	a4,a5,1
    800037a4:	0007069b          	sext.w	a3,a4
    800037a8:	0027179b          	slliw	a5,a4,0x2
    800037ac:	9fb9                	addw	a5,a5,a4
    800037ae:	0017979b          	slliw	a5,a5,0x1
    800037b2:	54d8                	lw	a4,44(s1)
    800037b4:	9fb9                	addw	a5,a5,a4
    800037b6:	00f95963          	bge	s2,a5,800037c8 <begin_op+0x62>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    800037ba:	85a6                	mv	a1,s1
    800037bc:	8526                	mv	a0,s1
    800037be:	ffffe097          	auipc	ra,0xffffe
    800037c2:	e24080e7          	jalr	-476(ra) # 800015e2 <sleep>
    800037c6:	bfd1                	j	8000379a <begin_op+0x34>
    } else {
      log.outstanding += 1;
    800037c8:	00016517          	auipc	a0,0x16
    800037cc:	85850513          	addi	a0,a0,-1960 # 80019020 <log>
    800037d0:	d114                	sw	a3,32(a0)
      release(&log.lock);
    800037d2:	00003097          	auipc	ra,0x3
    800037d6:	d74080e7          	jalr	-652(ra) # 80006546 <release>
      break;
    }
  }
}
    800037da:	60e2                	ld	ra,24(sp)
    800037dc:	6442                	ld	s0,16(sp)
    800037de:	64a2                	ld	s1,8(sp)
    800037e0:	6902                	ld	s2,0(sp)
    800037e2:	6105                	addi	sp,sp,32
    800037e4:	8082                	ret

00000000800037e6 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    800037e6:	7139                	addi	sp,sp,-64
    800037e8:	fc06                	sd	ra,56(sp)
    800037ea:	f822                	sd	s0,48(sp)
    800037ec:	f426                	sd	s1,40(sp)
    800037ee:	f04a                	sd	s2,32(sp)
    800037f0:	ec4e                	sd	s3,24(sp)
    800037f2:	e852                	sd	s4,16(sp)
    800037f4:	e456                	sd	s5,8(sp)
    800037f6:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    800037f8:	00016497          	auipc	s1,0x16
    800037fc:	82848493          	addi	s1,s1,-2008 # 80019020 <log>
    80003800:	8526                	mv	a0,s1
    80003802:	00003097          	auipc	ra,0x3
    80003806:	c90080e7          	jalr	-880(ra) # 80006492 <acquire>
  log.outstanding -= 1;
    8000380a:	509c                	lw	a5,32(s1)
    8000380c:	37fd                	addiw	a5,a5,-1
    8000380e:	0007891b          	sext.w	s2,a5
    80003812:	d09c                	sw	a5,32(s1)
  if(log.committing)
    80003814:	50dc                	lw	a5,36(s1)
    80003816:	efb9                	bnez	a5,80003874 <end_op+0x8e>
    panic("log.committing");
  if(log.outstanding == 0){
    80003818:	06091663          	bnez	s2,80003884 <end_op+0x9e>
    do_commit = 1;
    log.committing = 1;
    8000381c:	00016497          	auipc	s1,0x16
    80003820:	80448493          	addi	s1,s1,-2044 # 80019020 <log>
    80003824:	4785                	li	a5,1
    80003826:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    80003828:	8526                	mv	a0,s1
    8000382a:	00003097          	auipc	ra,0x3
    8000382e:	d1c080e7          	jalr	-740(ra) # 80006546 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    80003832:	54dc                	lw	a5,44(s1)
    80003834:	06f04763          	bgtz	a5,800038a2 <end_op+0xbc>
    acquire(&log.lock);
    80003838:	00015497          	auipc	s1,0x15
    8000383c:	7e848493          	addi	s1,s1,2024 # 80019020 <log>
    80003840:	8526                	mv	a0,s1
    80003842:	00003097          	auipc	ra,0x3
    80003846:	c50080e7          	jalr	-944(ra) # 80006492 <acquire>
    log.committing = 0;
    8000384a:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    8000384e:	8526                	mv	a0,s1
    80003850:	ffffe097          	auipc	ra,0xffffe
    80003854:	f1e080e7          	jalr	-226(ra) # 8000176e <wakeup>
    release(&log.lock);
    80003858:	8526                	mv	a0,s1
    8000385a:	00003097          	auipc	ra,0x3
    8000385e:	cec080e7          	jalr	-788(ra) # 80006546 <release>
}
    80003862:	70e2                	ld	ra,56(sp)
    80003864:	7442                	ld	s0,48(sp)
    80003866:	74a2                	ld	s1,40(sp)
    80003868:	7902                	ld	s2,32(sp)
    8000386a:	69e2                	ld	s3,24(sp)
    8000386c:	6a42                	ld	s4,16(sp)
    8000386e:	6aa2                	ld	s5,8(sp)
    80003870:	6121                	addi	sp,sp,64
    80003872:	8082                	ret
    panic("log.committing");
    80003874:	00005517          	auipc	a0,0x5
    80003878:	e1450513          	addi	a0,a0,-492 # 80008688 <syscalls+0x2d0>
    8000387c:	00002097          	auipc	ra,0x2
    80003880:	6cc080e7          	jalr	1740(ra) # 80005f48 <panic>
    wakeup(&log);
    80003884:	00015497          	auipc	s1,0x15
    80003888:	79c48493          	addi	s1,s1,1948 # 80019020 <log>
    8000388c:	8526                	mv	a0,s1
    8000388e:	ffffe097          	auipc	ra,0xffffe
    80003892:	ee0080e7          	jalr	-288(ra) # 8000176e <wakeup>
  release(&log.lock);
    80003896:	8526                	mv	a0,s1
    80003898:	00003097          	auipc	ra,0x3
    8000389c:	cae080e7          	jalr	-850(ra) # 80006546 <release>
  if(do_commit){
    800038a0:	b7c9                	j	80003862 <end_op+0x7c>
  for (tail = 0; tail < log.lh.n; tail++) {
    800038a2:	00015a97          	auipc	s5,0x15
    800038a6:	7aea8a93          	addi	s5,s5,1966 # 80019050 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    800038aa:	00015a17          	auipc	s4,0x15
    800038ae:	776a0a13          	addi	s4,s4,1910 # 80019020 <log>
    800038b2:	018a2583          	lw	a1,24(s4)
    800038b6:	012585bb          	addw	a1,a1,s2
    800038ba:	2585                	addiw	a1,a1,1
    800038bc:	028a2503          	lw	a0,40(s4)
    800038c0:	fffff097          	auipc	ra,0xfffff
    800038c4:	b6c080e7          	jalr	-1172(ra) # 8000242c <bread>
    800038c8:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    800038ca:	000aa583          	lw	a1,0(s5)
    800038ce:	028a2503          	lw	a0,40(s4)
    800038d2:	fffff097          	auipc	ra,0xfffff
    800038d6:	b5a080e7          	jalr	-1190(ra) # 8000242c <bread>
    800038da:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    800038dc:	40000613          	li	a2,1024
    800038e0:	05850593          	addi	a1,a0,88
    800038e4:	05848513          	addi	a0,s1,88
    800038e8:	ffffd097          	auipc	ra,0xffffd
    800038ec:	8f0080e7          	jalr	-1808(ra) # 800001d8 <memmove>
    bwrite(to);  // write the log
    800038f0:	8526                	mv	a0,s1
    800038f2:	fffff097          	auipc	ra,0xfffff
    800038f6:	b6e080e7          	jalr	-1170(ra) # 80002460 <bwrite>
    brelse(from);
    800038fa:	854e                	mv	a0,s3
    800038fc:	fffff097          	auipc	ra,0xfffff
    80003900:	ba2080e7          	jalr	-1118(ra) # 8000249e <brelse>
    brelse(to);
    80003904:	8526                	mv	a0,s1
    80003906:	fffff097          	auipc	ra,0xfffff
    8000390a:	b98080e7          	jalr	-1128(ra) # 8000249e <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    8000390e:	2905                	addiw	s2,s2,1
    80003910:	0a91                	addi	s5,s5,4
    80003912:	02ca2783          	lw	a5,44(s4)
    80003916:	f8f94ee3          	blt	s2,a5,800038b2 <end_op+0xcc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    8000391a:	00000097          	auipc	ra,0x0
    8000391e:	c6a080e7          	jalr	-918(ra) # 80003584 <write_head>
    install_trans(0); // Now install writes to home locations
    80003922:	4501                	li	a0,0
    80003924:	00000097          	auipc	ra,0x0
    80003928:	cda080e7          	jalr	-806(ra) # 800035fe <install_trans>
    log.lh.n = 0;
    8000392c:	00015797          	auipc	a5,0x15
    80003930:	7207a023          	sw	zero,1824(a5) # 8001904c <log+0x2c>
    write_head();    // Erase the transaction from the log
    80003934:	00000097          	auipc	ra,0x0
    80003938:	c50080e7          	jalr	-944(ra) # 80003584 <write_head>
    8000393c:	bdf5                	j	80003838 <end_op+0x52>

000000008000393e <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    8000393e:	1101                	addi	sp,sp,-32
    80003940:	ec06                	sd	ra,24(sp)
    80003942:	e822                	sd	s0,16(sp)
    80003944:	e426                	sd	s1,8(sp)
    80003946:	e04a                	sd	s2,0(sp)
    80003948:	1000                	addi	s0,sp,32
    8000394a:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    8000394c:	00015917          	auipc	s2,0x15
    80003950:	6d490913          	addi	s2,s2,1748 # 80019020 <log>
    80003954:	854a                	mv	a0,s2
    80003956:	00003097          	auipc	ra,0x3
    8000395a:	b3c080e7          	jalr	-1220(ra) # 80006492 <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    8000395e:	02c92603          	lw	a2,44(s2)
    80003962:	47f5                	li	a5,29
    80003964:	06c7c563          	blt	a5,a2,800039ce <log_write+0x90>
    80003968:	00015797          	auipc	a5,0x15
    8000396c:	6d47a783          	lw	a5,1748(a5) # 8001903c <log+0x1c>
    80003970:	37fd                	addiw	a5,a5,-1
    80003972:	04f65e63          	bge	a2,a5,800039ce <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    80003976:	00015797          	auipc	a5,0x15
    8000397a:	6ca7a783          	lw	a5,1738(a5) # 80019040 <log+0x20>
    8000397e:	06f05063          	blez	a5,800039de <log_write+0xa0>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    80003982:	4781                	li	a5,0
    80003984:	06c05563          	blez	a2,800039ee <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    80003988:	44cc                	lw	a1,12(s1)
    8000398a:	00015717          	auipc	a4,0x15
    8000398e:	6c670713          	addi	a4,a4,1734 # 80019050 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    80003992:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    80003994:	4314                	lw	a3,0(a4)
    80003996:	04b68c63          	beq	a3,a1,800039ee <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    8000399a:	2785                	addiw	a5,a5,1
    8000399c:	0711                	addi	a4,a4,4
    8000399e:	fef61be3          	bne	a2,a5,80003994 <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    800039a2:	0621                	addi	a2,a2,8
    800039a4:	060a                	slli	a2,a2,0x2
    800039a6:	00015797          	auipc	a5,0x15
    800039aa:	67a78793          	addi	a5,a5,1658 # 80019020 <log>
    800039ae:	963e                	add	a2,a2,a5
    800039b0:	44dc                	lw	a5,12(s1)
    800039b2:	ca1c                	sw	a5,16(a2)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    800039b4:	8526                	mv	a0,s1
    800039b6:	fffff097          	auipc	ra,0xfffff
    800039ba:	b86080e7          	jalr	-1146(ra) # 8000253c <bpin>
    log.lh.n++;
    800039be:	00015717          	auipc	a4,0x15
    800039c2:	66270713          	addi	a4,a4,1634 # 80019020 <log>
    800039c6:	575c                	lw	a5,44(a4)
    800039c8:	2785                	addiw	a5,a5,1
    800039ca:	d75c                	sw	a5,44(a4)
    800039cc:	a835                	j	80003a08 <log_write+0xca>
    panic("too big a transaction");
    800039ce:	00005517          	auipc	a0,0x5
    800039d2:	cca50513          	addi	a0,a0,-822 # 80008698 <syscalls+0x2e0>
    800039d6:	00002097          	auipc	ra,0x2
    800039da:	572080e7          	jalr	1394(ra) # 80005f48 <panic>
    panic("log_write outside of trans");
    800039de:	00005517          	auipc	a0,0x5
    800039e2:	cd250513          	addi	a0,a0,-814 # 800086b0 <syscalls+0x2f8>
    800039e6:	00002097          	auipc	ra,0x2
    800039ea:	562080e7          	jalr	1378(ra) # 80005f48 <panic>
  log.lh.block[i] = b->blockno;
    800039ee:	00878713          	addi	a4,a5,8
    800039f2:	00271693          	slli	a3,a4,0x2
    800039f6:	00015717          	auipc	a4,0x15
    800039fa:	62a70713          	addi	a4,a4,1578 # 80019020 <log>
    800039fe:	9736                	add	a4,a4,a3
    80003a00:	44d4                	lw	a3,12(s1)
    80003a02:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    80003a04:	faf608e3          	beq	a2,a5,800039b4 <log_write+0x76>
  }
  release(&log.lock);
    80003a08:	00015517          	auipc	a0,0x15
    80003a0c:	61850513          	addi	a0,a0,1560 # 80019020 <log>
    80003a10:	00003097          	auipc	ra,0x3
    80003a14:	b36080e7          	jalr	-1226(ra) # 80006546 <release>
}
    80003a18:	60e2                	ld	ra,24(sp)
    80003a1a:	6442                	ld	s0,16(sp)
    80003a1c:	64a2                	ld	s1,8(sp)
    80003a1e:	6902                	ld	s2,0(sp)
    80003a20:	6105                	addi	sp,sp,32
    80003a22:	8082                	ret

0000000080003a24 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80003a24:	1101                	addi	sp,sp,-32
    80003a26:	ec06                	sd	ra,24(sp)
    80003a28:	e822                	sd	s0,16(sp)
    80003a2a:	e426                	sd	s1,8(sp)
    80003a2c:	e04a                	sd	s2,0(sp)
    80003a2e:	1000                	addi	s0,sp,32
    80003a30:	84aa                	mv	s1,a0
    80003a32:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    80003a34:	00005597          	auipc	a1,0x5
    80003a38:	c9c58593          	addi	a1,a1,-868 # 800086d0 <syscalls+0x318>
    80003a3c:	0521                	addi	a0,a0,8
    80003a3e:	00003097          	auipc	ra,0x3
    80003a42:	9c4080e7          	jalr	-1596(ra) # 80006402 <initlock>
  lk->name = name;
    80003a46:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    80003a4a:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003a4e:	0204a423          	sw	zero,40(s1)
}
    80003a52:	60e2                	ld	ra,24(sp)
    80003a54:	6442                	ld	s0,16(sp)
    80003a56:	64a2                	ld	s1,8(sp)
    80003a58:	6902                	ld	s2,0(sp)
    80003a5a:	6105                	addi	sp,sp,32
    80003a5c:	8082                	ret

0000000080003a5e <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80003a5e:	1101                	addi	sp,sp,-32
    80003a60:	ec06                	sd	ra,24(sp)
    80003a62:	e822                	sd	s0,16(sp)
    80003a64:	e426                	sd	s1,8(sp)
    80003a66:	e04a                	sd	s2,0(sp)
    80003a68:	1000                	addi	s0,sp,32
    80003a6a:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003a6c:	00850913          	addi	s2,a0,8
    80003a70:	854a                	mv	a0,s2
    80003a72:	00003097          	auipc	ra,0x3
    80003a76:	a20080e7          	jalr	-1504(ra) # 80006492 <acquire>
  while (lk->locked) {
    80003a7a:	409c                	lw	a5,0(s1)
    80003a7c:	cb89                	beqz	a5,80003a8e <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    80003a7e:	85ca                	mv	a1,s2
    80003a80:	8526                	mv	a0,s1
    80003a82:	ffffe097          	auipc	ra,0xffffe
    80003a86:	b60080e7          	jalr	-1184(ra) # 800015e2 <sleep>
  while (lk->locked) {
    80003a8a:	409c                	lw	a5,0(s1)
    80003a8c:	fbed                	bnez	a5,80003a7e <acquiresleep+0x20>
  }
  lk->locked = 1;
    80003a8e:	4785                	li	a5,1
    80003a90:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    80003a92:	ffffd097          	auipc	ra,0xffffd
    80003a96:	494080e7          	jalr	1172(ra) # 80000f26 <myproc>
    80003a9a:	591c                	lw	a5,48(a0)
    80003a9c:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    80003a9e:	854a                	mv	a0,s2
    80003aa0:	00003097          	auipc	ra,0x3
    80003aa4:	aa6080e7          	jalr	-1370(ra) # 80006546 <release>
}
    80003aa8:	60e2                	ld	ra,24(sp)
    80003aaa:	6442                	ld	s0,16(sp)
    80003aac:	64a2                	ld	s1,8(sp)
    80003aae:	6902                	ld	s2,0(sp)
    80003ab0:	6105                	addi	sp,sp,32
    80003ab2:	8082                	ret

0000000080003ab4 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    80003ab4:	1101                	addi	sp,sp,-32
    80003ab6:	ec06                	sd	ra,24(sp)
    80003ab8:	e822                	sd	s0,16(sp)
    80003aba:	e426                	sd	s1,8(sp)
    80003abc:	e04a                	sd	s2,0(sp)
    80003abe:	1000                	addi	s0,sp,32
    80003ac0:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003ac2:	00850913          	addi	s2,a0,8
    80003ac6:	854a                	mv	a0,s2
    80003ac8:	00003097          	auipc	ra,0x3
    80003acc:	9ca080e7          	jalr	-1590(ra) # 80006492 <acquire>
  lk->locked = 0;
    80003ad0:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003ad4:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80003ad8:	8526                	mv	a0,s1
    80003ada:	ffffe097          	auipc	ra,0xffffe
    80003ade:	c94080e7          	jalr	-876(ra) # 8000176e <wakeup>
  release(&lk->lk);
    80003ae2:	854a                	mv	a0,s2
    80003ae4:	00003097          	auipc	ra,0x3
    80003ae8:	a62080e7          	jalr	-1438(ra) # 80006546 <release>
}
    80003aec:	60e2                	ld	ra,24(sp)
    80003aee:	6442                	ld	s0,16(sp)
    80003af0:	64a2                	ld	s1,8(sp)
    80003af2:	6902                	ld	s2,0(sp)
    80003af4:	6105                	addi	sp,sp,32
    80003af6:	8082                	ret

0000000080003af8 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80003af8:	7179                	addi	sp,sp,-48
    80003afa:	f406                	sd	ra,40(sp)
    80003afc:	f022                	sd	s0,32(sp)
    80003afe:	ec26                	sd	s1,24(sp)
    80003b00:	e84a                	sd	s2,16(sp)
    80003b02:	e44e                	sd	s3,8(sp)
    80003b04:	1800                	addi	s0,sp,48
    80003b06:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80003b08:	00850913          	addi	s2,a0,8
    80003b0c:	854a                	mv	a0,s2
    80003b0e:	00003097          	auipc	ra,0x3
    80003b12:	984080e7          	jalr	-1660(ra) # 80006492 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80003b16:	409c                	lw	a5,0(s1)
    80003b18:	ef99                	bnez	a5,80003b36 <holdingsleep+0x3e>
    80003b1a:	4481                	li	s1,0
  release(&lk->lk);
    80003b1c:	854a                	mv	a0,s2
    80003b1e:	00003097          	auipc	ra,0x3
    80003b22:	a28080e7          	jalr	-1496(ra) # 80006546 <release>
  return r;
}
    80003b26:	8526                	mv	a0,s1
    80003b28:	70a2                	ld	ra,40(sp)
    80003b2a:	7402                	ld	s0,32(sp)
    80003b2c:	64e2                	ld	s1,24(sp)
    80003b2e:	6942                	ld	s2,16(sp)
    80003b30:	69a2                	ld	s3,8(sp)
    80003b32:	6145                	addi	sp,sp,48
    80003b34:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    80003b36:	0284a983          	lw	s3,40(s1)
    80003b3a:	ffffd097          	auipc	ra,0xffffd
    80003b3e:	3ec080e7          	jalr	1004(ra) # 80000f26 <myproc>
    80003b42:	5904                	lw	s1,48(a0)
    80003b44:	413484b3          	sub	s1,s1,s3
    80003b48:	0014b493          	seqz	s1,s1
    80003b4c:	bfc1                	j	80003b1c <holdingsleep+0x24>

0000000080003b4e <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80003b4e:	1141                	addi	sp,sp,-16
    80003b50:	e406                	sd	ra,8(sp)
    80003b52:	e022                	sd	s0,0(sp)
    80003b54:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80003b56:	00005597          	auipc	a1,0x5
    80003b5a:	b8a58593          	addi	a1,a1,-1142 # 800086e0 <syscalls+0x328>
    80003b5e:	00015517          	auipc	a0,0x15
    80003b62:	60a50513          	addi	a0,a0,1546 # 80019168 <ftable>
    80003b66:	00003097          	auipc	ra,0x3
    80003b6a:	89c080e7          	jalr	-1892(ra) # 80006402 <initlock>
}
    80003b6e:	60a2                	ld	ra,8(sp)
    80003b70:	6402                	ld	s0,0(sp)
    80003b72:	0141                	addi	sp,sp,16
    80003b74:	8082                	ret

0000000080003b76 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80003b76:	1101                	addi	sp,sp,-32
    80003b78:	ec06                	sd	ra,24(sp)
    80003b7a:	e822                	sd	s0,16(sp)
    80003b7c:	e426                	sd	s1,8(sp)
    80003b7e:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    80003b80:	00015517          	auipc	a0,0x15
    80003b84:	5e850513          	addi	a0,a0,1512 # 80019168 <ftable>
    80003b88:	00003097          	auipc	ra,0x3
    80003b8c:	90a080e7          	jalr	-1782(ra) # 80006492 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003b90:	00015497          	auipc	s1,0x15
    80003b94:	5f048493          	addi	s1,s1,1520 # 80019180 <ftable+0x18>
    80003b98:	00016717          	auipc	a4,0x16
    80003b9c:	58870713          	addi	a4,a4,1416 # 8001a120 <ftable+0xfb8>
    if(f->ref == 0){
    80003ba0:	40dc                	lw	a5,4(s1)
    80003ba2:	cf99                	beqz	a5,80003bc0 <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    80003ba4:	02848493          	addi	s1,s1,40
    80003ba8:	fee49ce3          	bne	s1,a4,80003ba0 <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    80003bac:	00015517          	auipc	a0,0x15
    80003bb0:	5bc50513          	addi	a0,a0,1468 # 80019168 <ftable>
    80003bb4:	00003097          	auipc	ra,0x3
    80003bb8:	992080e7          	jalr	-1646(ra) # 80006546 <release>
  return 0;
    80003bbc:	4481                	li	s1,0
    80003bbe:	a819                	j	80003bd4 <filealloc+0x5e>
      f->ref = 1;
    80003bc0:	4785                	li	a5,1
    80003bc2:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    80003bc4:	00015517          	auipc	a0,0x15
    80003bc8:	5a450513          	addi	a0,a0,1444 # 80019168 <ftable>
    80003bcc:	00003097          	auipc	ra,0x3
    80003bd0:	97a080e7          	jalr	-1670(ra) # 80006546 <release>
}
    80003bd4:	8526                	mv	a0,s1
    80003bd6:	60e2                	ld	ra,24(sp)
    80003bd8:	6442                	ld	s0,16(sp)
    80003bda:	64a2                	ld	s1,8(sp)
    80003bdc:	6105                	addi	sp,sp,32
    80003bde:	8082                	ret

0000000080003be0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80003be0:	1101                	addi	sp,sp,-32
    80003be2:	ec06                	sd	ra,24(sp)
    80003be4:	e822                	sd	s0,16(sp)
    80003be6:	e426                	sd	s1,8(sp)
    80003be8:	1000                	addi	s0,sp,32
    80003bea:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    80003bec:	00015517          	auipc	a0,0x15
    80003bf0:	57c50513          	addi	a0,a0,1404 # 80019168 <ftable>
    80003bf4:	00003097          	auipc	ra,0x3
    80003bf8:	89e080e7          	jalr	-1890(ra) # 80006492 <acquire>
  if(f->ref < 1)
    80003bfc:	40dc                	lw	a5,4(s1)
    80003bfe:	02f05263          	blez	a5,80003c22 <filedup+0x42>
    panic("filedup");
  f->ref++;
    80003c02:	2785                	addiw	a5,a5,1
    80003c04:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80003c06:	00015517          	auipc	a0,0x15
    80003c0a:	56250513          	addi	a0,a0,1378 # 80019168 <ftable>
    80003c0e:	00003097          	auipc	ra,0x3
    80003c12:	938080e7          	jalr	-1736(ra) # 80006546 <release>
  return f;
}
    80003c16:	8526                	mv	a0,s1
    80003c18:	60e2                	ld	ra,24(sp)
    80003c1a:	6442                	ld	s0,16(sp)
    80003c1c:	64a2                	ld	s1,8(sp)
    80003c1e:	6105                	addi	sp,sp,32
    80003c20:	8082                	ret
    panic("filedup");
    80003c22:	00005517          	auipc	a0,0x5
    80003c26:	ac650513          	addi	a0,a0,-1338 # 800086e8 <syscalls+0x330>
    80003c2a:	00002097          	auipc	ra,0x2
    80003c2e:	31e080e7          	jalr	798(ra) # 80005f48 <panic>

0000000080003c32 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80003c32:	7139                	addi	sp,sp,-64
    80003c34:	fc06                	sd	ra,56(sp)
    80003c36:	f822                	sd	s0,48(sp)
    80003c38:	f426                	sd	s1,40(sp)
    80003c3a:	f04a                	sd	s2,32(sp)
    80003c3c:	ec4e                	sd	s3,24(sp)
    80003c3e:	e852                	sd	s4,16(sp)
    80003c40:	e456                	sd	s5,8(sp)
    80003c42:	0080                	addi	s0,sp,64
    80003c44:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80003c46:	00015517          	auipc	a0,0x15
    80003c4a:	52250513          	addi	a0,a0,1314 # 80019168 <ftable>
    80003c4e:	00003097          	auipc	ra,0x3
    80003c52:	844080e7          	jalr	-1980(ra) # 80006492 <acquire>
  if(f->ref < 1)
    80003c56:	40dc                	lw	a5,4(s1)
    80003c58:	06f05163          	blez	a5,80003cba <fileclose+0x88>
    panic("fileclose");
  if(--f->ref > 0){
    80003c5c:	37fd                	addiw	a5,a5,-1
    80003c5e:	0007871b          	sext.w	a4,a5
    80003c62:	c0dc                	sw	a5,4(s1)
    80003c64:	06e04363          	bgtz	a4,80003cca <fileclose+0x98>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80003c68:	0004a903          	lw	s2,0(s1)
    80003c6c:	0094ca83          	lbu	s5,9(s1)
    80003c70:	0104ba03          	ld	s4,16(s1)
    80003c74:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80003c78:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80003c7c:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80003c80:	00015517          	auipc	a0,0x15
    80003c84:	4e850513          	addi	a0,a0,1256 # 80019168 <ftable>
    80003c88:	00003097          	auipc	ra,0x3
    80003c8c:	8be080e7          	jalr	-1858(ra) # 80006546 <release>

  if(ff.type == FD_PIPE){
    80003c90:	4785                	li	a5,1
    80003c92:	04f90d63          	beq	s2,a5,80003cec <fileclose+0xba>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80003c96:	3979                	addiw	s2,s2,-2
    80003c98:	4785                	li	a5,1
    80003c9a:	0527e063          	bltu	a5,s2,80003cda <fileclose+0xa8>
    begin_op();
    80003c9e:	00000097          	auipc	ra,0x0
    80003ca2:	ac8080e7          	jalr	-1336(ra) # 80003766 <begin_op>
    iput(ff.ip);
    80003ca6:	854e                	mv	a0,s3
    80003ca8:	fffff097          	auipc	ra,0xfffff
    80003cac:	11e080e7          	jalr	286(ra) # 80002dc6 <iput>
    end_op();
    80003cb0:	00000097          	auipc	ra,0x0
    80003cb4:	b36080e7          	jalr	-1226(ra) # 800037e6 <end_op>
    80003cb8:	a00d                	j	80003cda <fileclose+0xa8>
    panic("fileclose");
    80003cba:	00005517          	auipc	a0,0x5
    80003cbe:	a3650513          	addi	a0,a0,-1482 # 800086f0 <syscalls+0x338>
    80003cc2:	00002097          	auipc	ra,0x2
    80003cc6:	286080e7          	jalr	646(ra) # 80005f48 <panic>
    release(&ftable.lock);
    80003cca:	00015517          	auipc	a0,0x15
    80003cce:	49e50513          	addi	a0,a0,1182 # 80019168 <ftable>
    80003cd2:	00003097          	auipc	ra,0x3
    80003cd6:	874080e7          	jalr	-1932(ra) # 80006546 <release>
  }
}
    80003cda:	70e2                	ld	ra,56(sp)
    80003cdc:	7442                	ld	s0,48(sp)
    80003cde:	74a2                	ld	s1,40(sp)
    80003ce0:	7902                	ld	s2,32(sp)
    80003ce2:	69e2                	ld	s3,24(sp)
    80003ce4:	6a42                	ld	s4,16(sp)
    80003ce6:	6aa2                	ld	s5,8(sp)
    80003ce8:	6121                	addi	sp,sp,64
    80003cea:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80003cec:	85d6                	mv	a1,s5
    80003cee:	8552                	mv	a0,s4
    80003cf0:	00000097          	auipc	ra,0x0
    80003cf4:	34c080e7          	jalr	844(ra) # 8000403c <pipeclose>
    80003cf8:	b7cd                	j	80003cda <fileclose+0xa8>

0000000080003cfa <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80003cfa:	715d                	addi	sp,sp,-80
    80003cfc:	e486                	sd	ra,72(sp)
    80003cfe:	e0a2                	sd	s0,64(sp)
    80003d00:	fc26                	sd	s1,56(sp)
    80003d02:	f84a                	sd	s2,48(sp)
    80003d04:	f44e                	sd	s3,40(sp)
    80003d06:	0880                	addi	s0,sp,80
    80003d08:	84aa                	mv	s1,a0
    80003d0a:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    80003d0c:	ffffd097          	auipc	ra,0xffffd
    80003d10:	21a080e7          	jalr	538(ra) # 80000f26 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80003d14:	409c                	lw	a5,0(s1)
    80003d16:	37f9                	addiw	a5,a5,-2
    80003d18:	4705                	li	a4,1
    80003d1a:	04f76763          	bltu	a4,a5,80003d68 <filestat+0x6e>
    80003d1e:	892a                	mv	s2,a0
    ilock(f->ip);
    80003d20:	6c88                	ld	a0,24(s1)
    80003d22:	fffff097          	auipc	ra,0xfffff
    80003d26:	eea080e7          	jalr	-278(ra) # 80002c0c <ilock>
    stati(f->ip, &st);
    80003d2a:	fb840593          	addi	a1,s0,-72
    80003d2e:	6c88                	ld	a0,24(s1)
    80003d30:	fffff097          	auipc	ra,0xfffff
    80003d34:	166080e7          	jalr	358(ra) # 80002e96 <stati>
    iunlock(f->ip);
    80003d38:	6c88                	ld	a0,24(s1)
    80003d3a:	fffff097          	auipc	ra,0xfffff
    80003d3e:	f94080e7          	jalr	-108(ra) # 80002cce <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80003d42:	46e1                	li	a3,24
    80003d44:	fb840613          	addi	a2,s0,-72
    80003d48:	85ce                	mv	a1,s3
    80003d4a:	05093503          	ld	a0,80(s2)
    80003d4e:	ffffd097          	auipc	ra,0xffffd
    80003d52:	db4080e7          	jalr	-588(ra) # 80000b02 <copyout>
    80003d56:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    80003d5a:	60a6                	ld	ra,72(sp)
    80003d5c:	6406                	ld	s0,64(sp)
    80003d5e:	74e2                	ld	s1,56(sp)
    80003d60:	7942                	ld	s2,48(sp)
    80003d62:	79a2                	ld	s3,40(sp)
    80003d64:	6161                	addi	sp,sp,80
    80003d66:	8082                	ret
  return -1;
    80003d68:	557d                	li	a0,-1
    80003d6a:	bfc5                	j	80003d5a <filestat+0x60>

0000000080003d6c <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80003d6c:	7179                	addi	sp,sp,-48
    80003d6e:	f406                	sd	ra,40(sp)
    80003d70:	f022                	sd	s0,32(sp)
    80003d72:	ec26                	sd	s1,24(sp)
    80003d74:	e84a                	sd	s2,16(sp)
    80003d76:	e44e                	sd	s3,8(sp)
    80003d78:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80003d7a:	00854783          	lbu	a5,8(a0)
    80003d7e:	c3d5                	beqz	a5,80003e22 <fileread+0xb6>
    80003d80:	84aa                	mv	s1,a0
    80003d82:	89ae                	mv	s3,a1
    80003d84:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    80003d86:	411c                	lw	a5,0(a0)
    80003d88:	4705                	li	a4,1
    80003d8a:	04e78963          	beq	a5,a4,80003ddc <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003d8e:	470d                	li	a4,3
    80003d90:	04e78d63          	beq	a5,a4,80003dea <fileread+0x7e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    80003d94:	4709                	li	a4,2
    80003d96:	06e79e63          	bne	a5,a4,80003e12 <fileread+0xa6>
    ilock(f->ip);
    80003d9a:	6d08                	ld	a0,24(a0)
    80003d9c:	fffff097          	auipc	ra,0xfffff
    80003da0:	e70080e7          	jalr	-400(ra) # 80002c0c <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80003da4:	874a                	mv	a4,s2
    80003da6:	5094                	lw	a3,32(s1)
    80003da8:	864e                	mv	a2,s3
    80003daa:	4585                	li	a1,1
    80003dac:	6c88                	ld	a0,24(s1)
    80003dae:	fffff097          	auipc	ra,0xfffff
    80003db2:	112080e7          	jalr	274(ra) # 80002ec0 <readi>
    80003db6:	892a                	mv	s2,a0
    80003db8:	00a05563          	blez	a0,80003dc2 <fileread+0x56>
      f->off += r;
    80003dbc:	509c                	lw	a5,32(s1)
    80003dbe:	9fa9                	addw	a5,a5,a0
    80003dc0:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80003dc2:	6c88                	ld	a0,24(s1)
    80003dc4:	fffff097          	auipc	ra,0xfffff
    80003dc8:	f0a080e7          	jalr	-246(ra) # 80002cce <iunlock>
  } else {
    panic("fileread");
  }

  return r;
}
    80003dcc:	854a                	mv	a0,s2
    80003dce:	70a2                	ld	ra,40(sp)
    80003dd0:	7402                	ld	s0,32(sp)
    80003dd2:	64e2                	ld	s1,24(sp)
    80003dd4:	6942                	ld	s2,16(sp)
    80003dd6:	69a2                	ld	s3,8(sp)
    80003dd8:	6145                	addi	sp,sp,48
    80003dda:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80003ddc:	6908                	ld	a0,16(a0)
    80003dde:	00000097          	auipc	ra,0x0
    80003de2:	3c8080e7          	jalr	968(ra) # 800041a6 <piperead>
    80003de6:	892a                	mv	s2,a0
    80003de8:	b7d5                	j	80003dcc <fileread+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80003dea:	02451783          	lh	a5,36(a0)
    80003dee:	03079693          	slli	a3,a5,0x30
    80003df2:	92c1                	srli	a3,a3,0x30
    80003df4:	4725                	li	a4,9
    80003df6:	02d76863          	bltu	a4,a3,80003e26 <fileread+0xba>
    80003dfa:	0792                	slli	a5,a5,0x4
    80003dfc:	00015717          	auipc	a4,0x15
    80003e00:	2cc70713          	addi	a4,a4,716 # 800190c8 <devsw>
    80003e04:	97ba                	add	a5,a5,a4
    80003e06:	639c                	ld	a5,0(a5)
    80003e08:	c38d                	beqz	a5,80003e2a <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    80003e0a:	4505                	li	a0,1
    80003e0c:	9782                	jalr	a5
    80003e0e:	892a                	mv	s2,a0
    80003e10:	bf75                	j	80003dcc <fileread+0x60>
    panic("fileread");
    80003e12:	00005517          	auipc	a0,0x5
    80003e16:	8ee50513          	addi	a0,a0,-1810 # 80008700 <syscalls+0x348>
    80003e1a:	00002097          	auipc	ra,0x2
    80003e1e:	12e080e7          	jalr	302(ra) # 80005f48 <panic>
    return -1;
    80003e22:	597d                	li	s2,-1
    80003e24:	b765                	j	80003dcc <fileread+0x60>
      return -1;
    80003e26:	597d                	li	s2,-1
    80003e28:	b755                	j	80003dcc <fileread+0x60>
    80003e2a:	597d                	li	s2,-1
    80003e2c:	b745                	j	80003dcc <fileread+0x60>

0000000080003e2e <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    80003e2e:	715d                	addi	sp,sp,-80
    80003e30:	e486                	sd	ra,72(sp)
    80003e32:	e0a2                	sd	s0,64(sp)
    80003e34:	fc26                	sd	s1,56(sp)
    80003e36:	f84a                	sd	s2,48(sp)
    80003e38:	f44e                	sd	s3,40(sp)
    80003e3a:	f052                	sd	s4,32(sp)
    80003e3c:	ec56                	sd	s5,24(sp)
    80003e3e:	e85a                	sd	s6,16(sp)
    80003e40:	e45e                	sd	s7,8(sp)
    80003e42:	e062                	sd	s8,0(sp)
    80003e44:	0880                	addi	s0,sp,80
  int r, ret = 0;

  if(f->writable == 0)
    80003e46:	00954783          	lbu	a5,9(a0)
    80003e4a:	10078663          	beqz	a5,80003f56 <filewrite+0x128>
    80003e4e:	892a                	mv	s2,a0
    80003e50:	8aae                	mv	s5,a1
    80003e52:	8a32                	mv	s4,a2
    return -1;

  if(f->type == FD_PIPE){
    80003e54:	411c                	lw	a5,0(a0)
    80003e56:	4705                	li	a4,1
    80003e58:	02e78263          	beq	a5,a4,80003e7c <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003e5c:	470d                	li	a4,3
    80003e5e:	02e78663          	beq	a5,a4,80003e8a <filewrite+0x5c>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    80003e62:	4709                	li	a4,2
    80003e64:	0ee79163          	bne	a5,a4,80003f46 <filewrite+0x118>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80003e68:	0ac05d63          	blez	a2,80003f22 <filewrite+0xf4>
    int i = 0;
    80003e6c:	4981                	li	s3,0
    80003e6e:	6b05                	lui	s6,0x1
    80003e70:	c00b0b13          	addi	s6,s6,-1024 # c00 <_entry-0x7ffff400>
    80003e74:	6b85                	lui	s7,0x1
    80003e76:	c00b8b9b          	addiw	s7,s7,-1024
    80003e7a:	a861                	j	80003f12 <filewrite+0xe4>
    ret = pipewrite(f->pipe, addr, n);
    80003e7c:	6908                	ld	a0,16(a0)
    80003e7e:	00000097          	auipc	ra,0x0
    80003e82:	22e080e7          	jalr	558(ra) # 800040ac <pipewrite>
    80003e86:	8a2a                	mv	s4,a0
    80003e88:	a045                	j	80003f28 <filewrite+0xfa>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80003e8a:	02451783          	lh	a5,36(a0)
    80003e8e:	03079693          	slli	a3,a5,0x30
    80003e92:	92c1                	srli	a3,a3,0x30
    80003e94:	4725                	li	a4,9
    80003e96:	0cd76263          	bltu	a4,a3,80003f5a <filewrite+0x12c>
    80003e9a:	0792                	slli	a5,a5,0x4
    80003e9c:	00015717          	auipc	a4,0x15
    80003ea0:	22c70713          	addi	a4,a4,556 # 800190c8 <devsw>
    80003ea4:	97ba                	add	a5,a5,a4
    80003ea6:	679c                	ld	a5,8(a5)
    80003ea8:	cbdd                	beqz	a5,80003f5e <filewrite+0x130>
    ret = devsw[f->major].write(1, addr, n);
    80003eaa:	4505                	li	a0,1
    80003eac:	9782                	jalr	a5
    80003eae:	8a2a                	mv	s4,a0
    80003eb0:	a8a5                	j	80003f28 <filewrite+0xfa>
    80003eb2:	00048c1b          	sext.w	s8,s1
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
    80003eb6:	00000097          	auipc	ra,0x0
    80003eba:	8b0080e7          	jalr	-1872(ra) # 80003766 <begin_op>
      ilock(f->ip);
    80003ebe:	01893503          	ld	a0,24(s2)
    80003ec2:	fffff097          	auipc	ra,0xfffff
    80003ec6:	d4a080e7          	jalr	-694(ra) # 80002c0c <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80003eca:	8762                	mv	a4,s8
    80003ecc:	02092683          	lw	a3,32(s2)
    80003ed0:	01598633          	add	a2,s3,s5
    80003ed4:	4585                	li	a1,1
    80003ed6:	01893503          	ld	a0,24(s2)
    80003eda:	fffff097          	auipc	ra,0xfffff
    80003ede:	0de080e7          	jalr	222(ra) # 80002fb8 <writei>
    80003ee2:	84aa                	mv	s1,a0
    80003ee4:	00a05763          	blez	a0,80003ef2 <filewrite+0xc4>
        f->off += r;
    80003ee8:	02092783          	lw	a5,32(s2)
    80003eec:	9fa9                	addw	a5,a5,a0
    80003eee:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80003ef2:	01893503          	ld	a0,24(s2)
    80003ef6:	fffff097          	auipc	ra,0xfffff
    80003efa:	dd8080e7          	jalr	-552(ra) # 80002cce <iunlock>
      end_op();
    80003efe:	00000097          	auipc	ra,0x0
    80003f02:	8e8080e7          	jalr	-1816(ra) # 800037e6 <end_op>

      if(r != n1){
    80003f06:	009c1f63          	bne	s8,s1,80003f24 <filewrite+0xf6>
        // error from writei
        break;
      }
      i += r;
    80003f0a:	013489bb          	addw	s3,s1,s3
    while(i < n){
    80003f0e:	0149db63          	bge	s3,s4,80003f24 <filewrite+0xf6>
      int n1 = n - i;
    80003f12:	413a07bb          	subw	a5,s4,s3
      if(n1 > max)
    80003f16:	84be                	mv	s1,a5
    80003f18:	2781                	sext.w	a5,a5
    80003f1a:	f8fb5ce3          	bge	s6,a5,80003eb2 <filewrite+0x84>
    80003f1e:	84de                	mv	s1,s7
    80003f20:	bf49                	j	80003eb2 <filewrite+0x84>
    int i = 0;
    80003f22:	4981                	li	s3,0
    }
    ret = (i == n ? n : -1);
    80003f24:	013a1f63          	bne	s4,s3,80003f42 <filewrite+0x114>
  } else {
    panic("filewrite");
  }

  return ret;
}
    80003f28:	8552                	mv	a0,s4
    80003f2a:	60a6                	ld	ra,72(sp)
    80003f2c:	6406                	ld	s0,64(sp)
    80003f2e:	74e2                	ld	s1,56(sp)
    80003f30:	7942                	ld	s2,48(sp)
    80003f32:	79a2                	ld	s3,40(sp)
    80003f34:	7a02                	ld	s4,32(sp)
    80003f36:	6ae2                	ld	s5,24(sp)
    80003f38:	6b42                	ld	s6,16(sp)
    80003f3a:	6ba2                	ld	s7,8(sp)
    80003f3c:	6c02                	ld	s8,0(sp)
    80003f3e:	6161                	addi	sp,sp,80
    80003f40:	8082                	ret
    ret = (i == n ? n : -1);
    80003f42:	5a7d                	li	s4,-1
    80003f44:	b7d5                	j	80003f28 <filewrite+0xfa>
    panic("filewrite");
    80003f46:	00004517          	auipc	a0,0x4
    80003f4a:	7ca50513          	addi	a0,a0,1994 # 80008710 <syscalls+0x358>
    80003f4e:	00002097          	auipc	ra,0x2
    80003f52:	ffa080e7          	jalr	-6(ra) # 80005f48 <panic>
    return -1;
    80003f56:	5a7d                	li	s4,-1
    80003f58:	bfc1                	j	80003f28 <filewrite+0xfa>
      return -1;
    80003f5a:	5a7d                	li	s4,-1
    80003f5c:	b7f1                	j	80003f28 <filewrite+0xfa>
    80003f5e:	5a7d                	li	s4,-1
    80003f60:	b7e1                	j	80003f28 <filewrite+0xfa>

0000000080003f62 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80003f62:	7179                	addi	sp,sp,-48
    80003f64:	f406                	sd	ra,40(sp)
    80003f66:	f022                	sd	s0,32(sp)
    80003f68:	ec26                	sd	s1,24(sp)
    80003f6a:	e84a                	sd	s2,16(sp)
    80003f6c:	e44e                	sd	s3,8(sp)
    80003f6e:	e052                	sd	s4,0(sp)
    80003f70:	1800                	addi	s0,sp,48
    80003f72:	84aa                	mv	s1,a0
    80003f74:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80003f76:	0005b023          	sd	zero,0(a1)
    80003f7a:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80003f7e:	00000097          	auipc	ra,0x0
    80003f82:	bf8080e7          	jalr	-1032(ra) # 80003b76 <filealloc>
    80003f86:	e088                	sd	a0,0(s1)
    80003f88:	c551                	beqz	a0,80004014 <pipealloc+0xb2>
    80003f8a:	00000097          	auipc	ra,0x0
    80003f8e:	bec080e7          	jalr	-1044(ra) # 80003b76 <filealloc>
    80003f92:	00aa3023          	sd	a0,0(s4)
    80003f96:	c92d                	beqz	a0,80004008 <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80003f98:	ffffc097          	auipc	ra,0xffffc
    80003f9c:	180080e7          	jalr	384(ra) # 80000118 <kalloc>
    80003fa0:	892a                	mv	s2,a0
    80003fa2:	c125                	beqz	a0,80004002 <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    80003fa4:	4985                	li	s3,1
    80003fa6:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80003faa:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    80003fae:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80003fb2:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80003fb6:	00004597          	auipc	a1,0x4
    80003fba:	76a58593          	addi	a1,a1,1898 # 80008720 <syscalls+0x368>
    80003fbe:	00002097          	auipc	ra,0x2
    80003fc2:	444080e7          	jalr	1092(ra) # 80006402 <initlock>
  (*f0)->type = FD_PIPE;
    80003fc6:	609c                	ld	a5,0(s1)
    80003fc8:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80003fcc:	609c                	ld	a5,0(s1)
    80003fce:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80003fd2:	609c                	ld	a5,0(s1)
    80003fd4:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80003fd8:	609c                	ld	a5,0(s1)
    80003fda:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80003fde:	000a3783          	ld	a5,0(s4)
    80003fe2:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80003fe6:	000a3783          	ld	a5,0(s4)
    80003fea:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80003fee:	000a3783          	ld	a5,0(s4)
    80003ff2:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80003ff6:	000a3783          	ld	a5,0(s4)
    80003ffa:	0127b823          	sd	s2,16(a5)
  return 0;
    80003ffe:	4501                	li	a0,0
    80004000:	a025                	j	80004028 <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80004002:	6088                	ld	a0,0(s1)
    80004004:	e501                	bnez	a0,8000400c <pipealloc+0xaa>
    80004006:	a039                	j	80004014 <pipealloc+0xb2>
    80004008:	6088                	ld	a0,0(s1)
    8000400a:	c51d                	beqz	a0,80004038 <pipealloc+0xd6>
    fileclose(*f0);
    8000400c:	00000097          	auipc	ra,0x0
    80004010:	c26080e7          	jalr	-986(ra) # 80003c32 <fileclose>
  if(*f1)
    80004014:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80004018:	557d                	li	a0,-1
  if(*f1)
    8000401a:	c799                	beqz	a5,80004028 <pipealloc+0xc6>
    fileclose(*f1);
    8000401c:	853e                	mv	a0,a5
    8000401e:	00000097          	auipc	ra,0x0
    80004022:	c14080e7          	jalr	-1004(ra) # 80003c32 <fileclose>
  return -1;
    80004026:	557d                	li	a0,-1
}
    80004028:	70a2                	ld	ra,40(sp)
    8000402a:	7402                	ld	s0,32(sp)
    8000402c:	64e2                	ld	s1,24(sp)
    8000402e:	6942                	ld	s2,16(sp)
    80004030:	69a2                	ld	s3,8(sp)
    80004032:	6a02                	ld	s4,0(sp)
    80004034:	6145                	addi	sp,sp,48
    80004036:	8082                	ret
  return -1;
    80004038:	557d                	li	a0,-1
    8000403a:	b7fd                	j	80004028 <pipealloc+0xc6>

000000008000403c <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    8000403c:	1101                	addi	sp,sp,-32
    8000403e:	ec06                	sd	ra,24(sp)
    80004040:	e822                	sd	s0,16(sp)
    80004042:	e426                	sd	s1,8(sp)
    80004044:	e04a                	sd	s2,0(sp)
    80004046:	1000                	addi	s0,sp,32
    80004048:	84aa                	mv	s1,a0
    8000404a:	892e                	mv	s2,a1
  acquire(&pi->lock);
    8000404c:	00002097          	auipc	ra,0x2
    80004050:	446080e7          	jalr	1094(ra) # 80006492 <acquire>
  if(writable){
    80004054:	02090d63          	beqz	s2,8000408e <pipeclose+0x52>
    pi->writeopen = 0;
    80004058:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    8000405c:	21848513          	addi	a0,s1,536
    80004060:	ffffd097          	auipc	ra,0xffffd
    80004064:	70e080e7          	jalr	1806(ra) # 8000176e <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80004068:	2204b783          	ld	a5,544(s1)
    8000406c:	eb95                	bnez	a5,800040a0 <pipeclose+0x64>
    release(&pi->lock);
    8000406e:	8526                	mv	a0,s1
    80004070:	00002097          	auipc	ra,0x2
    80004074:	4d6080e7          	jalr	1238(ra) # 80006546 <release>
    kfree((char*)pi);
    80004078:	8526                	mv	a0,s1
    8000407a:	ffffc097          	auipc	ra,0xffffc
    8000407e:	fa2080e7          	jalr	-94(ra) # 8000001c <kfree>
  } else
    release(&pi->lock);
}
    80004082:	60e2                	ld	ra,24(sp)
    80004084:	6442                	ld	s0,16(sp)
    80004086:	64a2                	ld	s1,8(sp)
    80004088:	6902                	ld	s2,0(sp)
    8000408a:	6105                	addi	sp,sp,32
    8000408c:	8082                	ret
    pi->readopen = 0;
    8000408e:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80004092:	21c48513          	addi	a0,s1,540
    80004096:	ffffd097          	auipc	ra,0xffffd
    8000409a:	6d8080e7          	jalr	1752(ra) # 8000176e <wakeup>
    8000409e:	b7e9                	j	80004068 <pipeclose+0x2c>
    release(&pi->lock);
    800040a0:	8526                	mv	a0,s1
    800040a2:	00002097          	auipc	ra,0x2
    800040a6:	4a4080e7          	jalr	1188(ra) # 80006546 <release>
}
    800040aa:	bfe1                	j	80004082 <pipeclose+0x46>

00000000800040ac <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    800040ac:	7159                	addi	sp,sp,-112
    800040ae:	f486                	sd	ra,104(sp)
    800040b0:	f0a2                	sd	s0,96(sp)
    800040b2:	eca6                	sd	s1,88(sp)
    800040b4:	e8ca                	sd	s2,80(sp)
    800040b6:	e4ce                	sd	s3,72(sp)
    800040b8:	e0d2                	sd	s4,64(sp)
    800040ba:	fc56                	sd	s5,56(sp)
    800040bc:	f85a                	sd	s6,48(sp)
    800040be:	f45e                	sd	s7,40(sp)
    800040c0:	f062                	sd	s8,32(sp)
    800040c2:	ec66                	sd	s9,24(sp)
    800040c4:	1880                	addi	s0,sp,112
    800040c6:	84aa                	mv	s1,a0
    800040c8:	8aae                	mv	s5,a1
    800040ca:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    800040cc:	ffffd097          	auipc	ra,0xffffd
    800040d0:	e5a080e7          	jalr	-422(ra) # 80000f26 <myproc>
    800040d4:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    800040d6:	8526                	mv	a0,s1
    800040d8:	00002097          	auipc	ra,0x2
    800040dc:	3ba080e7          	jalr	954(ra) # 80006492 <acquire>
  while(i < n){
    800040e0:	0d405163          	blez	s4,800041a2 <pipewrite+0xf6>
    800040e4:	8ba6                	mv	s7,s1
  int i = 0;
    800040e6:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    800040e8:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    800040ea:	21848c93          	addi	s9,s1,536
      sleep(&pi->nwrite, &pi->lock);
    800040ee:	21c48c13          	addi	s8,s1,540
    800040f2:	a08d                	j	80004154 <pipewrite+0xa8>
      release(&pi->lock);
    800040f4:	8526                	mv	a0,s1
    800040f6:	00002097          	auipc	ra,0x2
    800040fa:	450080e7          	jalr	1104(ra) # 80006546 <release>
      return -1;
    800040fe:	597d                	li	s2,-1
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80004100:	854a                	mv	a0,s2
    80004102:	70a6                	ld	ra,104(sp)
    80004104:	7406                	ld	s0,96(sp)
    80004106:	64e6                	ld	s1,88(sp)
    80004108:	6946                	ld	s2,80(sp)
    8000410a:	69a6                	ld	s3,72(sp)
    8000410c:	6a06                	ld	s4,64(sp)
    8000410e:	7ae2                	ld	s5,56(sp)
    80004110:	7b42                	ld	s6,48(sp)
    80004112:	7ba2                	ld	s7,40(sp)
    80004114:	7c02                	ld	s8,32(sp)
    80004116:	6ce2                	ld	s9,24(sp)
    80004118:	6165                	addi	sp,sp,112
    8000411a:	8082                	ret
      wakeup(&pi->nread);
    8000411c:	8566                	mv	a0,s9
    8000411e:	ffffd097          	auipc	ra,0xffffd
    80004122:	650080e7          	jalr	1616(ra) # 8000176e <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80004126:	85de                	mv	a1,s7
    80004128:	8562                	mv	a0,s8
    8000412a:	ffffd097          	auipc	ra,0xffffd
    8000412e:	4b8080e7          	jalr	1208(ra) # 800015e2 <sleep>
    80004132:	a839                	j	80004150 <pipewrite+0xa4>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80004134:	21c4a783          	lw	a5,540(s1)
    80004138:	0017871b          	addiw	a4,a5,1
    8000413c:	20e4ae23          	sw	a4,540(s1)
    80004140:	1ff7f793          	andi	a5,a5,511
    80004144:	97a6                	add	a5,a5,s1
    80004146:	f9f44703          	lbu	a4,-97(s0)
    8000414a:	00e78c23          	sb	a4,24(a5)
      i++;
    8000414e:	2905                	addiw	s2,s2,1
  while(i < n){
    80004150:	03495d63          	bge	s2,s4,8000418a <pipewrite+0xde>
    if(pi->readopen == 0 || pr->killed){
    80004154:	2204a783          	lw	a5,544(s1)
    80004158:	dfd1                	beqz	a5,800040f4 <pipewrite+0x48>
    8000415a:	0289a783          	lw	a5,40(s3)
    8000415e:	fbd9                	bnez	a5,800040f4 <pipewrite+0x48>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80004160:	2184a783          	lw	a5,536(s1)
    80004164:	21c4a703          	lw	a4,540(s1)
    80004168:	2007879b          	addiw	a5,a5,512
    8000416c:	faf708e3          	beq	a4,a5,8000411c <pipewrite+0x70>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80004170:	4685                	li	a3,1
    80004172:	01590633          	add	a2,s2,s5
    80004176:	f9f40593          	addi	a1,s0,-97
    8000417a:	0509b503          	ld	a0,80(s3)
    8000417e:	ffffd097          	auipc	ra,0xffffd
    80004182:	a10080e7          	jalr	-1520(ra) # 80000b8e <copyin>
    80004186:	fb6517e3          	bne	a0,s6,80004134 <pipewrite+0x88>
  wakeup(&pi->nread);
    8000418a:	21848513          	addi	a0,s1,536
    8000418e:	ffffd097          	auipc	ra,0xffffd
    80004192:	5e0080e7          	jalr	1504(ra) # 8000176e <wakeup>
  release(&pi->lock);
    80004196:	8526                	mv	a0,s1
    80004198:	00002097          	auipc	ra,0x2
    8000419c:	3ae080e7          	jalr	942(ra) # 80006546 <release>
  return i;
    800041a0:	b785                	j	80004100 <pipewrite+0x54>
  int i = 0;
    800041a2:	4901                	li	s2,0
    800041a4:	b7dd                	j	8000418a <pipewrite+0xde>

00000000800041a6 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    800041a6:	715d                	addi	sp,sp,-80
    800041a8:	e486                	sd	ra,72(sp)
    800041aa:	e0a2                	sd	s0,64(sp)
    800041ac:	fc26                	sd	s1,56(sp)
    800041ae:	f84a                	sd	s2,48(sp)
    800041b0:	f44e                	sd	s3,40(sp)
    800041b2:	f052                	sd	s4,32(sp)
    800041b4:	ec56                	sd	s5,24(sp)
    800041b6:	e85a                	sd	s6,16(sp)
    800041b8:	0880                	addi	s0,sp,80
    800041ba:	84aa                	mv	s1,a0
    800041bc:	892e                	mv	s2,a1
    800041be:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    800041c0:	ffffd097          	auipc	ra,0xffffd
    800041c4:	d66080e7          	jalr	-666(ra) # 80000f26 <myproc>
    800041c8:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    800041ca:	8b26                	mv	s6,s1
    800041cc:	8526                	mv	a0,s1
    800041ce:	00002097          	auipc	ra,0x2
    800041d2:	2c4080e7          	jalr	708(ra) # 80006492 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800041d6:	2184a703          	lw	a4,536(s1)
    800041da:	21c4a783          	lw	a5,540(s1)
    if(pr->killed){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    800041de:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800041e2:	02f71463          	bne	a4,a5,8000420a <piperead+0x64>
    800041e6:	2244a783          	lw	a5,548(s1)
    800041ea:	c385                	beqz	a5,8000420a <piperead+0x64>
    if(pr->killed){
    800041ec:	028a2783          	lw	a5,40(s4)
    800041f0:	ebc1                	bnez	a5,80004280 <piperead+0xda>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    800041f2:	85da                	mv	a1,s6
    800041f4:	854e                	mv	a0,s3
    800041f6:	ffffd097          	auipc	ra,0xffffd
    800041fa:	3ec080e7          	jalr	1004(ra) # 800015e2 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    800041fe:	2184a703          	lw	a4,536(s1)
    80004202:	21c4a783          	lw	a5,540(s1)
    80004206:	fef700e3          	beq	a4,a5,800041e6 <piperead+0x40>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8000420a:	09505263          	blez	s5,8000428e <piperead+0xe8>
    8000420e:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004210:	5b7d                	li	s6,-1
    if(pi->nread == pi->nwrite)
    80004212:	2184a783          	lw	a5,536(s1)
    80004216:	21c4a703          	lw	a4,540(s1)
    8000421a:	02f70d63          	beq	a4,a5,80004254 <piperead+0xae>
    ch = pi->data[pi->nread++ % PIPESIZE];
    8000421e:	0017871b          	addiw	a4,a5,1
    80004222:	20e4ac23          	sw	a4,536(s1)
    80004226:	1ff7f793          	andi	a5,a5,511
    8000422a:	97a6                	add	a5,a5,s1
    8000422c:	0187c783          	lbu	a5,24(a5)
    80004230:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004234:	4685                	li	a3,1
    80004236:	fbf40613          	addi	a2,s0,-65
    8000423a:	85ca                	mv	a1,s2
    8000423c:	050a3503          	ld	a0,80(s4)
    80004240:	ffffd097          	auipc	ra,0xffffd
    80004244:	8c2080e7          	jalr	-1854(ra) # 80000b02 <copyout>
    80004248:	01650663          	beq	a0,s6,80004254 <piperead+0xae>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8000424c:	2985                	addiw	s3,s3,1
    8000424e:	0905                	addi	s2,s2,1
    80004250:	fd3a91e3          	bne	s5,s3,80004212 <piperead+0x6c>
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80004254:	21c48513          	addi	a0,s1,540
    80004258:	ffffd097          	auipc	ra,0xffffd
    8000425c:	516080e7          	jalr	1302(ra) # 8000176e <wakeup>
  release(&pi->lock);
    80004260:	8526                	mv	a0,s1
    80004262:	00002097          	auipc	ra,0x2
    80004266:	2e4080e7          	jalr	740(ra) # 80006546 <release>
  return i;
}
    8000426a:	854e                	mv	a0,s3
    8000426c:	60a6                	ld	ra,72(sp)
    8000426e:	6406                	ld	s0,64(sp)
    80004270:	74e2                	ld	s1,56(sp)
    80004272:	7942                	ld	s2,48(sp)
    80004274:	79a2                	ld	s3,40(sp)
    80004276:	7a02                	ld	s4,32(sp)
    80004278:	6ae2                	ld	s5,24(sp)
    8000427a:	6b42                	ld	s6,16(sp)
    8000427c:	6161                	addi	sp,sp,80
    8000427e:	8082                	ret
      release(&pi->lock);
    80004280:	8526                	mv	a0,s1
    80004282:	00002097          	auipc	ra,0x2
    80004286:	2c4080e7          	jalr	708(ra) # 80006546 <release>
      return -1;
    8000428a:	59fd                	li	s3,-1
    8000428c:	bff9                	j	8000426a <piperead+0xc4>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8000428e:	4981                	li	s3,0
    80004290:	b7d1                	j	80004254 <piperead+0xae>

0000000080004292 <exec>:

static int loadseg(pde_t *pgdir, uint64 addr, struct inode *ip, uint offset, uint sz);

int
exec(char *path, char **argv)
{
    80004292:	df010113          	addi	sp,sp,-528
    80004296:	20113423          	sd	ra,520(sp)
    8000429a:	20813023          	sd	s0,512(sp)
    8000429e:	ffa6                	sd	s1,504(sp)
    800042a0:	fbca                	sd	s2,496(sp)
    800042a2:	f7ce                	sd	s3,488(sp)
    800042a4:	f3d2                	sd	s4,480(sp)
    800042a6:	efd6                	sd	s5,472(sp)
    800042a8:	ebda                	sd	s6,464(sp)
    800042aa:	e7de                	sd	s7,456(sp)
    800042ac:	e3e2                	sd	s8,448(sp)
    800042ae:	ff66                	sd	s9,440(sp)
    800042b0:	fb6a                	sd	s10,432(sp)
    800042b2:	f76e                	sd	s11,424(sp)
    800042b4:	0c00                	addi	s0,sp,528
    800042b6:	84aa                	mv	s1,a0
    800042b8:	dea43c23          	sd	a0,-520(s0)
    800042bc:	e0b43023          	sd	a1,-512(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    800042c0:	ffffd097          	auipc	ra,0xffffd
    800042c4:	c66080e7          	jalr	-922(ra) # 80000f26 <myproc>
    800042c8:	892a                	mv	s2,a0

  begin_op();
    800042ca:	fffff097          	auipc	ra,0xfffff
    800042ce:	49c080e7          	jalr	1180(ra) # 80003766 <begin_op>

  if((ip = namei(path)) == 0){
    800042d2:	8526                	mv	a0,s1
    800042d4:	fffff097          	auipc	ra,0xfffff
    800042d8:	0e4080e7          	jalr	228(ra) # 800033b8 <namei>
    800042dc:	c92d                	beqz	a0,8000434e <exec+0xbc>
    800042de:	84aa                	mv	s1,a0
    end_op();
    return -1;
  }
  ilock(ip);
    800042e0:	fffff097          	auipc	ra,0xfffff
    800042e4:	92c080e7          	jalr	-1748(ra) # 80002c0c <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    800042e8:	04000713          	li	a4,64
    800042ec:	4681                	li	a3,0
    800042ee:	e5040613          	addi	a2,s0,-432
    800042f2:	4581                	li	a1,0
    800042f4:	8526                	mv	a0,s1
    800042f6:	fffff097          	auipc	ra,0xfffff
    800042fa:	bca080e7          	jalr	-1078(ra) # 80002ec0 <readi>
    800042fe:	04000793          	li	a5,64
    80004302:	00f51a63          	bne	a0,a5,80004316 <exec+0x84>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    80004306:	e5042703          	lw	a4,-432(s0)
    8000430a:	464c47b7          	lui	a5,0x464c4
    8000430e:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80004312:	04f70463          	beq	a4,a5,8000435a <exec+0xc8>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    80004316:	8526                	mv	a0,s1
    80004318:	fffff097          	auipc	ra,0xfffff
    8000431c:	b56080e7          	jalr	-1194(ra) # 80002e6e <iunlockput>
    end_op();
    80004320:	fffff097          	auipc	ra,0xfffff
    80004324:	4c6080e7          	jalr	1222(ra) # 800037e6 <end_op>
  }
  return -1;
    80004328:	557d                	li	a0,-1
}
    8000432a:	20813083          	ld	ra,520(sp)
    8000432e:	20013403          	ld	s0,512(sp)
    80004332:	74fe                	ld	s1,504(sp)
    80004334:	795e                	ld	s2,496(sp)
    80004336:	79be                	ld	s3,488(sp)
    80004338:	7a1e                	ld	s4,480(sp)
    8000433a:	6afe                	ld	s5,472(sp)
    8000433c:	6b5e                	ld	s6,464(sp)
    8000433e:	6bbe                	ld	s7,456(sp)
    80004340:	6c1e                	ld	s8,448(sp)
    80004342:	7cfa                	ld	s9,440(sp)
    80004344:	7d5a                	ld	s10,432(sp)
    80004346:	7dba                	ld	s11,424(sp)
    80004348:	21010113          	addi	sp,sp,528
    8000434c:	8082                	ret
    end_op();
    8000434e:	fffff097          	auipc	ra,0xfffff
    80004352:	498080e7          	jalr	1176(ra) # 800037e6 <end_op>
    return -1;
    80004356:	557d                	li	a0,-1
    80004358:	bfc9                	j	8000432a <exec+0x98>
  if((pagetable = proc_pagetable(p)) == 0)
    8000435a:	854a                	mv	a0,s2
    8000435c:	ffffd097          	auipc	ra,0xffffd
    80004360:	c8e080e7          	jalr	-882(ra) # 80000fea <proc_pagetable>
    80004364:	8baa                	mv	s7,a0
    80004366:	d945                	beqz	a0,80004316 <exec+0x84>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004368:	e7042983          	lw	s3,-400(s0)
    8000436c:	e8845783          	lhu	a5,-376(s0)
    80004370:	c7ad                	beqz	a5,800043da <exec+0x148>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004372:	4901                	li	s2,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004374:	4b01                	li	s6,0
    if((ph.vaddr % PGSIZE) != 0)
    80004376:	6c85                	lui	s9,0x1
    80004378:	fffc8793          	addi	a5,s9,-1 # fff <_entry-0x7ffff001>
    8000437c:	def43823          	sd	a5,-528(s0)
    80004380:	a42d                	j	800045aa <exec+0x318>
  uint64 pa;

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    80004382:	00004517          	auipc	a0,0x4
    80004386:	3a650513          	addi	a0,a0,934 # 80008728 <syscalls+0x370>
    8000438a:	00002097          	auipc	ra,0x2
    8000438e:	bbe080e7          	jalr	-1090(ra) # 80005f48 <panic>
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80004392:	8756                	mv	a4,s5
    80004394:	012d86bb          	addw	a3,s11,s2
    80004398:	4581                	li	a1,0
    8000439a:	8526                	mv	a0,s1
    8000439c:	fffff097          	auipc	ra,0xfffff
    800043a0:	b24080e7          	jalr	-1244(ra) # 80002ec0 <readi>
    800043a4:	2501                	sext.w	a0,a0
    800043a6:	1aaa9963          	bne	s5,a0,80004558 <exec+0x2c6>
  for(i = 0; i < sz; i += PGSIZE){
    800043aa:	6785                	lui	a5,0x1
    800043ac:	0127893b          	addw	s2,a5,s2
    800043b0:	77fd                	lui	a5,0xfffff
    800043b2:	01478a3b          	addw	s4,a5,s4
    800043b6:	1f897163          	bgeu	s2,s8,80004598 <exec+0x306>
    pa = walkaddr(pagetable, va + i);
    800043ba:	02091593          	slli	a1,s2,0x20
    800043be:	9181                	srli	a1,a1,0x20
    800043c0:	95ea                	add	a1,a1,s10
    800043c2:	855e                	mv	a0,s7
    800043c4:	ffffc097          	auipc	ra,0xffffc
    800043c8:	142080e7          	jalr	322(ra) # 80000506 <walkaddr>
    800043cc:	862a                	mv	a2,a0
    if(pa == 0)
    800043ce:	d955                	beqz	a0,80004382 <exec+0xf0>
      n = PGSIZE;
    800043d0:	8ae6                	mv	s5,s9
    if(sz - i < PGSIZE)
    800043d2:	fd9a70e3          	bgeu	s4,s9,80004392 <exec+0x100>
      n = sz - i;
    800043d6:	8ad2                	mv	s5,s4
    800043d8:	bf6d                	j	80004392 <exec+0x100>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    800043da:	4901                	li	s2,0
  iunlockput(ip);
    800043dc:	8526                	mv	a0,s1
    800043de:	fffff097          	auipc	ra,0xfffff
    800043e2:	a90080e7          	jalr	-1392(ra) # 80002e6e <iunlockput>
  end_op();
    800043e6:	fffff097          	auipc	ra,0xfffff
    800043ea:	400080e7          	jalr	1024(ra) # 800037e6 <end_op>
  p = myproc();
    800043ee:	ffffd097          	auipc	ra,0xffffd
    800043f2:	b38080e7          	jalr	-1224(ra) # 80000f26 <myproc>
    800043f6:	8aaa                	mv	s5,a0
  uint64 oldsz = p->sz;
    800043f8:	04853d03          	ld	s10,72(a0)
  sz = PGROUNDUP(sz);
    800043fc:	6785                	lui	a5,0x1
    800043fe:	17fd                	addi	a5,a5,-1
    80004400:	993e                	add	s2,s2,a5
    80004402:	757d                	lui	a0,0xfffff
    80004404:	00a977b3          	and	a5,s2,a0
    80004408:	e0f43423          	sd	a5,-504(s0)
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    8000440c:	6609                	lui	a2,0x2
    8000440e:	963e                	add	a2,a2,a5
    80004410:	85be                	mv	a1,a5
    80004412:	855e                	mv	a0,s7
    80004414:	ffffc097          	auipc	ra,0xffffc
    80004418:	49e080e7          	jalr	1182(ra) # 800008b2 <uvmalloc>
    8000441c:	8b2a                	mv	s6,a0
  ip = 0;
    8000441e:	4481                	li	s1,0
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80004420:	12050c63          	beqz	a0,80004558 <exec+0x2c6>
  uvmclear(pagetable, sz-2*PGSIZE);
    80004424:	75f9                	lui	a1,0xffffe
    80004426:	95aa                	add	a1,a1,a0
    80004428:	855e                	mv	a0,s7
    8000442a:	ffffc097          	auipc	ra,0xffffc
    8000442e:	6a6080e7          	jalr	1702(ra) # 80000ad0 <uvmclear>
  stackbase = sp - PGSIZE;
    80004432:	7c7d                	lui	s8,0xfffff
    80004434:	9c5a                	add	s8,s8,s6
  for(argc = 0; argv[argc]; argc++) {
    80004436:	e0043783          	ld	a5,-512(s0)
    8000443a:	6388                	ld	a0,0(a5)
    8000443c:	c535                	beqz	a0,800044a8 <exec+0x216>
    8000443e:	e9040993          	addi	s3,s0,-368
    80004442:	f9040c93          	addi	s9,s0,-112
  sp = sz;
    80004446:	895a                	mv	s2,s6
    sp -= strlen(argv[argc]) + 1;
    80004448:	ffffc097          	auipc	ra,0xffffc
    8000444c:	eb4080e7          	jalr	-332(ra) # 800002fc <strlen>
    80004450:	2505                	addiw	a0,a0,1
    80004452:	40a90933          	sub	s2,s2,a0
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80004456:	ff097913          	andi	s2,s2,-16
    if(sp < stackbase)
    8000445a:	13896363          	bltu	s2,s8,80004580 <exec+0x2ee>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    8000445e:	e0043d83          	ld	s11,-512(s0)
    80004462:	000dba03          	ld	s4,0(s11)
    80004466:	8552                	mv	a0,s4
    80004468:	ffffc097          	auipc	ra,0xffffc
    8000446c:	e94080e7          	jalr	-364(ra) # 800002fc <strlen>
    80004470:	0015069b          	addiw	a3,a0,1
    80004474:	8652                	mv	a2,s4
    80004476:	85ca                	mv	a1,s2
    80004478:	855e                	mv	a0,s7
    8000447a:	ffffc097          	auipc	ra,0xffffc
    8000447e:	688080e7          	jalr	1672(ra) # 80000b02 <copyout>
    80004482:	10054363          	bltz	a0,80004588 <exec+0x2f6>
    ustack[argc] = sp;
    80004486:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    8000448a:	0485                	addi	s1,s1,1
    8000448c:	008d8793          	addi	a5,s11,8
    80004490:	e0f43023          	sd	a5,-512(s0)
    80004494:	008db503          	ld	a0,8(s11)
    80004498:	c911                	beqz	a0,800044ac <exec+0x21a>
    if(argc >= MAXARG)
    8000449a:	09a1                	addi	s3,s3,8
    8000449c:	fb3c96e3          	bne	s9,s3,80004448 <exec+0x1b6>
  sz = sz1;
    800044a0:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    800044a4:	4481                	li	s1,0
    800044a6:	a84d                	j	80004558 <exec+0x2c6>
  sp = sz;
    800044a8:	895a                	mv	s2,s6
  for(argc = 0; argv[argc]; argc++) {
    800044aa:	4481                	li	s1,0
  ustack[argc] = 0;
    800044ac:	00349793          	slli	a5,s1,0x3
    800044b0:	f9040713          	addi	a4,s0,-112
    800044b4:	97ba                	add	a5,a5,a4
    800044b6:	f007b023          	sd	zero,-256(a5) # f00 <_entry-0x7ffff100>
  sp -= (argc+1) * sizeof(uint64);
    800044ba:	00148693          	addi	a3,s1,1
    800044be:	068e                	slli	a3,a3,0x3
    800044c0:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    800044c4:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    800044c8:	01897663          	bgeu	s2,s8,800044d4 <exec+0x242>
  sz = sz1;
    800044cc:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    800044d0:	4481                	li	s1,0
    800044d2:	a059                	j	80004558 <exec+0x2c6>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    800044d4:	e9040613          	addi	a2,s0,-368
    800044d8:	85ca                	mv	a1,s2
    800044da:	855e                	mv	a0,s7
    800044dc:	ffffc097          	auipc	ra,0xffffc
    800044e0:	626080e7          	jalr	1574(ra) # 80000b02 <copyout>
    800044e4:	0a054663          	bltz	a0,80004590 <exec+0x2fe>
  p->trapframe->a1 = sp;
    800044e8:	058ab783          	ld	a5,88(s5)
    800044ec:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    800044f0:	df843783          	ld	a5,-520(s0)
    800044f4:	0007c703          	lbu	a4,0(a5)
    800044f8:	cf11                	beqz	a4,80004514 <exec+0x282>
    800044fa:	0785                	addi	a5,a5,1
    if(*s == '/')
    800044fc:	02f00693          	li	a3,47
    80004500:	a039                	j	8000450e <exec+0x27c>
      last = s+1;
    80004502:	def43c23          	sd	a5,-520(s0)
  for(last=s=path; *s; s++)
    80004506:	0785                	addi	a5,a5,1
    80004508:	fff7c703          	lbu	a4,-1(a5)
    8000450c:	c701                	beqz	a4,80004514 <exec+0x282>
    if(*s == '/')
    8000450e:	fed71ce3          	bne	a4,a3,80004506 <exec+0x274>
    80004512:	bfc5                	j	80004502 <exec+0x270>
  safestrcpy(p->name, last, sizeof(p->name));
    80004514:	4641                	li	a2,16
    80004516:	df843583          	ld	a1,-520(s0)
    8000451a:	158a8513          	addi	a0,s5,344
    8000451e:	ffffc097          	auipc	ra,0xffffc
    80004522:	dac080e7          	jalr	-596(ra) # 800002ca <safestrcpy>
  oldpagetable = p->pagetable;
    80004526:	050ab503          	ld	a0,80(s5)
  p->pagetable = pagetable;
    8000452a:	057ab823          	sd	s7,80(s5)
  p->sz = sz;
    8000452e:	056ab423          	sd	s6,72(s5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    80004532:	058ab783          	ld	a5,88(s5)
    80004536:	e6843703          	ld	a4,-408(s0)
    8000453a:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    8000453c:	058ab783          	ld	a5,88(s5)
    80004540:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80004544:	85ea                	mv	a1,s10
    80004546:	ffffd097          	auipc	ra,0xffffd
    8000454a:	b40080e7          	jalr	-1216(ra) # 80001086 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    8000454e:	0004851b          	sext.w	a0,s1
    80004552:	bbe1                	j	8000432a <exec+0x98>
    80004554:	e1243423          	sd	s2,-504(s0)
    proc_freepagetable(pagetable, sz);
    80004558:	e0843583          	ld	a1,-504(s0)
    8000455c:	855e                	mv	a0,s7
    8000455e:	ffffd097          	auipc	ra,0xffffd
    80004562:	b28080e7          	jalr	-1240(ra) # 80001086 <proc_freepagetable>
  if(ip){
    80004566:	da0498e3          	bnez	s1,80004316 <exec+0x84>
  return -1;
    8000456a:	557d                	li	a0,-1
    8000456c:	bb7d                	j	8000432a <exec+0x98>
    8000456e:	e1243423          	sd	s2,-504(s0)
    80004572:	b7dd                	j	80004558 <exec+0x2c6>
    80004574:	e1243423          	sd	s2,-504(s0)
    80004578:	b7c5                	j	80004558 <exec+0x2c6>
    8000457a:	e1243423          	sd	s2,-504(s0)
    8000457e:	bfe9                	j	80004558 <exec+0x2c6>
  sz = sz1;
    80004580:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    80004584:	4481                	li	s1,0
    80004586:	bfc9                	j	80004558 <exec+0x2c6>
  sz = sz1;
    80004588:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    8000458c:	4481                	li	s1,0
    8000458e:	b7e9                	j	80004558 <exec+0x2c6>
  sz = sz1;
    80004590:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    80004594:	4481                	li	s1,0
    80004596:	b7c9                	j	80004558 <exec+0x2c6>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    80004598:	e0843903          	ld	s2,-504(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    8000459c:	2b05                	addiw	s6,s6,1
    8000459e:	0389899b          	addiw	s3,s3,56
    800045a2:	e8845783          	lhu	a5,-376(s0)
    800045a6:	e2fb5be3          	bge	s6,a5,800043dc <exec+0x14a>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    800045aa:	2981                	sext.w	s3,s3
    800045ac:	03800713          	li	a4,56
    800045b0:	86ce                	mv	a3,s3
    800045b2:	e1840613          	addi	a2,s0,-488
    800045b6:	4581                	li	a1,0
    800045b8:	8526                	mv	a0,s1
    800045ba:	fffff097          	auipc	ra,0xfffff
    800045be:	906080e7          	jalr	-1786(ra) # 80002ec0 <readi>
    800045c2:	03800793          	li	a5,56
    800045c6:	f8f517e3          	bne	a0,a5,80004554 <exec+0x2c2>
    if(ph.type != ELF_PROG_LOAD)
    800045ca:	e1842783          	lw	a5,-488(s0)
    800045ce:	4705                	li	a4,1
    800045d0:	fce796e3          	bne	a5,a4,8000459c <exec+0x30a>
    if(ph.memsz < ph.filesz)
    800045d4:	e4043603          	ld	a2,-448(s0)
    800045d8:	e3843783          	ld	a5,-456(s0)
    800045dc:	f8f669e3          	bltu	a2,a5,8000456e <exec+0x2dc>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    800045e0:	e2843783          	ld	a5,-472(s0)
    800045e4:	963e                	add	a2,a2,a5
    800045e6:	f8f667e3          	bltu	a2,a5,80004574 <exec+0x2e2>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    800045ea:	85ca                	mv	a1,s2
    800045ec:	855e                	mv	a0,s7
    800045ee:	ffffc097          	auipc	ra,0xffffc
    800045f2:	2c4080e7          	jalr	708(ra) # 800008b2 <uvmalloc>
    800045f6:	e0a43423          	sd	a0,-504(s0)
    800045fa:	d141                	beqz	a0,8000457a <exec+0x2e8>
    if((ph.vaddr % PGSIZE) != 0)
    800045fc:	e2843d03          	ld	s10,-472(s0)
    80004600:	df043783          	ld	a5,-528(s0)
    80004604:	00fd77b3          	and	a5,s10,a5
    80004608:	fba1                	bnez	a5,80004558 <exec+0x2c6>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    8000460a:	e2042d83          	lw	s11,-480(s0)
    8000460e:	e3842c03          	lw	s8,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80004612:	f80c03e3          	beqz	s8,80004598 <exec+0x306>
    80004616:	8a62                	mv	s4,s8
    80004618:	4901                	li	s2,0
    8000461a:	b345                	j	800043ba <exec+0x128>

000000008000461c <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    8000461c:	7179                	addi	sp,sp,-48
    8000461e:	f406                	sd	ra,40(sp)
    80004620:	f022                	sd	s0,32(sp)
    80004622:	ec26                	sd	s1,24(sp)
    80004624:	e84a                	sd	s2,16(sp)
    80004626:	1800                	addi	s0,sp,48
    80004628:	892e                	mv	s2,a1
    8000462a:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    8000462c:	fdc40593          	addi	a1,s0,-36
    80004630:	ffffe097          	auipc	ra,0xffffe
    80004634:	9a2080e7          	jalr	-1630(ra) # 80001fd2 <argint>
    80004638:	04054063          	bltz	a0,80004678 <argfd+0x5c>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    8000463c:	fdc42703          	lw	a4,-36(s0)
    80004640:	47bd                	li	a5,15
    80004642:	02e7ed63          	bltu	a5,a4,8000467c <argfd+0x60>
    80004646:	ffffd097          	auipc	ra,0xffffd
    8000464a:	8e0080e7          	jalr	-1824(ra) # 80000f26 <myproc>
    8000464e:	fdc42703          	lw	a4,-36(s0)
    80004652:	01a70793          	addi	a5,a4,26
    80004656:	078e                	slli	a5,a5,0x3
    80004658:	953e                	add	a0,a0,a5
    8000465a:	611c                	ld	a5,0(a0)
    8000465c:	c395                	beqz	a5,80004680 <argfd+0x64>
    return -1;
  if(pfd)
    8000465e:	00090463          	beqz	s2,80004666 <argfd+0x4a>
    *pfd = fd;
    80004662:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    80004666:	4501                	li	a0,0
  if(pf)
    80004668:	c091                	beqz	s1,8000466c <argfd+0x50>
    *pf = f;
    8000466a:	e09c                	sd	a5,0(s1)
}
    8000466c:	70a2                	ld	ra,40(sp)
    8000466e:	7402                	ld	s0,32(sp)
    80004670:	64e2                	ld	s1,24(sp)
    80004672:	6942                	ld	s2,16(sp)
    80004674:	6145                	addi	sp,sp,48
    80004676:	8082                	ret
    return -1;
    80004678:	557d                	li	a0,-1
    8000467a:	bfcd                	j	8000466c <argfd+0x50>
    return -1;
    8000467c:	557d                	li	a0,-1
    8000467e:	b7fd                	j	8000466c <argfd+0x50>
    80004680:	557d                	li	a0,-1
    80004682:	b7ed                	j	8000466c <argfd+0x50>

0000000080004684 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80004684:	1101                	addi	sp,sp,-32
    80004686:	ec06                	sd	ra,24(sp)
    80004688:	e822                	sd	s0,16(sp)
    8000468a:	e426                	sd	s1,8(sp)
    8000468c:	1000                	addi	s0,sp,32
    8000468e:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    80004690:	ffffd097          	auipc	ra,0xffffd
    80004694:	896080e7          	jalr	-1898(ra) # 80000f26 <myproc>
    80004698:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    8000469a:	0d050793          	addi	a5,a0,208 # fffffffffffff0d0 <end+0xffffffff7ffd8e90>
    8000469e:	4501                	li	a0,0
    800046a0:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    800046a2:	6398                	ld	a4,0(a5)
    800046a4:	cb19                	beqz	a4,800046ba <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    800046a6:	2505                	addiw	a0,a0,1
    800046a8:	07a1                	addi	a5,a5,8
    800046aa:	fed51ce3          	bne	a0,a3,800046a2 <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    800046ae:	557d                	li	a0,-1
}
    800046b0:	60e2                	ld	ra,24(sp)
    800046b2:	6442                	ld	s0,16(sp)
    800046b4:	64a2                	ld	s1,8(sp)
    800046b6:	6105                	addi	sp,sp,32
    800046b8:	8082                	ret
      p->ofile[fd] = f;
    800046ba:	01a50793          	addi	a5,a0,26
    800046be:	078e                	slli	a5,a5,0x3
    800046c0:	963e                	add	a2,a2,a5
    800046c2:	e204                	sd	s1,0(a2)
      return fd;
    800046c4:	b7f5                	j	800046b0 <fdalloc+0x2c>

00000000800046c6 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    800046c6:	715d                	addi	sp,sp,-80
    800046c8:	e486                	sd	ra,72(sp)
    800046ca:	e0a2                	sd	s0,64(sp)
    800046cc:	fc26                	sd	s1,56(sp)
    800046ce:	f84a                	sd	s2,48(sp)
    800046d0:	f44e                	sd	s3,40(sp)
    800046d2:	f052                	sd	s4,32(sp)
    800046d4:	ec56                	sd	s5,24(sp)
    800046d6:	0880                	addi	s0,sp,80
    800046d8:	89ae                	mv	s3,a1
    800046da:	8ab2                	mv	s5,a2
    800046dc:	8a36                	mv	s4,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    800046de:	fb040593          	addi	a1,s0,-80
    800046e2:	fffff097          	auipc	ra,0xfffff
    800046e6:	cf4080e7          	jalr	-780(ra) # 800033d6 <nameiparent>
    800046ea:	892a                	mv	s2,a0
    800046ec:	12050f63          	beqz	a0,8000482a <create+0x164>
    return 0;

  ilock(dp);
    800046f0:	ffffe097          	auipc	ra,0xffffe
    800046f4:	51c080e7          	jalr	1308(ra) # 80002c0c <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    800046f8:	4601                	li	a2,0
    800046fa:	fb040593          	addi	a1,s0,-80
    800046fe:	854a                	mv	a0,s2
    80004700:	fffff097          	auipc	ra,0xfffff
    80004704:	9e6080e7          	jalr	-1562(ra) # 800030e6 <dirlookup>
    80004708:	84aa                	mv	s1,a0
    8000470a:	c921                	beqz	a0,8000475a <create+0x94>
    iunlockput(dp);
    8000470c:	854a                	mv	a0,s2
    8000470e:	ffffe097          	auipc	ra,0xffffe
    80004712:	760080e7          	jalr	1888(ra) # 80002e6e <iunlockput>
    ilock(ip);
    80004716:	8526                	mv	a0,s1
    80004718:	ffffe097          	auipc	ra,0xffffe
    8000471c:	4f4080e7          	jalr	1268(ra) # 80002c0c <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80004720:	2981                	sext.w	s3,s3
    80004722:	4789                	li	a5,2
    80004724:	02f99463          	bne	s3,a5,8000474c <create+0x86>
    80004728:	0444d783          	lhu	a5,68(s1)
    8000472c:	37f9                	addiw	a5,a5,-2
    8000472e:	17c2                	slli	a5,a5,0x30
    80004730:	93c1                	srli	a5,a5,0x30
    80004732:	4705                	li	a4,1
    80004734:	00f76c63          	bltu	a4,a5,8000474c <create+0x86>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
    80004738:	8526                	mv	a0,s1
    8000473a:	60a6                	ld	ra,72(sp)
    8000473c:	6406                	ld	s0,64(sp)
    8000473e:	74e2                	ld	s1,56(sp)
    80004740:	7942                	ld	s2,48(sp)
    80004742:	79a2                	ld	s3,40(sp)
    80004744:	7a02                	ld	s4,32(sp)
    80004746:	6ae2                	ld	s5,24(sp)
    80004748:	6161                	addi	sp,sp,80
    8000474a:	8082                	ret
    iunlockput(ip);
    8000474c:	8526                	mv	a0,s1
    8000474e:	ffffe097          	auipc	ra,0xffffe
    80004752:	720080e7          	jalr	1824(ra) # 80002e6e <iunlockput>
    return 0;
    80004756:	4481                	li	s1,0
    80004758:	b7c5                	j	80004738 <create+0x72>
  if((ip = ialloc(dp->dev, type)) == 0)
    8000475a:	85ce                	mv	a1,s3
    8000475c:	00092503          	lw	a0,0(s2)
    80004760:	ffffe097          	auipc	ra,0xffffe
    80004764:	326080e7          	jalr	806(ra) # 80002a86 <ialloc>
    80004768:	84aa                	mv	s1,a0
    8000476a:	c529                	beqz	a0,800047b4 <create+0xee>
  ilock(ip);
    8000476c:	ffffe097          	auipc	ra,0xffffe
    80004770:	4a0080e7          	jalr	1184(ra) # 80002c0c <ilock>
  ip->major = major;
    80004774:	05549323          	sh	s5,70(s1)
  ip->minor = minor;
    80004778:	05449423          	sh	s4,72(s1)
  ip->nlink = 1;
    8000477c:	4785                	li	a5,1
    8000477e:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004782:	8526                	mv	a0,s1
    80004784:	ffffe097          	auipc	ra,0xffffe
    80004788:	3c6080e7          	jalr	966(ra) # 80002b4a <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    8000478c:	2981                	sext.w	s3,s3
    8000478e:	4785                	li	a5,1
    80004790:	02f98a63          	beq	s3,a5,800047c4 <create+0xfe>
  if(dirlink(dp, name, ip->inum) < 0)
    80004794:	40d0                	lw	a2,4(s1)
    80004796:	fb040593          	addi	a1,s0,-80
    8000479a:	854a                	mv	a0,s2
    8000479c:	fffff097          	auipc	ra,0xfffff
    800047a0:	b5a080e7          	jalr	-1190(ra) # 800032f6 <dirlink>
    800047a4:	06054b63          	bltz	a0,8000481a <create+0x154>
  iunlockput(dp);
    800047a8:	854a                	mv	a0,s2
    800047aa:	ffffe097          	auipc	ra,0xffffe
    800047ae:	6c4080e7          	jalr	1732(ra) # 80002e6e <iunlockput>
  return ip;
    800047b2:	b759                	j	80004738 <create+0x72>
    panic("create: ialloc");
    800047b4:	00004517          	auipc	a0,0x4
    800047b8:	f9450513          	addi	a0,a0,-108 # 80008748 <syscalls+0x390>
    800047bc:	00001097          	auipc	ra,0x1
    800047c0:	78c080e7          	jalr	1932(ra) # 80005f48 <panic>
    dp->nlink++;  // for ".."
    800047c4:	04a95783          	lhu	a5,74(s2)
    800047c8:	2785                	addiw	a5,a5,1
    800047ca:	04f91523          	sh	a5,74(s2)
    iupdate(dp);
    800047ce:	854a                	mv	a0,s2
    800047d0:	ffffe097          	auipc	ra,0xffffe
    800047d4:	37a080e7          	jalr	890(ra) # 80002b4a <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    800047d8:	40d0                	lw	a2,4(s1)
    800047da:	00004597          	auipc	a1,0x4
    800047de:	f7e58593          	addi	a1,a1,-130 # 80008758 <syscalls+0x3a0>
    800047e2:	8526                	mv	a0,s1
    800047e4:	fffff097          	auipc	ra,0xfffff
    800047e8:	b12080e7          	jalr	-1262(ra) # 800032f6 <dirlink>
    800047ec:	00054f63          	bltz	a0,8000480a <create+0x144>
    800047f0:	00492603          	lw	a2,4(s2)
    800047f4:	00004597          	auipc	a1,0x4
    800047f8:	f6c58593          	addi	a1,a1,-148 # 80008760 <syscalls+0x3a8>
    800047fc:	8526                	mv	a0,s1
    800047fe:	fffff097          	auipc	ra,0xfffff
    80004802:	af8080e7          	jalr	-1288(ra) # 800032f6 <dirlink>
    80004806:	f80557e3          	bgez	a0,80004794 <create+0xce>
      panic("create dots");
    8000480a:	00004517          	auipc	a0,0x4
    8000480e:	f5e50513          	addi	a0,a0,-162 # 80008768 <syscalls+0x3b0>
    80004812:	00001097          	auipc	ra,0x1
    80004816:	736080e7          	jalr	1846(ra) # 80005f48 <panic>
    panic("create: dirlink");
    8000481a:	00004517          	auipc	a0,0x4
    8000481e:	f5e50513          	addi	a0,a0,-162 # 80008778 <syscalls+0x3c0>
    80004822:	00001097          	auipc	ra,0x1
    80004826:	726080e7          	jalr	1830(ra) # 80005f48 <panic>
    return 0;
    8000482a:	84aa                	mv	s1,a0
    8000482c:	b731                	j	80004738 <create+0x72>

000000008000482e <sys_dup>:
{
    8000482e:	7179                	addi	sp,sp,-48
    80004830:	f406                	sd	ra,40(sp)
    80004832:	f022                	sd	s0,32(sp)
    80004834:	ec26                	sd	s1,24(sp)
    80004836:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    80004838:	fd840613          	addi	a2,s0,-40
    8000483c:	4581                	li	a1,0
    8000483e:	4501                	li	a0,0
    80004840:	00000097          	auipc	ra,0x0
    80004844:	ddc080e7          	jalr	-548(ra) # 8000461c <argfd>
    return -1;
    80004848:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    8000484a:	02054363          	bltz	a0,80004870 <sys_dup+0x42>
  if((fd=fdalloc(f)) < 0)
    8000484e:	fd843503          	ld	a0,-40(s0)
    80004852:	00000097          	auipc	ra,0x0
    80004856:	e32080e7          	jalr	-462(ra) # 80004684 <fdalloc>
    8000485a:	84aa                	mv	s1,a0
    return -1;
    8000485c:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    8000485e:	00054963          	bltz	a0,80004870 <sys_dup+0x42>
  filedup(f);
    80004862:	fd843503          	ld	a0,-40(s0)
    80004866:	fffff097          	auipc	ra,0xfffff
    8000486a:	37a080e7          	jalr	890(ra) # 80003be0 <filedup>
  return fd;
    8000486e:	87a6                	mv	a5,s1
}
    80004870:	853e                	mv	a0,a5
    80004872:	70a2                	ld	ra,40(sp)
    80004874:	7402                	ld	s0,32(sp)
    80004876:	64e2                	ld	s1,24(sp)
    80004878:	6145                	addi	sp,sp,48
    8000487a:	8082                	ret

000000008000487c <sys_read>:
{
    8000487c:	7179                	addi	sp,sp,-48
    8000487e:	f406                	sd	ra,40(sp)
    80004880:	f022                	sd	s0,32(sp)
    80004882:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004884:	fe840613          	addi	a2,s0,-24
    80004888:	4581                	li	a1,0
    8000488a:	4501                	li	a0,0
    8000488c:	00000097          	auipc	ra,0x0
    80004890:	d90080e7          	jalr	-624(ra) # 8000461c <argfd>
    return -1;
    80004894:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004896:	04054163          	bltz	a0,800048d8 <sys_read+0x5c>
    8000489a:	fe440593          	addi	a1,s0,-28
    8000489e:	4509                	li	a0,2
    800048a0:	ffffd097          	auipc	ra,0xffffd
    800048a4:	732080e7          	jalr	1842(ra) # 80001fd2 <argint>
    return -1;
    800048a8:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800048aa:	02054763          	bltz	a0,800048d8 <sys_read+0x5c>
    800048ae:	fd840593          	addi	a1,s0,-40
    800048b2:	4505                	li	a0,1
    800048b4:	ffffd097          	auipc	ra,0xffffd
    800048b8:	740080e7          	jalr	1856(ra) # 80001ff4 <argaddr>
    return -1;
    800048bc:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800048be:	00054d63          	bltz	a0,800048d8 <sys_read+0x5c>
  return fileread(f, p, n);
    800048c2:	fe442603          	lw	a2,-28(s0)
    800048c6:	fd843583          	ld	a1,-40(s0)
    800048ca:	fe843503          	ld	a0,-24(s0)
    800048ce:	fffff097          	auipc	ra,0xfffff
    800048d2:	49e080e7          	jalr	1182(ra) # 80003d6c <fileread>
    800048d6:	87aa                	mv	a5,a0
}
    800048d8:	853e                	mv	a0,a5
    800048da:	70a2                	ld	ra,40(sp)
    800048dc:	7402                	ld	s0,32(sp)
    800048de:	6145                	addi	sp,sp,48
    800048e0:	8082                	ret

00000000800048e2 <sys_write>:
{
    800048e2:	7179                	addi	sp,sp,-48
    800048e4:	f406                	sd	ra,40(sp)
    800048e6:	f022                	sd	s0,32(sp)
    800048e8:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800048ea:	fe840613          	addi	a2,s0,-24
    800048ee:	4581                	li	a1,0
    800048f0:	4501                	li	a0,0
    800048f2:	00000097          	auipc	ra,0x0
    800048f6:	d2a080e7          	jalr	-726(ra) # 8000461c <argfd>
    return -1;
    800048fa:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800048fc:	04054163          	bltz	a0,8000493e <sys_write+0x5c>
    80004900:	fe440593          	addi	a1,s0,-28
    80004904:	4509                	li	a0,2
    80004906:	ffffd097          	auipc	ra,0xffffd
    8000490a:	6cc080e7          	jalr	1740(ra) # 80001fd2 <argint>
    return -1;
    8000490e:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004910:	02054763          	bltz	a0,8000493e <sys_write+0x5c>
    80004914:	fd840593          	addi	a1,s0,-40
    80004918:	4505                	li	a0,1
    8000491a:	ffffd097          	auipc	ra,0xffffd
    8000491e:	6da080e7          	jalr	1754(ra) # 80001ff4 <argaddr>
    return -1;
    80004922:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004924:	00054d63          	bltz	a0,8000493e <sys_write+0x5c>
  return filewrite(f, p, n);
    80004928:	fe442603          	lw	a2,-28(s0)
    8000492c:	fd843583          	ld	a1,-40(s0)
    80004930:	fe843503          	ld	a0,-24(s0)
    80004934:	fffff097          	auipc	ra,0xfffff
    80004938:	4fa080e7          	jalr	1274(ra) # 80003e2e <filewrite>
    8000493c:	87aa                	mv	a5,a0
}
    8000493e:	853e                	mv	a0,a5
    80004940:	70a2                	ld	ra,40(sp)
    80004942:	7402                	ld	s0,32(sp)
    80004944:	6145                	addi	sp,sp,48
    80004946:	8082                	ret

0000000080004948 <sys_close>:
{
    80004948:	1101                	addi	sp,sp,-32
    8000494a:	ec06                	sd	ra,24(sp)
    8000494c:	e822                	sd	s0,16(sp)
    8000494e:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    80004950:	fe040613          	addi	a2,s0,-32
    80004954:	fec40593          	addi	a1,s0,-20
    80004958:	4501                	li	a0,0
    8000495a:	00000097          	auipc	ra,0x0
    8000495e:	cc2080e7          	jalr	-830(ra) # 8000461c <argfd>
    return -1;
    80004962:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    80004964:	02054463          	bltz	a0,8000498c <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    80004968:	ffffc097          	auipc	ra,0xffffc
    8000496c:	5be080e7          	jalr	1470(ra) # 80000f26 <myproc>
    80004970:	fec42783          	lw	a5,-20(s0)
    80004974:	07e9                	addi	a5,a5,26
    80004976:	078e                	slli	a5,a5,0x3
    80004978:	97aa                	add	a5,a5,a0
    8000497a:	0007b023          	sd	zero,0(a5)
  fileclose(f);
    8000497e:	fe043503          	ld	a0,-32(s0)
    80004982:	fffff097          	auipc	ra,0xfffff
    80004986:	2b0080e7          	jalr	688(ra) # 80003c32 <fileclose>
  return 0;
    8000498a:	4781                	li	a5,0
}
    8000498c:	853e                	mv	a0,a5
    8000498e:	60e2                	ld	ra,24(sp)
    80004990:	6442                	ld	s0,16(sp)
    80004992:	6105                	addi	sp,sp,32
    80004994:	8082                	ret

0000000080004996 <sys_fstat>:
{
    80004996:	1101                	addi	sp,sp,-32
    80004998:	ec06                	sd	ra,24(sp)
    8000499a:	e822                	sd	s0,16(sp)
    8000499c:	1000                	addi	s0,sp,32
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    8000499e:	fe840613          	addi	a2,s0,-24
    800049a2:	4581                	li	a1,0
    800049a4:	4501                	li	a0,0
    800049a6:	00000097          	auipc	ra,0x0
    800049aa:	c76080e7          	jalr	-906(ra) # 8000461c <argfd>
    return -1;
    800049ae:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    800049b0:	02054563          	bltz	a0,800049da <sys_fstat+0x44>
    800049b4:	fe040593          	addi	a1,s0,-32
    800049b8:	4505                	li	a0,1
    800049ba:	ffffd097          	auipc	ra,0xffffd
    800049be:	63a080e7          	jalr	1594(ra) # 80001ff4 <argaddr>
    return -1;
    800049c2:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    800049c4:	00054b63          	bltz	a0,800049da <sys_fstat+0x44>
  return filestat(f, st);
    800049c8:	fe043583          	ld	a1,-32(s0)
    800049cc:	fe843503          	ld	a0,-24(s0)
    800049d0:	fffff097          	auipc	ra,0xfffff
    800049d4:	32a080e7          	jalr	810(ra) # 80003cfa <filestat>
    800049d8:	87aa                	mv	a5,a0
}
    800049da:	853e                	mv	a0,a5
    800049dc:	60e2                	ld	ra,24(sp)
    800049de:	6442                	ld	s0,16(sp)
    800049e0:	6105                	addi	sp,sp,32
    800049e2:	8082                	ret

00000000800049e4 <sys_link>:
{
    800049e4:	7169                	addi	sp,sp,-304
    800049e6:	f606                	sd	ra,296(sp)
    800049e8:	f222                	sd	s0,288(sp)
    800049ea:	ee26                	sd	s1,280(sp)
    800049ec:	ea4a                	sd	s2,272(sp)
    800049ee:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800049f0:	08000613          	li	a2,128
    800049f4:	ed040593          	addi	a1,s0,-304
    800049f8:	4501                	li	a0,0
    800049fa:	ffffd097          	auipc	ra,0xffffd
    800049fe:	61c080e7          	jalr	1564(ra) # 80002016 <argstr>
    return -1;
    80004a02:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004a04:	10054e63          	bltz	a0,80004b20 <sys_link+0x13c>
    80004a08:	08000613          	li	a2,128
    80004a0c:	f5040593          	addi	a1,s0,-176
    80004a10:	4505                	li	a0,1
    80004a12:	ffffd097          	auipc	ra,0xffffd
    80004a16:	604080e7          	jalr	1540(ra) # 80002016 <argstr>
    return -1;
    80004a1a:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004a1c:	10054263          	bltz	a0,80004b20 <sys_link+0x13c>
  begin_op();
    80004a20:	fffff097          	auipc	ra,0xfffff
    80004a24:	d46080e7          	jalr	-698(ra) # 80003766 <begin_op>
  if((ip = namei(old)) == 0){
    80004a28:	ed040513          	addi	a0,s0,-304
    80004a2c:	fffff097          	auipc	ra,0xfffff
    80004a30:	98c080e7          	jalr	-1652(ra) # 800033b8 <namei>
    80004a34:	84aa                	mv	s1,a0
    80004a36:	c551                	beqz	a0,80004ac2 <sys_link+0xde>
  ilock(ip);
    80004a38:	ffffe097          	auipc	ra,0xffffe
    80004a3c:	1d4080e7          	jalr	468(ra) # 80002c0c <ilock>
  if(ip->type == T_DIR){
    80004a40:	04449703          	lh	a4,68(s1)
    80004a44:	4785                	li	a5,1
    80004a46:	08f70463          	beq	a4,a5,80004ace <sys_link+0xea>
  ip->nlink++;
    80004a4a:	04a4d783          	lhu	a5,74(s1)
    80004a4e:	2785                	addiw	a5,a5,1
    80004a50:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004a54:	8526                	mv	a0,s1
    80004a56:	ffffe097          	auipc	ra,0xffffe
    80004a5a:	0f4080e7          	jalr	244(ra) # 80002b4a <iupdate>
  iunlock(ip);
    80004a5e:	8526                	mv	a0,s1
    80004a60:	ffffe097          	auipc	ra,0xffffe
    80004a64:	26e080e7          	jalr	622(ra) # 80002cce <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    80004a68:	fd040593          	addi	a1,s0,-48
    80004a6c:	f5040513          	addi	a0,s0,-176
    80004a70:	fffff097          	auipc	ra,0xfffff
    80004a74:	966080e7          	jalr	-1690(ra) # 800033d6 <nameiparent>
    80004a78:	892a                	mv	s2,a0
    80004a7a:	c935                	beqz	a0,80004aee <sys_link+0x10a>
  ilock(dp);
    80004a7c:	ffffe097          	auipc	ra,0xffffe
    80004a80:	190080e7          	jalr	400(ra) # 80002c0c <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80004a84:	00092703          	lw	a4,0(s2)
    80004a88:	409c                	lw	a5,0(s1)
    80004a8a:	04f71d63          	bne	a4,a5,80004ae4 <sys_link+0x100>
    80004a8e:	40d0                	lw	a2,4(s1)
    80004a90:	fd040593          	addi	a1,s0,-48
    80004a94:	854a                	mv	a0,s2
    80004a96:	fffff097          	auipc	ra,0xfffff
    80004a9a:	860080e7          	jalr	-1952(ra) # 800032f6 <dirlink>
    80004a9e:	04054363          	bltz	a0,80004ae4 <sys_link+0x100>
  iunlockput(dp);
    80004aa2:	854a                	mv	a0,s2
    80004aa4:	ffffe097          	auipc	ra,0xffffe
    80004aa8:	3ca080e7          	jalr	970(ra) # 80002e6e <iunlockput>
  iput(ip);
    80004aac:	8526                	mv	a0,s1
    80004aae:	ffffe097          	auipc	ra,0xffffe
    80004ab2:	318080e7          	jalr	792(ra) # 80002dc6 <iput>
  end_op();
    80004ab6:	fffff097          	auipc	ra,0xfffff
    80004aba:	d30080e7          	jalr	-720(ra) # 800037e6 <end_op>
  return 0;
    80004abe:	4781                	li	a5,0
    80004ac0:	a085                	j	80004b20 <sys_link+0x13c>
    end_op();
    80004ac2:	fffff097          	auipc	ra,0xfffff
    80004ac6:	d24080e7          	jalr	-732(ra) # 800037e6 <end_op>
    return -1;
    80004aca:	57fd                	li	a5,-1
    80004acc:	a891                	j	80004b20 <sys_link+0x13c>
    iunlockput(ip);
    80004ace:	8526                	mv	a0,s1
    80004ad0:	ffffe097          	auipc	ra,0xffffe
    80004ad4:	39e080e7          	jalr	926(ra) # 80002e6e <iunlockput>
    end_op();
    80004ad8:	fffff097          	auipc	ra,0xfffff
    80004adc:	d0e080e7          	jalr	-754(ra) # 800037e6 <end_op>
    return -1;
    80004ae0:	57fd                	li	a5,-1
    80004ae2:	a83d                	j	80004b20 <sys_link+0x13c>
    iunlockput(dp);
    80004ae4:	854a                	mv	a0,s2
    80004ae6:	ffffe097          	auipc	ra,0xffffe
    80004aea:	388080e7          	jalr	904(ra) # 80002e6e <iunlockput>
  ilock(ip);
    80004aee:	8526                	mv	a0,s1
    80004af0:	ffffe097          	auipc	ra,0xffffe
    80004af4:	11c080e7          	jalr	284(ra) # 80002c0c <ilock>
  ip->nlink--;
    80004af8:	04a4d783          	lhu	a5,74(s1)
    80004afc:	37fd                	addiw	a5,a5,-1
    80004afe:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004b02:	8526                	mv	a0,s1
    80004b04:	ffffe097          	auipc	ra,0xffffe
    80004b08:	046080e7          	jalr	70(ra) # 80002b4a <iupdate>
  iunlockput(ip);
    80004b0c:	8526                	mv	a0,s1
    80004b0e:	ffffe097          	auipc	ra,0xffffe
    80004b12:	360080e7          	jalr	864(ra) # 80002e6e <iunlockput>
  end_op();
    80004b16:	fffff097          	auipc	ra,0xfffff
    80004b1a:	cd0080e7          	jalr	-816(ra) # 800037e6 <end_op>
  return -1;
    80004b1e:	57fd                	li	a5,-1
}
    80004b20:	853e                	mv	a0,a5
    80004b22:	70b2                	ld	ra,296(sp)
    80004b24:	7412                	ld	s0,288(sp)
    80004b26:	64f2                	ld	s1,280(sp)
    80004b28:	6952                	ld	s2,272(sp)
    80004b2a:	6155                	addi	sp,sp,304
    80004b2c:	8082                	ret

0000000080004b2e <sys_unlink>:
{
    80004b2e:	7151                	addi	sp,sp,-240
    80004b30:	f586                	sd	ra,232(sp)
    80004b32:	f1a2                	sd	s0,224(sp)
    80004b34:	eda6                	sd	s1,216(sp)
    80004b36:	e9ca                	sd	s2,208(sp)
    80004b38:	e5ce                	sd	s3,200(sp)
    80004b3a:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    80004b3c:	08000613          	li	a2,128
    80004b40:	f3040593          	addi	a1,s0,-208
    80004b44:	4501                	li	a0,0
    80004b46:	ffffd097          	auipc	ra,0xffffd
    80004b4a:	4d0080e7          	jalr	1232(ra) # 80002016 <argstr>
    80004b4e:	18054163          	bltz	a0,80004cd0 <sys_unlink+0x1a2>
  begin_op();
    80004b52:	fffff097          	auipc	ra,0xfffff
    80004b56:	c14080e7          	jalr	-1004(ra) # 80003766 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    80004b5a:	fb040593          	addi	a1,s0,-80
    80004b5e:	f3040513          	addi	a0,s0,-208
    80004b62:	fffff097          	auipc	ra,0xfffff
    80004b66:	874080e7          	jalr	-1932(ra) # 800033d6 <nameiparent>
    80004b6a:	84aa                	mv	s1,a0
    80004b6c:	c979                	beqz	a0,80004c42 <sys_unlink+0x114>
  ilock(dp);
    80004b6e:	ffffe097          	auipc	ra,0xffffe
    80004b72:	09e080e7          	jalr	158(ra) # 80002c0c <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    80004b76:	00004597          	auipc	a1,0x4
    80004b7a:	be258593          	addi	a1,a1,-1054 # 80008758 <syscalls+0x3a0>
    80004b7e:	fb040513          	addi	a0,s0,-80
    80004b82:	ffffe097          	auipc	ra,0xffffe
    80004b86:	54a080e7          	jalr	1354(ra) # 800030cc <namecmp>
    80004b8a:	14050a63          	beqz	a0,80004cde <sys_unlink+0x1b0>
    80004b8e:	00004597          	auipc	a1,0x4
    80004b92:	bd258593          	addi	a1,a1,-1070 # 80008760 <syscalls+0x3a8>
    80004b96:	fb040513          	addi	a0,s0,-80
    80004b9a:	ffffe097          	auipc	ra,0xffffe
    80004b9e:	532080e7          	jalr	1330(ra) # 800030cc <namecmp>
    80004ba2:	12050e63          	beqz	a0,80004cde <sys_unlink+0x1b0>
  if((ip = dirlookup(dp, name, &off)) == 0)
    80004ba6:	f2c40613          	addi	a2,s0,-212
    80004baa:	fb040593          	addi	a1,s0,-80
    80004bae:	8526                	mv	a0,s1
    80004bb0:	ffffe097          	auipc	ra,0xffffe
    80004bb4:	536080e7          	jalr	1334(ra) # 800030e6 <dirlookup>
    80004bb8:	892a                	mv	s2,a0
    80004bba:	12050263          	beqz	a0,80004cde <sys_unlink+0x1b0>
  ilock(ip);
    80004bbe:	ffffe097          	auipc	ra,0xffffe
    80004bc2:	04e080e7          	jalr	78(ra) # 80002c0c <ilock>
  if(ip->nlink < 1)
    80004bc6:	04a91783          	lh	a5,74(s2)
    80004bca:	08f05263          	blez	a5,80004c4e <sys_unlink+0x120>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80004bce:	04491703          	lh	a4,68(s2)
    80004bd2:	4785                	li	a5,1
    80004bd4:	08f70563          	beq	a4,a5,80004c5e <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
    80004bd8:	4641                	li	a2,16
    80004bda:	4581                	li	a1,0
    80004bdc:	fc040513          	addi	a0,s0,-64
    80004be0:	ffffb097          	auipc	ra,0xffffb
    80004be4:	598080e7          	jalr	1432(ra) # 80000178 <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004be8:	4741                	li	a4,16
    80004bea:	f2c42683          	lw	a3,-212(s0)
    80004bee:	fc040613          	addi	a2,s0,-64
    80004bf2:	4581                	li	a1,0
    80004bf4:	8526                	mv	a0,s1
    80004bf6:	ffffe097          	auipc	ra,0xffffe
    80004bfa:	3c2080e7          	jalr	962(ra) # 80002fb8 <writei>
    80004bfe:	47c1                	li	a5,16
    80004c00:	0af51563          	bne	a0,a5,80004caa <sys_unlink+0x17c>
  if(ip->type == T_DIR){
    80004c04:	04491703          	lh	a4,68(s2)
    80004c08:	4785                	li	a5,1
    80004c0a:	0af70863          	beq	a4,a5,80004cba <sys_unlink+0x18c>
  iunlockput(dp);
    80004c0e:	8526                	mv	a0,s1
    80004c10:	ffffe097          	auipc	ra,0xffffe
    80004c14:	25e080e7          	jalr	606(ra) # 80002e6e <iunlockput>
  ip->nlink--;
    80004c18:	04a95783          	lhu	a5,74(s2)
    80004c1c:	37fd                	addiw	a5,a5,-1
    80004c1e:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80004c22:	854a                	mv	a0,s2
    80004c24:	ffffe097          	auipc	ra,0xffffe
    80004c28:	f26080e7          	jalr	-218(ra) # 80002b4a <iupdate>
  iunlockput(ip);
    80004c2c:	854a                	mv	a0,s2
    80004c2e:	ffffe097          	auipc	ra,0xffffe
    80004c32:	240080e7          	jalr	576(ra) # 80002e6e <iunlockput>
  end_op();
    80004c36:	fffff097          	auipc	ra,0xfffff
    80004c3a:	bb0080e7          	jalr	-1104(ra) # 800037e6 <end_op>
  return 0;
    80004c3e:	4501                	li	a0,0
    80004c40:	a84d                	j	80004cf2 <sys_unlink+0x1c4>
    end_op();
    80004c42:	fffff097          	auipc	ra,0xfffff
    80004c46:	ba4080e7          	jalr	-1116(ra) # 800037e6 <end_op>
    return -1;
    80004c4a:	557d                	li	a0,-1
    80004c4c:	a05d                	j	80004cf2 <sys_unlink+0x1c4>
    panic("unlink: nlink < 1");
    80004c4e:	00004517          	auipc	a0,0x4
    80004c52:	b3a50513          	addi	a0,a0,-1222 # 80008788 <syscalls+0x3d0>
    80004c56:	00001097          	auipc	ra,0x1
    80004c5a:	2f2080e7          	jalr	754(ra) # 80005f48 <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004c5e:	04c92703          	lw	a4,76(s2)
    80004c62:	02000793          	li	a5,32
    80004c66:	f6e7f9e3          	bgeu	a5,a4,80004bd8 <sys_unlink+0xaa>
    80004c6a:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004c6e:	4741                	li	a4,16
    80004c70:	86ce                	mv	a3,s3
    80004c72:	f1840613          	addi	a2,s0,-232
    80004c76:	4581                	li	a1,0
    80004c78:	854a                	mv	a0,s2
    80004c7a:	ffffe097          	auipc	ra,0xffffe
    80004c7e:	246080e7          	jalr	582(ra) # 80002ec0 <readi>
    80004c82:	47c1                	li	a5,16
    80004c84:	00f51b63          	bne	a0,a5,80004c9a <sys_unlink+0x16c>
    if(de.inum != 0)
    80004c88:	f1845783          	lhu	a5,-232(s0)
    80004c8c:	e7a1                	bnez	a5,80004cd4 <sys_unlink+0x1a6>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004c8e:	29c1                	addiw	s3,s3,16
    80004c90:	04c92783          	lw	a5,76(s2)
    80004c94:	fcf9ede3          	bltu	s3,a5,80004c6e <sys_unlink+0x140>
    80004c98:	b781                	j	80004bd8 <sys_unlink+0xaa>
      panic("isdirempty: readi");
    80004c9a:	00004517          	auipc	a0,0x4
    80004c9e:	b0650513          	addi	a0,a0,-1274 # 800087a0 <syscalls+0x3e8>
    80004ca2:	00001097          	auipc	ra,0x1
    80004ca6:	2a6080e7          	jalr	678(ra) # 80005f48 <panic>
    panic("unlink: writei");
    80004caa:	00004517          	auipc	a0,0x4
    80004cae:	b0e50513          	addi	a0,a0,-1266 # 800087b8 <syscalls+0x400>
    80004cb2:	00001097          	auipc	ra,0x1
    80004cb6:	296080e7          	jalr	662(ra) # 80005f48 <panic>
    dp->nlink--;
    80004cba:	04a4d783          	lhu	a5,74(s1)
    80004cbe:	37fd                	addiw	a5,a5,-1
    80004cc0:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80004cc4:	8526                	mv	a0,s1
    80004cc6:	ffffe097          	auipc	ra,0xffffe
    80004cca:	e84080e7          	jalr	-380(ra) # 80002b4a <iupdate>
    80004cce:	b781                	j	80004c0e <sys_unlink+0xe0>
    return -1;
    80004cd0:	557d                	li	a0,-1
    80004cd2:	a005                	j	80004cf2 <sys_unlink+0x1c4>
    iunlockput(ip);
    80004cd4:	854a                	mv	a0,s2
    80004cd6:	ffffe097          	auipc	ra,0xffffe
    80004cda:	198080e7          	jalr	408(ra) # 80002e6e <iunlockput>
  iunlockput(dp);
    80004cde:	8526                	mv	a0,s1
    80004ce0:	ffffe097          	auipc	ra,0xffffe
    80004ce4:	18e080e7          	jalr	398(ra) # 80002e6e <iunlockput>
  end_op();
    80004ce8:	fffff097          	auipc	ra,0xfffff
    80004cec:	afe080e7          	jalr	-1282(ra) # 800037e6 <end_op>
  return -1;
    80004cf0:	557d                	li	a0,-1
}
    80004cf2:	70ae                	ld	ra,232(sp)
    80004cf4:	740e                	ld	s0,224(sp)
    80004cf6:	64ee                	ld	s1,216(sp)
    80004cf8:	694e                	ld	s2,208(sp)
    80004cfa:	69ae                	ld	s3,200(sp)
    80004cfc:	616d                	addi	sp,sp,240
    80004cfe:	8082                	ret

0000000080004d00 <sys_open>:

uint64
sys_open(void)
{
    80004d00:	7131                	addi	sp,sp,-192
    80004d02:	fd06                	sd	ra,184(sp)
    80004d04:	f922                	sd	s0,176(sp)
    80004d06:	f526                	sd	s1,168(sp)
    80004d08:	f14a                	sd	s2,160(sp)
    80004d0a:	ed4e                	sd	s3,152(sp)
    80004d0c:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80004d0e:	08000613          	li	a2,128
    80004d12:	f5040593          	addi	a1,s0,-176
    80004d16:	4501                	li	a0,0
    80004d18:	ffffd097          	auipc	ra,0xffffd
    80004d1c:	2fe080e7          	jalr	766(ra) # 80002016 <argstr>
    return -1;
    80004d20:	54fd                	li	s1,-1
  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80004d22:	0c054163          	bltz	a0,80004de4 <sys_open+0xe4>
    80004d26:	f4c40593          	addi	a1,s0,-180
    80004d2a:	4505                	li	a0,1
    80004d2c:	ffffd097          	auipc	ra,0xffffd
    80004d30:	2a6080e7          	jalr	678(ra) # 80001fd2 <argint>
    80004d34:	0a054863          	bltz	a0,80004de4 <sys_open+0xe4>

  begin_op();
    80004d38:	fffff097          	auipc	ra,0xfffff
    80004d3c:	a2e080e7          	jalr	-1490(ra) # 80003766 <begin_op>

  if(omode & O_CREATE){
    80004d40:	f4c42783          	lw	a5,-180(s0)
    80004d44:	2007f793          	andi	a5,a5,512
    80004d48:	cbdd                	beqz	a5,80004dfe <sys_open+0xfe>
    ip = create(path, T_FILE, 0, 0);
    80004d4a:	4681                	li	a3,0
    80004d4c:	4601                	li	a2,0
    80004d4e:	4589                	li	a1,2
    80004d50:	f5040513          	addi	a0,s0,-176
    80004d54:	00000097          	auipc	ra,0x0
    80004d58:	972080e7          	jalr	-1678(ra) # 800046c6 <create>
    80004d5c:	892a                	mv	s2,a0
    if(ip == 0){
    80004d5e:	c959                	beqz	a0,80004df4 <sys_open+0xf4>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80004d60:	04491703          	lh	a4,68(s2)
    80004d64:	478d                	li	a5,3
    80004d66:	00f71763          	bne	a4,a5,80004d74 <sys_open+0x74>
    80004d6a:	04695703          	lhu	a4,70(s2)
    80004d6e:	47a5                	li	a5,9
    80004d70:	0ce7ec63          	bltu	a5,a4,80004e48 <sys_open+0x148>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80004d74:	fffff097          	auipc	ra,0xfffff
    80004d78:	e02080e7          	jalr	-510(ra) # 80003b76 <filealloc>
    80004d7c:	89aa                	mv	s3,a0
    80004d7e:	10050263          	beqz	a0,80004e82 <sys_open+0x182>
    80004d82:	00000097          	auipc	ra,0x0
    80004d86:	902080e7          	jalr	-1790(ra) # 80004684 <fdalloc>
    80004d8a:	84aa                	mv	s1,a0
    80004d8c:	0e054663          	bltz	a0,80004e78 <sys_open+0x178>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80004d90:	04491703          	lh	a4,68(s2)
    80004d94:	478d                	li	a5,3
    80004d96:	0cf70463          	beq	a4,a5,80004e5e <sys_open+0x15e>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80004d9a:	4789                	li	a5,2
    80004d9c:	00f9a023          	sw	a5,0(s3)
    f->off = 0;
    80004da0:	0209a023          	sw	zero,32(s3)
  }
  f->ip = ip;
    80004da4:	0129bc23          	sd	s2,24(s3)
  f->readable = !(omode & O_WRONLY);
    80004da8:	f4c42783          	lw	a5,-180(s0)
    80004dac:	0017c713          	xori	a4,a5,1
    80004db0:	8b05                	andi	a4,a4,1
    80004db2:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80004db6:	0037f713          	andi	a4,a5,3
    80004dba:	00e03733          	snez	a4,a4
    80004dbe:	00e984a3          	sb	a4,9(s3)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80004dc2:	4007f793          	andi	a5,a5,1024
    80004dc6:	c791                	beqz	a5,80004dd2 <sys_open+0xd2>
    80004dc8:	04491703          	lh	a4,68(s2)
    80004dcc:	4789                	li	a5,2
    80004dce:	08f70f63          	beq	a4,a5,80004e6c <sys_open+0x16c>
    itrunc(ip);
  }

  iunlock(ip);
    80004dd2:	854a                	mv	a0,s2
    80004dd4:	ffffe097          	auipc	ra,0xffffe
    80004dd8:	efa080e7          	jalr	-262(ra) # 80002cce <iunlock>
  end_op();
    80004ddc:	fffff097          	auipc	ra,0xfffff
    80004de0:	a0a080e7          	jalr	-1526(ra) # 800037e6 <end_op>

  return fd;
}
    80004de4:	8526                	mv	a0,s1
    80004de6:	70ea                	ld	ra,184(sp)
    80004de8:	744a                	ld	s0,176(sp)
    80004dea:	74aa                	ld	s1,168(sp)
    80004dec:	790a                	ld	s2,160(sp)
    80004dee:	69ea                	ld	s3,152(sp)
    80004df0:	6129                	addi	sp,sp,192
    80004df2:	8082                	ret
      end_op();
    80004df4:	fffff097          	auipc	ra,0xfffff
    80004df8:	9f2080e7          	jalr	-1550(ra) # 800037e6 <end_op>
      return -1;
    80004dfc:	b7e5                	j	80004de4 <sys_open+0xe4>
    if((ip = namei(path)) == 0){
    80004dfe:	f5040513          	addi	a0,s0,-176
    80004e02:	ffffe097          	auipc	ra,0xffffe
    80004e06:	5b6080e7          	jalr	1462(ra) # 800033b8 <namei>
    80004e0a:	892a                	mv	s2,a0
    80004e0c:	c905                	beqz	a0,80004e3c <sys_open+0x13c>
    ilock(ip);
    80004e0e:	ffffe097          	auipc	ra,0xffffe
    80004e12:	dfe080e7          	jalr	-514(ra) # 80002c0c <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80004e16:	04491703          	lh	a4,68(s2)
    80004e1a:	4785                	li	a5,1
    80004e1c:	f4f712e3          	bne	a4,a5,80004d60 <sys_open+0x60>
    80004e20:	f4c42783          	lw	a5,-180(s0)
    80004e24:	dba1                	beqz	a5,80004d74 <sys_open+0x74>
      iunlockput(ip);
    80004e26:	854a                	mv	a0,s2
    80004e28:	ffffe097          	auipc	ra,0xffffe
    80004e2c:	046080e7          	jalr	70(ra) # 80002e6e <iunlockput>
      end_op();
    80004e30:	fffff097          	auipc	ra,0xfffff
    80004e34:	9b6080e7          	jalr	-1610(ra) # 800037e6 <end_op>
      return -1;
    80004e38:	54fd                	li	s1,-1
    80004e3a:	b76d                	j	80004de4 <sys_open+0xe4>
      end_op();
    80004e3c:	fffff097          	auipc	ra,0xfffff
    80004e40:	9aa080e7          	jalr	-1622(ra) # 800037e6 <end_op>
      return -1;
    80004e44:	54fd                	li	s1,-1
    80004e46:	bf79                	j	80004de4 <sys_open+0xe4>
    iunlockput(ip);
    80004e48:	854a                	mv	a0,s2
    80004e4a:	ffffe097          	auipc	ra,0xffffe
    80004e4e:	024080e7          	jalr	36(ra) # 80002e6e <iunlockput>
    end_op();
    80004e52:	fffff097          	auipc	ra,0xfffff
    80004e56:	994080e7          	jalr	-1644(ra) # 800037e6 <end_op>
    return -1;
    80004e5a:	54fd                	li	s1,-1
    80004e5c:	b761                	j	80004de4 <sys_open+0xe4>
    f->type = FD_DEVICE;
    80004e5e:	00f9a023          	sw	a5,0(s3)
    f->major = ip->major;
    80004e62:	04691783          	lh	a5,70(s2)
    80004e66:	02f99223          	sh	a5,36(s3)
    80004e6a:	bf2d                	j	80004da4 <sys_open+0xa4>
    itrunc(ip);
    80004e6c:	854a                	mv	a0,s2
    80004e6e:	ffffe097          	auipc	ra,0xffffe
    80004e72:	eac080e7          	jalr	-340(ra) # 80002d1a <itrunc>
    80004e76:	bfb1                	j	80004dd2 <sys_open+0xd2>
      fileclose(f);
    80004e78:	854e                	mv	a0,s3
    80004e7a:	fffff097          	auipc	ra,0xfffff
    80004e7e:	db8080e7          	jalr	-584(ra) # 80003c32 <fileclose>
    iunlockput(ip);
    80004e82:	854a                	mv	a0,s2
    80004e84:	ffffe097          	auipc	ra,0xffffe
    80004e88:	fea080e7          	jalr	-22(ra) # 80002e6e <iunlockput>
    end_op();
    80004e8c:	fffff097          	auipc	ra,0xfffff
    80004e90:	95a080e7          	jalr	-1702(ra) # 800037e6 <end_op>
    return -1;
    80004e94:	54fd                	li	s1,-1
    80004e96:	b7b9                	j	80004de4 <sys_open+0xe4>

0000000080004e98 <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80004e98:	7175                	addi	sp,sp,-144
    80004e9a:	e506                	sd	ra,136(sp)
    80004e9c:	e122                	sd	s0,128(sp)
    80004e9e:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80004ea0:	fffff097          	auipc	ra,0xfffff
    80004ea4:	8c6080e7          	jalr	-1850(ra) # 80003766 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80004ea8:	08000613          	li	a2,128
    80004eac:	f7040593          	addi	a1,s0,-144
    80004eb0:	4501                	li	a0,0
    80004eb2:	ffffd097          	auipc	ra,0xffffd
    80004eb6:	164080e7          	jalr	356(ra) # 80002016 <argstr>
    80004eba:	02054963          	bltz	a0,80004eec <sys_mkdir+0x54>
    80004ebe:	4681                	li	a3,0
    80004ec0:	4601                	li	a2,0
    80004ec2:	4585                	li	a1,1
    80004ec4:	f7040513          	addi	a0,s0,-144
    80004ec8:	fffff097          	auipc	ra,0xfffff
    80004ecc:	7fe080e7          	jalr	2046(ra) # 800046c6 <create>
    80004ed0:	cd11                	beqz	a0,80004eec <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004ed2:	ffffe097          	auipc	ra,0xffffe
    80004ed6:	f9c080e7          	jalr	-100(ra) # 80002e6e <iunlockput>
  end_op();
    80004eda:	fffff097          	auipc	ra,0xfffff
    80004ede:	90c080e7          	jalr	-1780(ra) # 800037e6 <end_op>
  return 0;
    80004ee2:	4501                	li	a0,0
}
    80004ee4:	60aa                	ld	ra,136(sp)
    80004ee6:	640a                	ld	s0,128(sp)
    80004ee8:	6149                	addi	sp,sp,144
    80004eea:	8082                	ret
    end_op();
    80004eec:	fffff097          	auipc	ra,0xfffff
    80004ef0:	8fa080e7          	jalr	-1798(ra) # 800037e6 <end_op>
    return -1;
    80004ef4:	557d                	li	a0,-1
    80004ef6:	b7fd                	j	80004ee4 <sys_mkdir+0x4c>

0000000080004ef8 <sys_mknod>:

uint64
sys_mknod(void)
{
    80004ef8:	7135                	addi	sp,sp,-160
    80004efa:	ed06                	sd	ra,152(sp)
    80004efc:	e922                	sd	s0,144(sp)
    80004efe:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80004f00:	fffff097          	auipc	ra,0xfffff
    80004f04:	866080e7          	jalr	-1946(ra) # 80003766 <begin_op>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004f08:	08000613          	li	a2,128
    80004f0c:	f7040593          	addi	a1,s0,-144
    80004f10:	4501                	li	a0,0
    80004f12:	ffffd097          	auipc	ra,0xffffd
    80004f16:	104080e7          	jalr	260(ra) # 80002016 <argstr>
    80004f1a:	04054a63          	bltz	a0,80004f6e <sys_mknod+0x76>
     argint(1, &major) < 0 ||
    80004f1e:	f6c40593          	addi	a1,s0,-148
    80004f22:	4505                	li	a0,1
    80004f24:	ffffd097          	auipc	ra,0xffffd
    80004f28:	0ae080e7          	jalr	174(ra) # 80001fd2 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004f2c:	04054163          	bltz	a0,80004f6e <sys_mknod+0x76>
     argint(2, &minor) < 0 ||
    80004f30:	f6840593          	addi	a1,s0,-152
    80004f34:	4509                	li	a0,2
    80004f36:	ffffd097          	auipc	ra,0xffffd
    80004f3a:	09c080e7          	jalr	156(ra) # 80001fd2 <argint>
     argint(1, &major) < 0 ||
    80004f3e:	02054863          	bltz	a0,80004f6e <sys_mknod+0x76>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80004f42:	f6841683          	lh	a3,-152(s0)
    80004f46:	f6c41603          	lh	a2,-148(s0)
    80004f4a:	458d                	li	a1,3
    80004f4c:	f7040513          	addi	a0,s0,-144
    80004f50:	fffff097          	auipc	ra,0xfffff
    80004f54:	776080e7          	jalr	1910(ra) # 800046c6 <create>
     argint(2, &minor) < 0 ||
    80004f58:	c919                	beqz	a0,80004f6e <sys_mknod+0x76>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004f5a:	ffffe097          	auipc	ra,0xffffe
    80004f5e:	f14080e7          	jalr	-236(ra) # 80002e6e <iunlockput>
  end_op();
    80004f62:	fffff097          	auipc	ra,0xfffff
    80004f66:	884080e7          	jalr	-1916(ra) # 800037e6 <end_op>
  return 0;
    80004f6a:	4501                	li	a0,0
    80004f6c:	a031                	j	80004f78 <sys_mknod+0x80>
    end_op();
    80004f6e:	fffff097          	auipc	ra,0xfffff
    80004f72:	878080e7          	jalr	-1928(ra) # 800037e6 <end_op>
    return -1;
    80004f76:	557d                	li	a0,-1
}
    80004f78:	60ea                	ld	ra,152(sp)
    80004f7a:	644a                	ld	s0,144(sp)
    80004f7c:	610d                	addi	sp,sp,160
    80004f7e:	8082                	ret

0000000080004f80 <sys_chdir>:

uint64
sys_chdir(void)
{
    80004f80:	7135                	addi	sp,sp,-160
    80004f82:	ed06                	sd	ra,152(sp)
    80004f84:	e922                	sd	s0,144(sp)
    80004f86:	e526                	sd	s1,136(sp)
    80004f88:	e14a                	sd	s2,128(sp)
    80004f8a:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80004f8c:	ffffc097          	auipc	ra,0xffffc
    80004f90:	f9a080e7          	jalr	-102(ra) # 80000f26 <myproc>
    80004f94:	892a                	mv	s2,a0
  
  begin_op();
    80004f96:	ffffe097          	auipc	ra,0xffffe
    80004f9a:	7d0080e7          	jalr	2000(ra) # 80003766 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80004f9e:	08000613          	li	a2,128
    80004fa2:	f6040593          	addi	a1,s0,-160
    80004fa6:	4501                	li	a0,0
    80004fa8:	ffffd097          	auipc	ra,0xffffd
    80004fac:	06e080e7          	jalr	110(ra) # 80002016 <argstr>
    80004fb0:	04054b63          	bltz	a0,80005006 <sys_chdir+0x86>
    80004fb4:	f6040513          	addi	a0,s0,-160
    80004fb8:	ffffe097          	auipc	ra,0xffffe
    80004fbc:	400080e7          	jalr	1024(ra) # 800033b8 <namei>
    80004fc0:	84aa                	mv	s1,a0
    80004fc2:	c131                	beqz	a0,80005006 <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    80004fc4:	ffffe097          	auipc	ra,0xffffe
    80004fc8:	c48080e7          	jalr	-952(ra) # 80002c0c <ilock>
  if(ip->type != T_DIR){
    80004fcc:	04449703          	lh	a4,68(s1)
    80004fd0:	4785                	li	a5,1
    80004fd2:	04f71063          	bne	a4,a5,80005012 <sys_chdir+0x92>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80004fd6:	8526                	mv	a0,s1
    80004fd8:	ffffe097          	auipc	ra,0xffffe
    80004fdc:	cf6080e7          	jalr	-778(ra) # 80002cce <iunlock>
  iput(p->cwd);
    80004fe0:	15093503          	ld	a0,336(s2)
    80004fe4:	ffffe097          	auipc	ra,0xffffe
    80004fe8:	de2080e7          	jalr	-542(ra) # 80002dc6 <iput>
  end_op();
    80004fec:	ffffe097          	auipc	ra,0xffffe
    80004ff0:	7fa080e7          	jalr	2042(ra) # 800037e6 <end_op>
  p->cwd = ip;
    80004ff4:	14993823          	sd	s1,336(s2)
  return 0;
    80004ff8:	4501                	li	a0,0
}
    80004ffa:	60ea                	ld	ra,152(sp)
    80004ffc:	644a                	ld	s0,144(sp)
    80004ffe:	64aa                	ld	s1,136(sp)
    80005000:	690a                	ld	s2,128(sp)
    80005002:	610d                	addi	sp,sp,160
    80005004:	8082                	ret
    end_op();
    80005006:	ffffe097          	auipc	ra,0xffffe
    8000500a:	7e0080e7          	jalr	2016(ra) # 800037e6 <end_op>
    return -1;
    8000500e:	557d                	li	a0,-1
    80005010:	b7ed                	j	80004ffa <sys_chdir+0x7a>
    iunlockput(ip);
    80005012:	8526                	mv	a0,s1
    80005014:	ffffe097          	auipc	ra,0xffffe
    80005018:	e5a080e7          	jalr	-422(ra) # 80002e6e <iunlockput>
    end_op();
    8000501c:	ffffe097          	auipc	ra,0xffffe
    80005020:	7ca080e7          	jalr	1994(ra) # 800037e6 <end_op>
    return -1;
    80005024:	557d                	li	a0,-1
    80005026:	bfd1                	j	80004ffa <sys_chdir+0x7a>

0000000080005028 <sys_exec>:

uint64
sys_exec(void)
{
    80005028:	7145                	addi	sp,sp,-464
    8000502a:	e786                	sd	ra,456(sp)
    8000502c:	e3a2                	sd	s0,448(sp)
    8000502e:	ff26                	sd	s1,440(sp)
    80005030:	fb4a                	sd	s2,432(sp)
    80005032:	f74e                	sd	s3,424(sp)
    80005034:	f352                	sd	s4,416(sp)
    80005036:	ef56                	sd	s5,408(sp)
    80005038:	0b80                	addi	s0,sp,464
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    8000503a:	08000613          	li	a2,128
    8000503e:	f4040593          	addi	a1,s0,-192
    80005042:	4501                	li	a0,0
    80005044:	ffffd097          	auipc	ra,0xffffd
    80005048:	fd2080e7          	jalr	-46(ra) # 80002016 <argstr>
    return -1;
    8000504c:	597d                	li	s2,-1
  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    8000504e:	0c054a63          	bltz	a0,80005122 <sys_exec+0xfa>
    80005052:	e3840593          	addi	a1,s0,-456
    80005056:	4505                	li	a0,1
    80005058:	ffffd097          	auipc	ra,0xffffd
    8000505c:	f9c080e7          	jalr	-100(ra) # 80001ff4 <argaddr>
    80005060:	0c054163          	bltz	a0,80005122 <sys_exec+0xfa>
  }
  memset(argv, 0, sizeof(argv));
    80005064:	10000613          	li	a2,256
    80005068:	4581                	li	a1,0
    8000506a:	e4040513          	addi	a0,s0,-448
    8000506e:	ffffb097          	auipc	ra,0xffffb
    80005072:	10a080e7          	jalr	266(ra) # 80000178 <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    80005076:	e4040493          	addi	s1,s0,-448
  memset(argv, 0, sizeof(argv));
    8000507a:	89a6                	mv	s3,s1
    8000507c:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    8000507e:	02000a13          	li	s4,32
    80005082:	00090a9b          	sext.w	s5,s2
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80005086:	00391513          	slli	a0,s2,0x3
    8000508a:	e3040593          	addi	a1,s0,-464
    8000508e:	e3843783          	ld	a5,-456(s0)
    80005092:	953e                	add	a0,a0,a5
    80005094:	ffffd097          	auipc	ra,0xffffd
    80005098:	ea4080e7          	jalr	-348(ra) # 80001f38 <fetchaddr>
    8000509c:	02054a63          	bltz	a0,800050d0 <sys_exec+0xa8>
      goto bad;
    }
    if(uarg == 0){
    800050a0:	e3043783          	ld	a5,-464(s0)
    800050a4:	c3b9                	beqz	a5,800050ea <sys_exec+0xc2>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    800050a6:	ffffb097          	auipc	ra,0xffffb
    800050aa:	072080e7          	jalr	114(ra) # 80000118 <kalloc>
    800050ae:	85aa                	mv	a1,a0
    800050b0:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    800050b4:	cd11                	beqz	a0,800050d0 <sys_exec+0xa8>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    800050b6:	6605                	lui	a2,0x1
    800050b8:	e3043503          	ld	a0,-464(s0)
    800050bc:	ffffd097          	auipc	ra,0xffffd
    800050c0:	ece080e7          	jalr	-306(ra) # 80001f8a <fetchstr>
    800050c4:	00054663          	bltz	a0,800050d0 <sys_exec+0xa8>
    if(i >= NELEM(argv)){
    800050c8:	0905                	addi	s2,s2,1
    800050ca:	09a1                	addi	s3,s3,8
    800050cc:	fb491be3          	bne	s2,s4,80005082 <sys_exec+0x5a>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800050d0:	10048913          	addi	s2,s1,256
    800050d4:	6088                	ld	a0,0(s1)
    800050d6:	c529                	beqz	a0,80005120 <sys_exec+0xf8>
    kfree(argv[i]);
    800050d8:	ffffb097          	auipc	ra,0xffffb
    800050dc:	f44080e7          	jalr	-188(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    800050e0:	04a1                	addi	s1,s1,8
    800050e2:	ff2499e3          	bne	s1,s2,800050d4 <sys_exec+0xac>
  return -1;
    800050e6:	597d                	li	s2,-1
    800050e8:	a82d                	j	80005122 <sys_exec+0xfa>
      argv[i] = 0;
    800050ea:	0a8e                	slli	s5,s5,0x3
    800050ec:	fc040793          	addi	a5,s0,-64
    800050f0:	9abe                	add	s5,s5,a5
    800050f2:	e80ab023          	sd	zero,-384(s5)
  int ret = exec(path, argv);
    800050f6:	e4040593          	addi	a1,s0,-448
    800050fa:	f4040513          	addi	a0,s0,-192
    800050fe:	fffff097          	auipc	ra,0xfffff
    80005102:	194080e7          	jalr	404(ra) # 80004292 <exec>
    80005106:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005108:	10048993          	addi	s3,s1,256
    8000510c:	6088                	ld	a0,0(s1)
    8000510e:	c911                	beqz	a0,80005122 <sys_exec+0xfa>
    kfree(argv[i]);
    80005110:	ffffb097          	auipc	ra,0xffffb
    80005114:	f0c080e7          	jalr	-244(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005118:	04a1                	addi	s1,s1,8
    8000511a:	ff3499e3          	bne	s1,s3,8000510c <sys_exec+0xe4>
    8000511e:	a011                	j	80005122 <sys_exec+0xfa>
  return -1;
    80005120:	597d                	li	s2,-1
}
    80005122:	854a                	mv	a0,s2
    80005124:	60be                	ld	ra,456(sp)
    80005126:	641e                	ld	s0,448(sp)
    80005128:	74fa                	ld	s1,440(sp)
    8000512a:	795a                	ld	s2,432(sp)
    8000512c:	79ba                	ld	s3,424(sp)
    8000512e:	7a1a                	ld	s4,416(sp)
    80005130:	6afa                	ld	s5,408(sp)
    80005132:	6179                	addi	sp,sp,464
    80005134:	8082                	ret

0000000080005136 <sys_pipe>:

uint64
sys_pipe(void)
{
    80005136:	7139                	addi	sp,sp,-64
    80005138:	fc06                	sd	ra,56(sp)
    8000513a:	f822                	sd	s0,48(sp)
    8000513c:	f426                	sd	s1,40(sp)
    8000513e:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80005140:	ffffc097          	auipc	ra,0xffffc
    80005144:	de6080e7          	jalr	-538(ra) # 80000f26 <myproc>
    80005148:	84aa                	mv	s1,a0

  if(argaddr(0, &fdarray) < 0)
    8000514a:	fd840593          	addi	a1,s0,-40
    8000514e:	4501                	li	a0,0
    80005150:	ffffd097          	auipc	ra,0xffffd
    80005154:	ea4080e7          	jalr	-348(ra) # 80001ff4 <argaddr>
    return -1;
    80005158:	57fd                	li	a5,-1
  if(argaddr(0, &fdarray) < 0)
    8000515a:	0e054063          	bltz	a0,8000523a <sys_pipe+0x104>
  if(pipealloc(&rf, &wf) < 0)
    8000515e:	fc840593          	addi	a1,s0,-56
    80005162:	fd040513          	addi	a0,s0,-48
    80005166:	fffff097          	auipc	ra,0xfffff
    8000516a:	dfc080e7          	jalr	-516(ra) # 80003f62 <pipealloc>
    return -1;
    8000516e:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    80005170:	0c054563          	bltz	a0,8000523a <sys_pipe+0x104>
  fd0 = -1;
    80005174:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80005178:	fd043503          	ld	a0,-48(s0)
    8000517c:	fffff097          	auipc	ra,0xfffff
    80005180:	508080e7          	jalr	1288(ra) # 80004684 <fdalloc>
    80005184:	fca42223          	sw	a0,-60(s0)
    80005188:	08054c63          	bltz	a0,80005220 <sys_pipe+0xea>
    8000518c:	fc843503          	ld	a0,-56(s0)
    80005190:	fffff097          	auipc	ra,0xfffff
    80005194:	4f4080e7          	jalr	1268(ra) # 80004684 <fdalloc>
    80005198:	fca42023          	sw	a0,-64(s0)
    8000519c:	06054863          	bltz	a0,8000520c <sys_pipe+0xd6>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    800051a0:	4691                	li	a3,4
    800051a2:	fc440613          	addi	a2,s0,-60
    800051a6:	fd843583          	ld	a1,-40(s0)
    800051aa:	68a8                	ld	a0,80(s1)
    800051ac:	ffffc097          	auipc	ra,0xffffc
    800051b0:	956080e7          	jalr	-1706(ra) # 80000b02 <copyout>
    800051b4:	02054063          	bltz	a0,800051d4 <sys_pipe+0x9e>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    800051b8:	4691                	li	a3,4
    800051ba:	fc040613          	addi	a2,s0,-64
    800051be:	fd843583          	ld	a1,-40(s0)
    800051c2:	0591                	addi	a1,a1,4
    800051c4:	68a8                	ld	a0,80(s1)
    800051c6:	ffffc097          	auipc	ra,0xffffc
    800051ca:	93c080e7          	jalr	-1732(ra) # 80000b02 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    800051ce:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    800051d0:	06055563          	bgez	a0,8000523a <sys_pipe+0x104>
    p->ofile[fd0] = 0;
    800051d4:	fc442783          	lw	a5,-60(s0)
    800051d8:	07e9                	addi	a5,a5,26
    800051da:	078e                	slli	a5,a5,0x3
    800051dc:	97a6                	add	a5,a5,s1
    800051de:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    800051e2:	fc042503          	lw	a0,-64(s0)
    800051e6:	0569                	addi	a0,a0,26
    800051e8:	050e                	slli	a0,a0,0x3
    800051ea:	9526                	add	a0,a0,s1
    800051ec:	00053023          	sd	zero,0(a0)
    fileclose(rf);
    800051f0:	fd043503          	ld	a0,-48(s0)
    800051f4:	fffff097          	auipc	ra,0xfffff
    800051f8:	a3e080e7          	jalr	-1474(ra) # 80003c32 <fileclose>
    fileclose(wf);
    800051fc:	fc843503          	ld	a0,-56(s0)
    80005200:	fffff097          	auipc	ra,0xfffff
    80005204:	a32080e7          	jalr	-1486(ra) # 80003c32 <fileclose>
    return -1;
    80005208:	57fd                	li	a5,-1
    8000520a:	a805                	j	8000523a <sys_pipe+0x104>
    if(fd0 >= 0)
    8000520c:	fc442783          	lw	a5,-60(s0)
    80005210:	0007c863          	bltz	a5,80005220 <sys_pipe+0xea>
      p->ofile[fd0] = 0;
    80005214:	01a78513          	addi	a0,a5,26
    80005218:	050e                	slli	a0,a0,0x3
    8000521a:	9526                	add	a0,a0,s1
    8000521c:	00053023          	sd	zero,0(a0)
    fileclose(rf);
    80005220:	fd043503          	ld	a0,-48(s0)
    80005224:	fffff097          	auipc	ra,0xfffff
    80005228:	a0e080e7          	jalr	-1522(ra) # 80003c32 <fileclose>
    fileclose(wf);
    8000522c:	fc843503          	ld	a0,-56(s0)
    80005230:	fffff097          	auipc	ra,0xfffff
    80005234:	a02080e7          	jalr	-1534(ra) # 80003c32 <fileclose>
    return -1;
    80005238:	57fd                	li	a5,-1
}
    8000523a:	853e                	mv	a0,a5
    8000523c:	70e2                	ld	ra,56(sp)
    8000523e:	7442                	ld	s0,48(sp)
    80005240:	74a2                	ld	s1,40(sp)
    80005242:	6121                	addi	sp,sp,64
    80005244:	8082                	ret
	...

0000000080005250 <kernelvec>:
    80005250:	7111                	addi	sp,sp,-256
    80005252:	e006                	sd	ra,0(sp)
    80005254:	e40a                	sd	sp,8(sp)
    80005256:	e80e                	sd	gp,16(sp)
    80005258:	ec12                	sd	tp,24(sp)
    8000525a:	f016                	sd	t0,32(sp)
    8000525c:	f41a                	sd	t1,40(sp)
    8000525e:	f81e                	sd	t2,48(sp)
    80005260:	fc22                	sd	s0,56(sp)
    80005262:	e0a6                	sd	s1,64(sp)
    80005264:	e4aa                	sd	a0,72(sp)
    80005266:	e8ae                	sd	a1,80(sp)
    80005268:	ecb2                	sd	a2,88(sp)
    8000526a:	f0b6                	sd	a3,96(sp)
    8000526c:	f4ba                	sd	a4,104(sp)
    8000526e:	f8be                	sd	a5,112(sp)
    80005270:	fcc2                	sd	a6,120(sp)
    80005272:	e146                	sd	a7,128(sp)
    80005274:	e54a                	sd	s2,136(sp)
    80005276:	e94e                	sd	s3,144(sp)
    80005278:	ed52                	sd	s4,152(sp)
    8000527a:	f156                	sd	s5,160(sp)
    8000527c:	f55a                	sd	s6,168(sp)
    8000527e:	f95e                	sd	s7,176(sp)
    80005280:	fd62                	sd	s8,184(sp)
    80005282:	e1e6                	sd	s9,192(sp)
    80005284:	e5ea                	sd	s10,200(sp)
    80005286:	e9ee                	sd	s11,208(sp)
    80005288:	edf2                	sd	t3,216(sp)
    8000528a:	f1f6                	sd	t4,224(sp)
    8000528c:	f5fa                	sd	t5,232(sp)
    8000528e:	f9fe                	sd	t6,240(sp)
    80005290:	b75fc0ef          	jal	ra,80001e04 <kerneltrap>
    80005294:	6082                	ld	ra,0(sp)
    80005296:	6122                	ld	sp,8(sp)
    80005298:	61c2                	ld	gp,16(sp)
    8000529a:	7282                	ld	t0,32(sp)
    8000529c:	7322                	ld	t1,40(sp)
    8000529e:	73c2                	ld	t2,48(sp)
    800052a0:	7462                	ld	s0,56(sp)
    800052a2:	6486                	ld	s1,64(sp)
    800052a4:	6526                	ld	a0,72(sp)
    800052a6:	65c6                	ld	a1,80(sp)
    800052a8:	6666                	ld	a2,88(sp)
    800052aa:	7686                	ld	a3,96(sp)
    800052ac:	7726                	ld	a4,104(sp)
    800052ae:	77c6                	ld	a5,112(sp)
    800052b0:	7866                	ld	a6,120(sp)
    800052b2:	688a                	ld	a7,128(sp)
    800052b4:	692a                	ld	s2,136(sp)
    800052b6:	69ca                	ld	s3,144(sp)
    800052b8:	6a6a                	ld	s4,152(sp)
    800052ba:	7a8a                	ld	s5,160(sp)
    800052bc:	7b2a                	ld	s6,168(sp)
    800052be:	7bca                	ld	s7,176(sp)
    800052c0:	7c6a                	ld	s8,184(sp)
    800052c2:	6c8e                	ld	s9,192(sp)
    800052c4:	6d2e                	ld	s10,200(sp)
    800052c6:	6dce                	ld	s11,208(sp)
    800052c8:	6e6e                	ld	t3,216(sp)
    800052ca:	7e8e                	ld	t4,224(sp)
    800052cc:	7f2e                	ld	t5,232(sp)
    800052ce:	7fce                	ld	t6,240(sp)
    800052d0:	6111                	addi	sp,sp,256
    800052d2:	10200073          	sret
    800052d6:	00000013          	nop
    800052da:	00000013          	nop
    800052de:	0001                	nop

00000000800052e0 <timervec>:
    800052e0:	34051573          	csrrw	a0,mscratch,a0
    800052e4:	e10c                	sd	a1,0(a0)
    800052e6:	e510                	sd	a2,8(a0)
    800052e8:	e914                	sd	a3,16(a0)
    800052ea:	6d0c                	ld	a1,24(a0)
    800052ec:	7110                	ld	a2,32(a0)
    800052ee:	6194                	ld	a3,0(a1)
    800052f0:	96b2                	add	a3,a3,a2
    800052f2:	e194                	sd	a3,0(a1)
    800052f4:	4589                	li	a1,2
    800052f6:	14459073          	csrw	sip,a1
    800052fa:	6914                	ld	a3,16(a0)
    800052fc:	6510                	ld	a2,8(a0)
    800052fe:	610c                	ld	a1,0(a0)
    80005300:	34051573          	csrrw	a0,mscratch,a0
    80005304:	30200073          	mret
	...

000000008000530a <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    8000530a:	1141                	addi	sp,sp,-16
    8000530c:	e422                	sd	s0,8(sp)
    8000530e:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80005310:	0c0007b7          	lui	a5,0xc000
    80005314:	4705                	li	a4,1
    80005316:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80005318:	c3d8                	sw	a4,4(a5)
}
    8000531a:	6422                	ld	s0,8(sp)
    8000531c:	0141                	addi	sp,sp,16
    8000531e:	8082                	ret

0000000080005320 <plicinithart>:

void
plicinithart(void)
{
    80005320:	1141                	addi	sp,sp,-16
    80005322:	e406                	sd	ra,8(sp)
    80005324:	e022                	sd	s0,0(sp)
    80005326:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005328:	ffffc097          	auipc	ra,0xffffc
    8000532c:	bd2080e7          	jalr	-1070(ra) # 80000efa <cpuid>
  
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80005330:	0085171b          	slliw	a4,a0,0x8
    80005334:	0c0027b7          	lui	a5,0xc002
    80005338:	97ba                	add	a5,a5,a4
    8000533a:	40200713          	li	a4,1026
    8000533e:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80005342:	00d5151b          	slliw	a0,a0,0xd
    80005346:	0c2017b7          	lui	a5,0xc201
    8000534a:	953e                	add	a0,a0,a5
    8000534c:	00052023          	sw	zero,0(a0)
}
    80005350:	60a2                	ld	ra,8(sp)
    80005352:	6402                	ld	s0,0(sp)
    80005354:	0141                	addi	sp,sp,16
    80005356:	8082                	ret

0000000080005358 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80005358:	1141                	addi	sp,sp,-16
    8000535a:	e406                	sd	ra,8(sp)
    8000535c:	e022                	sd	s0,0(sp)
    8000535e:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005360:	ffffc097          	auipc	ra,0xffffc
    80005364:	b9a080e7          	jalr	-1126(ra) # 80000efa <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80005368:	00d5179b          	slliw	a5,a0,0xd
    8000536c:	0c201537          	lui	a0,0xc201
    80005370:	953e                	add	a0,a0,a5
  return irq;
}
    80005372:	4148                	lw	a0,4(a0)
    80005374:	60a2                	ld	ra,8(sp)
    80005376:	6402                	ld	s0,0(sp)
    80005378:	0141                	addi	sp,sp,16
    8000537a:	8082                	ret

000000008000537c <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    8000537c:	1101                	addi	sp,sp,-32
    8000537e:	ec06                	sd	ra,24(sp)
    80005380:	e822                	sd	s0,16(sp)
    80005382:	e426                	sd	s1,8(sp)
    80005384:	1000                	addi	s0,sp,32
    80005386:	84aa                	mv	s1,a0
  int hart = cpuid();
    80005388:	ffffc097          	auipc	ra,0xffffc
    8000538c:	b72080e7          	jalr	-1166(ra) # 80000efa <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80005390:	00d5151b          	slliw	a0,a0,0xd
    80005394:	0c2017b7          	lui	a5,0xc201
    80005398:	97aa                	add	a5,a5,a0
    8000539a:	c3c4                	sw	s1,4(a5)
}
    8000539c:	60e2                	ld	ra,24(sp)
    8000539e:	6442                	ld	s0,16(sp)
    800053a0:	64a2                	ld	s1,8(sp)
    800053a2:	6105                	addi	sp,sp,32
    800053a4:	8082                	ret

00000000800053a6 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    800053a6:	1141                	addi	sp,sp,-16
    800053a8:	e406                	sd	ra,8(sp)
    800053aa:	e022                	sd	s0,0(sp)
    800053ac:	0800                	addi	s0,sp,16
  if(i >= NUM)
    800053ae:	479d                	li	a5,7
    800053b0:	06a7c963          	blt	a5,a0,80005422 <free_desc+0x7c>
    panic("free_desc 1");
  if(disk.free[i])
    800053b4:	00016797          	auipc	a5,0x16
    800053b8:	c4c78793          	addi	a5,a5,-948 # 8001b000 <disk>
    800053bc:	00a78733          	add	a4,a5,a0
    800053c0:	6789                	lui	a5,0x2
    800053c2:	97ba                	add	a5,a5,a4
    800053c4:	0187c783          	lbu	a5,24(a5) # 2018 <_entry-0x7fffdfe8>
    800053c8:	e7ad                	bnez	a5,80005432 <free_desc+0x8c>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    800053ca:	00451793          	slli	a5,a0,0x4
    800053ce:	00018717          	auipc	a4,0x18
    800053d2:	c3270713          	addi	a4,a4,-974 # 8001d000 <disk+0x2000>
    800053d6:	6314                	ld	a3,0(a4)
    800053d8:	96be                	add	a3,a3,a5
    800053da:	0006b023          	sd	zero,0(a3)
  disk.desc[i].len = 0;
    800053de:	6314                	ld	a3,0(a4)
    800053e0:	96be                	add	a3,a3,a5
    800053e2:	0006a423          	sw	zero,8(a3)
  disk.desc[i].flags = 0;
    800053e6:	6314                	ld	a3,0(a4)
    800053e8:	96be                	add	a3,a3,a5
    800053ea:	00069623          	sh	zero,12(a3)
  disk.desc[i].next = 0;
    800053ee:	6318                	ld	a4,0(a4)
    800053f0:	97ba                	add	a5,a5,a4
    800053f2:	00079723          	sh	zero,14(a5)
  disk.free[i] = 1;
    800053f6:	00016797          	auipc	a5,0x16
    800053fa:	c0a78793          	addi	a5,a5,-1014 # 8001b000 <disk>
    800053fe:	97aa                	add	a5,a5,a0
    80005400:	6509                	lui	a0,0x2
    80005402:	953e                	add	a0,a0,a5
    80005404:	4785                	li	a5,1
    80005406:	00f50c23          	sb	a5,24(a0) # 2018 <_entry-0x7fffdfe8>
  wakeup(&disk.free[0]);
    8000540a:	00018517          	auipc	a0,0x18
    8000540e:	c0e50513          	addi	a0,a0,-1010 # 8001d018 <disk+0x2018>
    80005412:	ffffc097          	auipc	ra,0xffffc
    80005416:	35c080e7          	jalr	860(ra) # 8000176e <wakeup>
}
    8000541a:	60a2                	ld	ra,8(sp)
    8000541c:	6402                	ld	s0,0(sp)
    8000541e:	0141                	addi	sp,sp,16
    80005420:	8082                	ret
    panic("free_desc 1");
    80005422:	00003517          	auipc	a0,0x3
    80005426:	3a650513          	addi	a0,a0,934 # 800087c8 <syscalls+0x410>
    8000542a:	00001097          	auipc	ra,0x1
    8000542e:	b1e080e7          	jalr	-1250(ra) # 80005f48 <panic>
    panic("free_desc 2");
    80005432:	00003517          	auipc	a0,0x3
    80005436:	3a650513          	addi	a0,a0,934 # 800087d8 <syscalls+0x420>
    8000543a:	00001097          	auipc	ra,0x1
    8000543e:	b0e080e7          	jalr	-1266(ra) # 80005f48 <panic>

0000000080005442 <virtio_disk_init>:
{
    80005442:	1101                	addi	sp,sp,-32
    80005444:	ec06                	sd	ra,24(sp)
    80005446:	e822                	sd	s0,16(sp)
    80005448:	e426                	sd	s1,8(sp)
    8000544a:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    8000544c:	00003597          	auipc	a1,0x3
    80005450:	39c58593          	addi	a1,a1,924 # 800087e8 <syscalls+0x430>
    80005454:	00018517          	auipc	a0,0x18
    80005458:	cd450513          	addi	a0,a0,-812 # 8001d128 <disk+0x2128>
    8000545c:	00001097          	auipc	ra,0x1
    80005460:	fa6080e7          	jalr	-90(ra) # 80006402 <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005464:	100017b7          	lui	a5,0x10001
    80005468:	4398                	lw	a4,0(a5)
    8000546a:	2701                	sext.w	a4,a4
    8000546c:	747277b7          	lui	a5,0x74727
    80005470:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80005474:	0ef71163          	bne	a4,a5,80005556 <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    80005478:	100017b7          	lui	a5,0x10001
    8000547c:	43dc                	lw	a5,4(a5)
    8000547e:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005480:	4705                	li	a4,1
    80005482:	0ce79a63          	bne	a5,a4,80005556 <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005486:	100017b7          	lui	a5,0x10001
    8000548a:	479c                	lw	a5,8(a5)
    8000548c:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    8000548e:	4709                	li	a4,2
    80005490:	0ce79363          	bne	a5,a4,80005556 <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80005494:	100017b7          	lui	a5,0x10001
    80005498:	47d8                	lw	a4,12(a5)
    8000549a:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    8000549c:	554d47b7          	lui	a5,0x554d4
    800054a0:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    800054a4:	0af71963          	bne	a4,a5,80005556 <virtio_disk_init+0x114>
  *R(VIRTIO_MMIO_STATUS) = status;
    800054a8:	100017b7          	lui	a5,0x10001
    800054ac:	4705                	li	a4,1
    800054ae:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    800054b0:	470d                	li	a4,3
    800054b2:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    800054b4:	4b94                	lw	a3,16(a5)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    800054b6:	c7ffe737          	lui	a4,0xc7ffe
    800054ba:	75f70713          	addi	a4,a4,1887 # ffffffffc7ffe75f <end+0xffffffff47fd851f>
    800054be:	8f75                	and	a4,a4,a3
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    800054c0:	2701                	sext.w	a4,a4
    800054c2:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    800054c4:	472d                	li	a4,11
    800054c6:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    800054c8:	473d                	li	a4,15
    800054ca:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PGSIZE;
    800054cc:	6705                	lui	a4,0x1
    800054ce:	d798                	sw	a4,40(a5)
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    800054d0:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    800054d4:	5bdc                	lw	a5,52(a5)
    800054d6:	2781                	sext.w	a5,a5
  if(max == 0)
    800054d8:	c7d9                	beqz	a5,80005566 <virtio_disk_init+0x124>
  if(max < NUM)
    800054da:	471d                	li	a4,7
    800054dc:	08f77d63          	bgeu	a4,a5,80005576 <virtio_disk_init+0x134>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    800054e0:	100014b7          	lui	s1,0x10001
    800054e4:	47a1                	li	a5,8
    800054e6:	dc9c                	sw	a5,56(s1)
  memset(disk.pages, 0, sizeof(disk.pages));
    800054e8:	6609                	lui	a2,0x2
    800054ea:	4581                	li	a1,0
    800054ec:	00016517          	auipc	a0,0x16
    800054f0:	b1450513          	addi	a0,a0,-1260 # 8001b000 <disk>
    800054f4:	ffffb097          	auipc	ra,0xffffb
    800054f8:	c84080e7          	jalr	-892(ra) # 80000178 <memset>
  *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64)disk.pages) >> PGSHIFT;
    800054fc:	00016717          	auipc	a4,0x16
    80005500:	b0470713          	addi	a4,a4,-1276 # 8001b000 <disk>
    80005504:	00c75793          	srli	a5,a4,0xc
    80005508:	2781                	sext.w	a5,a5
    8000550a:	c0bc                	sw	a5,64(s1)
  disk.desc = (struct virtq_desc *) disk.pages;
    8000550c:	00018797          	auipc	a5,0x18
    80005510:	af478793          	addi	a5,a5,-1292 # 8001d000 <disk+0x2000>
    80005514:	e398                	sd	a4,0(a5)
  disk.avail = (struct virtq_avail *)(disk.pages + NUM*sizeof(struct virtq_desc));
    80005516:	00016717          	auipc	a4,0x16
    8000551a:	b6a70713          	addi	a4,a4,-1174 # 8001b080 <disk+0x80>
    8000551e:	e798                	sd	a4,8(a5)
  disk.used = (struct virtq_used *) (disk.pages + PGSIZE);
    80005520:	00017717          	auipc	a4,0x17
    80005524:	ae070713          	addi	a4,a4,-1312 # 8001c000 <disk+0x1000>
    80005528:	eb98                	sd	a4,16(a5)
    disk.free[i] = 1;
    8000552a:	4705                	li	a4,1
    8000552c:	00e78c23          	sb	a4,24(a5)
    80005530:	00e78ca3          	sb	a4,25(a5)
    80005534:	00e78d23          	sb	a4,26(a5)
    80005538:	00e78da3          	sb	a4,27(a5)
    8000553c:	00e78e23          	sb	a4,28(a5)
    80005540:	00e78ea3          	sb	a4,29(a5)
    80005544:	00e78f23          	sb	a4,30(a5)
    80005548:	00e78fa3          	sb	a4,31(a5)
}
    8000554c:	60e2                	ld	ra,24(sp)
    8000554e:	6442                	ld	s0,16(sp)
    80005550:	64a2                	ld	s1,8(sp)
    80005552:	6105                	addi	sp,sp,32
    80005554:	8082                	ret
    panic("could not find virtio disk");
    80005556:	00003517          	auipc	a0,0x3
    8000555a:	2a250513          	addi	a0,a0,674 # 800087f8 <syscalls+0x440>
    8000555e:	00001097          	auipc	ra,0x1
    80005562:	9ea080e7          	jalr	-1558(ra) # 80005f48 <panic>
    panic("virtio disk has no queue 0");
    80005566:	00003517          	auipc	a0,0x3
    8000556a:	2b250513          	addi	a0,a0,690 # 80008818 <syscalls+0x460>
    8000556e:	00001097          	auipc	ra,0x1
    80005572:	9da080e7          	jalr	-1574(ra) # 80005f48 <panic>
    panic("virtio disk max queue too short");
    80005576:	00003517          	auipc	a0,0x3
    8000557a:	2c250513          	addi	a0,a0,706 # 80008838 <syscalls+0x480>
    8000557e:	00001097          	auipc	ra,0x1
    80005582:	9ca080e7          	jalr	-1590(ra) # 80005f48 <panic>

0000000080005586 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    80005586:	7159                	addi	sp,sp,-112
    80005588:	f486                	sd	ra,104(sp)
    8000558a:	f0a2                	sd	s0,96(sp)
    8000558c:	eca6                	sd	s1,88(sp)
    8000558e:	e8ca                	sd	s2,80(sp)
    80005590:	e4ce                	sd	s3,72(sp)
    80005592:	e0d2                	sd	s4,64(sp)
    80005594:	fc56                	sd	s5,56(sp)
    80005596:	f85a                	sd	s6,48(sp)
    80005598:	f45e                	sd	s7,40(sp)
    8000559a:	f062                	sd	s8,32(sp)
    8000559c:	ec66                	sd	s9,24(sp)
    8000559e:	e86a                	sd	s10,16(sp)
    800055a0:	1880                	addi	s0,sp,112
    800055a2:	892a                	mv	s2,a0
    800055a4:	8d2e                	mv	s10,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    800055a6:	00c52c83          	lw	s9,12(a0)
    800055aa:	001c9c9b          	slliw	s9,s9,0x1
    800055ae:	1c82                	slli	s9,s9,0x20
    800055b0:	020cdc93          	srli	s9,s9,0x20

  acquire(&disk.vdisk_lock);
    800055b4:	00018517          	auipc	a0,0x18
    800055b8:	b7450513          	addi	a0,a0,-1164 # 8001d128 <disk+0x2128>
    800055bc:	00001097          	auipc	ra,0x1
    800055c0:	ed6080e7          	jalr	-298(ra) # 80006492 <acquire>
  for(int i = 0; i < 3; i++){
    800055c4:	4981                	li	s3,0
  for(int i = 0; i < NUM; i++){
    800055c6:	4c21                	li	s8,8
      disk.free[i] = 0;
    800055c8:	00016b97          	auipc	s7,0x16
    800055cc:	a38b8b93          	addi	s7,s7,-1480 # 8001b000 <disk>
    800055d0:	6b09                	lui	s6,0x2
  for(int i = 0; i < 3; i++){
    800055d2:	4a8d                	li	s5,3
  for(int i = 0; i < NUM; i++){
    800055d4:	8a4e                	mv	s4,s3
    800055d6:	a051                	j	8000565a <virtio_disk_rw+0xd4>
      disk.free[i] = 0;
    800055d8:	00fb86b3          	add	a3,s7,a5
    800055dc:	96da                	add	a3,a3,s6
    800055de:	00068c23          	sb	zero,24(a3)
    idx[i] = alloc_desc();
    800055e2:	c21c                	sw	a5,0(a2)
    if(idx[i] < 0){
    800055e4:	0207c563          	bltz	a5,8000560e <virtio_disk_rw+0x88>
  for(int i = 0; i < 3; i++){
    800055e8:	2485                	addiw	s1,s1,1
    800055ea:	0711                	addi	a4,a4,4
    800055ec:	25548063          	beq	s1,s5,8000582c <virtio_disk_rw+0x2a6>
    idx[i] = alloc_desc();
    800055f0:	863a                	mv	a2,a4
  for(int i = 0; i < NUM; i++){
    800055f2:	00018697          	auipc	a3,0x18
    800055f6:	a2668693          	addi	a3,a3,-1498 # 8001d018 <disk+0x2018>
    800055fa:	87d2                	mv	a5,s4
    if(disk.free[i]){
    800055fc:	0006c583          	lbu	a1,0(a3)
    80005600:	fde1                	bnez	a1,800055d8 <virtio_disk_rw+0x52>
  for(int i = 0; i < NUM; i++){
    80005602:	2785                	addiw	a5,a5,1
    80005604:	0685                	addi	a3,a3,1
    80005606:	ff879be3          	bne	a5,s8,800055fc <virtio_disk_rw+0x76>
    idx[i] = alloc_desc();
    8000560a:	57fd                	li	a5,-1
    8000560c:	c21c                	sw	a5,0(a2)
      for(int j = 0; j < i; j++)
    8000560e:	02905a63          	blez	s1,80005642 <virtio_disk_rw+0xbc>
        free_desc(idx[j]);
    80005612:	f9042503          	lw	a0,-112(s0)
    80005616:	00000097          	auipc	ra,0x0
    8000561a:	d90080e7          	jalr	-624(ra) # 800053a6 <free_desc>
      for(int j = 0; j < i; j++)
    8000561e:	4785                	li	a5,1
    80005620:	0297d163          	bge	a5,s1,80005642 <virtio_disk_rw+0xbc>
        free_desc(idx[j]);
    80005624:	f9442503          	lw	a0,-108(s0)
    80005628:	00000097          	auipc	ra,0x0
    8000562c:	d7e080e7          	jalr	-642(ra) # 800053a6 <free_desc>
      for(int j = 0; j < i; j++)
    80005630:	4789                	li	a5,2
    80005632:	0097d863          	bge	a5,s1,80005642 <virtio_disk_rw+0xbc>
        free_desc(idx[j]);
    80005636:	f9842503          	lw	a0,-104(s0)
    8000563a:	00000097          	auipc	ra,0x0
    8000563e:	d6c080e7          	jalr	-660(ra) # 800053a6 <free_desc>
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    80005642:	00018597          	auipc	a1,0x18
    80005646:	ae658593          	addi	a1,a1,-1306 # 8001d128 <disk+0x2128>
    8000564a:	00018517          	auipc	a0,0x18
    8000564e:	9ce50513          	addi	a0,a0,-1586 # 8001d018 <disk+0x2018>
    80005652:	ffffc097          	auipc	ra,0xffffc
    80005656:	f90080e7          	jalr	-112(ra) # 800015e2 <sleep>
  for(int i = 0; i < 3; i++){
    8000565a:	f9040713          	addi	a4,s0,-112
    8000565e:	84ce                	mv	s1,s3
    80005660:	bf41                	j	800055f0 <virtio_disk_rw+0x6a>
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];

  if(write)
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
    80005662:	20058713          	addi	a4,a1,512
    80005666:	00471693          	slli	a3,a4,0x4
    8000566a:	00016717          	auipc	a4,0x16
    8000566e:	99670713          	addi	a4,a4,-1642 # 8001b000 <disk>
    80005672:	9736                	add	a4,a4,a3
    80005674:	4685                	li	a3,1
    80005676:	0ad72423          	sw	a3,168(a4)
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
  buf0->reserved = 0;
    8000567a:	20058713          	addi	a4,a1,512
    8000567e:	00471693          	slli	a3,a4,0x4
    80005682:	00016717          	auipc	a4,0x16
    80005686:	97e70713          	addi	a4,a4,-1666 # 8001b000 <disk>
    8000568a:	9736                	add	a4,a4,a3
    8000568c:	0a072623          	sw	zero,172(a4)
  buf0->sector = sector;
    80005690:	0b973823          	sd	s9,176(a4)

  disk.desc[idx[0]].addr = (uint64) buf0;
    80005694:	7679                	lui	a2,0xffffe
    80005696:	963e                	add	a2,a2,a5
    80005698:	00018697          	auipc	a3,0x18
    8000569c:	96868693          	addi	a3,a3,-1688 # 8001d000 <disk+0x2000>
    800056a0:	6298                	ld	a4,0(a3)
    800056a2:	9732                	add	a4,a4,a2
    800056a4:	e308                	sd	a0,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    800056a6:	6298                	ld	a4,0(a3)
    800056a8:	9732                	add	a4,a4,a2
    800056aa:	4541                	li	a0,16
    800056ac:	c708                	sw	a0,8(a4)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    800056ae:	6298                	ld	a4,0(a3)
    800056b0:	9732                	add	a4,a4,a2
    800056b2:	4505                	li	a0,1
    800056b4:	00a71623          	sh	a0,12(a4)
  disk.desc[idx[0]].next = idx[1];
    800056b8:	f9442703          	lw	a4,-108(s0)
    800056bc:	6288                	ld	a0,0(a3)
    800056be:	962a                	add	a2,a2,a0
    800056c0:	00e61723          	sh	a4,14(a2) # ffffffffffffe00e <end+0xffffffff7ffd7dce>

  disk.desc[idx[1]].addr = (uint64) b->data;
    800056c4:	0712                	slli	a4,a4,0x4
    800056c6:	6290                	ld	a2,0(a3)
    800056c8:	963a                	add	a2,a2,a4
    800056ca:	05890513          	addi	a0,s2,88
    800056ce:	e208                	sd	a0,0(a2)
  disk.desc[idx[1]].len = BSIZE;
    800056d0:	6294                	ld	a3,0(a3)
    800056d2:	96ba                	add	a3,a3,a4
    800056d4:	40000613          	li	a2,1024
    800056d8:	c690                	sw	a2,8(a3)
  if(write)
    800056da:	140d0063          	beqz	s10,8000581a <virtio_disk_rw+0x294>
    disk.desc[idx[1]].flags = 0; // device reads b->data
    800056de:	00018697          	auipc	a3,0x18
    800056e2:	9226b683          	ld	a3,-1758(a3) # 8001d000 <disk+0x2000>
    800056e6:	96ba                	add	a3,a3,a4
    800056e8:	00069623          	sh	zero,12(a3)
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    800056ec:	00016817          	auipc	a6,0x16
    800056f0:	91480813          	addi	a6,a6,-1772 # 8001b000 <disk>
    800056f4:	00018517          	auipc	a0,0x18
    800056f8:	90c50513          	addi	a0,a0,-1780 # 8001d000 <disk+0x2000>
    800056fc:	6114                	ld	a3,0(a0)
    800056fe:	96ba                	add	a3,a3,a4
    80005700:	00c6d603          	lhu	a2,12(a3)
    80005704:	00166613          	ori	a2,a2,1
    80005708:	00c69623          	sh	a2,12(a3)
  disk.desc[idx[1]].next = idx[2];
    8000570c:	f9842683          	lw	a3,-104(s0)
    80005710:	6110                	ld	a2,0(a0)
    80005712:	9732                	add	a4,a4,a2
    80005714:	00d71723          	sh	a3,14(a4)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80005718:	20058613          	addi	a2,a1,512
    8000571c:	0612                	slli	a2,a2,0x4
    8000571e:	9642                	add	a2,a2,a6
    80005720:	577d                	li	a4,-1
    80005722:	02e60823          	sb	a4,48(a2)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    80005726:	00469713          	slli	a4,a3,0x4
    8000572a:	6114                	ld	a3,0(a0)
    8000572c:	96ba                	add	a3,a3,a4
    8000572e:	03078793          	addi	a5,a5,48
    80005732:	97c2                	add	a5,a5,a6
    80005734:	e29c                	sd	a5,0(a3)
  disk.desc[idx[2]].len = 1;
    80005736:	611c                	ld	a5,0(a0)
    80005738:	97ba                	add	a5,a5,a4
    8000573a:	4685                	li	a3,1
    8000573c:	c794                	sw	a3,8(a5)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    8000573e:	611c                	ld	a5,0(a0)
    80005740:	97ba                	add	a5,a5,a4
    80005742:	4809                	li	a6,2
    80005744:	01079623          	sh	a6,12(a5)
  disk.desc[idx[2]].next = 0;
    80005748:	611c                	ld	a5,0(a0)
    8000574a:	973e                	add	a4,a4,a5
    8000574c:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    80005750:	00d92223          	sw	a3,4(s2)
  disk.info[idx[0]].b = b;
    80005754:	03263423          	sd	s2,40(a2)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80005758:	6518                	ld	a4,8(a0)
    8000575a:	00275783          	lhu	a5,2(a4)
    8000575e:	8b9d                	andi	a5,a5,7
    80005760:	0786                	slli	a5,a5,0x1
    80005762:	97ba                	add	a5,a5,a4
    80005764:	00b79223          	sh	a1,4(a5)

  __sync_synchronize();
    80005768:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    8000576c:	6518                	ld	a4,8(a0)
    8000576e:	00275783          	lhu	a5,2(a4)
    80005772:	2785                	addiw	a5,a5,1
    80005774:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    80005778:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    8000577c:	100017b7          	lui	a5,0x10001
    80005780:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80005784:	00492703          	lw	a4,4(s2)
    80005788:	4785                	li	a5,1
    8000578a:	02f71163          	bne	a4,a5,800057ac <virtio_disk_rw+0x226>
    sleep(b, &disk.vdisk_lock);
    8000578e:	00018997          	auipc	s3,0x18
    80005792:	99a98993          	addi	s3,s3,-1638 # 8001d128 <disk+0x2128>
  while(b->disk == 1) {
    80005796:	4485                	li	s1,1
    sleep(b, &disk.vdisk_lock);
    80005798:	85ce                	mv	a1,s3
    8000579a:	854a                	mv	a0,s2
    8000579c:	ffffc097          	auipc	ra,0xffffc
    800057a0:	e46080e7          	jalr	-442(ra) # 800015e2 <sleep>
  while(b->disk == 1) {
    800057a4:	00492783          	lw	a5,4(s2)
    800057a8:	fe9788e3          	beq	a5,s1,80005798 <virtio_disk_rw+0x212>
  }

  disk.info[idx[0]].b = 0;
    800057ac:	f9042903          	lw	s2,-112(s0)
    800057b0:	20090793          	addi	a5,s2,512
    800057b4:	00479713          	slli	a4,a5,0x4
    800057b8:	00016797          	auipc	a5,0x16
    800057bc:	84878793          	addi	a5,a5,-1976 # 8001b000 <disk>
    800057c0:	97ba                	add	a5,a5,a4
    800057c2:	0207b423          	sd	zero,40(a5)
    int flag = disk.desc[i].flags;
    800057c6:	00018997          	auipc	s3,0x18
    800057ca:	83a98993          	addi	s3,s3,-1990 # 8001d000 <disk+0x2000>
    800057ce:	00491713          	slli	a4,s2,0x4
    800057d2:	0009b783          	ld	a5,0(s3)
    800057d6:	97ba                	add	a5,a5,a4
    800057d8:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    800057dc:	854a                	mv	a0,s2
    800057de:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    800057e2:	00000097          	auipc	ra,0x0
    800057e6:	bc4080e7          	jalr	-1084(ra) # 800053a6 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    800057ea:	8885                	andi	s1,s1,1
    800057ec:	f0ed                	bnez	s1,800057ce <virtio_disk_rw+0x248>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    800057ee:	00018517          	auipc	a0,0x18
    800057f2:	93a50513          	addi	a0,a0,-1734 # 8001d128 <disk+0x2128>
    800057f6:	00001097          	auipc	ra,0x1
    800057fa:	d50080e7          	jalr	-688(ra) # 80006546 <release>
}
    800057fe:	70a6                	ld	ra,104(sp)
    80005800:	7406                	ld	s0,96(sp)
    80005802:	64e6                	ld	s1,88(sp)
    80005804:	6946                	ld	s2,80(sp)
    80005806:	69a6                	ld	s3,72(sp)
    80005808:	6a06                	ld	s4,64(sp)
    8000580a:	7ae2                	ld	s5,56(sp)
    8000580c:	7b42                	ld	s6,48(sp)
    8000580e:	7ba2                	ld	s7,40(sp)
    80005810:	7c02                	ld	s8,32(sp)
    80005812:	6ce2                	ld	s9,24(sp)
    80005814:	6d42                	ld	s10,16(sp)
    80005816:	6165                	addi	sp,sp,112
    80005818:	8082                	ret
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    8000581a:	00017697          	auipc	a3,0x17
    8000581e:	7e66b683          	ld	a3,2022(a3) # 8001d000 <disk+0x2000>
    80005822:	96ba                	add	a3,a3,a4
    80005824:	4609                	li	a2,2
    80005826:	00c69623          	sh	a2,12(a3)
    8000582a:	b5c9                	j	800056ec <virtio_disk_rw+0x166>
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    8000582c:	f9042583          	lw	a1,-112(s0)
    80005830:	20058793          	addi	a5,a1,512
    80005834:	0792                	slli	a5,a5,0x4
    80005836:	00016517          	auipc	a0,0x16
    8000583a:	87250513          	addi	a0,a0,-1934 # 8001b0a8 <disk+0xa8>
    8000583e:	953e                	add	a0,a0,a5
  if(write)
    80005840:	e20d11e3          	bnez	s10,80005662 <virtio_disk_rw+0xdc>
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
    80005844:	20058713          	addi	a4,a1,512
    80005848:	00471693          	slli	a3,a4,0x4
    8000584c:	00015717          	auipc	a4,0x15
    80005850:	7b470713          	addi	a4,a4,1972 # 8001b000 <disk>
    80005854:	9736                	add	a4,a4,a3
    80005856:	0a072423          	sw	zero,168(a4)
    8000585a:	b505                	j	8000567a <virtio_disk_rw+0xf4>

000000008000585c <virtio_disk_intr>:

void
virtio_disk_intr()
{
    8000585c:	1101                	addi	sp,sp,-32
    8000585e:	ec06                	sd	ra,24(sp)
    80005860:	e822                	sd	s0,16(sp)
    80005862:	e426                	sd	s1,8(sp)
    80005864:	e04a                	sd	s2,0(sp)
    80005866:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    80005868:	00018517          	auipc	a0,0x18
    8000586c:	8c050513          	addi	a0,a0,-1856 # 8001d128 <disk+0x2128>
    80005870:	00001097          	auipc	ra,0x1
    80005874:	c22080e7          	jalr	-990(ra) # 80006492 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80005878:	10001737          	lui	a4,0x10001
    8000587c:	533c                	lw	a5,96(a4)
    8000587e:	8b8d                	andi	a5,a5,3
    80005880:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    80005882:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80005886:	00017797          	auipc	a5,0x17
    8000588a:	77a78793          	addi	a5,a5,1914 # 8001d000 <disk+0x2000>
    8000588e:	6b94                	ld	a3,16(a5)
    80005890:	0207d703          	lhu	a4,32(a5)
    80005894:	0026d783          	lhu	a5,2(a3)
    80005898:	06f70163          	beq	a4,a5,800058fa <virtio_disk_intr+0x9e>
    __sync_synchronize();
    int id = disk.used->ring[disk.used_idx % NUM].id;
    8000589c:	00015917          	auipc	s2,0x15
    800058a0:	76490913          	addi	s2,s2,1892 # 8001b000 <disk>
    800058a4:	00017497          	auipc	s1,0x17
    800058a8:	75c48493          	addi	s1,s1,1884 # 8001d000 <disk+0x2000>
    __sync_synchronize();
    800058ac:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    800058b0:	6898                	ld	a4,16(s1)
    800058b2:	0204d783          	lhu	a5,32(s1)
    800058b6:	8b9d                	andi	a5,a5,7
    800058b8:	078e                	slli	a5,a5,0x3
    800058ba:	97ba                	add	a5,a5,a4
    800058bc:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    800058be:	20078713          	addi	a4,a5,512
    800058c2:	0712                	slli	a4,a4,0x4
    800058c4:	974a                	add	a4,a4,s2
    800058c6:	03074703          	lbu	a4,48(a4) # 10001030 <_entry-0x6fffefd0>
    800058ca:	e731                	bnez	a4,80005916 <virtio_disk_intr+0xba>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    800058cc:	20078793          	addi	a5,a5,512
    800058d0:	0792                	slli	a5,a5,0x4
    800058d2:	97ca                	add	a5,a5,s2
    800058d4:	7788                	ld	a0,40(a5)
    b->disk = 0;   // disk is done with buf
    800058d6:	00052223          	sw	zero,4(a0)
    wakeup(b);
    800058da:	ffffc097          	auipc	ra,0xffffc
    800058de:	e94080e7          	jalr	-364(ra) # 8000176e <wakeup>

    disk.used_idx += 1;
    800058e2:	0204d783          	lhu	a5,32(s1)
    800058e6:	2785                	addiw	a5,a5,1
    800058e8:	17c2                	slli	a5,a5,0x30
    800058ea:	93c1                	srli	a5,a5,0x30
    800058ec:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    800058f0:	6898                	ld	a4,16(s1)
    800058f2:	00275703          	lhu	a4,2(a4)
    800058f6:	faf71be3          	bne	a4,a5,800058ac <virtio_disk_intr+0x50>
  }

  release(&disk.vdisk_lock);
    800058fa:	00018517          	auipc	a0,0x18
    800058fe:	82e50513          	addi	a0,a0,-2002 # 8001d128 <disk+0x2128>
    80005902:	00001097          	auipc	ra,0x1
    80005906:	c44080e7          	jalr	-956(ra) # 80006546 <release>
}
    8000590a:	60e2                	ld	ra,24(sp)
    8000590c:	6442                	ld	s0,16(sp)
    8000590e:	64a2                	ld	s1,8(sp)
    80005910:	6902                	ld	s2,0(sp)
    80005912:	6105                	addi	sp,sp,32
    80005914:	8082                	ret
      panic("virtio_disk_intr status");
    80005916:	00003517          	auipc	a0,0x3
    8000591a:	f4250513          	addi	a0,a0,-190 # 80008858 <syscalls+0x4a0>
    8000591e:	00000097          	auipc	ra,0x0
    80005922:	62a080e7          	jalr	1578(ra) # 80005f48 <panic>

0000000080005926 <swap_page_from_pte>:
/* NTU OS 2024 */
/* Allocate eight consecutive disk blocks. */
/* Save the content of the physical page in the pte */
/* to the disk blocks and save the block-id into the */
/* pte. */
char *swap_page_from_pte(pte_t *pte) {
    80005926:	7179                	addi	sp,sp,-48
    80005928:	f406                	sd	ra,40(sp)
    8000592a:	f022                	sd	s0,32(sp)
    8000592c:	ec26                	sd	s1,24(sp)
    8000592e:	e84a                	sd	s2,16(sp)
    80005930:	e44e                	sd	s3,8(sp)
    80005932:	1800                	addi	s0,sp,48
    80005934:	89aa                	mv	s3,a0
  char *pa = (char*) PTE2PA(*pte);
    80005936:	00053903          	ld	s2,0(a0)
    8000593a:	00a95913          	srli	s2,s2,0xa
    8000593e:	0932                	slli	s2,s2,0xc
  uint dp = balloc_page(ROOTDEV);
    80005940:	4505                	li	a0,1
    80005942:	ffffe097          	auipc	ra,0xffffe
    80005946:	ab0080e7          	jalr	-1360(ra) # 800033f2 <balloc_page>
    8000594a:	0005049b          	sext.w	s1,a0

  write_page_to_disk(ROOTDEV, pa, dp); // write this page to disk
    8000594e:	8626                	mv	a2,s1
    80005950:	85ca                	mv	a1,s2
    80005952:	4505                	li	a0,1
    80005954:	ffffd097          	auipc	ra,0xffffd
    80005958:	c60080e7          	jalr	-928(ra) # 800025b4 <write_page_to_disk>
  *pte = (BLOCKNO2PTE(dp) | PTE_FLAGS(*pte) | PTE_S) & ~PTE_V;
    8000595c:	0009b783          	ld	a5,0(s3)
    80005960:	00a4949b          	slliw	s1,s1,0xa
    80005964:	1482                	slli	s1,s1,0x20
    80005966:	9081                	srli	s1,s1,0x20
    80005968:	1fe7f793          	andi	a5,a5,510
    8000596c:	8cdd                	or	s1,s1,a5
    8000596e:	2004e493          	ori	s1,s1,512
    80005972:	0099b023          	sd	s1,0(s3)

  return pa;
}
    80005976:	854a                	mv	a0,s2
    80005978:	70a2                	ld	ra,40(sp)
    8000597a:	7402                	ld	s0,32(sp)
    8000597c:	64e2                	ld	s1,24(sp)
    8000597e:	6942                	ld	s2,16(sp)
    80005980:	69a2                	ld	s3,8(sp)
    80005982:	6145                	addi	sp,sp,48
    80005984:	8082                	ret

0000000080005986 <handle_pgfault>:

/* NTU OS 2024 */
/* Page fault handler */
int handle_pgfault() {
    80005986:	1141                	addi	sp,sp,-16
    80005988:	e406                	sd	ra,8(sp)
    8000598a:	e022                	sd	s0,0(sp)
    8000598c:	0800                	addi	s0,sp,16
  /* Find the address that caused the fault */
  /* uint64 va = r_stval(); */

  /* TODO */
  panic("not implemented yet\n");
    8000598e:	00003517          	auipc	a0,0x3
    80005992:	ee250513          	addi	a0,a0,-286 # 80008870 <syscalls+0x4b8>
    80005996:	00000097          	auipc	ra,0x0
    8000599a:	5b2080e7          	jalr	1458(ra) # 80005f48 <panic>

000000008000599e <sys_vmprint>:

/* NTU OS 2024 */
/* Entry of vmprint() syscall. */
uint64
sys_vmprint(void)
{
    8000599e:	1141                	addi	sp,sp,-16
    800059a0:	e406                	sd	ra,8(sp)
    800059a2:	e022                	sd	s0,0(sp)
    800059a4:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    800059a6:	ffffb097          	auipc	ra,0xffffb
    800059aa:	580080e7          	jalr	1408(ra) # 80000f26 <myproc>
  vmprint(p->pagetable);
    800059ae:	6928                	ld	a0,80(a0)
    800059b0:	ffffb097          	auipc	ra,0xffffb
    800059b4:	3e6080e7          	jalr	998(ra) # 80000d96 <vmprint>
  return 0;
}
    800059b8:	4501                	li	a0,0
    800059ba:	60a2                	ld	ra,8(sp)
    800059bc:	6402                	ld	s0,0(sp)
    800059be:	0141                	addi	sp,sp,16
    800059c0:	8082                	ret

00000000800059c2 <sys_madvise>:

/* NTU OS 2024 */
/* Entry of madvise() syscall. */
uint64
sys_madvise(void)
{
    800059c2:	1101                	addi	sp,sp,-32
    800059c4:	ec06                	sd	ra,24(sp)
    800059c6:	e822                	sd	s0,16(sp)
    800059c8:	1000                	addi	s0,sp,32

  uint64 addr;
  int length;
  int advise;

  if (argaddr(0, &addr) < 0) return -1;
    800059ca:	fe840593          	addi	a1,s0,-24
    800059ce:	4501                	li	a0,0
    800059d0:	ffffc097          	auipc	ra,0xffffc
    800059d4:	624080e7          	jalr	1572(ra) # 80001ff4 <argaddr>
    800059d8:	57fd                	li	a5,-1
    800059da:	04054163          	bltz	a0,80005a1c <sys_madvise+0x5a>
  if (argint(1, &length) < 0) return -1;
    800059de:	fe440593          	addi	a1,s0,-28
    800059e2:	4505                	li	a0,1
    800059e4:	ffffc097          	auipc	ra,0xffffc
    800059e8:	5ee080e7          	jalr	1518(ra) # 80001fd2 <argint>
    800059ec:	57fd                	li	a5,-1
    800059ee:	02054763          	bltz	a0,80005a1c <sys_madvise+0x5a>
  if (argint(2, &advise) < 0) return -1;
    800059f2:	fe040593          	addi	a1,s0,-32
    800059f6:	4509                	li	a0,2
    800059f8:	ffffc097          	auipc	ra,0xffffc
    800059fc:	5da080e7          	jalr	1498(ra) # 80001fd2 <argint>
    80005a00:	57fd                	li	a5,-1
    80005a02:	00054d63          	bltz	a0,80005a1c <sys_madvise+0x5a>

  int ret = madvise(addr, length, advise);
    80005a06:	fe042603          	lw	a2,-32(s0)
    80005a0a:	fe442583          	lw	a1,-28(s0)
    80005a0e:	fe843503          	ld	a0,-24(s0)
    80005a12:	ffffb097          	auipc	ra,0xffffb
    80005a16:	2bc080e7          	jalr	700(ra) # 80000cce <madvise>
  return ret;
    80005a1a:	87aa                	mv	a5,a0
}
    80005a1c:	853e                	mv	a0,a5
    80005a1e:	60e2                	ld	ra,24(sp)
    80005a20:	6442                	ld	s0,16(sp)
    80005a22:	6105                	addi	sp,sp,32
    80005a24:	8082                	ret

0000000080005a26 <timerinit>:
// which arrive at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    80005a26:	1141                	addi	sp,sp,-16
    80005a28:	e422                	sd	s0,8(sp)
    80005a2a:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80005a2c:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    80005a30:	0007869b          	sext.w	a3,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    80005a34:	0037979b          	slliw	a5,a5,0x3
    80005a38:	02004737          	lui	a4,0x2004
    80005a3c:	97ba                	add	a5,a5,a4
    80005a3e:	0200c737          	lui	a4,0x200c
    80005a42:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80005a46:	000f4637          	lui	a2,0xf4
    80005a4a:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80005a4e:	95b2                	add	a1,a1,a2
    80005a50:	e38c                	sd	a1,0(a5)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    80005a52:	00269713          	slli	a4,a3,0x2
    80005a56:	9736                	add	a4,a4,a3
    80005a58:	00371693          	slli	a3,a4,0x3
    80005a5c:	00018717          	auipc	a4,0x18
    80005a60:	5a470713          	addi	a4,a4,1444 # 8001e000 <timer_scratch>
    80005a64:	9736                	add	a4,a4,a3
  scratch[3] = CLINT_MTIMECMP(id);
    80005a66:	ef1c                	sd	a5,24(a4)
  scratch[4] = interval;
    80005a68:	f310                	sd	a2,32(a4)
  asm volatile("csrw mscratch, %0" : : "r" (x));
    80005a6a:	34071073          	csrw	mscratch,a4
  asm volatile("csrw mtvec, %0" : : "r" (x));
    80005a6e:	00000797          	auipc	a5,0x0
    80005a72:	87278793          	addi	a5,a5,-1934 # 800052e0 <timervec>
    80005a76:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80005a7a:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    80005a7e:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005a82:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    80005a86:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    80005a8a:	0807e793          	ori	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    80005a8e:	30479073          	csrw	mie,a5
}
    80005a92:	6422                	ld	s0,8(sp)
    80005a94:	0141                	addi	sp,sp,16
    80005a96:	8082                	ret

0000000080005a98 <start>:
{
    80005a98:	1141                	addi	sp,sp,-16
    80005a9a:	e406                	sd	ra,8(sp)
    80005a9c:	e022                	sd	s0,0(sp)
    80005a9e:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80005aa0:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80005aa4:	7779                	lui	a4,0xffffe
    80005aa6:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffd85bf>
    80005aaa:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    80005aac:	6705                	lui	a4,0x1
    80005aae:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80005ab2:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005ab4:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    80005ab8:	ffffb797          	auipc	a5,0xffffb
    80005abc:	86e78793          	addi	a5,a5,-1938 # 80000326 <main>
    80005ac0:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    80005ac4:	4781                	li	a5,0
    80005ac6:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    80005aca:	67c1                	lui	a5,0x10
    80005acc:	17fd                	addi	a5,a5,-1
    80005ace:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80005ad2:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    80005ad6:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    80005ada:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    80005ade:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    80005ae2:	57fd                	li	a5,-1
    80005ae4:	83a9                	srli	a5,a5,0xa
    80005ae6:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    80005aea:	47bd                	li	a5,15
    80005aec:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    80005af0:	00000097          	auipc	ra,0x0
    80005af4:	f36080e7          	jalr	-202(ra) # 80005a26 <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80005af8:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    80005afc:	2781                	sext.w	a5,a5
  asm volatile("mv tp, %0" : : "r" (x));
    80005afe:	823e                	mv	tp,a5
  asm volatile("mret");
    80005b00:	30200073          	mret
}
    80005b04:	60a2                	ld	ra,8(sp)
    80005b06:	6402                	ld	s0,0(sp)
    80005b08:	0141                	addi	sp,sp,16
    80005b0a:	8082                	ret

0000000080005b0c <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80005b0c:	715d                	addi	sp,sp,-80
    80005b0e:	e486                	sd	ra,72(sp)
    80005b10:	e0a2                	sd	s0,64(sp)
    80005b12:	fc26                	sd	s1,56(sp)
    80005b14:	f84a                	sd	s2,48(sp)
    80005b16:	f44e                	sd	s3,40(sp)
    80005b18:	f052                	sd	s4,32(sp)
    80005b1a:	ec56                	sd	s5,24(sp)
    80005b1c:	0880                	addi	s0,sp,80
  int i;

  for(i = 0; i < n; i++){
    80005b1e:	04c05663          	blez	a2,80005b6a <consolewrite+0x5e>
    80005b22:	8a2a                	mv	s4,a0
    80005b24:	84ae                	mv	s1,a1
    80005b26:	89b2                	mv	s3,a2
    80005b28:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    80005b2a:	5afd                	li	s5,-1
    80005b2c:	4685                	li	a3,1
    80005b2e:	8626                	mv	a2,s1
    80005b30:	85d2                	mv	a1,s4
    80005b32:	fbf40513          	addi	a0,s0,-65
    80005b36:	ffffc097          	auipc	ra,0xffffc
    80005b3a:	ea6080e7          	jalr	-346(ra) # 800019dc <either_copyin>
    80005b3e:	01550c63          	beq	a0,s5,80005b56 <consolewrite+0x4a>
      break;
    uartputc(c);
    80005b42:	fbf44503          	lbu	a0,-65(s0)
    80005b46:	00000097          	auipc	ra,0x0
    80005b4a:	78e080e7          	jalr	1934(ra) # 800062d4 <uartputc>
  for(i = 0; i < n; i++){
    80005b4e:	2905                	addiw	s2,s2,1
    80005b50:	0485                	addi	s1,s1,1
    80005b52:	fd299de3          	bne	s3,s2,80005b2c <consolewrite+0x20>
  }

  return i;
}
    80005b56:	854a                	mv	a0,s2
    80005b58:	60a6                	ld	ra,72(sp)
    80005b5a:	6406                	ld	s0,64(sp)
    80005b5c:	74e2                	ld	s1,56(sp)
    80005b5e:	7942                	ld	s2,48(sp)
    80005b60:	79a2                	ld	s3,40(sp)
    80005b62:	7a02                	ld	s4,32(sp)
    80005b64:	6ae2                	ld	s5,24(sp)
    80005b66:	6161                	addi	sp,sp,80
    80005b68:	8082                	ret
  for(i = 0; i < n; i++){
    80005b6a:	4901                	li	s2,0
    80005b6c:	b7ed                	j	80005b56 <consolewrite+0x4a>

0000000080005b6e <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80005b6e:	7119                	addi	sp,sp,-128
    80005b70:	fc86                	sd	ra,120(sp)
    80005b72:	f8a2                	sd	s0,112(sp)
    80005b74:	f4a6                	sd	s1,104(sp)
    80005b76:	f0ca                	sd	s2,96(sp)
    80005b78:	ecce                	sd	s3,88(sp)
    80005b7a:	e8d2                	sd	s4,80(sp)
    80005b7c:	e4d6                	sd	s5,72(sp)
    80005b7e:	e0da                	sd	s6,64(sp)
    80005b80:	fc5e                	sd	s7,56(sp)
    80005b82:	f862                	sd	s8,48(sp)
    80005b84:	f466                	sd	s9,40(sp)
    80005b86:	f06a                	sd	s10,32(sp)
    80005b88:	ec6e                	sd	s11,24(sp)
    80005b8a:	0100                	addi	s0,sp,128
    80005b8c:	8b2a                	mv	s6,a0
    80005b8e:	8aae                	mv	s5,a1
    80005b90:	8a32                	mv	s4,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80005b92:	00060b9b          	sext.w	s7,a2
  acquire(&cons.lock);
    80005b96:	00020517          	auipc	a0,0x20
    80005b9a:	5aa50513          	addi	a0,a0,1450 # 80026140 <cons>
    80005b9e:	00001097          	auipc	ra,0x1
    80005ba2:	8f4080e7          	jalr	-1804(ra) # 80006492 <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    80005ba6:	00020497          	auipc	s1,0x20
    80005baa:	59a48493          	addi	s1,s1,1434 # 80026140 <cons>
      if(myproc()->killed){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    80005bae:	89a6                	mv	s3,s1
    80005bb0:	00020917          	auipc	s2,0x20
    80005bb4:	62890913          	addi	s2,s2,1576 # 800261d8 <cons+0x98>
    }

    c = cons.buf[cons.r++ % INPUT_BUF];

    if(c == C('D')){  // end-of-file
    80005bb8:	4c91                	li	s9,4
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80005bba:	5d7d                	li	s10,-1
      break;

    dst++;
    --n;

    if(c == '\n'){
    80005bbc:	4da9                	li	s11,10
  while(n > 0){
    80005bbe:	07405863          	blez	s4,80005c2e <consoleread+0xc0>
    while(cons.r == cons.w){
    80005bc2:	0984a783          	lw	a5,152(s1)
    80005bc6:	09c4a703          	lw	a4,156(s1)
    80005bca:	02f71463          	bne	a4,a5,80005bf2 <consoleread+0x84>
      if(myproc()->killed){
    80005bce:	ffffb097          	auipc	ra,0xffffb
    80005bd2:	358080e7          	jalr	856(ra) # 80000f26 <myproc>
    80005bd6:	551c                	lw	a5,40(a0)
    80005bd8:	e7b5                	bnez	a5,80005c44 <consoleread+0xd6>
      sleep(&cons.r, &cons.lock);
    80005bda:	85ce                	mv	a1,s3
    80005bdc:	854a                	mv	a0,s2
    80005bde:	ffffc097          	auipc	ra,0xffffc
    80005be2:	a04080e7          	jalr	-1532(ra) # 800015e2 <sleep>
    while(cons.r == cons.w){
    80005be6:	0984a783          	lw	a5,152(s1)
    80005bea:	09c4a703          	lw	a4,156(s1)
    80005bee:	fef700e3          	beq	a4,a5,80005bce <consoleread+0x60>
    c = cons.buf[cons.r++ % INPUT_BUF];
    80005bf2:	0017871b          	addiw	a4,a5,1
    80005bf6:	08e4ac23          	sw	a4,152(s1)
    80005bfa:	07f7f713          	andi	a4,a5,127
    80005bfe:	9726                	add	a4,a4,s1
    80005c00:	01874703          	lbu	a4,24(a4)
    80005c04:	00070c1b          	sext.w	s8,a4
    if(c == C('D')){  // end-of-file
    80005c08:	079c0663          	beq	s8,s9,80005c74 <consoleread+0x106>
    cbuf = c;
    80005c0c:	f8e407a3          	sb	a4,-113(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80005c10:	4685                	li	a3,1
    80005c12:	f8f40613          	addi	a2,s0,-113
    80005c16:	85d6                	mv	a1,s5
    80005c18:	855a                	mv	a0,s6
    80005c1a:	ffffc097          	auipc	ra,0xffffc
    80005c1e:	d6c080e7          	jalr	-660(ra) # 80001986 <either_copyout>
    80005c22:	01a50663          	beq	a0,s10,80005c2e <consoleread+0xc0>
    dst++;
    80005c26:	0a85                	addi	s5,s5,1
    --n;
    80005c28:	3a7d                	addiw	s4,s4,-1
    if(c == '\n'){
    80005c2a:	f9bc1ae3          	bne	s8,s11,80005bbe <consoleread+0x50>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);
    80005c2e:	00020517          	auipc	a0,0x20
    80005c32:	51250513          	addi	a0,a0,1298 # 80026140 <cons>
    80005c36:	00001097          	auipc	ra,0x1
    80005c3a:	910080e7          	jalr	-1776(ra) # 80006546 <release>

  return target - n;
    80005c3e:	414b853b          	subw	a0,s7,s4
    80005c42:	a811                	j	80005c56 <consoleread+0xe8>
        release(&cons.lock);
    80005c44:	00020517          	auipc	a0,0x20
    80005c48:	4fc50513          	addi	a0,a0,1276 # 80026140 <cons>
    80005c4c:	00001097          	auipc	ra,0x1
    80005c50:	8fa080e7          	jalr	-1798(ra) # 80006546 <release>
        return -1;
    80005c54:	557d                	li	a0,-1
}
    80005c56:	70e6                	ld	ra,120(sp)
    80005c58:	7446                	ld	s0,112(sp)
    80005c5a:	74a6                	ld	s1,104(sp)
    80005c5c:	7906                	ld	s2,96(sp)
    80005c5e:	69e6                	ld	s3,88(sp)
    80005c60:	6a46                	ld	s4,80(sp)
    80005c62:	6aa6                	ld	s5,72(sp)
    80005c64:	6b06                	ld	s6,64(sp)
    80005c66:	7be2                	ld	s7,56(sp)
    80005c68:	7c42                	ld	s8,48(sp)
    80005c6a:	7ca2                	ld	s9,40(sp)
    80005c6c:	7d02                	ld	s10,32(sp)
    80005c6e:	6de2                	ld	s11,24(sp)
    80005c70:	6109                	addi	sp,sp,128
    80005c72:	8082                	ret
      if(n < target){
    80005c74:	000a071b          	sext.w	a4,s4
    80005c78:	fb777be3          	bgeu	a4,s7,80005c2e <consoleread+0xc0>
        cons.r--;
    80005c7c:	00020717          	auipc	a4,0x20
    80005c80:	54f72e23          	sw	a5,1372(a4) # 800261d8 <cons+0x98>
    80005c84:	b76d                	j	80005c2e <consoleread+0xc0>

0000000080005c86 <consputc>:
{
    80005c86:	1141                	addi	sp,sp,-16
    80005c88:	e406                	sd	ra,8(sp)
    80005c8a:	e022                	sd	s0,0(sp)
    80005c8c:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    80005c8e:	10000793          	li	a5,256
    80005c92:	00f50a63          	beq	a0,a5,80005ca6 <consputc+0x20>
    uartputc_sync(c);
    80005c96:	00000097          	auipc	ra,0x0
    80005c9a:	564080e7          	jalr	1380(ra) # 800061fa <uartputc_sync>
}
    80005c9e:	60a2                	ld	ra,8(sp)
    80005ca0:	6402                	ld	s0,0(sp)
    80005ca2:	0141                	addi	sp,sp,16
    80005ca4:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80005ca6:	4521                	li	a0,8
    80005ca8:	00000097          	auipc	ra,0x0
    80005cac:	552080e7          	jalr	1362(ra) # 800061fa <uartputc_sync>
    80005cb0:	02000513          	li	a0,32
    80005cb4:	00000097          	auipc	ra,0x0
    80005cb8:	546080e7          	jalr	1350(ra) # 800061fa <uartputc_sync>
    80005cbc:	4521                	li	a0,8
    80005cbe:	00000097          	auipc	ra,0x0
    80005cc2:	53c080e7          	jalr	1340(ra) # 800061fa <uartputc_sync>
    80005cc6:	bfe1                	j	80005c9e <consputc+0x18>

0000000080005cc8 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    80005cc8:	1101                	addi	sp,sp,-32
    80005cca:	ec06                	sd	ra,24(sp)
    80005ccc:	e822                	sd	s0,16(sp)
    80005cce:	e426                	sd	s1,8(sp)
    80005cd0:	e04a                	sd	s2,0(sp)
    80005cd2:	1000                	addi	s0,sp,32
    80005cd4:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    80005cd6:	00020517          	auipc	a0,0x20
    80005cda:	46a50513          	addi	a0,a0,1130 # 80026140 <cons>
    80005cde:	00000097          	auipc	ra,0x0
    80005ce2:	7b4080e7          	jalr	1972(ra) # 80006492 <acquire>

  switch(c){
    80005ce6:	47d5                	li	a5,21
    80005ce8:	0af48663          	beq	s1,a5,80005d94 <consoleintr+0xcc>
    80005cec:	0297ca63          	blt	a5,s1,80005d20 <consoleintr+0x58>
    80005cf0:	47a1                	li	a5,8
    80005cf2:	0ef48763          	beq	s1,a5,80005de0 <consoleintr+0x118>
    80005cf6:	47c1                	li	a5,16
    80005cf8:	10f49a63          	bne	s1,a5,80005e0c <consoleintr+0x144>
  case C('P'):  // Print process list.
    procdump();
    80005cfc:	ffffc097          	auipc	ra,0xffffc
    80005d00:	d36080e7          	jalr	-714(ra) # 80001a32 <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    80005d04:	00020517          	auipc	a0,0x20
    80005d08:	43c50513          	addi	a0,a0,1084 # 80026140 <cons>
    80005d0c:	00001097          	auipc	ra,0x1
    80005d10:	83a080e7          	jalr	-1990(ra) # 80006546 <release>
}
    80005d14:	60e2                	ld	ra,24(sp)
    80005d16:	6442                	ld	s0,16(sp)
    80005d18:	64a2                	ld	s1,8(sp)
    80005d1a:	6902                	ld	s2,0(sp)
    80005d1c:	6105                	addi	sp,sp,32
    80005d1e:	8082                	ret
  switch(c){
    80005d20:	07f00793          	li	a5,127
    80005d24:	0af48e63          	beq	s1,a5,80005de0 <consoleintr+0x118>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80005d28:	00020717          	auipc	a4,0x20
    80005d2c:	41870713          	addi	a4,a4,1048 # 80026140 <cons>
    80005d30:	0a072783          	lw	a5,160(a4)
    80005d34:	09872703          	lw	a4,152(a4)
    80005d38:	9f99                	subw	a5,a5,a4
    80005d3a:	07f00713          	li	a4,127
    80005d3e:	fcf763e3          	bltu	a4,a5,80005d04 <consoleintr+0x3c>
      c = (c == '\r') ? '\n' : c;
    80005d42:	47b5                	li	a5,13
    80005d44:	0cf48763          	beq	s1,a5,80005e12 <consoleintr+0x14a>
      consputc(c);
    80005d48:	8526                	mv	a0,s1
    80005d4a:	00000097          	auipc	ra,0x0
    80005d4e:	f3c080e7          	jalr	-196(ra) # 80005c86 <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80005d52:	00020797          	auipc	a5,0x20
    80005d56:	3ee78793          	addi	a5,a5,1006 # 80026140 <cons>
    80005d5a:	0a07a703          	lw	a4,160(a5)
    80005d5e:	0017069b          	addiw	a3,a4,1
    80005d62:	0006861b          	sext.w	a2,a3
    80005d66:	0ad7a023          	sw	a3,160(a5)
    80005d6a:	07f77713          	andi	a4,a4,127
    80005d6e:	97ba                	add	a5,a5,a4
    80005d70:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == C('D') || cons.e == cons.r+INPUT_BUF){
    80005d74:	47a9                	li	a5,10
    80005d76:	0cf48563          	beq	s1,a5,80005e40 <consoleintr+0x178>
    80005d7a:	4791                	li	a5,4
    80005d7c:	0cf48263          	beq	s1,a5,80005e40 <consoleintr+0x178>
    80005d80:	00020797          	auipc	a5,0x20
    80005d84:	4587a783          	lw	a5,1112(a5) # 800261d8 <cons+0x98>
    80005d88:	0807879b          	addiw	a5,a5,128
    80005d8c:	f6f61ce3          	bne	a2,a5,80005d04 <consoleintr+0x3c>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80005d90:	863e                	mv	a2,a5
    80005d92:	a07d                	j	80005e40 <consoleintr+0x178>
    while(cons.e != cons.w &&
    80005d94:	00020717          	auipc	a4,0x20
    80005d98:	3ac70713          	addi	a4,a4,940 # 80026140 <cons>
    80005d9c:	0a072783          	lw	a5,160(a4)
    80005da0:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    80005da4:	00020497          	auipc	s1,0x20
    80005da8:	39c48493          	addi	s1,s1,924 # 80026140 <cons>
    while(cons.e != cons.w &&
    80005dac:	4929                	li	s2,10
    80005dae:	f4f70be3          	beq	a4,a5,80005d04 <consoleintr+0x3c>
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    80005db2:	37fd                	addiw	a5,a5,-1
    80005db4:	07f7f713          	andi	a4,a5,127
    80005db8:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    80005dba:	01874703          	lbu	a4,24(a4)
    80005dbe:	f52703e3          	beq	a4,s2,80005d04 <consoleintr+0x3c>
      cons.e--;
    80005dc2:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    80005dc6:	10000513          	li	a0,256
    80005dca:	00000097          	auipc	ra,0x0
    80005dce:	ebc080e7          	jalr	-324(ra) # 80005c86 <consputc>
    while(cons.e != cons.w &&
    80005dd2:	0a04a783          	lw	a5,160(s1)
    80005dd6:	09c4a703          	lw	a4,156(s1)
    80005dda:	fcf71ce3          	bne	a4,a5,80005db2 <consoleintr+0xea>
    80005dde:	b71d                	j	80005d04 <consoleintr+0x3c>
    if(cons.e != cons.w){
    80005de0:	00020717          	auipc	a4,0x20
    80005de4:	36070713          	addi	a4,a4,864 # 80026140 <cons>
    80005de8:	0a072783          	lw	a5,160(a4)
    80005dec:	09c72703          	lw	a4,156(a4)
    80005df0:	f0f70ae3          	beq	a4,a5,80005d04 <consoleintr+0x3c>
      cons.e--;
    80005df4:	37fd                	addiw	a5,a5,-1
    80005df6:	00020717          	auipc	a4,0x20
    80005dfa:	3ef72523          	sw	a5,1002(a4) # 800261e0 <cons+0xa0>
      consputc(BACKSPACE);
    80005dfe:	10000513          	li	a0,256
    80005e02:	00000097          	auipc	ra,0x0
    80005e06:	e84080e7          	jalr	-380(ra) # 80005c86 <consputc>
    80005e0a:	bded                	j	80005d04 <consoleintr+0x3c>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80005e0c:	ee048ce3          	beqz	s1,80005d04 <consoleintr+0x3c>
    80005e10:	bf21                	j	80005d28 <consoleintr+0x60>
      consputc(c);
    80005e12:	4529                	li	a0,10
    80005e14:	00000097          	auipc	ra,0x0
    80005e18:	e72080e7          	jalr	-398(ra) # 80005c86 <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80005e1c:	00020797          	auipc	a5,0x20
    80005e20:	32478793          	addi	a5,a5,804 # 80026140 <cons>
    80005e24:	0a07a703          	lw	a4,160(a5)
    80005e28:	0017069b          	addiw	a3,a4,1
    80005e2c:	0006861b          	sext.w	a2,a3
    80005e30:	0ad7a023          	sw	a3,160(a5)
    80005e34:	07f77713          	andi	a4,a4,127
    80005e38:	97ba                	add	a5,a5,a4
    80005e3a:	4729                	li	a4,10
    80005e3c:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    80005e40:	00020797          	auipc	a5,0x20
    80005e44:	38c7ae23          	sw	a2,924(a5) # 800261dc <cons+0x9c>
        wakeup(&cons.r);
    80005e48:	00020517          	auipc	a0,0x20
    80005e4c:	39050513          	addi	a0,a0,912 # 800261d8 <cons+0x98>
    80005e50:	ffffc097          	auipc	ra,0xffffc
    80005e54:	91e080e7          	jalr	-1762(ra) # 8000176e <wakeup>
    80005e58:	b575                	j	80005d04 <consoleintr+0x3c>

0000000080005e5a <consoleinit>:

void
consoleinit(void)
{
    80005e5a:	1141                	addi	sp,sp,-16
    80005e5c:	e406                	sd	ra,8(sp)
    80005e5e:	e022                	sd	s0,0(sp)
    80005e60:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    80005e62:	00003597          	auipc	a1,0x3
    80005e66:	a2658593          	addi	a1,a1,-1498 # 80008888 <syscalls+0x4d0>
    80005e6a:	00020517          	auipc	a0,0x20
    80005e6e:	2d650513          	addi	a0,a0,726 # 80026140 <cons>
    80005e72:	00000097          	auipc	ra,0x0
    80005e76:	590080e7          	jalr	1424(ra) # 80006402 <initlock>

  uartinit();
    80005e7a:	00000097          	auipc	ra,0x0
    80005e7e:	330080e7          	jalr	816(ra) # 800061aa <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80005e82:	00013797          	auipc	a5,0x13
    80005e86:	24678793          	addi	a5,a5,582 # 800190c8 <devsw>
    80005e8a:	00000717          	auipc	a4,0x0
    80005e8e:	ce470713          	addi	a4,a4,-796 # 80005b6e <consoleread>
    80005e92:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80005e94:	00000717          	auipc	a4,0x0
    80005e98:	c7870713          	addi	a4,a4,-904 # 80005b0c <consolewrite>
    80005e9c:	ef98                	sd	a4,24(a5)
}
    80005e9e:	60a2                	ld	ra,8(sp)
    80005ea0:	6402                	ld	s0,0(sp)
    80005ea2:	0141                	addi	sp,sp,16
    80005ea4:	8082                	ret

0000000080005ea6 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    80005ea6:	7179                	addi	sp,sp,-48
    80005ea8:	f406                	sd	ra,40(sp)
    80005eaa:	f022                	sd	s0,32(sp)
    80005eac:	ec26                	sd	s1,24(sp)
    80005eae:	e84a                	sd	s2,16(sp)
    80005eb0:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    80005eb2:	c219                	beqz	a2,80005eb8 <printint+0x12>
    80005eb4:	08054663          	bltz	a0,80005f40 <printint+0x9a>
    x = -xx;
  else
    x = xx;
    80005eb8:	2501                	sext.w	a0,a0
    80005eba:	4881                	li	a7,0
    80005ebc:	fd040693          	addi	a3,s0,-48

  i = 0;
    80005ec0:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    80005ec2:	2581                	sext.w	a1,a1
    80005ec4:	00003617          	auipc	a2,0x3
    80005ec8:	9f460613          	addi	a2,a2,-1548 # 800088b8 <digits>
    80005ecc:	883a                	mv	a6,a4
    80005ece:	2705                	addiw	a4,a4,1
    80005ed0:	02b577bb          	remuw	a5,a0,a1
    80005ed4:	1782                	slli	a5,a5,0x20
    80005ed6:	9381                	srli	a5,a5,0x20
    80005ed8:	97b2                	add	a5,a5,a2
    80005eda:	0007c783          	lbu	a5,0(a5)
    80005ede:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    80005ee2:	0005079b          	sext.w	a5,a0
    80005ee6:	02b5553b          	divuw	a0,a0,a1
    80005eea:	0685                	addi	a3,a3,1
    80005eec:	feb7f0e3          	bgeu	a5,a1,80005ecc <printint+0x26>

  if(sign)
    80005ef0:	00088b63          	beqz	a7,80005f06 <printint+0x60>
    buf[i++] = '-';
    80005ef4:	fe040793          	addi	a5,s0,-32
    80005ef8:	973e                	add	a4,a4,a5
    80005efa:	02d00793          	li	a5,45
    80005efe:	fef70823          	sb	a5,-16(a4)
    80005f02:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    80005f06:	02e05763          	blez	a4,80005f34 <printint+0x8e>
    80005f0a:	fd040793          	addi	a5,s0,-48
    80005f0e:	00e784b3          	add	s1,a5,a4
    80005f12:	fff78913          	addi	s2,a5,-1
    80005f16:	993a                	add	s2,s2,a4
    80005f18:	377d                	addiw	a4,a4,-1
    80005f1a:	1702                	slli	a4,a4,0x20
    80005f1c:	9301                	srli	a4,a4,0x20
    80005f1e:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    80005f22:	fff4c503          	lbu	a0,-1(s1)
    80005f26:	00000097          	auipc	ra,0x0
    80005f2a:	d60080e7          	jalr	-672(ra) # 80005c86 <consputc>
  while(--i >= 0)
    80005f2e:	14fd                	addi	s1,s1,-1
    80005f30:	ff2499e3          	bne	s1,s2,80005f22 <printint+0x7c>
}
    80005f34:	70a2                	ld	ra,40(sp)
    80005f36:	7402                	ld	s0,32(sp)
    80005f38:	64e2                	ld	s1,24(sp)
    80005f3a:	6942                	ld	s2,16(sp)
    80005f3c:	6145                	addi	sp,sp,48
    80005f3e:	8082                	ret
    x = -xx;
    80005f40:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    80005f44:	4885                	li	a7,1
    x = -xx;
    80005f46:	bf9d                	j	80005ebc <printint+0x16>

0000000080005f48 <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    80005f48:	1101                	addi	sp,sp,-32
    80005f4a:	ec06                	sd	ra,24(sp)
    80005f4c:	e822                	sd	s0,16(sp)
    80005f4e:	e426                	sd	s1,8(sp)
    80005f50:	1000                	addi	s0,sp,32
    80005f52:	84aa                	mv	s1,a0
  pr.locking = 0;
    80005f54:	00020797          	auipc	a5,0x20
    80005f58:	2a07a623          	sw	zero,684(a5) # 80026200 <pr+0x18>
  printf("panic: ");
    80005f5c:	00003517          	auipc	a0,0x3
    80005f60:	93450513          	addi	a0,a0,-1740 # 80008890 <syscalls+0x4d8>
    80005f64:	00000097          	auipc	ra,0x0
    80005f68:	02e080e7          	jalr	46(ra) # 80005f92 <printf>
  printf(s);
    80005f6c:	8526                	mv	a0,s1
    80005f6e:	00000097          	auipc	ra,0x0
    80005f72:	024080e7          	jalr	36(ra) # 80005f92 <printf>
  printf("\n");
    80005f76:	00002517          	auipc	a0,0x2
    80005f7a:	0d250513          	addi	a0,a0,210 # 80008048 <etext+0x48>
    80005f7e:	00000097          	auipc	ra,0x0
    80005f82:	014080e7          	jalr	20(ra) # 80005f92 <printf>
  panicked = 1; // freeze uart output from other CPUs
    80005f86:	4785                	li	a5,1
    80005f88:	00003717          	auipc	a4,0x3
    80005f8c:	08f72a23          	sw	a5,148(a4) # 8000901c <panicked>
  for(;;)
    80005f90:	a001                	j	80005f90 <panic+0x48>

0000000080005f92 <printf>:
{
    80005f92:	7131                	addi	sp,sp,-192
    80005f94:	fc86                	sd	ra,120(sp)
    80005f96:	f8a2                	sd	s0,112(sp)
    80005f98:	f4a6                	sd	s1,104(sp)
    80005f9a:	f0ca                	sd	s2,96(sp)
    80005f9c:	ecce                	sd	s3,88(sp)
    80005f9e:	e8d2                	sd	s4,80(sp)
    80005fa0:	e4d6                	sd	s5,72(sp)
    80005fa2:	e0da                	sd	s6,64(sp)
    80005fa4:	fc5e                	sd	s7,56(sp)
    80005fa6:	f862                	sd	s8,48(sp)
    80005fa8:	f466                	sd	s9,40(sp)
    80005faa:	f06a                	sd	s10,32(sp)
    80005fac:	ec6e                	sd	s11,24(sp)
    80005fae:	0100                	addi	s0,sp,128
    80005fb0:	8a2a                	mv	s4,a0
    80005fb2:	e40c                	sd	a1,8(s0)
    80005fb4:	e810                	sd	a2,16(s0)
    80005fb6:	ec14                	sd	a3,24(s0)
    80005fb8:	f018                	sd	a4,32(s0)
    80005fba:	f41c                	sd	a5,40(s0)
    80005fbc:	03043823          	sd	a6,48(s0)
    80005fc0:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    80005fc4:	00020d97          	auipc	s11,0x20
    80005fc8:	23cdad83          	lw	s11,572(s11) # 80026200 <pr+0x18>
  if(locking)
    80005fcc:	020d9b63          	bnez	s11,80006002 <printf+0x70>
  if (fmt == 0)
    80005fd0:	040a0263          	beqz	s4,80006014 <printf+0x82>
  va_start(ap, fmt);
    80005fd4:	00840793          	addi	a5,s0,8
    80005fd8:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80005fdc:	000a4503          	lbu	a0,0(s4)
    80005fe0:	16050263          	beqz	a0,80006144 <printf+0x1b2>
    80005fe4:	4481                	li	s1,0
    if(c != '%'){
    80005fe6:	02500a93          	li	s5,37
    switch(c){
    80005fea:	07000b13          	li	s6,112
  consputc('x');
    80005fee:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80005ff0:	00003b97          	auipc	s7,0x3
    80005ff4:	8c8b8b93          	addi	s7,s7,-1848 # 800088b8 <digits>
    switch(c){
    80005ff8:	07300c93          	li	s9,115
    80005ffc:	06400c13          	li	s8,100
    80006000:	a82d                	j	8000603a <printf+0xa8>
    acquire(&pr.lock);
    80006002:	00020517          	auipc	a0,0x20
    80006006:	1e650513          	addi	a0,a0,486 # 800261e8 <pr>
    8000600a:	00000097          	auipc	ra,0x0
    8000600e:	488080e7          	jalr	1160(ra) # 80006492 <acquire>
    80006012:	bf7d                	j	80005fd0 <printf+0x3e>
    panic("null fmt");
    80006014:	00003517          	auipc	a0,0x3
    80006018:	88c50513          	addi	a0,a0,-1908 # 800088a0 <syscalls+0x4e8>
    8000601c:	00000097          	auipc	ra,0x0
    80006020:	f2c080e7          	jalr	-212(ra) # 80005f48 <panic>
      consputc(c);
    80006024:	00000097          	auipc	ra,0x0
    80006028:	c62080e7          	jalr	-926(ra) # 80005c86 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    8000602c:	2485                	addiw	s1,s1,1
    8000602e:	009a07b3          	add	a5,s4,s1
    80006032:	0007c503          	lbu	a0,0(a5)
    80006036:	10050763          	beqz	a0,80006144 <printf+0x1b2>
    if(c != '%'){
    8000603a:	ff5515e3          	bne	a0,s5,80006024 <printf+0x92>
    c = fmt[++i] & 0xff;
    8000603e:	2485                	addiw	s1,s1,1
    80006040:	009a07b3          	add	a5,s4,s1
    80006044:	0007c783          	lbu	a5,0(a5)
    80006048:	0007891b          	sext.w	s2,a5
    if(c == 0)
    8000604c:	cfe5                	beqz	a5,80006144 <printf+0x1b2>
    switch(c){
    8000604e:	05678a63          	beq	a5,s6,800060a2 <printf+0x110>
    80006052:	02fb7663          	bgeu	s6,a5,8000607e <printf+0xec>
    80006056:	09978963          	beq	a5,s9,800060e8 <printf+0x156>
    8000605a:	07800713          	li	a4,120
    8000605e:	0ce79863          	bne	a5,a4,8000612e <printf+0x19c>
      printint(va_arg(ap, int), 16, 1);
    80006062:	f8843783          	ld	a5,-120(s0)
    80006066:	00878713          	addi	a4,a5,8
    8000606a:	f8e43423          	sd	a4,-120(s0)
    8000606e:	4605                	li	a2,1
    80006070:	85ea                	mv	a1,s10
    80006072:	4388                	lw	a0,0(a5)
    80006074:	00000097          	auipc	ra,0x0
    80006078:	e32080e7          	jalr	-462(ra) # 80005ea6 <printint>
      break;
    8000607c:	bf45                	j	8000602c <printf+0x9a>
    switch(c){
    8000607e:	0b578263          	beq	a5,s5,80006122 <printf+0x190>
    80006082:	0b879663          	bne	a5,s8,8000612e <printf+0x19c>
      printint(va_arg(ap, int), 10, 1);
    80006086:	f8843783          	ld	a5,-120(s0)
    8000608a:	00878713          	addi	a4,a5,8
    8000608e:	f8e43423          	sd	a4,-120(s0)
    80006092:	4605                	li	a2,1
    80006094:	45a9                	li	a1,10
    80006096:	4388                	lw	a0,0(a5)
    80006098:	00000097          	auipc	ra,0x0
    8000609c:	e0e080e7          	jalr	-498(ra) # 80005ea6 <printint>
      break;
    800060a0:	b771                	j	8000602c <printf+0x9a>
      printptr(va_arg(ap, uint64));
    800060a2:	f8843783          	ld	a5,-120(s0)
    800060a6:	00878713          	addi	a4,a5,8
    800060aa:	f8e43423          	sd	a4,-120(s0)
    800060ae:	0007b983          	ld	s3,0(a5)
  consputc('0');
    800060b2:	03000513          	li	a0,48
    800060b6:	00000097          	auipc	ra,0x0
    800060ba:	bd0080e7          	jalr	-1072(ra) # 80005c86 <consputc>
  consputc('x');
    800060be:	07800513          	li	a0,120
    800060c2:	00000097          	auipc	ra,0x0
    800060c6:	bc4080e7          	jalr	-1084(ra) # 80005c86 <consputc>
    800060ca:	896a                	mv	s2,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800060cc:	03c9d793          	srli	a5,s3,0x3c
    800060d0:	97de                	add	a5,a5,s7
    800060d2:	0007c503          	lbu	a0,0(a5)
    800060d6:	00000097          	auipc	ra,0x0
    800060da:	bb0080e7          	jalr	-1104(ra) # 80005c86 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800060de:	0992                	slli	s3,s3,0x4
    800060e0:	397d                	addiw	s2,s2,-1
    800060e2:	fe0915e3          	bnez	s2,800060cc <printf+0x13a>
    800060e6:	b799                	j	8000602c <printf+0x9a>
      if((s = va_arg(ap, char*)) == 0)
    800060e8:	f8843783          	ld	a5,-120(s0)
    800060ec:	00878713          	addi	a4,a5,8
    800060f0:	f8e43423          	sd	a4,-120(s0)
    800060f4:	0007b903          	ld	s2,0(a5)
    800060f8:	00090e63          	beqz	s2,80006114 <printf+0x182>
      for(; *s; s++)
    800060fc:	00094503          	lbu	a0,0(s2)
    80006100:	d515                	beqz	a0,8000602c <printf+0x9a>
        consputc(*s);
    80006102:	00000097          	auipc	ra,0x0
    80006106:	b84080e7          	jalr	-1148(ra) # 80005c86 <consputc>
      for(; *s; s++)
    8000610a:	0905                	addi	s2,s2,1
    8000610c:	00094503          	lbu	a0,0(s2)
    80006110:	f96d                	bnez	a0,80006102 <printf+0x170>
    80006112:	bf29                	j	8000602c <printf+0x9a>
        s = "(null)";
    80006114:	00002917          	auipc	s2,0x2
    80006118:	78490913          	addi	s2,s2,1924 # 80008898 <syscalls+0x4e0>
      for(; *s; s++)
    8000611c:	02800513          	li	a0,40
    80006120:	b7cd                	j	80006102 <printf+0x170>
      consputc('%');
    80006122:	8556                	mv	a0,s5
    80006124:	00000097          	auipc	ra,0x0
    80006128:	b62080e7          	jalr	-1182(ra) # 80005c86 <consputc>
      break;
    8000612c:	b701                	j	8000602c <printf+0x9a>
      consputc('%');
    8000612e:	8556                	mv	a0,s5
    80006130:	00000097          	auipc	ra,0x0
    80006134:	b56080e7          	jalr	-1194(ra) # 80005c86 <consputc>
      consputc(c);
    80006138:	854a                	mv	a0,s2
    8000613a:	00000097          	auipc	ra,0x0
    8000613e:	b4c080e7          	jalr	-1204(ra) # 80005c86 <consputc>
      break;
    80006142:	b5ed                	j	8000602c <printf+0x9a>
  if(locking)
    80006144:	020d9163          	bnez	s11,80006166 <printf+0x1d4>
}
    80006148:	70e6                	ld	ra,120(sp)
    8000614a:	7446                	ld	s0,112(sp)
    8000614c:	74a6                	ld	s1,104(sp)
    8000614e:	7906                	ld	s2,96(sp)
    80006150:	69e6                	ld	s3,88(sp)
    80006152:	6a46                	ld	s4,80(sp)
    80006154:	6aa6                	ld	s5,72(sp)
    80006156:	6b06                	ld	s6,64(sp)
    80006158:	7be2                	ld	s7,56(sp)
    8000615a:	7c42                	ld	s8,48(sp)
    8000615c:	7ca2                	ld	s9,40(sp)
    8000615e:	7d02                	ld	s10,32(sp)
    80006160:	6de2                	ld	s11,24(sp)
    80006162:	6129                	addi	sp,sp,192
    80006164:	8082                	ret
    release(&pr.lock);
    80006166:	00020517          	auipc	a0,0x20
    8000616a:	08250513          	addi	a0,a0,130 # 800261e8 <pr>
    8000616e:	00000097          	auipc	ra,0x0
    80006172:	3d8080e7          	jalr	984(ra) # 80006546 <release>
}
    80006176:	bfc9                	j	80006148 <printf+0x1b6>

0000000080006178 <printfinit>:
    ;
}

void
printfinit(void)
{
    80006178:	1101                	addi	sp,sp,-32
    8000617a:	ec06                	sd	ra,24(sp)
    8000617c:	e822                	sd	s0,16(sp)
    8000617e:	e426                	sd	s1,8(sp)
    80006180:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    80006182:	00020497          	auipc	s1,0x20
    80006186:	06648493          	addi	s1,s1,102 # 800261e8 <pr>
    8000618a:	00002597          	auipc	a1,0x2
    8000618e:	72658593          	addi	a1,a1,1830 # 800088b0 <syscalls+0x4f8>
    80006192:	8526                	mv	a0,s1
    80006194:	00000097          	auipc	ra,0x0
    80006198:	26e080e7          	jalr	622(ra) # 80006402 <initlock>
  pr.locking = 1;
    8000619c:	4785                	li	a5,1
    8000619e:	cc9c                	sw	a5,24(s1)
}
    800061a0:	60e2                	ld	ra,24(sp)
    800061a2:	6442                	ld	s0,16(sp)
    800061a4:	64a2                	ld	s1,8(sp)
    800061a6:	6105                	addi	sp,sp,32
    800061a8:	8082                	ret

00000000800061aa <uartinit>:

void uartstart();

void
uartinit(void)
{
    800061aa:	1141                	addi	sp,sp,-16
    800061ac:	e406                	sd	ra,8(sp)
    800061ae:	e022                	sd	s0,0(sp)
    800061b0:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    800061b2:	100007b7          	lui	a5,0x10000
    800061b6:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    800061ba:	f8000713          	li	a4,-128
    800061be:	00e781a3          	sb	a4,3(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    800061c2:	470d                	li	a4,3
    800061c4:	00e78023          	sb	a4,0(a5)

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    800061c8:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    800061cc:	00e781a3          	sb	a4,3(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    800061d0:	469d                	li	a3,7
    800061d2:	00d78123          	sb	a3,2(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    800061d6:	00e780a3          	sb	a4,1(a5)

  initlock(&uart_tx_lock, "uart");
    800061da:	00002597          	auipc	a1,0x2
    800061de:	6f658593          	addi	a1,a1,1782 # 800088d0 <digits+0x18>
    800061e2:	00020517          	auipc	a0,0x20
    800061e6:	02650513          	addi	a0,a0,38 # 80026208 <uart_tx_lock>
    800061ea:	00000097          	auipc	ra,0x0
    800061ee:	218080e7          	jalr	536(ra) # 80006402 <initlock>
}
    800061f2:	60a2                	ld	ra,8(sp)
    800061f4:	6402                	ld	s0,0(sp)
    800061f6:	0141                	addi	sp,sp,16
    800061f8:	8082                	ret

00000000800061fa <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    800061fa:	1101                	addi	sp,sp,-32
    800061fc:	ec06                	sd	ra,24(sp)
    800061fe:	e822                	sd	s0,16(sp)
    80006200:	e426                	sd	s1,8(sp)
    80006202:	1000                	addi	s0,sp,32
    80006204:	84aa                	mv	s1,a0
  push_off();
    80006206:	00000097          	auipc	ra,0x0
    8000620a:	240080e7          	jalr	576(ra) # 80006446 <push_off>

  if(panicked){
    8000620e:	00003797          	auipc	a5,0x3
    80006212:	e0e7a783          	lw	a5,-498(a5) # 8000901c <panicked>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80006216:	10000737          	lui	a4,0x10000
  if(panicked){
    8000621a:	c391                	beqz	a5,8000621e <uartputc_sync+0x24>
    for(;;)
    8000621c:	a001                	j	8000621c <uartputc_sync+0x22>
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    8000621e:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80006222:	0ff7f793          	andi	a5,a5,255
    80006226:	0207f793          	andi	a5,a5,32
    8000622a:	dbf5                	beqz	a5,8000621e <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    8000622c:	0ff4f793          	andi	a5,s1,255
    80006230:	10000737          	lui	a4,0x10000
    80006234:	00f70023          	sb	a5,0(a4) # 10000000 <_entry-0x70000000>

  pop_off();
    80006238:	00000097          	auipc	ra,0x0
    8000623c:	2ae080e7          	jalr	686(ra) # 800064e6 <pop_off>
}
    80006240:	60e2                	ld	ra,24(sp)
    80006242:	6442                	ld	s0,16(sp)
    80006244:	64a2                	ld	s1,8(sp)
    80006246:	6105                	addi	sp,sp,32
    80006248:	8082                	ret

000000008000624a <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    8000624a:	00003717          	auipc	a4,0x3
    8000624e:	dd673703          	ld	a4,-554(a4) # 80009020 <uart_tx_r>
    80006252:	00003797          	auipc	a5,0x3
    80006256:	dd67b783          	ld	a5,-554(a5) # 80009028 <uart_tx_w>
    8000625a:	06e78c63          	beq	a5,a4,800062d2 <uartstart+0x88>
{
    8000625e:	7139                	addi	sp,sp,-64
    80006260:	fc06                	sd	ra,56(sp)
    80006262:	f822                	sd	s0,48(sp)
    80006264:	f426                	sd	s1,40(sp)
    80006266:	f04a                	sd	s2,32(sp)
    80006268:	ec4e                	sd	s3,24(sp)
    8000626a:	e852                	sd	s4,16(sp)
    8000626c:	e456                	sd	s5,8(sp)
    8000626e:	0080                	addi	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80006270:	10000937          	lui	s2,0x10000
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80006274:	00020a17          	auipc	s4,0x20
    80006278:	f94a0a13          	addi	s4,s4,-108 # 80026208 <uart_tx_lock>
    uart_tx_r += 1;
    8000627c:	00003497          	auipc	s1,0x3
    80006280:	da448493          	addi	s1,s1,-604 # 80009020 <uart_tx_r>
    if(uart_tx_w == uart_tx_r){
    80006284:	00003997          	auipc	s3,0x3
    80006288:	da498993          	addi	s3,s3,-604 # 80009028 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    8000628c:	00594783          	lbu	a5,5(s2) # 10000005 <_entry-0x6ffffffb>
    80006290:	0ff7f793          	andi	a5,a5,255
    80006294:	0207f793          	andi	a5,a5,32
    80006298:	c785                	beqz	a5,800062c0 <uartstart+0x76>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    8000629a:	01f77793          	andi	a5,a4,31
    8000629e:	97d2                	add	a5,a5,s4
    800062a0:	0187ca83          	lbu	s5,24(a5)
    uart_tx_r += 1;
    800062a4:	0705                	addi	a4,a4,1
    800062a6:	e098                	sd	a4,0(s1)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    800062a8:	8526                	mv	a0,s1
    800062aa:	ffffb097          	auipc	ra,0xffffb
    800062ae:	4c4080e7          	jalr	1220(ra) # 8000176e <wakeup>
    
    WriteReg(THR, c);
    800062b2:	01590023          	sb	s5,0(s2)
    if(uart_tx_w == uart_tx_r){
    800062b6:	6098                	ld	a4,0(s1)
    800062b8:	0009b783          	ld	a5,0(s3)
    800062bc:	fce798e3          	bne	a5,a4,8000628c <uartstart+0x42>
  }
}
    800062c0:	70e2                	ld	ra,56(sp)
    800062c2:	7442                	ld	s0,48(sp)
    800062c4:	74a2                	ld	s1,40(sp)
    800062c6:	7902                	ld	s2,32(sp)
    800062c8:	69e2                	ld	s3,24(sp)
    800062ca:	6a42                	ld	s4,16(sp)
    800062cc:	6aa2                	ld	s5,8(sp)
    800062ce:	6121                	addi	sp,sp,64
    800062d0:	8082                	ret
    800062d2:	8082                	ret

00000000800062d4 <uartputc>:
{
    800062d4:	7179                	addi	sp,sp,-48
    800062d6:	f406                	sd	ra,40(sp)
    800062d8:	f022                	sd	s0,32(sp)
    800062da:	ec26                	sd	s1,24(sp)
    800062dc:	e84a                	sd	s2,16(sp)
    800062de:	e44e                	sd	s3,8(sp)
    800062e0:	e052                	sd	s4,0(sp)
    800062e2:	1800                	addi	s0,sp,48
    800062e4:	89aa                	mv	s3,a0
  acquire(&uart_tx_lock);
    800062e6:	00020517          	auipc	a0,0x20
    800062ea:	f2250513          	addi	a0,a0,-222 # 80026208 <uart_tx_lock>
    800062ee:	00000097          	auipc	ra,0x0
    800062f2:	1a4080e7          	jalr	420(ra) # 80006492 <acquire>
  if(panicked){
    800062f6:	00003797          	auipc	a5,0x3
    800062fa:	d267a783          	lw	a5,-730(a5) # 8000901c <panicked>
    800062fe:	c391                	beqz	a5,80006302 <uartputc+0x2e>
    for(;;)
    80006300:	a001                	j	80006300 <uartputc+0x2c>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80006302:	00003797          	auipc	a5,0x3
    80006306:	d267b783          	ld	a5,-730(a5) # 80009028 <uart_tx_w>
    8000630a:	00003717          	auipc	a4,0x3
    8000630e:	d1673703          	ld	a4,-746(a4) # 80009020 <uart_tx_r>
    80006312:	02070713          	addi	a4,a4,32
    80006316:	02f71b63          	bne	a4,a5,8000634c <uartputc+0x78>
      sleep(&uart_tx_r, &uart_tx_lock);
    8000631a:	00020a17          	auipc	s4,0x20
    8000631e:	eeea0a13          	addi	s4,s4,-274 # 80026208 <uart_tx_lock>
    80006322:	00003497          	auipc	s1,0x3
    80006326:	cfe48493          	addi	s1,s1,-770 # 80009020 <uart_tx_r>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    8000632a:	00003917          	auipc	s2,0x3
    8000632e:	cfe90913          	addi	s2,s2,-770 # 80009028 <uart_tx_w>
      sleep(&uart_tx_r, &uart_tx_lock);
    80006332:	85d2                	mv	a1,s4
    80006334:	8526                	mv	a0,s1
    80006336:	ffffb097          	auipc	ra,0xffffb
    8000633a:	2ac080e7          	jalr	684(ra) # 800015e2 <sleep>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    8000633e:	00093783          	ld	a5,0(s2)
    80006342:	6098                	ld	a4,0(s1)
    80006344:	02070713          	addi	a4,a4,32
    80006348:	fef705e3          	beq	a4,a5,80006332 <uartputc+0x5e>
      uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    8000634c:	00020497          	auipc	s1,0x20
    80006350:	ebc48493          	addi	s1,s1,-324 # 80026208 <uart_tx_lock>
    80006354:	01f7f713          	andi	a4,a5,31
    80006358:	9726                	add	a4,a4,s1
    8000635a:	01370c23          	sb	s3,24(a4)
      uart_tx_w += 1;
    8000635e:	0785                	addi	a5,a5,1
    80006360:	00003717          	auipc	a4,0x3
    80006364:	ccf73423          	sd	a5,-824(a4) # 80009028 <uart_tx_w>
      uartstart();
    80006368:	00000097          	auipc	ra,0x0
    8000636c:	ee2080e7          	jalr	-286(ra) # 8000624a <uartstart>
      release(&uart_tx_lock);
    80006370:	8526                	mv	a0,s1
    80006372:	00000097          	auipc	ra,0x0
    80006376:	1d4080e7          	jalr	468(ra) # 80006546 <release>
}
    8000637a:	70a2                	ld	ra,40(sp)
    8000637c:	7402                	ld	s0,32(sp)
    8000637e:	64e2                	ld	s1,24(sp)
    80006380:	6942                	ld	s2,16(sp)
    80006382:	69a2                	ld	s3,8(sp)
    80006384:	6a02                	ld	s4,0(sp)
    80006386:	6145                	addi	sp,sp,48
    80006388:	8082                	ret

000000008000638a <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    8000638a:	1141                	addi	sp,sp,-16
    8000638c:	e422                	sd	s0,8(sp)
    8000638e:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80006390:	100007b7          	lui	a5,0x10000
    80006394:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006398:	8b85                	andi	a5,a5,1
    8000639a:	cb91                	beqz	a5,800063ae <uartgetc+0x24>
    // input data is ready.
    return ReadReg(RHR);
    8000639c:	100007b7          	lui	a5,0x10000
    800063a0:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
    800063a4:	0ff57513          	andi	a0,a0,255
  } else {
    return -1;
  }
}
    800063a8:	6422                	ld	s0,8(sp)
    800063aa:	0141                	addi	sp,sp,16
    800063ac:	8082                	ret
    return -1;
    800063ae:	557d                	li	a0,-1
    800063b0:	bfe5                	j	800063a8 <uartgetc+0x1e>

00000000800063b2 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from trap.c.
void
uartintr(void)
{
    800063b2:	1101                	addi	sp,sp,-32
    800063b4:	ec06                	sd	ra,24(sp)
    800063b6:	e822                	sd	s0,16(sp)
    800063b8:	e426                	sd	s1,8(sp)
    800063ba:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    800063bc:	54fd                	li	s1,-1
    int c = uartgetc();
    800063be:	00000097          	auipc	ra,0x0
    800063c2:	fcc080e7          	jalr	-52(ra) # 8000638a <uartgetc>
    if(c == -1)
    800063c6:	00950763          	beq	a0,s1,800063d4 <uartintr+0x22>
      break;
    consoleintr(c);
    800063ca:	00000097          	auipc	ra,0x0
    800063ce:	8fe080e7          	jalr	-1794(ra) # 80005cc8 <consoleintr>
  while(1){
    800063d2:	b7f5                	j	800063be <uartintr+0xc>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    800063d4:	00020497          	auipc	s1,0x20
    800063d8:	e3448493          	addi	s1,s1,-460 # 80026208 <uart_tx_lock>
    800063dc:	8526                	mv	a0,s1
    800063de:	00000097          	auipc	ra,0x0
    800063e2:	0b4080e7          	jalr	180(ra) # 80006492 <acquire>
  uartstart();
    800063e6:	00000097          	auipc	ra,0x0
    800063ea:	e64080e7          	jalr	-412(ra) # 8000624a <uartstart>
  release(&uart_tx_lock);
    800063ee:	8526                	mv	a0,s1
    800063f0:	00000097          	auipc	ra,0x0
    800063f4:	156080e7          	jalr	342(ra) # 80006546 <release>
}
    800063f8:	60e2                	ld	ra,24(sp)
    800063fa:	6442                	ld	s0,16(sp)
    800063fc:	64a2                	ld	s1,8(sp)
    800063fe:	6105                	addi	sp,sp,32
    80006400:	8082                	ret

0000000080006402 <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    80006402:	1141                	addi	sp,sp,-16
    80006404:	e422                	sd	s0,8(sp)
    80006406:	0800                	addi	s0,sp,16
  lk->name = name;
    80006408:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    8000640a:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    8000640e:	00053823          	sd	zero,16(a0)
}
    80006412:	6422                	ld	s0,8(sp)
    80006414:	0141                	addi	sp,sp,16
    80006416:	8082                	ret

0000000080006418 <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80006418:	411c                	lw	a5,0(a0)
    8000641a:	e399                	bnez	a5,80006420 <holding+0x8>
    8000641c:	4501                	li	a0,0
  return r;
}
    8000641e:	8082                	ret
{
    80006420:	1101                	addi	sp,sp,-32
    80006422:	ec06                	sd	ra,24(sp)
    80006424:	e822                	sd	s0,16(sp)
    80006426:	e426                	sd	s1,8(sp)
    80006428:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    8000642a:	6904                	ld	s1,16(a0)
    8000642c:	ffffb097          	auipc	ra,0xffffb
    80006430:	ade080e7          	jalr	-1314(ra) # 80000f0a <mycpu>
    80006434:	40a48533          	sub	a0,s1,a0
    80006438:	00153513          	seqz	a0,a0
}
    8000643c:	60e2                	ld	ra,24(sp)
    8000643e:	6442                	ld	s0,16(sp)
    80006440:	64a2                	ld	s1,8(sp)
    80006442:	6105                	addi	sp,sp,32
    80006444:	8082                	ret

0000000080006446 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    80006446:	1101                	addi	sp,sp,-32
    80006448:	ec06                	sd	ra,24(sp)
    8000644a:	e822                	sd	s0,16(sp)
    8000644c:	e426                	sd	s1,8(sp)
    8000644e:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80006450:	100024f3          	csrr	s1,sstatus
    80006454:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80006458:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000645a:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    8000645e:	ffffb097          	auipc	ra,0xffffb
    80006462:	aac080e7          	jalr	-1364(ra) # 80000f0a <mycpu>
    80006466:	5d3c                	lw	a5,120(a0)
    80006468:	cf89                	beqz	a5,80006482 <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    8000646a:	ffffb097          	auipc	ra,0xffffb
    8000646e:	aa0080e7          	jalr	-1376(ra) # 80000f0a <mycpu>
    80006472:	5d3c                	lw	a5,120(a0)
    80006474:	2785                	addiw	a5,a5,1
    80006476:	dd3c                	sw	a5,120(a0)
}
    80006478:	60e2                	ld	ra,24(sp)
    8000647a:	6442                	ld	s0,16(sp)
    8000647c:	64a2                	ld	s1,8(sp)
    8000647e:	6105                	addi	sp,sp,32
    80006480:	8082                	ret
    mycpu()->intena = old;
    80006482:	ffffb097          	auipc	ra,0xffffb
    80006486:	a88080e7          	jalr	-1400(ra) # 80000f0a <mycpu>
  return (x & SSTATUS_SIE) != 0;
    8000648a:	8085                	srli	s1,s1,0x1
    8000648c:	8885                	andi	s1,s1,1
    8000648e:	dd64                	sw	s1,124(a0)
    80006490:	bfe9                	j	8000646a <push_off+0x24>

0000000080006492 <acquire>:
{
    80006492:	1101                	addi	sp,sp,-32
    80006494:	ec06                	sd	ra,24(sp)
    80006496:	e822                	sd	s0,16(sp)
    80006498:	e426                	sd	s1,8(sp)
    8000649a:	1000                	addi	s0,sp,32
    8000649c:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    8000649e:	00000097          	auipc	ra,0x0
    800064a2:	fa8080e7          	jalr	-88(ra) # 80006446 <push_off>
  if(holding(lk))
    800064a6:	8526                	mv	a0,s1
    800064a8:	00000097          	auipc	ra,0x0
    800064ac:	f70080e7          	jalr	-144(ra) # 80006418 <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    800064b0:	4705                	li	a4,1
  if(holding(lk))
    800064b2:	e115                	bnez	a0,800064d6 <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    800064b4:	87ba                	mv	a5,a4
    800064b6:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800064ba:	2781                	sext.w	a5,a5
    800064bc:	ffe5                	bnez	a5,800064b4 <acquire+0x22>
  __sync_synchronize();
    800064be:	0ff0000f          	fence
  lk->cpu = mycpu();
    800064c2:	ffffb097          	auipc	ra,0xffffb
    800064c6:	a48080e7          	jalr	-1464(ra) # 80000f0a <mycpu>
    800064ca:	e888                	sd	a0,16(s1)
}
    800064cc:	60e2                	ld	ra,24(sp)
    800064ce:	6442                	ld	s0,16(sp)
    800064d0:	64a2                	ld	s1,8(sp)
    800064d2:	6105                	addi	sp,sp,32
    800064d4:	8082                	ret
    panic("acquire");
    800064d6:	00002517          	auipc	a0,0x2
    800064da:	40250513          	addi	a0,a0,1026 # 800088d8 <digits+0x20>
    800064de:	00000097          	auipc	ra,0x0
    800064e2:	a6a080e7          	jalr	-1430(ra) # 80005f48 <panic>

00000000800064e6 <pop_off>:

void
pop_off(void)
{
    800064e6:	1141                	addi	sp,sp,-16
    800064e8:	e406                	sd	ra,8(sp)
    800064ea:	e022                	sd	s0,0(sp)
    800064ec:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    800064ee:	ffffb097          	auipc	ra,0xffffb
    800064f2:	a1c080e7          	jalr	-1508(ra) # 80000f0a <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800064f6:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    800064fa:	8b89                	andi	a5,a5,2
  if(intr_get())
    800064fc:	e78d                	bnez	a5,80006526 <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    800064fe:	5d3c                	lw	a5,120(a0)
    80006500:	02f05b63          	blez	a5,80006536 <pop_off+0x50>
    panic("pop_off");
  c->noff -= 1;
    80006504:	37fd                	addiw	a5,a5,-1
    80006506:	0007871b          	sext.w	a4,a5
    8000650a:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    8000650c:	eb09                	bnez	a4,8000651e <pop_off+0x38>
    8000650e:	5d7c                	lw	a5,124(a0)
    80006510:	c799                	beqz	a5,8000651e <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80006512:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80006516:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000651a:	10079073          	csrw	sstatus,a5
    intr_on();
}
    8000651e:	60a2                	ld	ra,8(sp)
    80006520:	6402                	ld	s0,0(sp)
    80006522:	0141                	addi	sp,sp,16
    80006524:	8082                	ret
    panic("pop_off - interruptible");
    80006526:	00002517          	auipc	a0,0x2
    8000652a:	3ba50513          	addi	a0,a0,954 # 800088e0 <digits+0x28>
    8000652e:	00000097          	auipc	ra,0x0
    80006532:	a1a080e7          	jalr	-1510(ra) # 80005f48 <panic>
    panic("pop_off");
    80006536:	00002517          	auipc	a0,0x2
    8000653a:	3c250513          	addi	a0,a0,962 # 800088f8 <digits+0x40>
    8000653e:	00000097          	auipc	ra,0x0
    80006542:	a0a080e7          	jalr	-1526(ra) # 80005f48 <panic>

0000000080006546 <release>:
{
    80006546:	1101                	addi	sp,sp,-32
    80006548:	ec06                	sd	ra,24(sp)
    8000654a:	e822                	sd	s0,16(sp)
    8000654c:	e426                	sd	s1,8(sp)
    8000654e:	1000                	addi	s0,sp,32
    80006550:	84aa                	mv	s1,a0
  if(!holding(lk))
    80006552:	00000097          	auipc	ra,0x0
    80006556:	ec6080e7          	jalr	-314(ra) # 80006418 <holding>
    8000655a:	c115                	beqz	a0,8000657e <release+0x38>
  lk->cpu = 0;
    8000655c:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    80006560:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    80006564:	0f50000f          	fence	iorw,ow
    80006568:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    8000656c:	00000097          	auipc	ra,0x0
    80006570:	f7a080e7          	jalr	-134(ra) # 800064e6 <pop_off>
}
    80006574:	60e2                	ld	ra,24(sp)
    80006576:	6442                	ld	s0,16(sp)
    80006578:	64a2                	ld	s1,8(sp)
    8000657a:	6105                	addi	sp,sp,32
    8000657c:	8082                	ret
    panic("release");
    8000657e:	00002517          	auipc	a0,0x2
    80006582:	38250513          	addi	a0,a0,898 # 80008900 <digits+0x48>
    80006586:	00000097          	auipc	ra,0x0
    8000658a:	9c2080e7          	jalr	-1598(ra) # 80005f48 <panic>
	...

0000000080007000 <_trampoline>:
    80007000:	14051573          	csrrw	a0,sscratch,a0
    80007004:	02153423          	sd	ra,40(a0)
    80007008:	02253823          	sd	sp,48(a0)
    8000700c:	02353c23          	sd	gp,56(a0)
    80007010:	04453023          	sd	tp,64(a0)
    80007014:	04553423          	sd	t0,72(a0)
    80007018:	04653823          	sd	t1,80(a0)
    8000701c:	04753c23          	sd	t2,88(a0)
    80007020:	f120                	sd	s0,96(a0)
    80007022:	f524                	sd	s1,104(a0)
    80007024:	fd2c                	sd	a1,120(a0)
    80007026:	e150                	sd	a2,128(a0)
    80007028:	e554                	sd	a3,136(a0)
    8000702a:	e958                	sd	a4,144(a0)
    8000702c:	ed5c                	sd	a5,152(a0)
    8000702e:	0b053023          	sd	a6,160(a0)
    80007032:	0b153423          	sd	a7,168(a0)
    80007036:	0b253823          	sd	s2,176(a0)
    8000703a:	0b353c23          	sd	s3,184(a0)
    8000703e:	0d453023          	sd	s4,192(a0)
    80007042:	0d553423          	sd	s5,200(a0)
    80007046:	0d653823          	sd	s6,208(a0)
    8000704a:	0d753c23          	sd	s7,216(a0)
    8000704e:	0f853023          	sd	s8,224(a0)
    80007052:	0f953423          	sd	s9,232(a0)
    80007056:	0fa53823          	sd	s10,240(a0)
    8000705a:	0fb53c23          	sd	s11,248(a0)
    8000705e:	11c53023          	sd	t3,256(a0)
    80007062:	11d53423          	sd	t4,264(a0)
    80007066:	11e53823          	sd	t5,272(a0)
    8000706a:	11f53c23          	sd	t6,280(a0)
    8000706e:	140022f3          	csrr	t0,sscratch
    80007072:	06553823          	sd	t0,112(a0)
    80007076:	00853103          	ld	sp,8(a0)
    8000707a:	02053203          	ld	tp,32(a0)
    8000707e:	01053283          	ld	t0,16(a0)
    80007082:	00053303          	ld	t1,0(a0)
    80007086:	18031073          	csrw	satp,t1
    8000708a:	12000073          	sfence.vma
    8000708e:	8282                	jr	t0

0000000080007090 <userret>:
    80007090:	18059073          	csrw	satp,a1
    80007094:	12000073          	sfence.vma
    80007098:	07053283          	ld	t0,112(a0)
    8000709c:	14029073          	csrw	sscratch,t0
    800070a0:	02853083          	ld	ra,40(a0)
    800070a4:	03053103          	ld	sp,48(a0)
    800070a8:	03853183          	ld	gp,56(a0)
    800070ac:	04053203          	ld	tp,64(a0)
    800070b0:	04853283          	ld	t0,72(a0)
    800070b4:	05053303          	ld	t1,80(a0)
    800070b8:	05853383          	ld	t2,88(a0)
    800070bc:	7120                	ld	s0,96(a0)
    800070be:	7524                	ld	s1,104(a0)
    800070c0:	7d2c                	ld	a1,120(a0)
    800070c2:	6150                	ld	a2,128(a0)
    800070c4:	6554                	ld	a3,136(a0)
    800070c6:	6958                	ld	a4,144(a0)
    800070c8:	6d5c                	ld	a5,152(a0)
    800070ca:	0a053803          	ld	a6,160(a0)
    800070ce:	0a853883          	ld	a7,168(a0)
    800070d2:	0b053903          	ld	s2,176(a0)
    800070d6:	0b853983          	ld	s3,184(a0)
    800070da:	0c053a03          	ld	s4,192(a0)
    800070de:	0c853a83          	ld	s5,200(a0)
    800070e2:	0d053b03          	ld	s6,208(a0)
    800070e6:	0d853b83          	ld	s7,216(a0)
    800070ea:	0e053c03          	ld	s8,224(a0)
    800070ee:	0e853c83          	ld	s9,232(a0)
    800070f2:	0f053d03          	ld	s10,240(a0)
    800070f6:	0f853d83          	ld	s11,248(a0)
    800070fa:	10053e03          	ld	t3,256(a0)
    800070fe:	10853e83          	ld	t4,264(a0)
    80007102:	11053f03          	ld	t5,272(a0)
    80007106:	11853f83          	ld	t6,280(a0)
    8000710a:	14051573          	csrrw	a0,sscratch,a0
    8000710e:	10200073          	sret
	...
