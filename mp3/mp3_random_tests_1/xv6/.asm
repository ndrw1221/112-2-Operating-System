
user/_custom_rttask:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <f>:
#include "kernel/types.h"
          #include "user/user.h"
          #include "user/threads.h"
          #define NULL 0
          int k = 0;
          void f(void *arg){
       0:	1101                	addi	sp,sp,-32
       2:	ec22                	sd	s0,24(sp)
       4:	1000                	addi	s0,sp,32
       6:	fea43423          	sd	a0,-24(s0)
              while (1) k++;
       a:	00002797          	auipc	a5,0x2
       e:	63e78793          	addi	a5,a5,1598 # 2648 <k>
      12:	439c                	lw	a5,0(a5)
      14:	2785                	addiw	a5,a5,1
      16:	0007871b          	sext.w	a4,a5
      1a:	00002797          	auipc	a5,0x2
      1e:	62e78793          	addi	a5,a5,1582 # 2648 <k>
      22:	c398                	sw	a4,0(a5)
      24:	b7dd                	j	a <f+0xa>

0000000000000026 <main>:
          }
          int main(int argc, char **argv){
      26:	7179                	addi	sp,sp,-48
      28:	f406                	sd	ra,40(sp)
      2a:	f022                	sd	s0,32(sp)
      2c:	1800                	addi	s0,sp,48
      2e:	87aa                	mv	a5,a0
      30:	fcb43823          	sd	a1,-48(s0)
      34:	fcf42e23          	sw	a5,-36(s0)
          struct thread *t1 = thread_create(f, NULL, 1, 13, 44, 1);
      38:	4785                	li	a5,1
      3a:	02c00713          	li	a4,44
      3e:	46b5                	li	a3,13
      40:	4605                	li	a2,1
      42:	4581                	li	a1,0
      44:	00000517          	auipc	a0,0x0
      48:	fbc50513          	addi	a0,a0,-68 # 0 <f>
      4c:	00001097          	auipc	ra,0x1
      50:	eda080e7          	jalr	-294(ra) # f26 <thread_create>
      54:	fea43423          	sd	a0,-24(s0)
thread_set_weight(t1, 1);
      58:	4585                	li	a1,1
      5a:	fe843503          	ld	a0,-24(s0)
      5e:	00001097          	auipc	ra,0x1
      62:	fd2080e7          	jalr	-46(ra) # 1030 <thread_set_weight>
thread_add_at(t1, 62);
      66:	03e00593          	li	a1,62
      6a:	fe843503          	ld	a0,-24(s0)
      6e:	00001097          	auipc	ra,0x1
      72:	fe4080e7          	jalr	-28(ra) # 1052 <thread_add_at>
thread_start_threading();
      76:	00001097          	auipc	ra,0x1
      7a:	7ea080e7          	jalr	2026(ra) # 1860 <thread_start_threading>
          printf("\nexited\n");
      7e:	00002517          	auipc	a0,0x2
      82:	43250513          	addi	a0,a0,1074 # 24b0 <schedule_dm+0x2d2>
      86:	00001097          	auipc	ra,0x1
      8a:	9e8080e7          	jalr	-1560(ra) # a6e <printf>
          exit(0);
      8e:	4501                	li	a0,0
      90:	00000097          	auipc	ra,0x0
      94:	498080e7          	jalr	1176(ra) # 528 <exit>

0000000000000098 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
      98:	7179                	addi	sp,sp,-48
      9a:	f422                	sd	s0,40(sp)
      9c:	1800                	addi	s0,sp,48
      9e:	fca43c23          	sd	a0,-40(s0)
      a2:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
      a6:	fd843783          	ld	a5,-40(s0)
      aa:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
      ae:	0001                	nop
      b0:	fd043703          	ld	a4,-48(s0)
      b4:	00170793          	addi	a5,a4,1
      b8:	fcf43823          	sd	a5,-48(s0)
      bc:	fd843783          	ld	a5,-40(s0)
      c0:	00178693          	addi	a3,a5,1
      c4:	fcd43c23          	sd	a3,-40(s0)
      c8:	00074703          	lbu	a4,0(a4)
      cc:	00e78023          	sb	a4,0(a5)
      d0:	0007c783          	lbu	a5,0(a5)
      d4:	fff1                	bnez	a5,b0 <strcpy+0x18>
    ;
  return os;
      d6:	fe843783          	ld	a5,-24(s0)
}
      da:	853e                	mv	a0,a5
      dc:	7422                	ld	s0,40(sp)
      de:	6145                	addi	sp,sp,48
      e0:	8082                	ret

00000000000000e2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
      e2:	1101                	addi	sp,sp,-32
      e4:	ec22                	sd	s0,24(sp)
      e6:	1000                	addi	s0,sp,32
      e8:	fea43423          	sd	a0,-24(s0)
      ec:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
      f0:	a819                	j	106 <strcmp+0x24>
    p++, q++;
      f2:	fe843783          	ld	a5,-24(s0)
      f6:	0785                	addi	a5,a5,1
      f8:	fef43423          	sd	a5,-24(s0)
      fc:	fe043783          	ld	a5,-32(s0)
     100:	0785                	addi	a5,a5,1
     102:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     106:	fe843783          	ld	a5,-24(s0)
     10a:	0007c783          	lbu	a5,0(a5)
     10e:	cb99                	beqz	a5,124 <strcmp+0x42>
     110:	fe843783          	ld	a5,-24(s0)
     114:	0007c703          	lbu	a4,0(a5)
     118:	fe043783          	ld	a5,-32(s0)
     11c:	0007c783          	lbu	a5,0(a5)
     120:	fcf709e3          	beq	a4,a5,f2 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     124:	fe843783          	ld	a5,-24(s0)
     128:	0007c783          	lbu	a5,0(a5)
     12c:	0007871b          	sext.w	a4,a5
     130:	fe043783          	ld	a5,-32(s0)
     134:	0007c783          	lbu	a5,0(a5)
     138:	2781                	sext.w	a5,a5
     13a:	40f707bb          	subw	a5,a4,a5
     13e:	2781                	sext.w	a5,a5
}
     140:	853e                	mv	a0,a5
     142:	6462                	ld	s0,24(sp)
     144:	6105                	addi	sp,sp,32
     146:	8082                	ret

0000000000000148 <strlen>:

uint
strlen(const char *s)
{
     148:	7179                	addi	sp,sp,-48
     14a:	f422                	sd	s0,40(sp)
     14c:	1800                	addi	s0,sp,48
     14e:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     152:	fe042623          	sw	zero,-20(s0)
     156:	a031                	j	162 <strlen+0x1a>
     158:	fec42783          	lw	a5,-20(s0)
     15c:	2785                	addiw	a5,a5,1
     15e:	fef42623          	sw	a5,-20(s0)
     162:	fec42783          	lw	a5,-20(s0)
     166:	fd843703          	ld	a4,-40(s0)
     16a:	97ba                	add	a5,a5,a4
     16c:	0007c783          	lbu	a5,0(a5)
     170:	f7e5                	bnez	a5,158 <strlen+0x10>
    ;
  return n;
     172:	fec42783          	lw	a5,-20(s0)
}
     176:	853e                	mv	a0,a5
     178:	7422                	ld	s0,40(sp)
     17a:	6145                	addi	sp,sp,48
     17c:	8082                	ret

000000000000017e <memset>:

void*
memset(void *dst, int c, uint n)
{
     17e:	7179                	addi	sp,sp,-48
     180:	f422                	sd	s0,40(sp)
     182:	1800                	addi	s0,sp,48
     184:	fca43c23          	sd	a0,-40(s0)
     188:	87ae                	mv	a5,a1
     18a:	8732                	mv	a4,a2
     18c:	fcf42a23          	sw	a5,-44(s0)
     190:	87ba                	mv	a5,a4
     192:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     196:	fd843783          	ld	a5,-40(s0)
     19a:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     19e:	fe042623          	sw	zero,-20(s0)
     1a2:	a00d                	j	1c4 <memset+0x46>
    cdst[i] = c;
     1a4:	fec42783          	lw	a5,-20(s0)
     1a8:	fe043703          	ld	a4,-32(s0)
     1ac:	97ba                	add	a5,a5,a4
     1ae:	fd442703          	lw	a4,-44(s0)
     1b2:	0ff77713          	andi	a4,a4,255
     1b6:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     1ba:	fec42783          	lw	a5,-20(s0)
     1be:	2785                	addiw	a5,a5,1
     1c0:	fef42623          	sw	a5,-20(s0)
     1c4:	fec42703          	lw	a4,-20(s0)
     1c8:	fd042783          	lw	a5,-48(s0)
     1cc:	2781                	sext.w	a5,a5
     1ce:	fcf76be3          	bltu	a4,a5,1a4 <memset+0x26>
  }
  return dst;
     1d2:	fd843783          	ld	a5,-40(s0)
}
     1d6:	853e                	mv	a0,a5
     1d8:	7422                	ld	s0,40(sp)
     1da:	6145                	addi	sp,sp,48
     1dc:	8082                	ret

00000000000001de <strchr>:

char*
strchr(const char *s, char c)
{
     1de:	1101                	addi	sp,sp,-32
     1e0:	ec22                	sd	s0,24(sp)
     1e2:	1000                	addi	s0,sp,32
     1e4:	fea43423          	sd	a0,-24(s0)
     1e8:	87ae                	mv	a5,a1
     1ea:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     1ee:	a01d                	j	214 <strchr+0x36>
    if(*s == c)
     1f0:	fe843783          	ld	a5,-24(s0)
     1f4:	0007c703          	lbu	a4,0(a5)
     1f8:	fe744783          	lbu	a5,-25(s0)
     1fc:	0ff7f793          	andi	a5,a5,255
     200:	00e79563          	bne	a5,a4,20a <strchr+0x2c>
      return (char*)s;
     204:	fe843783          	ld	a5,-24(s0)
     208:	a821                	j	220 <strchr+0x42>
  for(; *s; s++)
     20a:	fe843783          	ld	a5,-24(s0)
     20e:	0785                	addi	a5,a5,1
     210:	fef43423          	sd	a5,-24(s0)
     214:	fe843783          	ld	a5,-24(s0)
     218:	0007c783          	lbu	a5,0(a5)
     21c:	fbf1                	bnez	a5,1f0 <strchr+0x12>
  return 0;
     21e:	4781                	li	a5,0
}
     220:	853e                	mv	a0,a5
     222:	6462                	ld	s0,24(sp)
     224:	6105                	addi	sp,sp,32
     226:	8082                	ret

0000000000000228 <gets>:

char*
gets(char *buf, int max)
{
     228:	7179                	addi	sp,sp,-48
     22a:	f406                	sd	ra,40(sp)
     22c:	f022                	sd	s0,32(sp)
     22e:	1800                	addi	s0,sp,48
     230:	fca43c23          	sd	a0,-40(s0)
     234:	87ae                	mv	a5,a1
     236:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     23a:	fe042623          	sw	zero,-20(s0)
     23e:	a8a1                	j	296 <gets+0x6e>
    cc = read(0, &c, 1);
     240:	fe740793          	addi	a5,s0,-25
     244:	4605                	li	a2,1
     246:	85be                	mv	a1,a5
     248:	4501                	li	a0,0
     24a:	00000097          	auipc	ra,0x0
     24e:	2f6080e7          	jalr	758(ra) # 540 <read>
     252:	87aa                	mv	a5,a0
     254:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     258:	fe842783          	lw	a5,-24(s0)
     25c:	2781                	sext.w	a5,a5
     25e:	04f05763          	blez	a5,2ac <gets+0x84>
      break;
    buf[i++] = c;
     262:	fec42783          	lw	a5,-20(s0)
     266:	0017871b          	addiw	a4,a5,1
     26a:	fee42623          	sw	a4,-20(s0)
     26e:	873e                	mv	a4,a5
     270:	fd843783          	ld	a5,-40(s0)
     274:	97ba                	add	a5,a5,a4
     276:	fe744703          	lbu	a4,-25(s0)
     27a:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     27e:	fe744783          	lbu	a5,-25(s0)
     282:	873e                	mv	a4,a5
     284:	47a9                	li	a5,10
     286:	02f70463          	beq	a4,a5,2ae <gets+0x86>
     28a:	fe744783          	lbu	a5,-25(s0)
     28e:	873e                	mv	a4,a5
     290:	47b5                	li	a5,13
     292:	00f70e63          	beq	a4,a5,2ae <gets+0x86>
  for(i=0; i+1 < max; ){
     296:	fec42783          	lw	a5,-20(s0)
     29a:	2785                	addiw	a5,a5,1
     29c:	0007871b          	sext.w	a4,a5
     2a0:	fd442783          	lw	a5,-44(s0)
     2a4:	2781                	sext.w	a5,a5
     2a6:	f8f74de3          	blt	a4,a5,240 <gets+0x18>
     2aa:	a011                	j	2ae <gets+0x86>
      break;
     2ac:	0001                	nop
      break;
  }
  buf[i] = '\0';
     2ae:	fec42783          	lw	a5,-20(s0)
     2b2:	fd843703          	ld	a4,-40(s0)
     2b6:	97ba                	add	a5,a5,a4
     2b8:	00078023          	sb	zero,0(a5)
  return buf;
     2bc:	fd843783          	ld	a5,-40(s0)
}
     2c0:	853e                	mv	a0,a5
     2c2:	70a2                	ld	ra,40(sp)
     2c4:	7402                	ld	s0,32(sp)
     2c6:	6145                	addi	sp,sp,48
     2c8:	8082                	ret

00000000000002ca <stat>:

int
stat(const char *n, struct stat *st)
{
     2ca:	7179                	addi	sp,sp,-48
     2cc:	f406                	sd	ra,40(sp)
     2ce:	f022                	sd	s0,32(sp)
     2d0:	1800                	addi	s0,sp,48
     2d2:	fca43c23          	sd	a0,-40(s0)
     2d6:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     2da:	4581                	li	a1,0
     2dc:	fd843503          	ld	a0,-40(s0)
     2e0:	00000097          	auipc	ra,0x0
     2e4:	288080e7          	jalr	648(ra) # 568 <open>
     2e8:	87aa                	mv	a5,a0
     2ea:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     2ee:	fec42783          	lw	a5,-20(s0)
     2f2:	2781                	sext.w	a5,a5
     2f4:	0007d463          	bgez	a5,2fc <stat+0x32>
    return -1;
     2f8:	57fd                	li	a5,-1
     2fa:	a035                	j	326 <stat+0x5c>
  r = fstat(fd, st);
     2fc:	fec42783          	lw	a5,-20(s0)
     300:	fd043583          	ld	a1,-48(s0)
     304:	853e                	mv	a0,a5
     306:	00000097          	auipc	ra,0x0
     30a:	27a080e7          	jalr	634(ra) # 580 <fstat>
     30e:	87aa                	mv	a5,a0
     310:	fef42423          	sw	a5,-24(s0)
  close(fd);
     314:	fec42783          	lw	a5,-20(s0)
     318:	853e                	mv	a0,a5
     31a:	00000097          	auipc	ra,0x0
     31e:	236080e7          	jalr	566(ra) # 550 <close>
  return r;
     322:	fe842783          	lw	a5,-24(s0)
}
     326:	853e                	mv	a0,a5
     328:	70a2                	ld	ra,40(sp)
     32a:	7402                	ld	s0,32(sp)
     32c:	6145                	addi	sp,sp,48
     32e:	8082                	ret

0000000000000330 <atoi>:

int
atoi(const char *s)
{
     330:	7179                	addi	sp,sp,-48
     332:	f422                	sd	s0,40(sp)
     334:	1800                	addi	s0,sp,48
     336:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     33a:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     33e:	a815                	j	372 <atoi+0x42>
    n = n*10 + *s++ - '0';
     340:	fec42703          	lw	a4,-20(s0)
     344:	87ba                	mv	a5,a4
     346:	0027979b          	slliw	a5,a5,0x2
     34a:	9fb9                	addw	a5,a5,a4
     34c:	0017979b          	slliw	a5,a5,0x1
     350:	0007871b          	sext.w	a4,a5
     354:	fd843783          	ld	a5,-40(s0)
     358:	00178693          	addi	a3,a5,1
     35c:	fcd43c23          	sd	a3,-40(s0)
     360:	0007c783          	lbu	a5,0(a5)
     364:	2781                	sext.w	a5,a5
     366:	9fb9                	addw	a5,a5,a4
     368:	2781                	sext.w	a5,a5
     36a:	fd07879b          	addiw	a5,a5,-48
     36e:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     372:	fd843783          	ld	a5,-40(s0)
     376:	0007c783          	lbu	a5,0(a5)
     37a:	873e                	mv	a4,a5
     37c:	02f00793          	li	a5,47
     380:	00e7fb63          	bgeu	a5,a4,396 <atoi+0x66>
     384:	fd843783          	ld	a5,-40(s0)
     388:	0007c783          	lbu	a5,0(a5)
     38c:	873e                	mv	a4,a5
     38e:	03900793          	li	a5,57
     392:	fae7f7e3          	bgeu	a5,a4,340 <atoi+0x10>
  return n;
     396:	fec42783          	lw	a5,-20(s0)
}
     39a:	853e                	mv	a0,a5
     39c:	7422                	ld	s0,40(sp)
     39e:	6145                	addi	sp,sp,48
     3a0:	8082                	ret

00000000000003a2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     3a2:	7139                	addi	sp,sp,-64
     3a4:	fc22                	sd	s0,56(sp)
     3a6:	0080                	addi	s0,sp,64
     3a8:	fca43c23          	sd	a0,-40(s0)
     3ac:	fcb43823          	sd	a1,-48(s0)
     3b0:	87b2                	mv	a5,a2
     3b2:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     3b6:	fd843783          	ld	a5,-40(s0)
     3ba:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     3be:	fd043783          	ld	a5,-48(s0)
     3c2:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     3c6:	fe043703          	ld	a4,-32(s0)
     3ca:	fe843783          	ld	a5,-24(s0)
     3ce:	02e7fc63          	bgeu	a5,a4,406 <memmove+0x64>
    while(n-- > 0)
     3d2:	a00d                	j	3f4 <memmove+0x52>
      *dst++ = *src++;
     3d4:	fe043703          	ld	a4,-32(s0)
     3d8:	00170793          	addi	a5,a4,1
     3dc:	fef43023          	sd	a5,-32(s0)
     3e0:	fe843783          	ld	a5,-24(s0)
     3e4:	00178693          	addi	a3,a5,1
     3e8:	fed43423          	sd	a3,-24(s0)
     3ec:	00074703          	lbu	a4,0(a4)
     3f0:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     3f4:	fcc42783          	lw	a5,-52(s0)
     3f8:	fff7871b          	addiw	a4,a5,-1
     3fc:	fce42623          	sw	a4,-52(s0)
     400:	fcf04ae3          	bgtz	a5,3d4 <memmove+0x32>
     404:	a891                	j	458 <memmove+0xb6>
  } else {
    dst += n;
     406:	fcc42783          	lw	a5,-52(s0)
     40a:	fe843703          	ld	a4,-24(s0)
     40e:	97ba                	add	a5,a5,a4
     410:	fef43423          	sd	a5,-24(s0)
    src += n;
     414:	fcc42783          	lw	a5,-52(s0)
     418:	fe043703          	ld	a4,-32(s0)
     41c:	97ba                	add	a5,a5,a4
     41e:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     422:	a01d                	j	448 <memmove+0xa6>
      *--dst = *--src;
     424:	fe043783          	ld	a5,-32(s0)
     428:	17fd                	addi	a5,a5,-1
     42a:	fef43023          	sd	a5,-32(s0)
     42e:	fe843783          	ld	a5,-24(s0)
     432:	17fd                	addi	a5,a5,-1
     434:	fef43423          	sd	a5,-24(s0)
     438:	fe043783          	ld	a5,-32(s0)
     43c:	0007c703          	lbu	a4,0(a5)
     440:	fe843783          	ld	a5,-24(s0)
     444:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     448:	fcc42783          	lw	a5,-52(s0)
     44c:	fff7871b          	addiw	a4,a5,-1
     450:	fce42623          	sw	a4,-52(s0)
     454:	fcf048e3          	bgtz	a5,424 <memmove+0x82>
  }
  return vdst;
     458:	fd843783          	ld	a5,-40(s0)
}
     45c:	853e                	mv	a0,a5
     45e:	7462                	ld	s0,56(sp)
     460:	6121                	addi	sp,sp,64
     462:	8082                	ret

0000000000000464 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     464:	7139                	addi	sp,sp,-64
     466:	fc22                	sd	s0,56(sp)
     468:	0080                	addi	s0,sp,64
     46a:	fca43c23          	sd	a0,-40(s0)
     46e:	fcb43823          	sd	a1,-48(s0)
     472:	87b2                	mv	a5,a2
     474:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     478:	fd843783          	ld	a5,-40(s0)
     47c:	fef43423          	sd	a5,-24(s0)
     480:	fd043783          	ld	a5,-48(s0)
     484:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     488:	a0a1                	j	4d0 <memcmp+0x6c>
    if (*p1 != *p2) {
     48a:	fe843783          	ld	a5,-24(s0)
     48e:	0007c703          	lbu	a4,0(a5)
     492:	fe043783          	ld	a5,-32(s0)
     496:	0007c783          	lbu	a5,0(a5)
     49a:	02f70163          	beq	a4,a5,4bc <memcmp+0x58>
      return *p1 - *p2;
     49e:	fe843783          	ld	a5,-24(s0)
     4a2:	0007c783          	lbu	a5,0(a5)
     4a6:	0007871b          	sext.w	a4,a5
     4aa:	fe043783          	ld	a5,-32(s0)
     4ae:	0007c783          	lbu	a5,0(a5)
     4b2:	2781                	sext.w	a5,a5
     4b4:	40f707bb          	subw	a5,a4,a5
     4b8:	2781                	sext.w	a5,a5
     4ba:	a01d                	j	4e0 <memcmp+0x7c>
    }
    p1++;
     4bc:	fe843783          	ld	a5,-24(s0)
     4c0:	0785                	addi	a5,a5,1
     4c2:	fef43423          	sd	a5,-24(s0)
    p2++;
     4c6:	fe043783          	ld	a5,-32(s0)
     4ca:	0785                	addi	a5,a5,1
     4cc:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     4d0:	fcc42783          	lw	a5,-52(s0)
     4d4:	fff7871b          	addiw	a4,a5,-1
     4d8:	fce42623          	sw	a4,-52(s0)
     4dc:	f7dd                	bnez	a5,48a <memcmp+0x26>
  }
  return 0;
     4de:	4781                	li	a5,0
}
     4e0:	853e                	mv	a0,a5
     4e2:	7462                	ld	s0,56(sp)
     4e4:	6121                	addi	sp,sp,64
     4e6:	8082                	ret

00000000000004e8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     4e8:	7179                	addi	sp,sp,-48
     4ea:	f406                	sd	ra,40(sp)
     4ec:	f022                	sd	s0,32(sp)
     4ee:	1800                	addi	s0,sp,48
     4f0:	fea43423          	sd	a0,-24(s0)
     4f4:	feb43023          	sd	a1,-32(s0)
     4f8:	87b2                	mv	a5,a2
     4fa:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     4fe:	fdc42783          	lw	a5,-36(s0)
     502:	863e                	mv	a2,a5
     504:	fe043583          	ld	a1,-32(s0)
     508:	fe843503          	ld	a0,-24(s0)
     50c:	00000097          	auipc	ra,0x0
     510:	e96080e7          	jalr	-362(ra) # 3a2 <memmove>
     514:	87aa                	mv	a5,a0
}
     516:	853e                	mv	a0,a5
     518:	70a2                	ld	ra,40(sp)
     51a:	7402                	ld	s0,32(sp)
     51c:	6145                	addi	sp,sp,48
     51e:	8082                	ret

0000000000000520 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     520:	4885                	li	a7,1
 ecall
     522:	00000073          	ecall
 ret
     526:	8082                	ret

0000000000000528 <exit>:
.global exit
exit:
 li a7, SYS_exit
     528:	4889                	li	a7,2
 ecall
     52a:	00000073          	ecall
 ret
     52e:	8082                	ret

0000000000000530 <wait>:
.global wait
wait:
 li a7, SYS_wait
     530:	488d                	li	a7,3
 ecall
     532:	00000073          	ecall
 ret
     536:	8082                	ret

0000000000000538 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     538:	4891                	li	a7,4
 ecall
     53a:	00000073          	ecall
 ret
     53e:	8082                	ret

0000000000000540 <read>:
.global read
read:
 li a7, SYS_read
     540:	4895                	li	a7,5
 ecall
     542:	00000073          	ecall
 ret
     546:	8082                	ret

0000000000000548 <write>:
.global write
write:
 li a7, SYS_write
     548:	48c1                	li	a7,16
 ecall
     54a:	00000073          	ecall
 ret
     54e:	8082                	ret

0000000000000550 <close>:
.global close
close:
 li a7, SYS_close
     550:	48d5                	li	a7,21
 ecall
     552:	00000073          	ecall
 ret
     556:	8082                	ret

0000000000000558 <kill>:
.global kill
kill:
 li a7, SYS_kill
     558:	4899                	li	a7,6
 ecall
     55a:	00000073          	ecall
 ret
     55e:	8082                	ret

0000000000000560 <exec>:
.global exec
exec:
 li a7, SYS_exec
     560:	489d                	li	a7,7
 ecall
     562:	00000073          	ecall
 ret
     566:	8082                	ret

0000000000000568 <open>:
.global open
open:
 li a7, SYS_open
     568:	48bd                	li	a7,15
 ecall
     56a:	00000073          	ecall
 ret
     56e:	8082                	ret

0000000000000570 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     570:	48c5                	li	a7,17
 ecall
     572:	00000073          	ecall
 ret
     576:	8082                	ret

0000000000000578 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     578:	48c9                	li	a7,18
 ecall
     57a:	00000073          	ecall
 ret
     57e:	8082                	ret

0000000000000580 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     580:	48a1                	li	a7,8
 ecall
     582:	00000073          	ecall
 ret
     586:	8082                	ret

0000000000000588 <link>:
.global link
link:
 li a7, SYS_link
     588:	48cd                	li	a7,19
 ecall
     58a:	00000073          	ecall
 ret
     58e:	8082                	ret

0000000000000590 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     590:	48d1                	li	a7,20
 ecall
     592:	00000073          	ecall
 ret
     596:	8082                	ret

0000000000000598 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     598:	48a5                	li	a7,9
 ecall
     59a:	00000073          	ecall
 ret
     59e:	8082                	ret

00000000000005a0 <dup>:
.global dup
dup:
 li a7, SYS_dup
     5a0:	48a9                	li	a7,10
 ecall
     5a2:	00000073          	ecall
 ret
     5a6:	8082                	ret

00000000000005a8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     5a8:	48ad                	li	a7,11
 ecall
     5aa:	00000073          	ecall
 ret
     5ae:	8082                	ret

00000000000005b0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     5b0:	48b1                	li	a7,12
 ecall
     5b2:	00000073          	ecall
 ret
     5b6:	8082                	ret

00000000000005b8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     5b8:	48b5                	li	a7,13
 ecall
     5ba:	00000073          	ecall
 ret
     5be:	8082                	ret

00000000000005c0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     5c0:	48b9                	li	a7,14
 ecall
     5c2:	00000073          	ecall
 ret
     5c6:	8082                	ret

00000000000005c8 <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     5c8:	48d9                	li	a7,22
 ecall
     5ca:	00000073          	ecall
 ret
     5ce:	8082                	ret

00000000000005d0 <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     5d0:	48dd                	li	a7,23
 ecall
     5d2:	00000073          	ecall
 ret
     5d6:	8082                	ret

00000000000005d8 <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     5d8:	48e1                	li	a7,24
 ecall
     5da:	00000073          	ecall
 ret
     5de:	8082                	ret

00000000000005e0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     5e0:	1101                	addi	sp,sp,-32
     5e2:	ec06                	sd	ra,24(sp)
     5e4:	e822                	sd	s0,16(sp)
     5e6:	1000                	addi	s0,sp,32
     5e8:	87aa                	mv	a5,a0
     5ea:	872e                	mv	a4,a1
     5ec:	fef42623          	sw	a5,-20(s0)
     5f0:	87ba                	mv	a5,a4
     5f2:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     5f6:	feb40713          	addi	a4,s0,-21
     5fa:	fec42783          	lw	a5,-20(s0)
     5fe:	4605                	li	a2,1
     600:	85ba                	mv	a1,a4
     602:	853e                	mv	a0,a5
     604:	00000097          	auipc	ra,0x0
     608:	f44080e7          	jalr	-188(ra) # 548 <write>
}
     60c:	0001                	nop
     60e:	60e2                	ld	ra,24(sp)
     610:	6442                	ld	s0,16(sp)
     612:	6105                	addi	sp,sp,32
     614:	8082                	ret

0000000000000616 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     616:	7139                	addi	sp,sp,-64
     618:	fc06                	sd	ra,56(sp)
     61a:	f822                	sd	s0,48(sp)
     61c:	0080                	addi	s0,sp,64
     61e:	87aa                	mv	a5,a0
     620:	8736                	mv	a4,a3
     622:	fcf42623          	sw	a5,-52(s0)
     626:	87ae                	mv	a5,a1
     628:	fcf42423          	sw	a5,-56(s0)
     62c:	87b2                	mv	a5,a2
     62e:	fcf42223          	sw	a5,-60(s0)
     632:	87ba                	mv	a5,a4
     634:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     638:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     63c:	fc042783          	lw	a5,-64(s0)
     640:	2781                	sext.w	a5,a5
     642:	c38d                	beqz	a5,664 <printint+0x4e>
     644:	fc842783          	lw	a5,-56(s0)
     648:	2781                	sext.w	a5,a5
     64a:	0007dd63          	bgez	a5,664 <printint+0x4e>
    neg = 1;
     64e:	4785                	li	a5,1
     650:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     654:	fc842783          	lw	a5,-56(s0)
     658:	40f007bb          	negw	a5,a5
     65c:	2781                	sext.w	a5,a5
     65e:	fef42223          	sw	a5,-28(s0)
     662:	a029                	j	66c <printint+0x56>
  } else {
    x = xx;
     664:	fc842783          	lw	a5,-56(s0)
     668:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     66c:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     670:	fc442783          	lw	a5,-60(s0)
     674:	fe442703          	lw	a4,-28(s0)
     678:	02f777bb          	remuw	a5,a4,a5
     67c:	0007861b          	sext.w	a2,a5
     680:	fec42783          	lw	a5,-20(s0)
     684:	0017871b          	addiw	a4,a5,1
     688:	fee42623          	sw	a4,-20(s0)
     68c:	00002697          	auipc	a3,0x2
     690:	f7c68693          	addi	a3,a3,-132 # 2608 <digits>
     694:	02061713          	slli	a4,a2,0x20
     698:	9301                	srli	a4,a4,0x20
     69a:	9736                	add	a4,a4,a3
     69c:	00074703          	lbu	a4,0(a4)
     6a0:	ff040693          	addi	a3,s0,-16
     6a4:	97b6                	add	a5,a5,a3
     6a6:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     6aa:	fc442783          	lw	a5,-60(s0)
     6ae:	fe442703          	lw	a4,-28(s0)
     6b2:	02f757bb          	divuw	a5,a4,a5
     6b6:	fef42223          	sw	a5,-28(s0)
     6ba:	fe442783          	lw	a5,-28(s0)
     6be:	2781                	sext.w	a5,a5
     6c0:	fbc5                	bnez	a5,670 <printint+0x5a>
  if(neg)
     6c2:	fe842783          	lw	a5,-24(s0)
     6c6:	2781                	sext.w	a5,a5
     6c8:	cf95                	beqz	a5,704 <printint+0xee>
    buf[i++] = '-';
     6ca:	fec42783          	lw	a5,-20(s0)
     6ce:	0017871b          	addiw	a4,a5,1
     6d2:	fee42623          	sw	a4,-20(s0)
     6d6:	ff040713          	addi	a4,s0,-16
     6da:	97ba                	add	a5,a5,a4
     6dc:	02d00713          	li	a4,45
     6e0:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     6e4:	a005                	j	704 <printint+0xee>
    putc(fd, buf[i]);
     6e6:	fec42783          	lw	a5,-20(s0)
     6ea:	ff040713          	addi	a4,s0,-16
     6ee:	97ba                	add	a5,a5,a4
     6f0:	fe07c703          	lbu	a4,-32(a5)
     6f4:	fcc42783          	lw	a5,-52(s0)
     6f8:	85ba                	mv	a1,a4
     6fa:	853e                	mv	a0,a5
     6fc:	00000097          	auipc	ra,0x0
     700:	ee4080e7          	jalr	-284(ra) # 5e0 <putc>
  while(--i >= 0)
     704:	fec42783          	lw	a5,-20(s0)
     708:	37fd                	addiw	a5,a5,-1
     70a:	fef42623          	sw	a5,-20(s0)
     70e:	fec42783          	lw	a5,-20(s0)
     712:	2781                	sext.w	a5,a5
     714:	fc07d9e3          	bgez	a5,6e6 <printint+0xd0>
}
     718:	0001                	nop
     71a:	0001                	nop
     71c:	70e2                	ld	ra,56(sp)
     71e:	7442                	ld	s0,48(sp)
     720:	6121                	addi	sp,sp,64
     722:	8082                	ret

0000000000000724 <printptr>:

static void
printptr(int fd, uint64 x) {
     724:	7179                	addi	sp,sp,-48
     726:	f406                	sd	ra,40(sp)
     728:	f022                	sd	s0,32(sp)
     72a:	1800                	addi	s0,sp,48
     72c:	87aa                	mv	a5,a0
     72e:	fcb43823          	sd	a1,-48(s0)
     732:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     736:	fdc42783          	lw	a5,-36(s0)
     73a:	03000593          	li	a1,48
     73e:	853e                	mv	a0,a5
     740:	00000097          	auipc	ra,0x0
     744:	ea0080e7          	jalr	-352(ra) # 5e0 <putc>
  putc(fd, 'x');
     748:	fdc42783          	lw	a5,-36(s0)
     74c:	07800593          	li	a1,120
     750:	853e                	mv	a0,a5
     752:	00000097          	auipc	ra,0x0
     756:	e8e080e7          	jalr	-370(ra) # 5e0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     75a:	fe042623          	sw	zero,-20(s0)
     75e:	a82d                	j	798 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     760:	fd043783          	ld	a5,-48(s0)
     764:	93f1                	srli	a5,a5,0x3c
     766:	00002717          	auipc	a4,0x2
     76a:	ea270713          	addi	a4,a4,-350 # 2608 <digits>
     76e:	97ba                	add	a5,a5,a4
     770:	0007c703          	lbu	a4,0(a5)
     774:	fdc42783          	lw	a5,-36(s0)
     778:	85ba                	mv	a1,a4
     77a:	853e                	mv	a0,a5
     77c:	00000097          	auipc	ra,0x0
     780:	e64080e7          	jalr	-412(ra) # 5e0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     784:	fec42783          	lw	a5,-20(s0)
     788:	2785                	addiw	a5,a5,1
     78a:	fef42623          	sw	a5,-20(s0)
     78e:	fd043783          	ld	a5,-48(s0)
     792:	0792                	slli	a5,a5,0x4
     794:	fcf43823          	sd	a5,-48(s0)
     798:	fec42783          	lw	a5,-20(s0)
     79c:	873e                	mv	a4,a5
     79e:	47bd                	li	a5,15
     7a0:	fce7f0e3          	bgeu	a5,a4,760 <printptr+0x3c>
}
     7a4:	0001                	nop
     7a6:	0001                	nop
     7a8:	70a2                	ld	ra,40(sp)
     7aa:	7402                	ld	s0,32(sp)
     7ac:	6145                	addi	sp,sp,48
     7ae:	8082                	ret

00000000000007b0 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     7b0:	715d                	addi	sp,sp,-80
     7b2:	e486                	sd	ra,72(sp)
     7b4:	e0a2                	sd	s0,64(sp)
     7b6:	0880                	addi	s0,sp,80
     7b8:	87aa                	mv	a5,a0
     7ba:	fcb43023          	sd	a1,-64(s0)
     7be:	fac43c23          	sd	a2,-72(s0)
     7c2:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     7c6:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     7ca:	fe042223          	sw	zero,-28(s0)
     7ce:	a42d                	j	9f8 <vprintf+0x248>
    c = fmt[i] & 0xff;
     7d0:	fe442783          	lw	a5,-28(s0)
     7d4:	fc043703          	ld	a4,-64(s0)
     7d8:	97ba                	add	a5,a5,a4
     7da:	0007c783          	lbu	a5,0(a5)
     7de:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     7e2:	fe042783          	lw	a5,-32(s0)
     7e6:	2781                	sext.w	a5,a5
     7e8:	eb9d                	bnez	a5,81e <vprintf+0x6e>
      if(c == '%'){
     7ea:	fdc42783          	lw	a5,-36(s0)
     7ee:	0007871b          	sext.w	a4,a5
     7f2:	02500793          	li	a5,37
     7f6:	00f71763          	bne	a4,a5,804 <vprintf+0x54>
        state = '%';
     7fa:	02500793          	li	a5,37
     7fe:	fef42023          	sw	a5,-32(s0)
     802:	a2f5                	j	9ee <vprintf+0x23e>
      } else {
        putc(fd, c);
     804:	fdc42783          	lw	a5,-36(s0)
     808:	0ff7f713          	andi	a4,a5,255
     80c:	fcc42783          	lw	a5,-52(s0)
     810:	85ba                	mv	a1,a4
     812:	853e                	mv	a0,a5
     814:	00000097          	auipc	ra,0x0
     818:	dcc080e7          	jalr	-564(ra) # 5e0 <putc>
     81c:	aac9                	j	9ee <vprintf+0x23e>
      }
    } else if(state == '%'){
     81e:	fe042783          	lw	a5,-32(s0)
     822:	0007871b          	sext.w	a4,a5
     826:	02500793          	li	a5,37
     82a:	1cf71263          	bne	a4,a5,9ee <vprintf+0x23e>
      if(c == 'd'){
     82e:	fdc42783          	lw	a5,-36(s0)
     832:	0007871b          	sext.w	a4,a5
     836:	06400793          	li	a5,100
     83a:	02f71463          	bne	a4,a5,862 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     83e:	fb843783          	ld	a5,-72(s0)
     842:	00878713          	addi	a4,a5,8
     846:	fae43c23          	sd	a4,-72(s0)
     84a:	4398                	lw	a4,0(a5)
     84c:	fcc42783          	lw	a5,-52(s0)
     850:	4685                	li	a3,1
     852:	4629                	li	a2,10
     854:	85ba                	mv	a1,a4
     856:	853e                	mv	a0,a5
     858:	00000097          	auipc	ra,0x0
     85c:	dbe080e7          	jalr	-578(ra) # 616 <printint>
     860:	a269                	j	9ea <vprintf+0x23a>
      } else if(c == 'l') {
     862:	fdc42783          	lw	a5,-36(s0)
     866:	0007871b          	sext.w	a4,a5
     86a:	06c00793          	li	a5,108
     86e:	02f71663          	bne	a4,a5,89a <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     872:	fb843783          	ld	a5,-72(s0)
     876:	00878713          	addi	a4,a5,8
     87a:	fae43c23          	sd	a4,-72(s0)
     87e:	639c                	ld	a5,0(a5)
     880:	0007871b          	sext.w	a4,a5
     884:	fcc42783          	lw	a5,-52(s0)
     888:	4681                	li	a3,0
     88a:	4629                	li	a2,10
     88c:	85ba                	mv	a1,a4
     88e:	853e                	mv	a0,a5
     890:	00000097          	auipc	ra,0x0
     894:	d86080e7          	jalr	-634(ra) # 616 <printint>
     898:	aa89                	j	9ea <vprintf+0x23a>
      } else if(c == 'x') {
     89a:	fdc42783          	lw	a5,-36(s0)
     89e:	0007871b          	sext.w	a4,a5
     8a2:	07800793          	li	a5,120
     8a6:	02f71463          	bne	a4,a5,8ce <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     8aa:	fb843783          	ld	a5,-72(s0)
     8ae:	00878713          	addi	a4,a5,8
     8b2:	fae43c23          	sd	a4,-72(s0)
     8b6:	4398                	lw	a4,0(a5)
     8b8:	fcc42783          	lw	a5,-52(s0)
     8bc:	4681                	li	a3,0
     8be:	4641                	li	a2,16
     8c0:	85ba                	mv	a1,a4
     8c2:	853e                	mv	a0,a5
     8c4:	00000097          	auipc	ra,0x0
     8c8:	d52080e7          	jalr	-686(ra) # 616 <printint>
     8cc:	aa39                	j	9ea <vprintf+0x23a>
      } else if(c == 'p') {
     8ce:	fdc42783          	lw	a5,-36(s0)
     8d2:	0007871b          	sext.w	a4,a5
     8d6:	07000793          	li	a5,112
     8da:	02f71263          	bne	a4,a5,8fe <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     8de:	fb843783          	ld	a5,-72(s0)
     8e2:	00878713          	addi	a4,a5,8
     8e6:	fae43c23          	sd	a4,-72(s0)
     8ea:	6398                	ld	a4,0(a5)
     8ec:	fcc42783          	lw	a5,-52(s0)
     8f0:	85ba                	mv	a1,a4
     8f2:	853e                	mv	a0,a5
     8f4:	00000097          	auipc	ra,0x0
     8f8:	e30080e7          	jalr	-464(ra) # 724 <printptr>
     8fc:	a0fd                	j	9ea <vprintf+0x23a>
      } else if(c == 's'){
     8fe:	fdc42783          	lw	a5,-36(s0)
     902:	0007871b          	sext.w	a4,a5
     906:	07300793          	li	a5,115
     90a:	04f71c63          	bne	a4,a5,962 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     90e:	fb843783          	ld	a5,-72(s0)
     912:	00878713          	addi	a4,a5,8
     916:	fae43c23          	sd	a4,-72(s0)
     91a:	639c                	ld	a5,0(a5)
     91c:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     920:	fe843783          	ld	a5,-24(s0)
     924:	eb8d                	bnez	a5,956 <vprintf+0x1a6>
          s = "(null)";
     926:	00002797          	auipc	a5,0x2
     92a:	b9a78793          	addi	a5,a5,-1126 # 24c0 <schedule_dm+0x2e2>
     92e:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     932:	a015                	j	956 <vprintf+0x1a6>
          putc(fd, *s);
     934:	fe843783          	ld	a5,-24(s0)
     938:	0007c703          	lbu	a4,0(a5)
     93c:	fcc42783          	lw	a5,-52(s0)
     940:	85ba                	mv	a1,a4
     942:	853e                	mv	a0,a5
     944:	00000097          	auipc	ra,0x0
     948:	c9c080e7          	jalr	-868(ra) # 5e0 <putc>
          s++;
     94c:	fe843783          	ld	a5,-24(s0)
     950:	0785                	addi	a5,a5,1
     952:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     956:	fe843783          	ld	a5,-24(s0)
     95a:	0007c783          	lbu	a5,0(a5)
     95e:	fbf9                	bnez	a5,934 <vprintf+0x184>
     960:	a069                	j	9ea <vprintf+0x23a>
        }
      } else if(c == 'c'){
     962:	fdc42783          	lw	a5,-36(s0)
     966:	0007871b          	sext.w	a4,a5
     96a:	06300793          	li	a5,99
     96e:	02f71463          	bne	a4,a5,996 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     972:	fb843783          	ld	a5,-72(s0)
     976:	00878713          	addi	a4,a5,8
     97a:	fae43c23          	sd	a4,-72(s0)
     97e:	439c                	lw	a5,0(a5)
     980:	0ff7f713          	andi	a4,a5,255
     984:	fcc42783          	lw	a5,-52(s0)
     988:	85ba                	mv	a1,a4
     98a:	853e                	mv	a0,a5
     98c:	00000097          	auipc	ra,0x0
     990:	c54080e7          	jalr	-940(ra) # 5e0 <putc>
     994:	a899                	j	9ea <vprintf+0x23a>
      } else if(c == '%'){
     996:	fdc42783          	lw	a5,-36(s0)
     99a:	0007871b          	sext.w	a4,a5
     99e:	02500793          	li	a5,37
     9a2:	00f71f63          	bne	a4,a5,9c0 <vprintf+0x210>
        putc(fd, c);
     9a6:	fdc42783          	lw	a5,-36(s0)
     9aa:	0ff7f713          	andi	a4,a5,255
     9ae:	fcc42783          	lw	a5,-52(s0)
     9b2:	85ba                	mv	a1,a4
     9b4:	853e                	mv	a0,a5
     9b6:	00000097          	auipc	ra,0x0
     9ba:	c2a080e7          	jalr	-982(ra) # 5e0 <putc>
     9be:	a035                	j	9ea <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     9c0:	fcc42783          	lw	a5,-52(s0)
     9c4:	02500593          	li	a1,37
     9c8:	853e                	mv	a0,a5
     9ca:	00000097          	auipc	ra,0x0
     9ce:	c16080e7          	jalr	-1002(ra) # 5e0 <putc>
        putc(fd, c);
     9d2:	fdc42783          	lw	a5,-36(s0)
     9d6:	0ff7f713          	andi	a4,a5,255
     9da:	fcc42783          	lw	a5,-52(s0)
     9de:	85ba                	mv	a1,a4
     9e0:	853e                	mv	a0,a5
     9e2:	00000097          	auipc	ra,0x0
     9e6:	bfe080e7          	jalr	-1026(ra) # 5e0 <putc>
      }
      state = 0;
     9ea:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     9ee:	fe442783          	lw	a5,-28(s0)
     9f2:	2785                	addiw	a5,a5,1
     9f4:	fef42223          	sw	a5,-28(s0)
     9f8:	fe442783          	lw	a5,-28(s0)
     9fc:	fc043703          	ld	a4,-64(s0)
     a00:	97ba                	add	a5,a5,a4
     a02:	0007c783          	lbu	a5,0(a5)
     a06:	dc0795e3          	bnez	a5,7d0 <vprintf+0x20>
    }
  }
}
     a0a:	0001                	nop
     a0c:	0001                	nop
     a0e:	60a6                	ld	ra,72(sp)
     a10:	6406                	ld	s0,64(sp)
     a12:	6161                	addi	sp,sp,80
     a14:	8082                	ret

0000000000000a16 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     a16:	7159                	addi	sp,sp,-112
     a18:	fc06                	sd	ra,56(sp)
     a1a:	f822                	sd	s0,48(sp)
     a1c:	0080                	addi	s0,sp,64
     a1e:	fcb43823          	sd	a1,-48(s0)
     a22:	e010                	sd	a2,0(s0)
     a24:	e414                	sd	a3,8(s0)
     a26:	e818                	sd	a4,16(s0)
     a28:	ec1c                	sd	a5,24(s0)
     a2a:	03043023          	sd	a6,32(s0)
     a2e:	03143423          	sd	a7,40(s0)
     a32:	87aa                	mv	a5,a0
     a34:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     a38:	03040793          	addi	a5,s0,48
     a3c:	fcf43423          	sd	a5,-56(s0)
     a40:	fc843783          	ld	a5,-56(s0)
     a44:	fd078793          	addi	a5,a5,-48
     a48:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     a4c:	fe843703          	ld	a4,-24(s0)
     a50:	fdc42783          	lw	a5,-36(s0)
     a54:	863a                	mv	a2,a4
     a56:	fd043583          	ld	a1,-48(s0)
     a5a:	853e                	mv	a0,a5
     a5c:	00000097          	auipc	ra,0x0
     a60:	d54080e7          	jalr	-684(ra) # 7b0 <vprintf>
}
     a64:	0001                	nop
     a66:	70e2                	ld	ra,56(sp)
     a68:	7442                	ld	s0,48(sp)
     a6a:	6165                	addi	sp,sp,112
     a6c:	8082                	ret

0000000000000a6e <printf>:

void
printf(const char *fmt, ...)
{
     a6e:	7159                	addi	sp,sp,-112
     a70:	f406                	sd	ra,40(sp)
     a72:	f022                	sd	s0,32(sp)
     a74:	1800                	addi	s0,sp,48
     a76:	fca43c23          	sd	a0,-40(s0)
     a7a:	e40c                	sd	a1,8(s0)
     a7c:	e810                	sd	a2,16(s0)
     a7e:	ec14                	sd	a3,24(s0)
     a80:	f018                	sd	a4,32(s0)
     a82:	f41c                	sd	a5,40(s0)
     a84:	03043823          	sd	a6,48(s0)
     a88:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     a8c:	04040793          	addi	a5,s0,64
     a90:	fcf43823          	sd	a5,-48(s0)
     a94:	fd043783          	ld	a5,-48(s0)
     a98:	fc878793          	addi	a5,a5,-56
     a9c:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     aa0:	fe843783          	ld	a5,-24(s0)
     aa4:	863e                	mv	a2,a5
     aa6:	fd843583          	ld	a1,-40(s0)
     aaa:	4505                	li	a0,1
     aac:	00000097          	auipc	ra,0x0
     ab0:	d04080e7          	jalr	-764(ra) # 7b0 <vprintf>
}
     ab4:	0001                	nop
     ab6:	70a2                	ld	ra,40(sp)
     ab8:	7402                	ld	s0,32(sp)
     aba:	6165                	addi	sp,sp,112
     abc:	8082                	ret

0000000000000abe <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     abe:	7179                	addi	sp,sp,-48
     ac0:	f422                	sd	s0,40(sp)
     ac2:	1800                	addi	s0,sp,48
     ac4:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     ac8:	fd843783          	ld	a5,-40(s0)
     acc:	17c1                	addi	a5,a5,-16
     ace:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     ad2:	00002797          	auipc	a5,0x2
     ad6:	b8e78793          	addi	a5,a5,-1138 # 2660 <freep>
     ada:	639c                	ld	a5,0(a5)
     adc:	fef43423          	sd	a5,-24(s0)
     ae0:	a815                	j	b14 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     ae2:	fe843783          	ld	a5,-24(s0)
     ae6:	639c                	ld	a5,0(a5)
     ae8:	fe843703          	ld	a4,-24(s0)
     aec:	00f76f63          	bltu	a4,a5,b0a <free+0x4c>
     af0:	fe043703          	ld	a4,-32(s0)
     af4:	fe843783          	ld	a5,-24(s0)
     af8:	02e7eb63          	bltu	a5,a4,b2e <free+0x70>
     afc:	fe843783          	ld	a5,-24(s0)
     b00:	639c                	ld	a5,0(a5)
     b02:	fe043703          	ld	a4,-32(s0)
     b06:	02f76463          	bltu	a4,a5,b2e <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     b0a:	fe843783          	ld	a5,-24(s0)
     b0e:	639c                	ld	a5,0(a5)
     b10:	fef43423          	sd	a5,-24(s0)
     b14:	fe043703          	ld	a4,-32(s0)
     b18:	fe843783          	ld	a5,-24(s0)
     b1c:	fce7f3e3          	bgeu	a5,a4,ae2 <free+0x24>
     b20:	fe843783          	ld	a5,-24(s0)
     b24:	639c                	ld	a5,0(a5)
     b26:	fe043703          	ld	a4,-32(s0)
     b2a:	faf77ce3          	bgeu	a4,a5,ae2 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     b2e:	fe043783          	ld	a5,-32(s0)
     b32:	479c                	lw	a5,8(a5)
     b34:	1782                	slli	a5,a5,0x20
     b36:	9381                	srli	a5,a5,0x20
     b38:	0792                	slli	a5,a5,0x4
     b3a:	fe043703          	ld	a4,-32(s0)
     b3e:	973e                	add	a4,a4,a5
     b40:	fe843783          	ld	a5,-24(s0)
     b44:	639c                	ld	a5,0(a5)
     b46:	02f71763          	bne	a4,a5,b74 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     b4a:	fe043783          	ld	a5,-32(s0)
     b4e:	4798                	lw	a4,8(a5)
     b50:	fe843783          	ld	a5,-24(s0)
     b54:	639c                	ld	a5,0(a5)
     b56:	479c                	lw	a5,8(a5)
     b58:	9fb9                	addw	a5,a5,a4
     b5a:	0007871b          	sext.w	a4,a5
     b5e:	fe043783          	ld	a5,-32(s0)
     b62:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     b64:	fe843783          	ld	a5,-24(s0)
     b68:	639c                	ld	a5,0(a5)
     b6a:	6398                	ld	a4,0(a5)
     b6c:	fe043783          	ld	a5,-32(s0)
     b70:	e398                	sd	a4,0(a5)
     b72:	a039                	j	b80 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     b74:	fe843783          	ld	a5,-24(s0)
     b78:	6398                	ld	a4,0(a5)
     b7a:	fe043783          	ld	a5,-32(s0)
     b7e:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     b80:	fe843783          	ld	a5,-24(s0)
     b84:	479c                	lw	a5,8(a5)
     b86:	1782                	slli	a5,a5,0x20
     b88:	9381                	srli	a5,a5,0x20
     b8a:	0792                	slli	a5,a5,0x4
     b8c:	fe843703          	ld	a4,-24(s0)
     b90:	97ba                	add	a5,a5,a4
     b92:	fe043703          	ld	a4,-32(s0)
     b96:	02f71563          	bne	a4,a5,bc0 <free+0x102>
    p->s.size += bp->s.size;
     b9a:	fe843783          	ld	a5,-24(s0)
     b9e:	4798                	lw	a4,8(a5)
     ba0:	fe043783          	ld	a5,-32(s0)
     ba4:	479c                	lw	a5,8(a5)
     ba6:	9fb9                	addw	a5,a5,a4
     ba8:	0007871b          	sext.w	a4,a5
     bac:	fe843783          	ld	a5,-24(s0)
     bb0:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     bb2:	fe043783          	ld	a5,-32(s0)
     bb6:	6398                	ld	a4,0(a5)
     bb8:	fe843783          	ld	a5,-24(s0)
     bbc:	e398                	sd	a4,0(a5)
     bbe:	a031                	j	bca <free+0x10c>
  } else
    p->s.ptr = bp;
     bc0:	fe843783          	ld	a5,-24(s0)
     bc4:	fe043703          	ld	a4,-32(s0)
     bc8:	e398                	sd	a4,0(a5)
  freep = p;
     bca:	00002797          	auipc	a5,0x2
     bce:	a9678793          	addi	a5,a5,-1386 # 2660 <freep>
     bd2:	fe843703          	ld	a4,-24(s0)
     bd6:	e398                	sd	a4,0(a5)
}
     bd8:	0001                	nop
     bda:	7422                	ld	s0,40(sp)
     bdc:	6145                	addi	sp,sp,48
     bde:	8082                	ret

0000000000000be0 <morecore>:

static Header*
morecore(uint nu)
{
     be0:	7179                	addi	sp,sp,-48
     be2:	f406                	sd	ra,40(sp)
     be4:	f022                	sd	s0,32(sp)
     be6:	1800                	addi	s0,sp,48
     be8:	87aa                	mv	a5,a0
     bea:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     bee:	fdc42783          	lw	a5,-36(s0)
     bf2:	0007871b          	sext.w	a4,a5
     bf6:	6785                	lui	a5,0x1
     bf8:	00f77563          	bgeu	a4,a5,c02 <morecore+0x22>
    nu = 4096;
     bfc:	6785                	lui	a5,0x1
     bfe:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     c02:	fdc42783          	lw	a5,-36(s0)
     c06:	0047979b          	slliw	a5,a5,0x4
     c0a:	2781                	sext.w	a5,a5
     c0c:	2781                	sext.w	a5,a5
     c0e:	853e                	mv	a0,a5
     c10:	00000097          	auipc	ra,0x0
     c14:	9a0080e7          	jalr	-1632(ra) # 5b0 <sbrk>
     c18:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     c1c:	fe843703          	ld	a4,-24(s0)
     c20:	57fd                	li	a5,-1
     c22:	00f71463          	bne	a4,a5,c2a <morecore+0x4a>
    return 0;
     c26:	4781                	li	a5,0
     c28:	a03d                	j	c56 <morecore+0x76>
  hp = (Header*)p;
     c2a:	fe843783          	ld	a5,-24(s0)
     c2e:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     c32:	fe043783          	ld	a5,-32(s0)
     c36:	fdc42703          	lw	a4,-36(s0)
     c3a:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     c3c:	fe043783          	ld	a5,-32(s0)
     c40:	07c1                	addi	a5,a5,16
     c42:	853e                	mv	a0,a5
     c44:	00000097          	auipc	ra,0x0
     c48:	e7a080e7          	jalr	-390(ra) # abe <free>
  return freep;
     c4c:	00002797          	auipc	a5,0x2
     c50:	a1478793          	addi	a5,a5,-1516 # 2660 <freep>
     c54:	639c                	ld	a5,0(a5)
}
     c56:	853e                	mv	a0,a5
     c58:	70a2                	ld	ra,40(sp)
     c5a:	7402                	ld	s0,32(sp)
     c5c:	6145                	addi	sp,sp,48
     c5e:	8082                	ret

0000000000000c60 <malloc>:

void*
malloc(uint nbytes)
{
     c60:	7139                	addi	sp,sp,-64
     c62:	fc06                	sd	ra,56(sp)
     c64:	f822                	sd	s0,48(sp)
     c66:	0080                	addi	s0,sp,64
     c68:	87aa                	mv	a5,a0
     c6a:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     c6e:	fcc46783          	lwu	a5,-52(s0)
     c72:	07bd                	addi	a5,a5,15
     c74:	8391                	srli	a5,a5,0x4
     c76:	2781                	sext.w	a5,a5
     c78:	2785                	addiw	a5,a5,1
     c7a:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     c7e:	00002797          	auipc	a5,0x2
     c82:	9e278793          	addi	a5,a5,-1566 # 2660 <freep>
     c86:	639c                	ld	a5,0(a5)
     c88:	fef43023          	sd	a5,-32(s0)
     c8c:	fe043783          	ld	a5,-32(s0)
     c90:	ef95                	bnez	a5,ccc <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     c92:	00002797          	auipc	a5,0x2
     c96:	9be78793          	addi	a5,a5,-1602 # 2650 <base>
     c9a:	fef43023          	sd	a5,-32(s0)
     c9e:	00002797          	auipc	a5,0x2
     ca2:	9c278793          	addi	a5,a5,-1598 # 2660 <freep>
     ca6:	fe043703          	ld	a4,-32(s0)
     caa:	e398                	sd	a4,0(a5)
     cac:	00002797          	auipc	a5,0x2
     cb0:	9b478793          	addi	a5,a5,-1612 # 2660 <freep>
     cb4:	6398                	ld	a4,0(a5)
     cb6:	00002797          	auipc	a5,0x2
     cba:	99a78793          	addi	a5,a5,-1638 # 2650 <base>
     cbe:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     cc0:	00002797          	auipc	a5,0x2
     cc4:	99078793          	addi	a5,a5,-1648 # 2650 <base>
     cc8:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     ccc:	fe043783          	ld	a5,-32(s0)
     cd0:	639c                	ld	a5,0(a5)
     cd2:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     cd6:	fe843783          	ld	a5,-24(s0)
     cda:	4798                	lw	a4,8(a5)
     cdc:	fdc42783          	lw	a5,-36(s0)
     ce0:	2781                	sext.w	a5,a5
     ce2:	06f76863          	bltu	a4,a5,d52 <malloc+0xf2>
      if(p->s.size == nunits)
     ce6:	fe843783          	ld	a5,-24(s0)
     cea:	4798                	lw	a4,8(a5)
     cec:	fdc42783          	lw	a5,-36(s0)
     cf0:	2781                	sext.w	a5,a5
     cf2:	00e79963          	bne	a5,a4,d04 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     cf6:	fe843783          	ld	a5,-24(s0)
     cfa:	6398                	ld	a4,0(a5)
     cfc:	fe043783          	ld	a5,-32(s0)
     d00:	e398                	sd	a4,0(a5)
     d02:	a82d                	j	d3c <malloc+0xdc>
      else {
        p->s.size -= nunits;
     d04:	fe843783          	ld	a5,-24(s0)
     d08:	4798                	lw	a4,8(a5)
     d0a:	fdc42783          	lw	a5,-36(s0)
     d0e:	40f707bb          	subw	a5,a4,a5
     d12:	0007871b          	sext.w	a4,a5
     d16:	fe843783          	ld	a5,-24(s0)
     d1a:	c798                	sw	a4,8(a5)
        p += p->s.size;
     d1c:	fe843783          	ld	a5,-24(s0)
     d20:	479c                	lw	a5,8(a5)
     d22:	1782                	slli	a5,a5,0x20
     d24:	9381                	srli	a5,a5,0x20
     d26:	0792                	slli	a5,a5,0x4
     d28:	fe843703          	ld	a4,-24(s0)
     d2c:	97ba                	add	a5,a5,a4
     d2e:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     d32:	fe843783          	ld	a5,-24(s0)
     d36:	fdc42703          	lw	a4,-36(s0)
     d3a:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     d3c:	00002797          	auipc	a5,0x2
     d40:	92478793          	addi	a5,a5,-1756 # 2660 <freep>
     d44:	fe043703          	ld	a4,-32(s0)
     d48:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     d4a:	fe843783          	ld	a5,-24(s0)
     d4e:	07c1                	addi	a5,a5,16
     d50:	a091                	j	d94 <malloc+0x134>
    }
    if(p == freep)
     d52:	00002797          	auipc	a5,0x2
     d56:	90e78793          	addi	a5,a5,-1778 # 2660 <freep>
     d5a:	639c                	ld	a5,0(a5)
     d5c:	fe843703          	ld	a4,-24(s0)
     d60:	02f71063          	bne	a4,a5,d80 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
     d64:	fdc42783          	lw	a5,-36(s0)
     d68:	853e                	mv	a0,a5
     d6a:	00000097          	auipc	ra,0x0
     d6e:	e76080e7          	jalr	-394(ra) # be0 <morecore>
     d72:	fea43423          	sd	a0,-24(s0)
     d76:	fe843783          	ld	a5,-24(s0)
     d7a:	e399                	bnez	a5,d80 <malloc+0x120>
        return 0;
     d7c:	4781                	li	a5,0
     d7e:	a819                	j	d94 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     d80:	fe843783          	ld	a5,-24(s0)
     d84:	fef43023          	sd	a5,-32(s0)
     d88:	fe843783          	ld	a5,-24(s0)
     d8c:	639c                	ld	a5,0(a5)
     d8e:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     d92:	b791                	j	cd6 <malloc+0x76>
  }
}
     d94:	853e                	mv	a0,a5
     d96:	70e2                	ld	ra,56(sp)
     d98:	7442                	ld	s0,48(sp)
     d9a:	6121                	addi	sp,sp,64
     d9c:	8082                	ret

0000000000000d9e <setjmp>:
     d9e:	e100                	sd	s0,0(a0)
     da0:	e504                	sd	s1,8(a0)
     da2:	01253823          	sd	s2,16(a0)
     da6:	01353c23          	sd	s3,24(a0)
     daa:	03453023          	sd	s4,32(a0)
     dae:	03553423          	sd	s5,40(a0)
     db2:	03653823          	sd	s6,48(a0)
     db6:	03753c23          	sd	s7,56(a0)
     dba:	05853023          	sd	s8,64(a0)
     dbe:	05953423          	sd	s9,72(a0)
     dc2:	05a53823          	sd	s10,80(a0)
     dc6:	05b53c23          	sd	s11,88(a0)
     dca:	06153023          	sd	ra,96(a0)
     dce:	06253423          	sd	sp,104(a0)
     dd2:	4501                	li	a0,0
     dd4:	8082                	ret

0000000000000dd6 <longjmp>:
     dd6:	6100                	ld	s0,0(a0)
     dd8:	6504                	ld	s1,8(a0)
     dda:	01053903          	ld	s2,16(a0)
     dde:	01853983          	ld	s3,24(a0)
     de2:	02053a03          	ld	s4,32(a0)
     de6:	02853a83          	ld	s5,40(a0)
     dea:	03053b03          	ld	s6,48(a0)
     dee:	03853b83          	ld	s7,56(a0)
     df2:	04053c03          	ld	s8,64(a0)
     df6:	04853c83          	ld	s9,72(a0)
     dfa:	05053d03          	ld	s10,80(a0)
     dfe:	05853d83          	ld	s11,88(a0)
     e02:	06053083          	ld	ra,96(a0)
     e06:	06853103          	ld	sp,104(a0)
     e0a:	c199                	beqz	a1,e10 <longjmp_1>
     e0c:	852e                	mv	a0,a1
     e0e:	8082                	ret

0000000000000e10 <longjmp_1>:
     e10:	4505                	li	a0,1
     e12:	8082                	ret

0000000000000e14 <__list_add>:
 * the prev/next entries already!
 */
static inline void __list_add(struct list_head *new_entry,
                              struct list_head *prev,
                              struct list_head *next)
{
     e14:	7179                	addi	sp,sp,-48
     e16:	f422                	sd	s0,40(sp)
     e18:	1800                	addi	s0,sp,48
     e1a:	fea43423          	sd	a0,-24(s0)
     e1e:	feb43023          	sd	a1,-32(s0)
     e22:	fcc43c23          	sd	a2,-40(s0)
    next->prev = new_entry;
     e26:	fd843783          	ld	a5,-40(s0)
     e2a:	fe843703          	ld	a4,-24(s0)
     e2e:	e798                	sd	a4,8(a5)
    new_entry->next = next;
     e30:	fe843783          	ld	a5,-24(s0)
     e34:	fd843703          	ld	a4,-40(s0)
     e38:	e398                	sd	a4,0(a5)
    new_entry->prev = prev;
     e3a:	fe843783          	ld	a5,-24(s0)
     e3e:	fe043703          	ld	a4,-32(s0)
     e42:	e798                	sd	a4,8(a5)
    prev->next = new_entry;
     e44:	fe043783          	ld	a5,-32(s0)
     e48:	fe843703          	ld	a4,-24(s0)
     e4c:	e398                	sd	a4,0(a5)
}
     e4e:	0001                	nop
     e50:	7422                	ld	s0,40(sp)
     e52:	6145                	addi	sp,sp,48
     e54:	8082                	ret

0000000000000e56 <list_add_tail>:
 *
 * Insert a new entry before the specified head.
 * This is useful for implementing queues.
 */
static inline void list_add_tail(struct list_head *new_entry, struct list_head *head)
{
     e56:	1101                	addi	sp,sp,-32
     e58:	ec06                	sd	ra,24(sp)
     e5a:	e822                	sd	s0,16(sp)
     e5c:	1000                	addi	s0,sp,32
     e5e:	fea43423          	sd	a0,-24(s0)
     e62:	feb43023          	sd	a1,-32(s0)
    __list_add(new_entry, head->prev, head);
     e66:	fe043783          	ld	a5,-32(s0)
     e6a:	679c                	ld	a5,8(a5)
     e6c:	fe043603          	ld	a2,-32(s0)
     e70:	85be                	mv	a1,a5
     e72:	fe843503          	ld	a0,-24(s0)
     e76:	00000097          	auipc	ra,0x0
     e7a:	f9e080e7          	jalr	-98(ra) # e14 <__list_add>
}
     e7e:	0001                	nop
     e80:	60e2                	ld	ra,24(sp)
     e82:	6442                	ld	s0,16(sp)
     e84:	6105                	addi	sp,sp,32
     e86:	8082                	ret

0000000000000e88 <__list_del>:
 *
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 */
static inline void __list_del(struct list_head *prev, struct list_head *next)
{
     e88:	1101                	addi	sp,sp,-32
     e8a:	ec22                	sd	s0,24(sp)
     e8c:	1000                	addi	s0,sp,32
     e8e:	fea43423          	sd	a0,-24(s0)
     e92:	feb43023          	sd	a1,-32(s0)
    next->prev = prev;
     e96:	fe043783          	ld	a5,-32(s0)
     e9a:	fe843703          	ld	a4,-24(s0)
     e9e:	e798                	sd	a4,8(a5)
    prev->next = next;
     ea0:	fe843783          	ld	a5,-24(s0)
     ea4:	fe043703          	ld	a4,-32(s0)
     ea8:	e398                	sd	a4,0(a5)
}
     eaa:	0001                	nop
     eac:	6462                	ld	s0,24(sp)
     eae:	6105                	addi	sp,sp,32
     eb0:	8082                	ret

0000000000000eb2 <list_del>:
 * @entry: the element to delete from the list.
 * Note: list_empty on entry does not return true after this, the entry is
 * in an undefined state.
 */
static inline void list_del(struct list_head *entry)
{
     eb2:	1101                	addi	sp,sp,-32
     eb4:	ec06                	sd	ra,24(sp)
     eb6:	e822                	sd	s0,16(sp)
     eb8:	1000                	addi	s0,sp,32
     eba:	fea43423          	sd	a0,-24(s0)
    __list_del(entry->prev, entry->next);
     ebe:	fe843783          	ld	a5,-24(s0)
     ec2:	6798                	ld	a4,8(a5)
     ec4:	fe843783          	ld	a5,-24(s0)
     ec8:	639c                	ld	a5,0(a5)
     eca:	85be                	mv	a1,a5
     ecc:	853a                	mv	a0,a4
     ece:	00000097          	auipc	ra,0x0
     ed2:	fba080e7          	jalr	-70(ra) # e88 <__list_del>
    entry->next = LIST_POISON1;
     ed6:	fe843783          	ld	a5,-24(s0)
     eda:	00100737          	lui	a4,0x100
     ede:	10070713          	addi	a4,a4,256 # 100100 <__global_pointer$+0xfd2f8>
     ee2:	e398                	sd	a4,0(a5)
    entry->prev = LIST_POISON2;
     ee4:	fe843783          	ld	a5,-24(s0)
     ee8:	00200737          	lui	a4,0x200
     eec:	20070713          	addi	a4,a4,512 # 200200 <__global_pointer$+0x1fd3f8>
     ef0:	e798                	sd	a4,8(a5)
}
     ef2:	0001                	nop
     ef4:	60e2                	ld	ra,24(sp)
     ef6:	6442                	ld	s0,16(sp)
     ef8:	6105                	addi	sp,sp,32
     efa:	8082                	ret

0000000000000efc <list_empty>:
/**
 * list_empty - tests whether a list is empty
 * @head: the list to test.
 */
static inline int list_empty(const struct list_head *head)
{
     efc:	1101                	addi	sp,sp,-32
     efe:	ec22                	sd	s0,24(sp)
     f00:	1000                	addi	s0,sp,32
     f02:	fea43423          	sd	a0,-24(s0)
    return head->next == head;
     f06:	fe843783          	ld	a5,-24(s0)
     f0a:	639c                	ld	a5,0(a5)
     f0c:	fe843703          	ld	a4,-24(s0)
     f10:	40f707b3          	sub	a5,a4,a5
     f14:	0017b793          	seqz	a5,a5
     f18:	0ff7f793          	andi	a5,a5,255
     f1c:	2781                	sext.w	a5,a5
}
     f1e:	853e                	mv	a0,a5
     f20:	6462                	ld	s0,24(sp)
     f22:	6105                	addi	sp,sp,32
     f24:	8082                	ret

0000000000000f26 <thread_create>:

void __dispatch(void);
void __schedule(void);

struct thread *thread_create(void (*f)(void *), void *arg, int is_real_time, int processing_time, int period, int n)
{
     f26:	715d                	addi	sp,sp,-80
     f28:	e486                	sd	ra,72(sp)
     f2a:	e0a2                	sd	s0,64(sp)
     f2c:	0880                	addi	s0,sp,80
     f2e:	fca43423          	sd	a0,-56(s0)
     f32:	fcb43023          	sd	a1,-64(s0)
     f36:	85b2                	mv	a1,a2
     f38:	8636                	mv	a2,a3
     f3a:	86ba                	mv	a3,a4
     f3c:	873e                	mv	a4,a5
     f3e:	87ae                	mv	a5,a1
     f40:	faf42e23          	sw	a5,-68(s0)
     f44:	87b2                	mv	a5,a2
     f46:	faf42c23          	sw	a5,-72(s0)
     f4a:	87b6                	mv	a5,a3
     f4c:	faf42a23          	sw	a5,-76(s0)
     f50:	87ba                	mv	a5,a4
     f52:	faf42823          	sw	a5,-80(s0)
    static int _id = 1;
    struct thread *t = (struct thread *)malloc(sizeof(struct thread));
     f56:	06000513          	li	a0,96
     f5a:	00000097          	auipc	ra,0x0
     f5e:	d06080e7          	jalr	-762(ra) # c60 <malloc>
     f62:	fea43423          	sd	a0,-24(s0)
    unsigned long new_stack_p;
    unsigned long new_stack;
    new_stack = (unsigned long)malloc(sizeof(unsigned long) * 0x200);
     f66:	6505                	lui	a0,0x1
     f68:	00000097          	auipc	ra,0x0
     f6c:	cf8080e7          	jalr	-776(ra) # c60 <malloc>
     f70:	87aa                	mv	a5,a0
     f72:	fef43023          	sd	a5,-32(s0)
    new_stack_p = new_stack + 0x200 * 8 - 0x2 * 8;
     f76:	fe043703          	ld	a4,-32(s0)
     f7a:	6785                	lui	a5,0x1
     f7c:	17c1                	addi	a5,a5,-16
     f7e:	97ba                	add	a5,a5,a4
     f80:	fcf43c23          	sd	a5,-40(s0)
    t->fp = f;
     f84:	fe843783          	ld	a5,-24(s0)
     f88:	fc843703          	ld	a4,-56(s0)
     f8c:	e398                	sd	a4,0(a5)
    t->arg = arg;
     f8e:	fe843783          	ld	a5,-24(s0)
     f92:	fc043703          	ld	a4,-64(s0)
     f96:	e798                	sd	a4,8(a5)
    t->ID = _id++;
     f98:	00001797          	auipc	a5,0x1
     f9c:	6ac78793          	addi	a5,a5,1708 # 2644 <_id.1229>
     fa0:	439c                	lw	a5,0(a5)
     fa2:	0017871b          	addiw	a4,a5,1
     fa6:	0007069b          	sext.w	a3,a4
     faa:	00001717          	auipc	a4,0x1
     fae:	69a70713          	addi	a4,a4,1690 # 2644 <_id.1229>
     fb2:	c314                	sw	a3,0(a4)
     fb4:	fe843703          	ld	a4,-24(s0)
     fb8:	df5c                	sw	a5,60(a4)
    t->buf_set = 0;
     fba:	fe843783          	ld	a5,-24(s0)
     fbe:	0207a023          	sw	zero,32(a5)
    t->stack = (void *)new_stack;
     fc2:	fe043703          	ld	a4,-32(s0)
     fc6:	fe843783          	ld	a5,-24(s0)
     fca:	eb98                	sd	a4,16(a5)
    t->stack_p = (void *)new_stack_p;
     fcc:	fd843703          	ld	a4,-40(s0)
     fd0:	fe843783          	ld	a5,-24(s0)
     fd4:	ef98                	sd	a4,24(a5)

    t->processing_time = processing_time;
     fd6:	fe843783          	ld	a5,-24(s0)
     fda:	fb842703          	lw	a4,-72(s0)
     fde:	c3f8                	sw	a4,68(a5)
    t->period = period;
     fe0:	fe843783          	ld	a5,-24(s0)
     fe4:	fb442703          	lw	a4,-76(s0)
     fe8:	cbb8                	sw	a4,80(a5)
    t->deadline = period;
     fea:	fe843783          	ld	a5,-24(s0)
     fee:	fb442703          	lw	a4,-76(s0)
     ff2:	c7f8                	sw	a4,76(a5)
    t->n = n;
     ff4:	fe843783          	ld	a5,-24(s0)
     ff8:	fb042703          	lw	a4,-80(s0)
     ffc:	cbf8                	sw	a4,84(a5)
    t->is_real_time = is_real_time;
     ffe:	fe843783          	ld	a5,-24(s0)
    1002:	fbc42703          	lw	a4,-68(s0)
    1006:	c3b8                	sw	a4,64(a5)
    t->weight = 1;
    1008:	fe843783          	ld	a5,-24(s0)
    100c:	4705                	li	a4,1
    100e:	c7b8                	sw	a4,72(a5)
    t->remaining_time = processing_time;
    1010:	fe843783          	ld	a5,-24(s0)
    1014:	fb842703          	lw	a4,-72(s0)
    1018:	cfb8                	sw	a4,88(a5)
    t->current_deadline = 0;
    101a:	fe843783          	ld	a5,-24(s0)
    101e:	0407ae23          	sw	zero,92(a5)
    return t;
    1022:	fe843783          	ld	a5,-24(s0)
}
    1026:	853e                	mv	a0,a5
    1028:	60a6                	ld	ra,72(sp)
    102a:	6406                	ld	s0,64(sp)
    102c:	6161                	addi	sp,sp,80
    102e:	8082                	ret

0000000000001030 <thread_set_weight>:

void thread_set_weight(struct thread *t, int weight)
{
    1030:	1101                	addi	sp,sp,-32
    1032:	ec22                	sd	s0,24(sp)
    1034:	1000                	addi	s0,sp,32
    1036:	fea43423          	sd	a0,-24(s0)
    103a:	87ae                	mv	a5,a1
    103c:	fef42223          	sw	a5,-28(s0)
    t->weight = weight;
    1040:	fe843783          	ld	a5,-24(s0)
    1044:	fe442703          	lw	a4,-28(s0)
    1048:	c7b8                	sw	a4,72(a5)
}
    104a:	0001                	nop
    104c:	6462                	ld	s0,24(sp)
    104e:	6105                	addi	sp,sp,32
    1050:	8082                	ret

0000000000001052 <thread_add_at>:

void thread_add_at(struct thread *t, int arrival_time)
{
    1052:	7179                	addi	sp,sp,-48
    1054:	f406                	sd	ra,40(sp)
    1056:	f022                	sd	s0,32(sp)
    1058:	1800                	addi	s0,sp,48
    105a:	fca43c23          	sd	a0,-40(s0)
    105e:	87ae                	mv	a5,a1
    1060:	fcf42a23          	sw	a5,-44(s0)
    struct release_queue_entry *new_entry = (struct release_queue_entry *)malloc(sizeof(struct release_queue_entry));
    1064:	02000513          	li	a0,32
    1068:	00000097          	auipc	ra,0x0
    106c:	bf8080e7          	jalr	-1032(ra) # c60 <malloc>
    1070:	fea43423          	sd	a0,-24(s0)
    new_entry->thrd = t;
    1074:	fe843783          	ld	a5,-24(s0)
    1078:	fd843703          	ld	a4,-40(s0)
    107c:	e398                	sd	a4,0(a5)
    new_entry->release_time = arrival_time;
    107e:	fe843783          	ld	a5,-24(s0)
    1082:	fd442703          	lw	a4,-44(s0)
    1086:	cf98                	sw	a4,24(a5)
    if (t->is_real_time) {
    1088:	fd843783          	ld	a5,-40(s0)
    108c:	43bc                	lw	a5,64(a5)
    108e:	c38d                	beqz	a5,10b0 <thread_add_at+0x5e>
        t->current_deadline = arrival_time;
    1090:	fd843783          	ld	a5,-40(s0)
    1094:	fd442703          	lw	a4,-44(s0)
    1098:	cff8                	sw	a4,92(a5)
        t->current_deadline = arrival_time + t->deadline;
    109a:	fd843783          	ld	a5,-40(s0)
    109e:	47fc                	lw	a5,76(a5)
    10a0:	fd442703          	lw	a4,-44(s0)
    10a4:	9fb9                	addw	a5,a5,a4
    10a6:	0007871b          	sext.w	a4,a5
    10aa:	fd843783          	ld	a5,-40(s0)
    10ae:	cff8                	sw	a4,92(a5)
    }
    list_add_tail(&new_entry->thread_list, &release_queue);
    10b0:	fe843783          	ld	a5,-24(s0)
    10b4:	07a1                	addi	a5,a5,8
    10b6:	00001597          	auipc	a1,0x1
    10ba:	57a58593          	addi	a1,a1,1402 # 2630 <release_queue>
    10be:	853e                	mv	a0,a5
    10c0:	00000097          	auipc	ra,0x0
    10c4:	d96080e7          	jalr	-618(ra) # e56 <list_add_tail>
}
    10c8:	0001                	nop
    10ca:	70a2                	ld	ra,40(sp)
    10cc:	7402                	ld	s0,32(sp)
    10ce:	6145                	addi	sp,sp,48
    10d0:	8082                	ret

00000000000010d2 <__release>:

void __release()
{
    10d2:	7139                	addi	sp,sp,-64
    10d4:	fc06                	sd	ra,56(sp)
    10d6:	f822                	sd	s0,48(sp)
    10d8:	0080                	addi	s0,sp,64
    struct release_queue_entry *cur, *nxt;
    list_for_each_entry_safe(cur, nxt, &release_queue, thread_list) {
    10da:	00001797          	auipc	a5,0x1
    10de:	55678793          	addi	a5,a5,1366 # 2630 <release_queue>
    10e2:	639c                	ld	a5,0(a5)
    10e4:	fcf43c23          	sd	a5,-40(s0)
    10e8:	fd843783          	ld	a5,-40(s0)
    10ec:	17e1                	addi	a5,a5,-8
    10ee:	fef43423          	sd	a5,-24(s0)
    10f2:	fe843783          	ld	a5,-24(s0)
    10f6:	679c                	ld	a5,8(a5)
    10f8:	fcf43823          	sd	a5,-48(s0)
    10fc:	fd043783          	ld	a5,-48(s0)
    1100:	17e1                	addi	a5,a5,-8
    1102:	fef43023          	sd	a5,-32(s0)
    1106:	a851                	j	119a <__release+0xc8>
        if (threading_system_time >= cur->release_time) {
    1108:	fe843783          	ld	a5,-24(s0)
    110c:	4f98                	lw	a4,24(a5)
    110e:	00001797          	auipc	a5,0x1
    1112:	56278793          	addi	a5,a5,1378 # 2670 <threading_system_time>
    1116:	439c                	lw	a5,0(a5)
    1118:	06e7c363          	blt	a5,a4,117e <__release+0xac>
            cur->thrd->remaining_time = cur->thrd->processing_time;
    111c:	fe843783          	ld	a5,-24(s0)
    1120:	6398                	ld	a4,0(a5)
    1122:	fe843783          	ld	a5,-24(s0)
    1126:	639c                	ld	a5,0(a5)
    1128:	4378                	lw	a4,68(a4)
    112a:	cfb8                	sw	a4,88(a5)
            cur->thrd->current_deadline = cur->release_time + cur->thrd->deadline;
    112c:	fe843783          	ld	a5,-24(s0)
    1130:	4f94                	lw	a3,24(a5)
    1132:	fe843783          	ld	a5,-24(s0)
    1136:	639c                	ld	a5,0(a5)
    1138:	47f8                	lw	a4,76(a5)
    113a:	fe843783          	ld	a5,-24(s0)
    113e:	639c                	ld	a5,0(a5)
    1140:	9f35                	addw	a4,a4,a3
    1142:	2701                	sext.w	a4,a4
    1144:	cff8                	sw	a4,92(a5)
            list_add_tail(&cur->thrd->thread_list, &run_queue);
    1146:	fe843783          	ld	a5,-24(s0)
    114a:	639c                	ld	a5,0(a5)
    114c:	02878793          	addi	a5,a5,40
    1150:	00001597          	auipc	a1,0x1
    1154:	4d058593          	addi	a1,a1,1232 # 2620 <run_queue>
    1158:	853e                	mv	a0,a5
    115a:	00000097          	auipc	ra,0x0
    115e:	cfc080e7          	jalr	-772(ra) # e56 <list_add_tail>
            list_del(&cur->thread_list);
    1162:	fe843783          	ld	a5,-24(s0)
    1166:	07a1                	addi	a5,a5,8
    1168:	853e                	mv	a0,a5
    116a:	00000097          	auipc	ra,0x0
    116e:	d48080e7          	jalr	-696(ra) # eb2 <list_del>
            free(cur);
    1172:	fe843503          	ld	a0,-24(s0)
    1176:	00000097          	auipc	ra,0x0
    117a:	948080e7          	jalr	-1720(ra) # abe <free>
    list_for_each_entry_safe(cur, nxt, &release_queue, thread_list) {
    117e:	fe043783          	ld	a5,-32(s0)
    1182:	fef43423          	sd	a5,-24(s0)
    1186:	fe043783          	ld	a5,-32(s0)
    118a:	679c                	ld	a5,8(a5)
    118c:	fcf43423          	sd	a5,-56(s0)
    1190:	fc843783          	ld	a5,-56(s0)
    1194:	17e1                	addi	a5,a5,-8
    1196:	fef43023          	sd	a5,-32(s0)
    119a:	fe843783          	ld	a5,-24(s0)
    119e:	00878713          	addi	a4,a5,8
    11a2:	00001797          	auipc	a5,0x1
    11a6:	48e78793          	addi	a5,a5,1166 # 2630 <release_queue>
    11aa:	f4f71fe3          	bne	a4,a5,1108 <__release+0x36>
        }
    }
}
    11ae:	0001                	nop
    11b0:	0001                	nop
    11b2:	70e2                	ld	ra,56(sp)
    11b4:	7442                	ld	s0,48(sp)
    11b6:	6121                	addi	sp,sp,64
    11b8:	8082                	ret

00000000000011ba <__thread_exit>:

void __thread_exit(struct thread *to_remove)
{
    11ba:	1101                	addi	sp,sp,-32
    11bc:	ec06                	sd	ra,24(sp)
    11be:	e822                	sd	s0,16(sp)
    11c0:	1000                	addi	s0,sp,32
    11c2:	fea43423          	sd	a0,-24(s0)
    current = to_remove->thread_list.prev;
    11c6:	fe843783          	ld	a5,-24(s0)
    11ca:	7b98                	ld	a4,48(a5)
    11cc:	00001797          	auipc	a5,0x1
    11d0:	49c78793          	addi	a5,a5,1180 # 2668 <current>
    11d4:	e398                	sd	a4,0(a5)
    list_del(&to_remove->thread_list);
    11d6:	fe843783          	ld	a5,-24(s0)
    11da:	02878793          	addi	a5,a5,40
    11de:	853e                	mv	a0,a5
    11e0:	00000097          	auipc	ra,0x0
    11e4:	cd2080e7          	jalr	-814(ra) # eb2 <list_del>

    free(to_remove->stack);
    11e8:	fe843783          	ld	a5,-24(s0)
    11ec:	6b9c                	ld	a5,16(a5)
    11ee:	853e                	mv	a0,a5
    11f0:	00000097          	auipc	ra,0x0
    11f4:	8ce080e7          	jalr	-1842(ra) # abe <free>
    free(to_remove);
    11f8:	fe843503          	ld	a0,-24(s0)
    11fc:	00000097          	auipc	ra,0x0
    1200:	8c2080e7          	jalr	-1854(ra) # abe <free>

    __schedule();
    1204:	00000097          	auipc	ra,0x0
    1208:	572080e7          	jalr	1394(ra) # 1776 <__schedule>
    __dispatch();
    120c:	00000097          	auipc	ra,0x0
    1210:	3da080e7          	jalr	986(ra) # 15e6 <__dispatch>
    thrdresume(main_thrd_id);
    1214:	00001797          	auipc	a5,0x1
    1218:	42c78793          	addi	a5,a5,1068 # 2640 <main_thrd_id>
    121c:	439c                	lw	a5,0(a5)
    121e:	853e                	mv	a0,a5
    1220:	fffff097          	auipc	ra,0xfffff
    1224:	3b0080e7          	jalr	944(ra) # 5d0 <thrdresume>
}
    1228:	0001                	nop
    122a:	60e2                	ld	ra,24(sp)
    122c:	6442                	ld	s0,16(sp)
    122e:	6105                	addi	sp,sp,32
    1230:	8082                	ret

0000000000001232 <thread_exit>:

void thread_exit(void)
{
    1232:	7179                	addi	sp,sp,-48
    1234:	f406                	sd	ra,40(sp)
    1236:	f022                	sd	s0,32(sp)
    1238:	1800                	addi	s0,sp,48
    if (current == &run_queue) {
    123a:	00001797          	auipc	a5,0x1
    123e:	42e78793          	addi	a5,a5,1070 # 2668 <current>
    1242:	6398                	ld	a4,0(a5)
    1244:	00001797          	auipc	a5,0x1
    1248:	3dc78793          	addi	a5,a5,988 # 2620 <run_queue>
    124c:	02f71063          	bne	a4,a5,126c <thread_exit+0x3a>
        fprintf(2, "[FATAL] thread_exit is called on a nonexistent thread\n");
    1250:	00001597          	auipc	a1,0x1
    1254:	27858593          	addi	a1,a1,632 # 24c8 <schedule_dm+0x2ea>
    1258:	4509                	li	a0,2
    125a:	fffff097          	auipc	ra,0xfffff
    125e:	7bc080e7          	jalr	1980(ra) # a16 <fprintf>
        exit(1);
    1262:	4505                	li	a0,1
    1264:	fffff097          	auipc	ra,0xfffff
    1268:	2c4080e7          	jalr	708(ra) # 528 <exit>
    }

    struct thread *to_remove = list_entry(current, struct thread, thread_list);
    126c:	00001797          	auipc	a5,0x1
    1270:	3fc78793          	addi	a5,a5,1020 # 2668 <current>
    1274:	639c                	ld	a5,0(a5)
    1276:	fef43423          	sd	a5,-24(s0)
    127a:	fe843783          	ld	a5,-24(s0)
    127e:	fd878793          	addi	a5,a5,-40
    1282:	fef43023          	sd	a5,-32(s0)
    int consume_ticks = cancelthrdstop(to_remove->thrdstop_context_id, 1);
    1286:	fe043783          	ld	a5,-32(s0)
    128a:	5f9c                	lw	a5,56(a5)
    128c:	4585                	li	a1,1
    128e:	853e                	mv	a0,a5
    1290:	fffff097          	auipc	ra,0xfffff
    1294:	348080e7          	jalr	840(ra) # 5d8 <cancelthrdstop>
    1298:	87aa                	mv	a5,a0
    129a:	fcf42e23          	sw	a5,-36(s0)
    threading_system_time += consume_ticks;
    129e:	00001797          	auipc	a5,0x1
    12a2:	3d278793          	addi	a5,a5,978 # 2670 <threading_system_time>
    12a6:	439c                	lw	a5,0(a5)
    12a8:	fdc42703          	lw	a4,-36(s0)
    12ac:	9fb9                	addw	a5,a5,a4
    12ae:	0007871b          	sext.w	a4,a5
    12b2:	00001797          	auipc	a5,0x1
    12b6:	3be78793          	addi	a5,a5,958 # 2670 <threading_system_time>
    12ba:	c398                	sw	a4,0(a5)

    __release();
    12bc:	00000097          	auipc	ra,0x0
    12c0:	e16080e7          	jalr	-490(ra) # 10d2 <__release>
    __thread_exit(to_remove);
    12c4:	fe043503          	ld	a0,-32(s0)
    12c8:	00000097          	auipc	ra,0x0
    12cc:	ef2080e7          	jalr	-270(ra) # 11ba <__thread_exit>
}
    12d0:	0001                	nop
    12d2:	70a2                	ld	ra,40(sp)
    12d4:	7402                	ld	s0,32(sp)
    12d6:	6145                	addi	sp,sp,48
    12d8:	8082                	ret

00000000000012da <__finish_current>:

void __finish_current()
{
    12da:	7179                	addi	sp,sp,-48
    12dc:	f406                	sd	ra,40(sp)
    12de:	f022                	sd	s0,32(sp)
    12e0:	1800                	addi	s0,sp,48
    struct thread *current_thread = list_entry(current, struct thread, thread_list);
    12e2:	00001797          	auipc	a5,0x1
    12e6:	38678793          	addi	a5,a5,902 # 2668 <current>
    12ea:	639c                	ld	a5,0(a5)
    12ec:	fef43423          	sd	a5,-24(s0)
    12f0:	fe843783          	ld	a5,-24(s0)
    12f4:	fd878793          	addi	a5,a5,-40
    12f8:	fef43023          	sd	a5,-32(s0)
    --current_thread->n;
    12fc:	fe043783          	ld	a5,-32(s0)
    1300:	4bfc                	lw	a5,84(a5)
    1302:	37fd                	addiw	a5,a5,-1
    1304:	0007871b          	sext.w	a4,a5
    1308:	fe043783          	ld	a5,-32(s0)
    130c:	cbf8                	sw	a4,84(a5)

    printf("thread#%d finish at %d\n",
    130e:	fe043783          	ld	a5,-32(s0)
    1312:	5fd8                	lw	a4,60(a5)
    1314:	00001797          	auipc	a5,0x1
    1318:	35c78793          	addi	a5,a5,860 # 2670 <threading_system_time>
    131c:	4390                	lw	a2,0(a5)
    131e:	fe043783          	ld	a5,-32(s0)
    1322:	4bfc                	lw	a5,84(a5)
    1324:	86be                	mv	a3,a5
    1326:	85ba                	mv	a1,a4
    1328:	00001517          	auipc	a0,0x1
    132c:	1d850513          	addi	a0,a0,472 # 2500 <schedule_dm+0x322>
    1330:	fffff097          	auipc	ra,0xfffff
    1334:	73e080e7          	jalr	1854(ra) # a6e <printf>
           current_thread->ID, threading_system_time, current_thread->n);

    if (current_thread->n > 0) {
    1338:	fe043783          	ld	a5,-32(s0)
    133c:	4bfc                	lw	a5,84(a5)
    133e:	04f05563          	blez	a5,1388 <__finish_current+0xae>
        struct list_head *to_remove = current;
    1342:	00001797          	auipc	a5,0x1
    1346:	32678793          	addi	a5,a5,806 # 2668 <current>
    134a:	639c                	ld	a5,0(a5)
    134c:	fcf43c23          	sd	a5,-40(s0)
        current = current->prev;
    1350:	00001797          	auipc	a5,0x1
    1354:	31878793          	addi	a5,a5,792 # 2668 <current>
    1358:	639c                	ld	a5,0(a5)
    135a:	6798                	ld	a4,8(a5)
    135c:	00001797          	auipc	a5,0x1
    1360:	30c78793          	addi	a5,a5,780 # 2668 <current>
    1364:	e398                	sd	a4,0(a5)
        list_del(to_remove);
    1366:	fd843503          	ld	a0,-40(s0)
    136a:	00000097          	auipc	ra,0x0
    136e:	b48080e7          	jalr	-1208(ra) # eb2 <list_del>
        thread_add_at(current_thread, current_thread->current_deadline);
    1372:	fe043783          	ld	a5,-32(s0)
    1376:	4ffc                	lw	a5,92(a5)
    1378:	85be                	mv	a1,a5
    137a:	fe043503          	ld	a0,-32(s0)
    137e:	00000097          	auipc	ra,0x0
    1382:	cd4080e7          	jalr	-812(ra) # 1052 <thread_add_at>
    } else {
        __thread_exit(current_thread);
    }
}
    1386:	a039                	j	1394 <__finish_current+0xba>
        __thread_exit(current_thread);
    1388:	fe043503          	ld	a0,-32(s0)
    138c:	00000097          	auipc	ra,0x0
    1390:	e2e080e7          	jalr	-466(ra) # 11ba <__thread_exit>
}
    1394:	0001                	nop
    1396:	70a2                	ld	ra,40(sp)
    1398:	7402                	ld	s0,32(sp)
    139a:	6145                	addi	sp,sp,48
    139c:	8082                	ret

000000000000139e <__rt_finish_current>:
void __rt_finish_current()
{
    139e:	7179                	addi	sp,sp,-48
    13a0:	f406                	sd	ra,40(sp)
    13a2:	f022                	sd	s0,32(sp)
    13a4:	1800                	addi	s0,sp,48
    struct thread *current_thread = list_entry(current, struct thread, thread_list);
    13a6:	00001797          	auipc	a5,0x1
    13aa:	2c278793          	addi	a5,a5,706 # 2668 <current>
    13ae:	639c                	ld	a5,0(a5)
    13b0:	fef43423          	sd	a5,-24(s0)
    13b4:	fe843783          	ld	a5,-24(s0)
    13b8:	fd878793          	addi	a5,a5,-40
    13bc:	fef43023          	sd	a5,-32(s0)
    --current_thread->n;
    13c0:	fe043783          	ld	a5,-32(s0)
    13c4:	4bfc                	lw	a5,84(a5)
    13c6:	37fd                	addiw	a5,a5,-1
    13c8:	0007871b          	sext.w	a4,a5
    13cc:	fe043783          	ld	a5,-32(s0)
    13d0:	cbf8                	sw	a4,84(a5)

    printf("thread#%d finish one cycle at %d: %d cycles left\n",
    13d2:	fe043783          	ld	a5,-32(s0)
    13d6:	5fd8                	lw	a4,60(a5)
    13d8:	00001797          	auipc	a5,0x1
    13dc:	29878793          	addi	a5,a5,664 # 2670 <threading_system_time>
    13e0:	4390                	lw	a2,0(a5)
    13e2:	fe043783          	ld	a5,-32(s0)
    13e6:	4bfc                	lw	a5,84(a5)
    13e8:	86be                	mv	a3,a5
    13ea:	85ba                	mv	a1,a4
    13ec:	00001517          	auipc	a0,0x1
    13f0:	12c50513          	addi	a0,a0,300 # 2518 <schedule_dm+0x33a>
    13f4:	fffff097          	auipc	ra,0xfffff
    13f8:	67a080e7          	jalr	1658(ra) # a6e <printf>
           current_thread->ID, threading_system_time, current_thread->n);

    if (current_thread->n > 0) {
    13fc:	fe043783          	ld	a5,-32(s0)
    1400:	4bfc                	lw	a5,84(a5)
    1402:	04f05563          	blez	a5,144c <__rt_finish_current+0xae>
        struct list_head *to_remove = current;
    1406:	00001797          	auipc	a5,0x1
    140a:	26278793          	addi	a5,a5,610 # 2668 <current>
    140e:	639c                	ld	a5,0(a5)
    1410:	fcf43c23          	sd	a5,-40(s0)
        current = current->prev;
    1414:	00001797          	auipc	a5,0x1
    1418:	25478793          	addi	a5,a5,596 # 2668 <current>
    141c:	639c                	ld	a5,0(a5)
    141e:	6798                	ld	a4,8(a5)
    1420:	00001797          	auipc	a5,0x1
    1424:	24878793          	addi	a5,a5,584 # 2668 <current>
    1428:	e398                	sd	a4,0(a5)
        list_del(to_remove);
    142a:	fd843503          	ld	a0,-40(s0)
    142e:	00000097          	auipc	ra,0x0
    1432:	a84080e7          	jalr	-1404(ra) # eb2 <list_del>
        thread_add_at(current_thread, current_thread->current_deadline);
    1436:	fe043783          	ld	a5,-32(s0)
    143a:	4ffc                	lw	a5,92(a5)
    143c:	85be                	mv	a1,a5
    143e:	fe043503          	ld	a0,-32(s0)
    1442:	00000097          	auipc	ra,0x0
    1446:	c10080e7          	jalr	-1008(ra) # 1052 <thread_add_at>
    } else {
        __thread_exit(current_thread);
    }
}
    144a:	a039                	j	1458 <__rt_finish_current+0xba>
        __thread_exit(current_thread);
    144c:	fe043503          	ld	a0,-32(s0)
    1450:	00000097          	auipc	ra,0x0
    1454:	d6a080e7          	jalr	-662(ra) # 11ba <__thread_exit>
}
    1458:	0001                	nop
    145a:	70a2                	ld	ra,40(sp)
    145c:	7402                	ld	s0,32(sp)
    145e:	6145                	addi	sp,sp,48
    1460:	8082                	ret

0000000000001462 <switch_handler>:

void switch_handler(void *arg)
{
    1462:	7139                	addi	sp,sp,-64
    1464:	fc06                	sd	ra,56(sp)
    1466:	f822                	sd	s0,48(sp)
    1468:	0080                	addi	s0,sp,64
    146a:	fca43423          	sd	a0,-56(s0)
    uint64 elapsed_time = (uint64)arg;
    146e:	fc843783          	ld	a5,-56(s0)
    1472:	fef43423          	sd	a5,-24(s0)
    struct thread *current_thread = list_entry(current, struct thread, thread_list);
    1476:	00001797          	auipc	a5,0x1
    147a:	1f278793          	addi	a5,a5,498 # 2668 <current>
    147e:	639c                	ld	a5,0(a5)
    1480:	fef43023          	sd	a5,-32(s0)
    1484:	fe043783          	ld	a5,-32(s0)
    1488:	fd878793          	addi	a5,a5,-40
    148c:	fcf43c23          	sd	a5,-40(s0)

    threading_system_time += elapsed_time;
    1490:	fe843783          	ld	a5,-24(s0)
    1494:	0007871b          	sext.w	a4,a5
    1498:	00001797          	auipc	a5,0x1
    149c:	1d878793          	addi	a5,a5,472 # 2670 <threading_system_time>
    14a0:	439c                	lw	a5,0(a5)
    14a2:	2781                	sext.w	a5,a5
    14a4:	9fb9                	addw	a5,a5,a4
    14a6:	2781                	sext.w	a5,a5
    14a8:	0007871b          	sext.w	a4,a5
    14ac:	00001797          	auipc	a5,0x1
    14b0:	1c478793          	addi	a5,a5,452 # 2670 <threading_system_time>
    14b4:	c398                	sw	a4,0(a5)
     __release();
    14b6:	00000097          	auipc	ra,0x0
    14ba:	c1c080e7          	jalr	-996(ra) # 10d2 <__release>
    current_thread->remaining_time -= elapsed_time;
    14be:	fd843783          	ld	a5,-40(s0)
    14c2:	4fbc                	lw	a5,88(a5)
    14c4:	0007871b          	sext.w	a4,a5
    14c8:	fe843783          	ld	a5,-24(s0)
    14cc:	2781                	sext.w	a5,a5
    14ce:	40f707bb          	subw	a5,a4,a5
    14d2:	2781                	sext.w	a5,a5
    14d4:	0007871b          	sext.w	a4,a5
    14d8:	fd843783          	ld	a5,-40(s0)
    14dc:	cfb8                	sw	a4,88(a5)

    if (current_thread->is_real_time)
    14de:	fd843783          	ld	a5,-40(s0)
    14e2:	43bc                	lw	a5,64(a5)
    14e4:	c3ad                	beqz	a5,1546 <switch_handler+0xe4>
        if (threading_system_time > current_thread->current_deadline || 
    14e6:	fd843783          	ld	a5,-40(s0)
    14ea:	4ff8                	lw	a4,92(a5)
    14ec:	00001797          	auipc	a5,0x1
    14f0:	18478793          	addi	a5,a5,388 # 2670 <threading_system_time>
    14f4:	439c                	lw	a5,0(a5)
    14f6:	02f74163          	blt	a4,a5,1518 <switch_handler+0xb6>
            (threading_system_time == current_thread->current_deadline && current_thread->remaining_time > 0)) {
    14fa:	fd843783          	ld	a5,-40(s0)
    14fe:	4ff8                	lw	a4,92(a5)
    1500:	00001797          	auipc	a5,0x1
    1504:	17078793          	addi	a5,a5,368 # 2670 <threading_system_time>
    1508:	439c                	lw	a5,0(a5)
        if (threading_system_time > current_thread->current_deadline || 
    150a:	02f71e63          	bne	a4,a5,1546 <switch_handler+0xe4>
            (threading_system_time == current_thread->current_deadline && current_thread->remaining_time > 0)) {
    150e:	fd843783          	ld	a5,-40(s0)
    1512:	4fbc                	lw	a5,88(a5)
    1514:	02f05963          	blez	a5,1546 <switch_handler+0xe4>
            printf("thread#%d misses a deadline at %d\n", current_thread->ID, threading_system_time);
    1518:	fd843783          	ld	a5,-40(s0)
    151c:	5fd8                	lw	a4,60(a5)
    151e:	00001797          	auipc	a5,0x1
    1522:	15278793          	addi	a5,a5,338 # 2670 <threading_system_time>
    1526:	439c                	lw	a5,0(a5)
    1528:	863e                	mv	a2,a5
    152a:	85ba                	mv	a1,a4
    152c:	00001517          	auipc	a0,0x1
    1530:	02450513          	addi	a0,a0,36 # 2550 <schedule_dm+0x372>
    1534:	fffff097          	auipc	ra,0xfffff
    1538:	53a080e7          	jalr	1338(ra) # a6e <printf>
            exit(0);
    153c:	4501                	li	a0,0
    153e:	fffff097          	auipc	ra,0xfffff
    1542:	fea080e7          	jalr	-22(ra) # 528 <exit>
        }

    if (current_thread->remaining_time <= 0) {
    1546:	fd843783          	ld	a5,-40(s0)
    154a:	4fbc                	lw	a5,88(a5)
    154c:	02f04063          	bgtz	a5,156c <switch_handler+0x10a>
        if (current_thread->is_real_time)
    1550:	fd843783          	ld	a5,-40(s0)
    1554:	43bc                	lw	a5,64(a5)
    1556:	c791                	beqz	a5,1562 <switch_handler+0x100>
            __rt_finish_current();
    1558:	00000097          	auipc	ra,0x0
    155c:	e46080e7          	jalr	-442(ra) # 139e <__rt_finish_current>
    1560:	a881                	j	15b0 <switch_handler+0x14e>
        else
            __finish_current();
    1562:	00000097          	auipc	ra,0x0
    1566:	d78080e7          	jalr	-648(ra) # 12da <__finish_current>
    156a:	a099                	j	15b0 <switch_handler+0x14e>
    } else {
        // move the current thread to the end of the run_queue
        struct list_head *to_remove = current;
    156c:	00001797          	auipc	a5,0x1
    1570:	0fc78793          	addi	a5,a5,252 # 2668 <current>
    1574:	639c                	ld	a5,0(a5)
    1576:	fcf43823          	sd	a5,-48(s0)
        current = current->prev;
    157a:	00001797          	auipc	a5,0x1
    157e:	0ee78793          	addi	a5,a5,238 # 2668 <current>
    1582:	639c                	ld	a5,0(a5)
    1584:	6798                	ld	a4,8(a5)
    1586:	00001797          	auipc	a5,0x1
    158a:	0e278793          	addi	a5,a5,226 # 2668 <current>
    158e:	e398                	sd	a4,0(a5)
        list_del(to_remove);
    1590:	fd043503          	ld	a0,-48(s0)
    1594:	00000097          	auipc	ra,0x0
    1598:	91e080e7          	jalr	-1762(ra) # eb2 <list_del>
        list_add_tail(to_remove, &run_queue);
    159c:	00001597          	auipc	a1,0x1
    15a0:	08458593          	addi	a1,a1,132 # 2620 <run_queue>
    15a4:	fd043503          	ld	a0,-48(s0)
    15a8:	00000097          	auipc	ra,0x0
    15ac:	8ae080e7          	jalr	-1874(ra) # e56 <list_add_tail>
    }

    __release();
    15b0:	00000097          	auipc	ra,0x0
    15b4:	b22080e7          	jalr	-1246(ra) # 10d2 <__release>
    __schedule();
    15b8:	00000097          	auipc	ra,0x0
    15bc:	1be080e7          	jalr	446(ra) # 1776 <__schedule>
    __dispatch();
    15c0:	00000097          	auipc	ra,0x0
    15c4:	026080e7          	jalr	38(ra) # 15e6 <__dispatch>
    thrdresume(main_thrd_id);
    15c8:	00001797          	auipc	a5,0x1
    15cc:	07878793          	addi	a5,a5,120 # 2640 <main_thrd_id>
    15d0:	439c                	lw	a5,0(a5)
    15d2:	853e                	mv	a0,a5
    15d4:	fffff097          	auipc	ra,0xfffff
    15d8:	ffc080e7          	jalr	-4(ra) # 5d0 <thrdresume>
}
    15dc:	0001                	nop
    15de:	70e2                	ld	ra,56(sp)
    15e0:	7442                	ld	s0,48(sp)
    15e2:	6121                	addi	sp,sp,64
    15e4:	8082                	ret

00000000000015e6 <__dispatch>:

void __dispatch()
{
    15e6:	7179                	addi	sp,sp,-48
    15e8:	f406                	sd	ra,40(sp)
    15ea:	f022                	sd	s0,32(sp)
    15ec:	1800                	addi	s0,sp,48
    if (current == &run_queue) {
    15ee:	00001797          	auipc	a5,0x1
    15f2:	07a78793          	addi	a5,a5,122 # 2668 <current>
    15f6:	6398                	ld	a4,0(a5)
    15f8:	00001797          	auipc	a5,0x1
    15fc:	02878793          	addi	a5,a5,40 # 2620 <run_queue>
    1600:	16f70663          	beq	a4,a5,176c <__dispatch+0x186>
    if (allocated_time < 0) {
        fprintf(2, "[FATAL] allocated_time is negative\n");
        exit(1);
    }

    struct thread *current_thread = list_entry(current, struct thread, thread_list);
    1604:	00001797          	auipc	a5,0x1
    1608:	06478793          	addi	a5,a5,100 # 2668 <current>
    160c:	639c                	ld	a5,0(a5)
    160e:	fef43423          	sd	a5,-24(s0)
    1612:	fe843783          	ld	a5,-24(s0)
    1616:	fd878793          	addi	a5,a5,-40
    161a:	fef43023          	sd	a5,-32(s0)
    if (current_thread->is_real_time && allocated_time == 0) { // miss deadline, abort
    161e:	fe043783          	ld	a5,-32(s0)
    1622:	43bc                	lw	a5,64(a5)
    1624:	cf85                	beqz	a5,165c <__dispatch+0x76>
    1626:	00001797          	auipc	a5,0x1
    162a:	05278793          	addi	a5,a5,82 # 2678 <allocated_time>
    162e:	639c                	ld	a5,0(a5)
    1630:	e795                	bnez	a5,165c <__dispatch+0x76>
        printf("thread#%d misses a deadline at %d\n", current_thread->ID, current_thread->current_deadline);
    1632:	fe043783          	ld	a5,-32(s0)
    1636:	5fd8                	lw	a4,60(a5)
    1638:	fe043783          	ld	a5,-32(s0)
    163c:	4ffc                	lw	a5,92(a5)
    163e:	863e                	mv	a2,a5
    1640:	85ba                	mv	a1,a4
    1642:	00001517          	auipc	a0,0x1
    1646:	f0e50513          	addi	a0,a0,-242 # 2550 <schedule_dm+0x372>
    164a:	fffff097          	auipc	ra,0xfffff
    164e:	424080e7          	jalr	1060(ra) # a6e <printf>
        exit(0);
    1652:	4501                	li	a0,0
    1654:	fffff097          	auipc	ra,0xfffff
    1658:	ed4080e7          	jalr	-300(ra) # 528 <exit>
    }

    printf("dispatch thread#%d at %d: allocated_time=%d\n", current_thread->ID, threading_system_time, allocated_time);
    165c:	fe043783          	ld	a5,-32(s0)
    1660:	5fd8                	lw	a4,60(a5)
    1662:	00001797          	auipc	a5,0x1
    1666:	00e78793          	addi	a5,a5,14 # 2670 <threading_system_time>
    166a:	4390                	lw	a2,0(a5)
    166c:	00001797          	auipc	a5,0x1
    1670:	00c78793          	addi	a5,a5,12 # 2678 <allocated_time>
    1674:	639c                	ld	a5,0(a5)
    1676:	86be                	mv	a3,a5
    1678:	85ba                	mv	a1,a4
    167a:	00001517          	auipc	a0,0x1
    167e:	efe50513          	addi	a0,a0,-258 # 2578 <schedule_dm+0x39a>
    1682:	fffff097          	auipc	ra,0xfffff
    1686:	3ec080e7          	jalr	1004(ra) # a6e <printf>

    if (current_thread->buf_set) {
    168a:	fe043783          	ld	a5,-32(s0)
    168e:	539c                	lw	a5,32(a5)
    1690:	c7a1                	beqz	a5,16d8 <__dispatch+0xf2>
        thrdstop(allocated_time, &(current_thread->thrdstop_context_id), switch_handler, (void *)allocated_time);
    1692:	00001797          	auipc	a5,0x1
    1696:	fe678793          	addi	a5,a5,-26 # 2678 <allocated_time>
    169a:	639c                	ld	a5,0(a5)
    169c:	0007871b          	sext.w	a4,a5
    16a0:	fe043783          	ld	a5,-32(s0)
    16a4:	03878593          	addi	a1,a5,56
    16a8:	00001797          	auipc	a5,0x1
    16ac:	fd078793          	addi	a5,a5,-48 # 2678 <allocated_time>
    16b0:	639c                	ld	a5,0(a5)
    16b2:	86be                	mv	a3,a5
    16b4:	00000617          	auipc	a2,0x0
    16b8:	dae60613          	addi	a2,a2,-594 # 1462 <switch_handler>
    16bc:	853a                	mv	a0,a4
    16be:	fffff097          	auipc	ra,0xfffff
    16c2:	f0a080e7          	jalr	-246(ra) # 5c8 <thrdstop>
        thrdresume(current_thread->thrdstop_context_id);
    16c6:	fe043783          	ld	a5,-32(s0)
    16ca:	5f9c                	lw	a5,56(a5)
    16cc:	853e                	mv	a0,a5
    16ce:	fffff097          	auipc	ra,0xfffff
    16d2:	f02080e7          	jalr	-254(ra) # 5d0 <thrdresume>
    16d6:	a071                	j	1762 <__dispatch+0x17c>
    } else {
        current_thread->buf_set = 1;
    16d8:	fe043783          	ld	a5,-32(s0)
    16dc:	4705                	li	a4,1
    16de:	d398                	sw	a4,32(a5)
        unsigned long new_stack_p = (unsigned long)current_thread->stack_p;
    16e0:	fe043783          	ld	a5,-32(s0)
    16e4:	6f9c                	ld	a5,24(a5)
    16e6:	fcf43c23          	sd	a5,-40(s0)
        current_thread->thrdstop_context_id = -1;
    16ea:	fe043783          	ld	a5,-32(s0)
    16ee:	577d                	li	a4,-1
    16f0:	df98                	sw	a4,56(a5)
        thrdstop(allocated_time, &(current_thread->thrdstop_context_id), switch_handler, (void *)allocated_time);
    16f2:	00001797          	auipc	a5,0x1
    16f6:	f8678793          	addi	a5,a5,-122 # 2678 <allocated_time>
    16fa:	639c                	ld	a5,0(a5)
    16fc:	0007871b          	sext.w	a4,a5
    1700:	fe043783          	ld	a5,-32(s0)
    1704:	03878593          	addi	a1,a5,56
    1708:	00001797          	auipc	a5,0x1
    170c:	f7078793          	addi	a5,a5,-144 # 2678 <allocated_time>
    1710:	639c                	ld	a5,0(a5)
    1712:	86be                	mv	a3,a5
    1714:	00000617          	auipc	a2,0x0
    1718:	d4e60613          	addi	a2,a2,-690 # 1462 <switch_handler>
    171c:	853a                	mv	a0,a4
    171e:	fffff097          	auipc	ra,0xfffff
    1722:	eaa080e7          	jalr	-342(ra) # 5c8 <thrdstop>
        if (current_thread->thrdstop_context_id < 0) {
    1726:	fe043783          	ld	a5,-32(s0)
    172a:	5f9c                	lw	a5,56(a5)
    172c:	0207d063          	bgez	a5,174c <__dispatch+0x166>
            fprintf(2, "[ERROR] number of threads may exceed MAX_THRD_NUM\n");
    1730:	00001597          	auipc	a1,0x1
    1734:	e7858593          	addi	a1,a1,-392 # 25a8 <schedule_dm+0x3ca>
    1738:	4509                	li	a0,2
    173a:	fffff097          	auipc	ra,0xfffff
    173e:	2dc080e7          	jalr	732(ra) # a16 <fprintf>
            exit(1);
    1742:	4505                	li	a0,1
    1744:	fffff097          	auipc	ra,0xfffff
    1748:	de4080e7          	jalr	-540(ra) # 528 <exit>
        }

        // set sp to stack pointer of current thread.
        asm volatile("mv sp, %0"
    174c:	fd843783          	ld	a5,-40(s0)
    1750:	813e                	mv	sp,a5
                     :
                     : "r"(new_stack_p));
        current_thread->fp(current_thread->arg);
    1752:	fe043783          	ld	a5,-32(s0)
    1756:	6398                	ld	a4,0(a5)
    1758:	fe043783          	ld	a5,-32(s0)
    175c:	679c                	ld	a5,8(a5)
    175e:	853e                	mv	a0,a5
    1760:	9702                	jalr	a4
    }
    thread_exit();
    1762:	00000097          	auipc	ra,0x0
    1766:	ad0080e7          	jalr	-1328(ra) # 1232 <thread_exit>
    176a:	a011                	j	176e <__dispatch+0x188>
        return;
    176c:	0001                	nop
}
    176e:	70a2                	ld	ra,40(sp)
    1770:	7402                	ld	s0,32(sp)
    1772:	6145                	addi	sp,sp,48
    1774:	8082                	ret

0000000000001776 <__schedule>:

void __schedule()
{
    1776:	711d                	addi	sp,sp,-96
    1778:	ec86                	sd	ra,88(sp)
    177a:	e8a2                	sd	s0,80(sp)
    177c:	1080                	addi	s0,sp,96
    struct threads_sched_args args = {
    177e:	00001797          	auipc	a5,0x1
    1782:	ef278793          	addi	a5,a5,-270 # 2670 <threading_system_time>
    1786:	439c                	lw	a5,0(a5)
    1788:	fcf42c23          	sw	a5,-40(s0)
    178c:	4789                	li	a5,2
    178e:	fcf42e23          	sw	a5,-36(s0)
    1792:	00001797          	auipc	a5,0x1
    1796:	e8e78793          	addi	a5,a5,-370 # 2620 <run_queue>
    179a:	fef43023          	sd	a5,-32(s0)
    179e:	00001797          	auipc	a5,0x1
    17a2:	e9278793          	addi	a5,a5,-366 # 2630 <release_queue>
    17a6:	fef43423          	sd	a5,-24(s0)
#ifdef THREAD_SCHEDULER_WRR
    r = schedule_wrr(args);
#endif

#ifdef THREAD_SCHEDULER_SJF
    r = schedule_sjf(args);
    17aa:	fd843783          	ld	a5,-40(s0)
    17ae:	faf43023          	sd	a5,-96(s0)
    17b2:	fe043783          	ld	a5,-32(s0)
    17b6:	faf43423          	sd	a5,-88(s0)
    17ba:	fe843783          	ld	a5,-24(s0)
    17be:	faf43823          	sd	a5,-80(s0)
    17c2:	fa040793          	addi	a5,s0,-96
    17c6:	853e                	mv	a0,a5
    17c8:	00000097          	auipc	ra,0x0
    17cc:	404080e7          	jalr	1028(ra) # 1bcc <schedule_sjf>
    17d0:	872a                	mv	a4,a0
    17d2:	87ae                	mv	a5,a1
    17d4:	fce43423          	sd	a4,-56(s0)
    17d8:	fcf43823          	sd	a5,-48(s0)

#ifdef THREAD_SCHEDULER_DM
    r = schedule_dm(args);
#endif

    current = r.scheduled_thread_list_member;
    17dc:	fc843703          	ld	a4,-56(s0)
    17e0:	00001797          	auipc	a5,0x1
    17e4:	e8878793          	addi	a5,a5,-376 # 2668 <current>
    17e8:	e398                	sd	a4,0(a5)
    allocated_time = r.allocated_time;
    17ea:	fd042783          	lw	a5,-48(s0)
    17ee:	873e                	mv	a4,a5
    17f0:	00001797          	auipc	a5,0x1
    17f4:	e8878793          	addi	a5,a5,-376 # 2678 <allocated_time>
    17f8:	e398                	sd	a4,0(a5)
}
    17fa:	0001                	nop
    17fc:	60e6                	ld	ra,88(sp)
    17fe:	6446                	ld	s0,80(sp)
    1800:	6125                	addi	sp,sp,96
    1802:	8082                	ret

0000000000001804 <back_to_main_handler>:

void back_to_main_handler(void *arg)
{
    1804:	1101                	addi	sp,sp,-32
    1806:	ec06                	sd	ra,24(sp)
    1808:	e822                	sd	s0,16(sp)
    180a:	1000                	addi	s0,sp,32
    180c:	fea43423          	sd	a0,-24(s0)
    sleeping = 0;
    1810:	00001797          	auipc	a5,0x1
    1814:	e6478793          	addi	a5,a5,-412 # 2674 <sleeping>
    1818:	0007a023          	sw	zero,0(a5)
    threading_system_time += (uint64)arg;
    181c:	fe843783          	ld	a5,-24(s0)
    1820:	0007871b          	sext.w	a4,a5
    1824:	00001797          	auipc	a5,0x1
    1828:	e4c78793          	addi	a5,a5,-436 # 2670 <threading_system_time>
    182c:	439c                	lw	a5,0(a5)
    182e:	2781                	sext.w	a5,a5
    1830:	9fb9                	addw	a5,a5,a4
    1832:	2781                	sext.w	a5,a5
    1834:	0007871b          	sext.w	a4,a5
    1838:	00001797          	auipc	a5,0x1
    183c:	e3878793          	addi	a5,a5,-456 # 2670 <threading_system_time>
    1840:	c398                	sw	a4,0(a5)
    thrdresume(main_thrd_id);
    1842:	00001797          	auipc	a5,0x1
    1846:	dfe78793          	addi	a5,a5,-514 # 2640 <main_thrd_id>
    184a:	439c                	lw	a5,0(a5)
    184c:	853e                	mv	a0,a5
    184e:	fffff097          	auipc	ra,0xfffff
    1852:	d82080e7          	jalr	-638(ra) # 5d0 <thrdresume>
}
    1856:	0001                	nop
    1858:	60e2                	ld	ra,24(sp)
    185a:	6442                	ld	s0,16(sp)
    185c:	6105                	addi	sp,sp,32
    185e:	8082                	ret

0000000000001860 <thread_start_threading>:

void thread_start_threading()
{
    1860:	1141                	addi	sp,sp,-16
    1862:	e406                	sd	ra,8(sp)
    1864:	e022                	sd	s0,0(sp)
    1866:	0800                	addi	s0,sp,16
    threading_system_time = 0;
    1868:	00001797          	auipc	a5,0x1
    186c:	e0878793          	addi	a5,a5,-504 # 2670 <threading_system_time>
    1870:	0007a023          	sw	zero,0(a5)
    current = &run_queue;
    1874:	00001797          	auipc	a5,0x1
    1878:	df478793          	addi	a5,a5,-524 # 2668 <current>
    187c:	00001717          	auipc	a4,0x1
    1880:	da470713          	addi	a4,a4,-604 # 2620 <run_queue>
    1884:	e398                	sd	a4,0(a5)

    // call thrdstop just for obtain an ID
    thrdstop(1000, &main_thrd_id, back_to_main_handler, (void *)0);
    1886:	4681                	li	a3,0
    1888:	00000617          	auipc	a2,0x0
    188c:	f7c60613          	addi	a2,a2,-132 # 1804 <back_to_main_handler>
    1890:	00001597          	auipc	a1,0x1
    1894:	db058593          	addi	a1,a1,-592 # 2640 <main_thrd_id>
    1898:	3e800513          	li	a0,1000
    189c:	fffff097          	auipc	ra,0xfffff
    18a0:	d2c080e7          	jalr	-724(ra) # 5c8 <thrdstop>
    cancelthrdstop(main_thrd_id, 0);
    18a4:	00001797          	auipc	a5,0x1
    18a8:	d9c78793          	addi	a5,a5,-612 # 2640 <main_thrd_id>
    18ac:	439c                	lw	a5,0(a5)
    18ae:	4581                	li	a1,0
    18b0:	853e                	mv	a0,a5
    18b2:	fffff097          	auipc	ra,0xfffff
    18b6:	d26080e7          	jalr	-730(ra) # 5d8 <cancelthrdstop>

    while (!list_empty(&run_queue) || !list_empty(&release_queue)) {
    18ba:	a0c9                	j	197c <thread_start_threading+0x11c>
        __release();
    18bc:	00000097          	auipc	ra,0x0
    18c0:	816080e7          	jalr	-2026(ra) # 10d2 <__release>
        __schedule();
    18c4:	00000097          	auipc	ra,0x0
    18c8:	eb2080e7          	jalr	-334(ra) # 1776 <__schedule>
        cancelthrdstop(main_thrd_id, 0);
    18cc:	00001797          	auipc	a5,0x1
    18d0:	d7478793          	addi	a5,a5,-652 # 2640 <main_thrd_id>
    18d4:	439c                	lw	a5,0(a5)
    18d6:	4581                	li	a1,0
    18d8:	853e                	mv	a0,a5
    18da:	fffff097          	auipc	ra,0xfffff
    18de:	cfe080e7          	jalr	-770(ra) # 5d8 <cancelthrdstop>
        __dispatch();
    18e2:	00000097          	auipc	ra,0x0
    18e6:	d04080e7          	jalr	-764(ra) # 15e6 <__dispatch>

        if (list_empty(&run_queue) && list_empty(&release_queue)) {
    18ea:	00001517          	auipc	a0,0x1
    18ee:	d3650513          	addi	a0,a0,-714 # 2620 <run_queue>
    18f2:	fffff097          	auipc	ra,0xfffff
    18f6:	60a080e7          	jalr	1546(ra) # efc <list_empty>
    18fa:	87aa                	mv	a5,a0
    18fc:	cb99                	beqz	a5,1912 <thread_start_threading+0xb2>
    18fe:	00001517          	auipc	a0,0x1
    1902:	d3250513          	addi	a0,a0,-718 # 2630 <release_queue>
    1906:	fffff097          	auipc	ra,0xfffff
    190a:	5f6080e7          	jalr	1526(ra) # efc <list_empty>
    190e:	87aa                	mv	a5,a0
    1910:	ebd9                	bnez	a5,19a6 <thread_start_threading+0x146>
            break;
        }

        // no thread in run_queue, release_queue not empty
        printf("run_queue is empty, sleep for %d ticks\n", allocated_time);
    1912:	00001797          	auipc	a5,0x1
    1916:	d6678793          	addi	a5,a5,-666 # 2678 <allocated_time>
    191a:	639c                	ld	a5,0(a5)
    191c:	85be                	mv	a1,a5
    191e:	00001517          	auipc	a0,0x1
    1922:	cc250513          	addi	a0,a0,-830 # 25e0 <schedule_dm+0x402>
    1926:	fffff097          	auipc	ra,0xfffff
    192a:	148080e7          	jalr	328(ra) # a6e <printf>
        sleeping = 1;
    192e:	00001797          	auipc	a5,0x1
    1932:	d4678793          	addi	a5,a5,-698 # 2674 <sleeping>
    1936:	4705                	li	a4,1
    1938:	c398                	sw	a4,0(a5)
        thrdstop(allocated_time, &main_thrd_id, back_to_main_handler, (void *)allocated_time);
    193a:	00001797          	auipc	a5,0x1
    193e:	d3e78793          	addi	a5,a5,-706 # 2678 <allocated_time>
    1942:	639c                	ld	a5,0(a5)
    1944:	0007871b          	sext.w	a4,a5
    1948:	00001797          	auipc	a5,0x1
    194c:	d3078793          	addi	a5,a5,-720 # 2678 <allocated_time>
    1950:	639c                	ld	a5,0(a5)
    1952:	86be                	mv	a3,a5
    1954:	00000617          	auipc	a2,0x0
    1958:	eb060613          	addi	a2,a2,-336 # 1804 <back_to_main_handler>
    195c:	00001597          	auipc	a1,0x1
    1960:	ce458593          	addi	a1,a1,-796 # 2640 <main_thrd_id>
    1964:	853a                	mv	a0,a4
    1966:	fffff097          	auipc	ra,0xfffff
    196a:	c62080e7          	jalr	-926(ra) # 5c8 <thrdstop>
        while (sleeping) {
    196e:	0001                	nop
    1970:	00001797          	auipc	a5,0x1
    1974:	d0478793          	addi	a5,a5,-764 # 2674 <sleeping>
    1978:	439c                	lw	a5,0(a5)
    197a:	fbfd                	bnez	a5,1970 <thread_start_threading+0x110>
    while (!list_empty(&run_queue) || !list_empty(&release_queue)) {
    197c:	00001517          	auipc	a0,0x1
    1980:	ca450513          	addi	a0,a0,-860 # 2620 <run_queue>
    1984:	fffff097          	auipc	ra,0xfffff
    1988:	578080e7          	jalr	1400(ra) # efc <list_empty>
    198c:	87aa                	mv	a5,a0
    198e:	d79d                	beqz	a5,18bc <thread_start_threading+0x5c>
    1990:	00001517          	auipc	a0,0x1
    1994:	ca050513          	addi	a0,a0,-864 # 2630 <release_queue>
    1998:	fffff097          	auipc	ra,0xfffff
    199c:	564080e7          	jalr	1380(ra) # efc <list_empty>
    19a0:	87aa                	mv	a5,a0
    19a2:	df89                	beqz	a5,18bc <thread_start_threading+0x5c>
            // zzz...
        }
    }
}
    19a4:	a011                	j	19a8 <thread_start_threading+0x148>
            break;
    19a6:	0001                	nop
}
    19a8:	0001                	nop
    19aa:	60a2                	ld	ra,8(sp)
    19ac:	6402                	ld	s0,0(sp)
    19ae:	0141                	addi	sp,sp,16
    19b0:	8082                	ret

00000000000019b2 <schedule_default>:
#define NULL 0
#define min(a, b) ((a) < (b) ? (a) : (b))

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
    19b2:	715d                	addi	sp,sp,-80
    19b4:	e4a2                	sd	s0,72(sp)
    19b6:	e0a6                	sd	s1,64(sp)
    19b8:	0880                	addi	s0,sp,80
    19ba:	84aa                	mv	s1,a0
    struct thread *thread_with_smallest_id = NULL;
    19bc:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
    19c0:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, args.run_queue, thread_list)
    19c4:	649c                	ld	a5,8(s1)
    19c6:	639c                	ld	a5,0(a5)
    19c8:	fcf43c23          	sd	a5,-40(s0)
    19cc:	fd843783          	ld	a5,-40(s0)
    19d0:	fd878793          	addi	a5,a5,-40
    19d4:	fef43023          	sd	a5,-32(s0)
    19d8:	a81d                	j	1a0e <schedule_default+0x5c>
    {
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID)
    19da:	fe843783          	ld	a5,-24(s0)
    19de:	cb89                	beqz	a5,19f0 <schedule_default+0x3e>
    19e0:	fe043783          	ld	a5,-32(s0)
    19e4:	5fd8                	lw	a4,60(a5)
    19e6:	fe843783          	ld	a5,-24(s0)
    19ea:	5fdc                	lw	a5,60(a5)
    19ec:	00f75663          	bge	a4,a5,19f8 <schedule_default+0x46>
            thread_with_smallest_id = th;
    19f0:	fe043783          	ld	a5,-32(s0)
    19f4:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list)
    19f8:	fe043783          	ld	a5,-32(s0)
    19fc:	779c                	ld	a5,40(a5)
    19fe:	fcf43823          	sd	a5,-48(s0)
    1a02:	fd043783          	ld	a5,-48(s0)
    1a06:	fd878793          	addi	a5,a5,-40
    1a0a:	fef43023          	sd	a5,-32(s0)
    1a0e:	fe043783          	ld	a5,-32(s0)
    1a12:	02878713          	addi	a4,a5,40
    1a16:	649c                	ld	a5,8(s1)
    1a18:	fcf711e3          	bne	a4,a5,19da <schedule_default+0x28>
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL)
    1a1c:	fe843783          	ld	a5,-24(s0)
    1a20:	cf89                	beqz	a5,1a3a <schedule_default+0x88>
    {
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
    1a22:	fe843783          	ld	a5,-24(s0)
    1a26:	02878793          	addi	a5,a5,40
    1a2a:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = thread_with_smallest_id->remaining_time;
    1a2e:	fe843783          	ld	a5,-24(s0)
    1a32:	4fbc                	lw	a5,88(a5)
    1a34:	faf42c23          	sw	a5,-72(s0)
    1a38:	a039                	j	1a46 <schedule_default+0x94>
    }
    else
    {
        r.scheduled_thread_list_member = args.run_queue;
    1a3a:	649c                	ld	a5,8(s1)
    1a3c:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = 1;
    1a40:	4785                	li	a5,1
    1a42:	faf42c23          	sw	a5,-72(s0)
    }

    return r;
    1a46:	fb043783          	ld	a5,-80(s0)
    1a4a:	fcf43023          	sd	a5,-64(s0)
    1a4e:	fb843783          	ld	a5,-72(s0)
    1a52:	fcf43423          	sd	a5,-56(s0)
    1a56:	4701                	li	a4,0
    1a58:	fc043703          	ld	a4,-64(s0)
    1a5c:	4781                	li	a5,0
    1a5e:	fc843783          	ld	a5,-56(s0)
    1a62:	863a                	mv	a2,a4
    1a64:	86be                	mv	a3,a5
    1a66:	8732                	mv	a4,a2
    1a68:	87b6                	mv	a5,a3
}
    1a6a:	853a                	mv	a0,a4
    1a6c:	85be                	mv	a1,a5
    1a6e:	6426                	ld	s0,72(sp)
    1a70:	6486                	ld	s1,64(sp)
    1a72:	6161                	addi	sp,sp,80
    1a74:	8082                	ret

0000000000001a76 <schedule_wrr>:

/* MP3 Part 1 - Non-Real-Time Scheduling */
/* Weighted-Round-Robin Scheduling */
struct threads_sched_result schedule_wrr(struct threads_sched_args args)
{
    1a76:	7119                	addi	sp,sp,-128
    1a78:	fca2                	sd	s0,120(sp)
    1a7a:	f8a6                	sd	s1,112(sp)
    1a7c:	0100                	addi	s0,sp,128
    1a7e:	84aa                	mv	s1,a0
    struct thread *next_thread = NULL;
    1a80:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
    1a84:	fe043023          	sd	zero,-32(s0)
    // printf("\nrun_queue: \n");
    list_for_each_entry(th, args.run_queue, thread_list)
    1a88:	649c                	ld	a5,8(s1)
    1a8a:	639c                	ld	a5,0(a5)
    1a8c:	fcf43423          	sd	a5,-56(s0)
    1a90:	fc843783          	ld	a5,-56(s0)
    1a94:	fd878793          	addi	a5,a5,-40
    1a98:	fef43023          	sd	a5,-32(s0)
    1a9c:	a01d                	j	1ac2 <schedule_wrr+0x4c>
    {
        // printf("th->ID: %d; ", th->ID);
        // printf("th->arrival_time: %d\n", th->current_deadline - th->deadline);
        // if (current_thread == NULL || (th->remaining_time == th->processing_time && th->ID < current_thread->ID))
        //     current_thread = th;
        if (next_thread == NULL)
    1a9e:	fe843783          	ld	a5,-24(s0)
    1aa2:	e789                	bnez	a5,1aac <schedule_wrr+0x36>
            next_thread = th;
    1aa4:	fe043783          	ld	a5,-32(s0)
    1aa8:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list)
    1aac:	fe043783          	ld	a5,-32(s0)
    1ab0:	779c                	ld	a5,40(a5)
    1ab2:	faf43423          	sd	a5,-88(s0)
    1ab6:	fa843783          	ld	a5,-88(s0)
    1aba:	fd878793          	addi	a5,a5,-40
    1abe:	fef43023          	sd	a5,-32(s0)
    1ac2:	fe043783          	ld	a5,-32(s0)
    1ac6:	02878713          	addi	a4,a5,40
    1aca:	649c                	ld	a5,8(s1)
    1acc:	fcf719e3          	bne	a4,a5,1a9e <schedule_wrr+0x28>
    }

    struct threads_sched_result r;
    // TODO: implement the weighted round-robin scheduling algorithm
    int weighted_time = args.time_quantum * next_thread->weight;
    1ad0:	40d8                	lw	a4,4(s1)
    1ad2:	fe843783          	ld	a5,-24(s0)
    1ad6:	47bc                	lw	a5,72(a5)
    1ad8:	02f707bb          	mulw	a5,a4,a5
    1adc:	fcf42223          	sw	a5,-60(s0)
    int remaining_time = next_thread->remaining_time;
    1ae0:	fe843783          	ld	a5,-24(s0)
    1ae4:	4fbc                	lw	a5,88(a5)
    1ae6:	fcf42023          	sw	a5,-64(s0)
    if (next_thread != NULL)
    1aea:	fe843783          	ld	a5,-24(s0)
    1aee:	c795                	beqz	a5,1b1a <schedule_wrr+0xa4>
    {
        r.scheduled_thread_list_member = &next_thread->thread_list;
    1af0:	fe843783          	ld	a5,-24(s0)
    1af4:	02878793          	addi	a5,a5,40
    1af8:	f8f43423          	sd	a5,-120(s0)
        r.allocated_time = min(weighted_time, remaining_time);
    1afc:	fc442503          	lw	a0,-60(s0)
    1b00:	fc042783          	lw	a5,-64(s0)
    1b04:	0007859b          	sext.w	a1,a5
    1b08:	0005071b          	sext.w	a4,a0
    1b0c:	00b75363          	bge	a4,a1,1b12 <schedule_wrr+0x9c>
    1b10:	87aa                	mv	a5,a0
    1b12:	2781                	sext.w	a5,a5
    1b14:	f8f42823          	sw	a5,-112(s0)
    1b18:	a051                	j	1b9c <schedule_wrr+0x126>
    }
    else
    {
        struct release_queue_entry *next_rqe = NULL;
    1b1a:	fc043c23          	sd	zero,-40(s0)
        struct release_queue_entry *rqe = NULL;
    1b1e:	fc043823          	sd	zero,-48(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list)
    1b22:	689c                	ld	a5,16(s1)
    1b24:	639c                	ld	a5,0(a5)
    1b26:	faf43c23          	sd	a5,-72(s0)
    1b2a:	fb843783          	ld	a5,-72(s0)
    1b2e:	17e1                	addi	a5,a5,-8
    1b30:	fcf43823          	sd	a5,-48(s0)
    1b34:	a815                	j	1b68 <schedule_wrr+0xf2>
        {
            if (rqe == NULL || rqe->release_time < next_rqe->release_time)
    1b36:	fd043783          	ld	a5,-48(s0)
    1b3a:	cb89                	beqz	a5,1b4c <schedule_wrr+0xd6>
    1b3c:	fd043783          	ld	a5,-48(s0)
    1b40:	4f98                	lw	a4,24(a5)
    1b42:	fd843783          	ld	a5,-40(s0)
    1b46:	4f9c                	lw	a5,24(a5)
    1b48:	00f75663          	bge	a4,a5,1b54 <schedule_wrr+0xde>
                next_rqe = rqe;
    1b4c:	fd043783          	ld	a5,-48(s0)
    1b50:	fcf43c23          	sd	a5,-40(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list)
    1b54:	fd043783          	ld	a5,-48(s0)
    1b58:	679c                	ld	a5,8(a5)
    1b5a:	faf43823          	sd	a5,-80(s0)
    1b5e:	fb043783          	ld	a5,-80(s0)
    1b62:	17e1                	addi	a5,a5,-8
    1b64:	fcf43823          	sd	a5,-48(s0)
    1b68:	fd043783          	ld	a5,-48(s0)
    1b6c:	00878713          	addi	a4,a5,8
    1b70:	689c                	ld	a5,16(s1)
    1b72:	fcf712e3          	bne	a4,a5,1b36 <schedule_wrr+0xc0>
        }

        r.scheduled_thread_list_member = args.run_queue;
    1b76:	649c                	ld	a5,8(s1)
    1b78:	f8f43423          	sd	a5,-120(s0)
        if (next_rqe != NULL)
    1b7c:	fd843783          	ld	a5,-40(s0)
    1b80:	cb99                	beqz	a5,1b96 <schedule_wrr+0x120>
            r.allocated_time = next_rqe->release_time - args.current_time;
    1b82:	fd843783          	ld	a5,-40(s0)
    1b86:	4f98                	lw	a4,24(a5)
    1b88:	409c                	lw	a5,0(s1)
    1b8a:	40f707bb          	subw	a5,a4,a5
    1b8e:	2781                	sext.w	a5,a5
    1b90:	f8f42823          	sw	a5,-112(s0)
    1b94:	a021                	j	1b9c <schedule_wrr+0x126>
        else
            r.allocated_time = 1;
    1b96:	4785                	li	a5,1
    1b98:	f8f42823          	sw	a5,-112(s0)
    }

    return r;
    1b9c:	f8843783          	ld	a5,-120(s0)
    1ba0:	f8f43c23          	sd	a5,-104(s0)
    1ba4:	f9043783          	ld	a5,-112(s0)
    1ba8:	faf43023          	sd	a5,-96(s0)
    1bac:	4701                	li	a4,0
    1bae:	f9843703          	ld	a4,-104(s0)
    1bb2:	4781                	li	a5,0
    1bb4:	fa043783          	ld	a5,-96(s0)
    1bb8:	863a                	mv	a2,a4
    1bba:	86be                	mv	a3,a5
    1bbc:	8732                	mv	a4,a2
    1bbe:	87b6                	mv	a5,a3
}
    1bc0:	853a                	mv	a0,a4
    1bc2:	85be                	mv	a1,a5
    1bc4:	7466                	ld	s0,120(sp)
    1bc6:	74c6                	ld	s1,112(sp)
    1bc8:	6109                	addi	sp,sp,128
    1bca:	8082                	ret

0000000000001bcc <schedule_sjf>:

/* Shortest-Job-First Scheduling */
struct threads_sched_result schedule_sjf(struct threads_sched_args args)
{
    1bcc:	7175                	addi	sp,sp,-144
    1bce:	e522                	sd	s0,136(sp)
    1bd0:	e126                	sd	s1,128(sp)
    1bd2:	0900                	addi	s0,sp,144
    1bd4:	84aa                	mv	s1,a0
    struct thread *shortest_job = NULL;
    1bd6:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
    1bda:	fe043023          	sd	zero,-32(s0)
    struct release_queue_entry *rqe = NULL;
    1bde:	fc043c23          	sd	zero,-40(s0)
    int smallest_release_time = 0;
    1be2:	fc042a23          	sw	zero,-44(s0)
    int allocated_time = 0;
    1be6:	fc042823          	sw	zero,-48(s0)

    // printf("\n>> run_queue: \n");
    list_for_each_entry(th, args.run_queue, thread_list)
    1bea:	649c                	ld	a5,8(s1)
    1bec:	639c                	ld	a5,0(a5)
    1bee:	faf43c23          	sd	a5,-72(s0)
    1bf2:	fb843783          	ld	a5,-72(s0)
    1bf6:	fd878793          	addi	a5,a5,-40
    1bfa:	fef43023          	sd	a5,-32(s0)
    1bfe:	a899                	j	1c54 <schedule_sjf+0x88>
        // printf("th->arrival_time: %d; ", th->current_deadline - th->deadline);
        // printf("th->remaining_time: %d; ", th->remaining_time);
        // printf("th->finish time: %d\n", args.current_time + th->remaining_time);

        // Find the shortest job in the run queue
        if (shortest_job == NULL ||
    1c00:	fe843783          	ld	a5,-24(s0)
    1c04:	cb8d                	beqz	a5,1c36 <schedule_sjf+0x6a>
            th->remaining_time < shortest_job->remaining_time ||
    1c06:	fe043783          	ld	a5,-32(s0)
    1c0a:	4fb8                	lw	a4,88(a5)
    1c0c:	fe843783          	ld	a5,-24(s0)
    1c10:	4fbc                	lw	a5,88(a5)
        if (shortest_job == NULL ||
    1c12:	02f74263          	blt	a4,a5,1c36 <schedule_sjf+0x6a>
            (th->remaining_time == shortest_job->remaining_time && th->ID < shortest_job->ID))
    1c16:	fe043783          	ld	a5,-32(s0)
    1c1a:	4fb8                	lw	a4,88(a5)
    1c1c:	fe843783          	ld	a5,-24(s0)
    1c20:	4fbc                	lw	a5,88(a5)
            th->remaining_time < shortest_job->remaining_time ||
    1c22:	00f71e63          	bne	a4,a5,1c3e <schedule_sjf+0x72>
            (th->remaining_time == shortest_job->remaining_time && th->ID < shortest_job->ID))
    1c26:	fe043783          	ld	a5,-32(s0)
    1c2a:	5fd8                	lw	a4,60(a5)
    1c2c:	fe843783          	ld	a5,-24(s0)
    1c30:	5fdc                	lw	a5,60(a5)
    1c32:	00f75663          	bge	a4,a5,1c3e <schedule_sjf+0x72>
            shortest_job = th;
    1c36:	fe043783          	ld	a5,-32(s0)
    1c3a:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list)
    1c3e:	fe043783          	ld	a5,-32(s0)
    1c42:	779c                	ld	a5,40(a5)
    1c44:	f8f43823          	sd	a5,-112(s0)
    1c48:	f9043783          	ld	a5,-112(s0)
    1c4c:	fd878793          	addi	a5,a5,-40
    1c50:	fef43023          	sd	a5,-32(s0)
    1c54:	fe043783          	ld	a5,-32(s0)
    1c58:	02878713          	addi	a4,a5,40
    1c5c:	649c                	ld	a5,8(s1)
    1c5e:	faf711e3          	bne	a4,a5,1c00 <schedule_sjf+0x34>
    }
    allocated_time = shortest_job->remaining_time;
    1c62:	fe843783          	ld	a5,-24(s0)
    1c66:	4fbc                	lw	a5,88(a5)
    1c68:	fcf42823          	sw	a5,-48(s0)

    // printf("\n>> release_queue: \n");
    list_for_each_entry(rqe, args.release_queue, thread_list)
    1c6c:	689c                	ld	a5,16(s1)
    1c6e:	639c                	ld	a5,0(a5)
    1c70:	faf43823          	sd	a5,-80(s0)
    1c74:	fb043783          	ld	a5,-80(s0)
    1c78:	17e1                	addi	a5,a5,-8
    1c7a:	fcf43c23          	sd	a5,-40(s0)
    1c7e:	a0c5                	j	1d5e <schedule_sjf+0x192>
        // printf("rqe->release_time: %d; ", rqe->release_time);
        // printf("rqe->thrd->processing_time: %d\n", rqe->thrd->processing_time);

        // If any job in the release queue has a shorter processing time than the shortest job
        // and the job is released before the shortest job finishes
        if (rqe->release_time < (args.current_time + allocated_time) &&
    1c80:	fd843783          	ld	a5,-40(s0)
    1c84:	4f8c                	lw	a1,24(a5)
    1c86:	409c                	lw	a5,0(s1)
    1c88:	fd042703          	lw	a4,-48(s0)
    1c8c:	9fb9                	addw	a5,a5,a4
    1c8e:	2781                	sext.w	a5,a5
    1c90:	872e                	mv	a4,a1
    1c92:	0af75c63          	bge	a4,a5,1d4a <schedule_sjf+0x17e>
            (rqe->thrd->processing_time < (shortest_job->remaining_time - (rqe->release_time - args.current_time)) ||
    1c96:	fd843783          	ld	a5,-40(s0)
    1c9a:	639c                	ld	a5,0(a5)
    1c9c:	43e8                	lw	a0,68(a5)
    1c9e:	fe843783          	ld	a5,-24(s0)
    1ca2:	4fb8                	lw	a4,88(a5)
    1ca4:	fd843783          	ld	a5,-40(s0)
    1ca8:	4f8c                	lw	a1,24(a5)
    1caa:	409c                	lw	a5,0(s1)
    1cac:	40f587bb          	subw	a5,a1,a5
    1cb0:	2781                	sext.w	a5,a5
    1cb2:	40f707bb          	subw	a5,a4,a5
    1cb6:	2781                	sext.w	a5,a5
        if (rqe->release_time < (args.current_time + allocated_time) &&
    1cb8:	872a                	mv	a4,a0
    1cba:	02f74f63          	blt	a4,a5,1cf8 <schedule_sjf+0x12c>
             (rqe->thrd->processing_time == (shortest_job->remaining_time - (rqe->release_time - args.current_time)) && rqe->thrd->ID < shortest_job->ID)))
    1cbe:	fd843783          	ld	a5,-40(s0)
    1cc2:	639c                	ld	a5,0(a5)
    1cc4:	43e8                	lw	a0,68(a5)
    1cc6:	fe843783          	ld	a5,-24(s0)
    1cca:	4fb8                	lw	a4,88(a5)
    1ccc:	fd843783          	ld	a5,-40(s0)
    1cd0:	4f8c                	lw	a1,24(a5)
    1cd2:	409c                	lw	a5,0(s1)
    1cd4:	40f587bb          	subw	a5,a1,a5
    1cd8:	2781                	sext.w	a5,a5
    1cda:	40f707bb          	subw	a5,a4,a5
    1cde:	2781                	sext.w	a5,a5
            (rqe->thrd->processing_time < (shortest_job->remaining_time - (rqe->release_time - args.current_time)) ||
    1ce0:	872a                	mv	a4,a0
    1ce2:	06f71463          	bne	a4,a5,1d4a <schedule_sjf+0x17e>
             (rqe->thrd->processing_time == (shortest_job->remaining_time - (rqe->release_time - args.current_time)) && rqe->thrd->ID < shortest_job->ID)))
    1ce6:	fd843783          	ld	a5,-40(s0)
    1cea:	639c                	ld	a5,0(a5)
    1cec:	5fd8                	lw	a4,60(a5)
    1cee:	fe843783          	ld	a5,-24(s0)
    1cf2:	5fdc                	lw	a5,60(a5)
    1cf4:	04f75b63          	bge	a4,a5,1d4a <schedule_sjf+0x17e>
        {
            if (smallest_release_time == 0 ||
    1cf8:	fd442783          	lw	a5,-44(s0)
    1cfc:	2781                	sext.w	a5,a5
    1cfe:	cb95                	beqz	a5,1d32 <schedule_sjf+0x166>
                rqe->release_time < smallest_release_time ||
    1d00:	fd843783          	ld	a5,-40(s0)
    1d04:	4f98                	lw	a4,24(a5)
            if (smallest_release_time == 0 ||
    1d06:	fd442783          	lw	a5,-44(s0)
    1d0a:	2781                	sext.w	a5,a5
    1d0c:	02f74363          	blt	a4,a5,1d32 <schedule_sjf+0x166>
                (rqe->release_time == smallest_release_time && rqe->thrd->ID < shortest_job->ID))
    1d10:	fd843783          	ld	a5,-40(s0)
    1d14:	4f98                	lw	a4,24(a5)
                rqe->release_time < smallest_release_time ||
    1d16:	fd442783          	lw	a5,-44(s0)
    1d1a:	2781                	sext.w	a5,a5
    1d1c:	02e79763          	bne	a5,a4,1d4a <schedule_sjf+0x17e>
                (rqe->release_time == smallest_release_time && rqe->thrd->ID < shortest_job->ID))
    1d20:	fd843783          	ld	a5,-40(s0)
    1d24:	639c                	ld	a5,0(a5)
    1d26:	5fd8                	lw	a4,60(a5)
    1d28:	fe843783          	ld	a5,-24(s0)
    1d2c:	5fdc                	lw	a5,60(a5)
    1d2e:	00f75e63          	bge	a4,a5,1d4a <schedule_sjf+0x17e>
            {
                smallest_release_time = rqe->release_time;
    1d32:	fd843783          	ld	a5,-40(s0)
    1d36:	4f9c                	lw	a5,24(a5)
    1d38:	fcf42a23          	sw	a5,-44(s0)
                allocated_time = smallest_release_time - args.current_time;
    1d3c:	409c                	lw	a5,0(s1)
    1d3e:	fd442703          	lw	a4,-44(s0)
    1d42:	40f707bb          	subw	a5,a4,a5
    1d46:	fcf42823          	sw	a5,-48(s0)
    list_for_each_entry(rqe, args.release_queue, thread_list)
    1d4a:	fd843783          	ld	a5,-40(s0)
    1d4e:	679c                	ld	a5,8(a5)
    1d50:	f8f43c23          	sd	a5,-104(s0)
    1d54:	f9843783          	ld	a5,-104(s0)
    1d58:	17e1                	addi	a5,a5,-8
    1d5a:	fcf43c23          	sd	a5,-40(s0)
    1d5e:	fd843783          	ld	a5,-40(s0)
    1d62:	00878713          	addi	a4,a5,8
    1d66:	689c                	ld	a5,16(s1)
    1d68:	f0f71ce3          	bne	a4,a5,1c80 <schedule_sjf+0xb4>
        }
    }

    struct threads_sched_result r;
    // TODO: implement the shortest-job-first scheduling algorithm
    if (shortest_job != NULL)
    1d6c:	fe843783          	ld	a5,-24(s0)
    1d70:	cf81                	beqz	a5,1d88 <schedule_sjf+0x1bc>
    {
        r.scheduled_thread_list_member = &shortest_job->thread_list;
    1d72:	fe843783          	ld	a5,-24(s0)
    1d76:	02878793          	addi	a5,a5,40
    1d7a:	f6f43823          	sd	a5,-144(s0)
        r.allocated_time = allocated_time;
    1d7e:	fd042783          	lw	a5,-48(s0)
    1d82:	f6f42c23          	sw	a5,-136(s0)
    1d86:	a065                	j	1e2e <schedule_sjf+0x262>
    }
    else
    {
        struct release_queue_entry *next_rqe = NULL;
    1d88:	fc043423          	sd	zero,-56(s0)
        struct release_queue_entry *rqe = NULL;
    1d8c:	fc043023          	sd	zero,-64(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list)
    1d90:	689c                	ld	a5,16(s1)
    1d92:	639c                	ld	a5,0(a5)
    1d94:	faf43423          	sd	a5,-88(s0)
    1d98:	fa843783          	ld	a5,-88(s0)
    1d9c:	17e1                	addi	a5,a5,-8
    1d9e:	fcf43023          	sd	a5,-64(s0)
    1da2:	a8a1                	j	1dfa <schedule_sjf+0x22e>
        {
            if (rqe == NULL ||
    1da4:	fc043783          	ld	a5,-64(s0)
    1da8:	cb9d                	beqz	a5,1dde <schedule_sjf+0x212>
                rqe->release_time < next_rqe->release_time ||
    1daa:	fc043783          	ld	a5,-64(s0)
    1dae:	4f98                	lw	a4,24(a5)
    1db0:	fc843783          	ld	a5,-56(s0)
    1db4:	4f9c                	lw	a5,24(a5)
            if (rqe == NULL ||
    1db6:	02f74463          	blt	a4,a5,1dde <schedule_sjf+0x212>
                (rqe->release_time == next_rqe->release_time && rqe->thrd->ID < next_rqe->thrd->ID))
    1dba:	fc043783          	ld	a5,-64(s0)
    1dbe:	4f98                	lw	a4,24(a5)
    1dc0:	fc843783          	ld	a5,-56(s0)
    1dc4:	4f9c                	lw	a5,24(a5)
                rqe->release_time < next_rqe->release_time ||
    1dc6:	02f71063          	bne	a4,a5,1de6 <schedule_sjf+0x21a>
                (rqe->release_time == next_rqe->release_time && rqe->thrd->ID < next_rqe->thrd->ID))
    1dca:	fc043783          	ld	a5,-64(s0)
    1dce:	639c                	ld	a5,0(a5)
    1dd0:	5fd8                	lw	a4,60(a5)
    1dd2:	fc843783          	ld	a5,-56(s0)
    1dd6:	639c                	ld	a5,0(a5)
    1dd8:	5fdc                	lw	a5,60(a5)
    1dda:	00f75663          	bge	a4,a5,1de6 <schedule_sjf+0x21a>
                next_rqe = rqe;
    1dde:	fc043783          	ld	a5,-64(s0)
    1de2:	fcf43423          	sd	a5,-56(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list)
    1de6:	fc043783          	ld	a5,-64(s0)
    1dea:	679c                	ld	a5,8(a5)
    1dec:	faf43023          	sd	a5,-96(s0)
    1df0:	fa043783          	ld	a5,-96(s0)
    1df4:	17e1                	addi	a5,a5,-8
    1df6:	fcf43023          	sd	a5,-64(s0)
    1dfa:	fc043783          	ld	a5,-64(s0)
    1dfe:	00878713          	addi	a4,a5,8
    1e02:	689c                	ld	a5,16(s1)
    1e04:	faf710e3          	bne	a4,a5,1da4 <schedule_sjf+0x1d8>
        }

        r.scheduled_thread_list_member = args.run_queue;
    1e08:	649c                	ld	a5,8(s1)
    1e0a:	f6f43823          	sd	a5,-144(s0)
        if (next_rqe != NULL)
    1e0e:	fc843783          	ld	a5,-56(s0)
    1e12:	cb99                	beqz	a5,1e28 <schedule_sjf+0x25c>
            r.allocated_time = next_rqe->release_time - args.current_time;
    1e14:	fc843783          	ld	a5,-56(s0)
    1e18:	4f98                	lw	a4,24(a5)
    1e1a:	409c                	lw	a5,0(s1)
    1e1c:	40f707bb          	subw	a5,a4,a5
    1e20:	2781                	sext.w	a5,a5
    1e22:	f6f42c23          	sw	a5,-136(s0)
    1e26:	a021                	j	1e2e <schedule_sjf+0x262>
        else
            r.allocated_time = 1;
    1e28:	4785                	li	a5,1
    1e2a:	f6f42c23          	sw	a5,-136(s0)
    }

    return r;
    1e2e:	f7043783          	ld	a5,-144(s0)
    1e32:	f8f43023          	sd	a5,-128(s0)
    1e36:	f7843783          	ld	a5,-136(s0)
    1e3a:	f8f43423          	sd	a5,-120(s0)
    1e3e:	4701                	li	a4,0
    1e40:	f8043703          	ld	a4,-128(s0)
    1e44:	4781                	li	a5,0
    1e46:	f8843783          	ld	a5,-120(s0)
    1e4a:	863a                	mv	a2,a4
    1e4c:	86be                	mv	a3,a5
    1e4e:	8732                	mv	a4,a2
    1e50:	87b6                	mv	a5,a3
}
    1e52:	853a                	mv	a0,a4
    1e54:	85be                	mv	a1,a5
    1e56:	642a                	ld	s0,136(sp)
    1e58:	648a                	ld	s1,128(sp)
    1e5a:	6149                	addi	sp,sp,144
    1e5c:	8082                	ret

0000000000001e5e <schedule_lst>:

/* MP3 Part 2 - Real-Time Scheduling*/
/* Least-Slack-Time Scheduling */
struct threads_sched_result schedule_lst(struct threads_sched_args args)
{
    1e5e:	7135                	addi	sp,sp,-160
    1e60:	ed22                	sd	s0,152(sp)
    1e62:	e926                	sd	s1,144(sp)
    1e64:	1100                	addi	s0,sp,160
    1e66:	84aa                	mv	s1,a0
    struct thread *least_slack_time_thread = NULL;
    1e68:	fe043423          	sd	zero,-24(s0)
    struct thread *miss_deadline_thread = NULL;
    1e6c:	fe043023          	sd	zero,-32(s0)
    struct thread *th = NULL;
    1e70:	fc043c23          	sd	zero,-40(s0)
    struct release_queue_entry *rqe = NULL;
    1e74:	fc043823          	sd	zero,-48(s0)
    int allocated_time = 0;
    1e78:	fc042623          	sw	zero,-52(s0)
    int smallest_release_time = 0;
    1e7c:	fc042423          	sw	zero,-56(s0)
#define slack_time(th) (th->current_deadline - args.current_time - th->remaining_time)
#define release_queue_slack_time(th) (th->deadline - th->processing_time)
    // printf("\n>> run_queue: \n");
    list_for_each_entry(th, args.run_queue, thread_list)
    1e80:	649c                	ld	a5,8(s1)
    1e82:	639c                	ld	a5,0(a5)
    1e84:	faf43823          	sd	a5,-80(s0)
    1e88:	fb043783          	ld	a5,-80(s0)
    1e8c:	fd878793          	addi	a5,a5,-40
    1e90:	fcf43c23          	sd	a5,-40(s0)
    1e94:	a0dd                	j	1f7a <schedule_lst+0x11c>
    {
        // printf("th->ID: %d; ", th->ID);
        // printf("th->slack_time: %d\n", slack_time(th));
        if (args.current_time >= th->current_deadline &&
    1e96:	4098                	lw	a4,0(s1)
    1e98:	fd843783          	ld	a5,-40(s0)
    1e9c:	4ffc                	lw	a5,92(a5)
    1e9e:	02f74163          	blt	a4,a5,1ec0 <schedule_lst+0x62>
    1ea2:	fe043783          	ld	a5,-32(s0)
    1ea6:	cb89                	beqz	a5,1eb8 <schedule_lst+0x5a>
            (miss_deadline_thread == NULL || th->ID < miss_deadline_thread->ID))
    1ea8:	fd843783          	ld	a5,-40(s0)
    1eac:	5fd8                	lw	a4,60(a5)
    1eae:	fe043783          	ld	a5,-32(s0)
    1eb2:	5fdc                	lw	a5,60(a5)
    1eb4:	00f75663          	bge	a4,a5,1ec0 <schedule_lst+0x62>
        {
            miss_deadline_thread = th;
    1eb8:	fd843783          	ld	a5,-40(s0)
    1ebc:	fef43023          	sd	a5,-32(s0)
        }

        if (miss_deadline_thread == NULL && (least_slack_time_thread == NULL ||
    1ec0:	fe043783          	ld	a5,-32(s0)
    1ec4:	e3c5                	bnez	a5,1f64 <schedule_lst+0x106>
    1ec6:	fe843783          	ld	a5,-24(s0)
    1eca:	cbc9                	beqz	a5,1f5c <schedule_lst+0xfe>
                                             slack_time(th) < slack_time(least_slack_time_thread) ||
    1ecc:	fd843783          	ld	a5,-40(s0)
    1ed0:	4ff8                	lw	a4,92(a5)
    1ed2:	409c                	lw	a5,0(s1)
    1ed4:	40f707bb          	subw	a5,a4,a5
    1ed8:	0007871b          	sext.w	a4,a5
    1edc:	fd843783          	ld	a5,-40(s0)
    1ee0:	4fbc                	lw	a5,88(a5)
    1ee2:	40f707bb          	subw	a5,a4,a5
    1ee6:	0007859b          	sext.w	a1,a5
    1eea:	fe843783          	ld	a5,-24(s0)
    1eee:	4ff8                	lw	a4,92(a5)
    1ef0:	409c                	lw	a5,0(s1)
    1ef2:	40f707bb          	subw	a5,a4,a5
    1ef6:	0007871b          	sext.w	a4,a5
    1efa:	fe843783          	ld	a5,-24(s0)
    1efe:	4fbc                	lw	a5,88(a5)
    1f00:	40f707bb          	subw	a5,a4,a5
    1f04:	2781                	sext.w	a5,a5
        if (miss_deadline_thread == NULL && (least_slack_time_thread == NULL ||
    1f06:	872e                	mv	a4,a1
    1f08:	04f74a63          	blt	a4,a5,1f5c <schedule_lst+0xfe>
                                             (slack_time(th) == slack_time(least_slack_time_thread) && th->ID < least_slack_time_thread->ID)))
    1f0c:	fd843783          	ld	a5,-40(s0)
    1f10:	4ff8                	lw	a4,92(a5)
    1f12:	409c                	lw	a5,0(s1)
    1f14:	40f707bb          	subw	a5,a4,a5
    1f18:	0007871b          	sext.w	a4,a5
    1f1c:	fd843783          	ld	a5,-40(s0)
    1f20:	4fbc                	lw	a5,88(a5)
    1f22:	40f707bb          	subw	a5,a4,a5
    1f26:	0007859b          	sext.w	a1,a5
    1f2a:	fe843783          	ld	a5,-24(s0)
    1f2e:	4ff8                	lw	a4,92(a5)
    1f30:	409c                	lw	a5,0(s1)
    1f32:	40f707bb          	subw	a5,a4,a5
    1f36:	0007871b          	sext.w	a4,a5
    1f3a:	fe843783          	ld	a5,-24(s0)
    1f3e:	4fbc                	lw	a5,88(a5)
    1f40:	40f707bb          	subw	a5,a4,a5
    1f44:	2781                	sext.w	a5,a5
                                             slack_time(th) < slack_time(least_slack_time_thread) ||
    1f46:	872e                	mv	a4,a1
    1f48:	00f71e63          	bne	a4,a5,1f64 <schedule_lst+0x106>
                                             (slack_time(th) == slack_time(least_slack_time_thread) && th->ID < least_slack_time_thread->ID)))
    1f4c:	fd843783          	ld	a5,-40(s0)
    1f50:	5fd8                	lw	a4,60(a5)
    1f52:	fe843783          	ld	a5,-24(s0)
    1f56:	5fdc                	lw	a5,60(a5)
    1f58:	00f75663          	bge	a4,a5,1f64 <schedule_lst+0x106>
        {
            least_slack_time_thread = th;
    1f5c:	fd843783          	ld	a5,-40(s0)
    1f60:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list)
    1f64:	fd843783          	ld	a5,-40(s0)
    1f68:	779c                	ld	a5,40(a5)
    1f6a:	f8f43423          	sd	a5,-120(s0)
    1f6e:	f8843783          	ld	a5,-120(s0)
    1f72:	fd878793          	addi	a5,a5,-40
    1f76:	fcf43c23          	sd	a5,-40(s0)
    1f7a:	fd843783          	ld	a5,-40(s0)
    1f7e:	02878713          	addi	a4,a5,40
    1f82:	649c                	ld	a5,8(s1)
    1f84:	f0f719e3          	bne	a4,a5,1e96 <schedule_lst+0x38>
        }
    }

    if (miss_deadline_thread != NULL)
    1f88:	fe043783          	ld	a5,-32(s0)
    1f8c:	cb81                	beqz	a5,1f9c <schedule_lst+0x13e>
    {
        least_slack_time_thread = miss_deadline_thread;
    1f8e:	fe043783          	ld	a5,-32(s0)
    1f92:	fef43423          	sd	a5,-24(s0)
        allocated_time = 0;
    1f96:	fc042623          	sw	zero,-52(s0)
    1f9a:	aa89                	j	20ec <schedule_lst+0x28e>
    }
    else
    {
        allocated_time = min(least_slack_time_thread->remaining_time, least_slack_time_thread->current_deadline - args.current_time);
    1f9c:	fe843783          	ld	a5,-24(s0)
    1fa0:	4ff8                	lw	a4,92(a5)
    1fa2:	409c                	lw	a5,0(s1)
    1fa4:	40f707bb          	subw	a5,a4,a5
    1fa8:	0007871b          	sext.w	a4,a5
    1fac:	fe843783          	ld	a5,-24(s0)
    1fb0:	4fbc                	lw	a5,88(a5)
    1fb2:	853e                	mv	a0,a5
    1fb4:	87ba                	mv	a5,a4
    1fb6:	0007859b          	sext.w	a1,a5
    1fba:	0005071b          	sext.w	a4,a0
    1fbe:	00b75363          	bge	a4,a1,1fc4 <schedule_lst+0x166>
    1fc2:	87aa                	mv	a5,a0
    1fc4:	fcf42623          	sw	a5,-52(s0)
        // printf("\n>> release_queue: \n");
        list_for_each_entry(rqe, args.release_queue, thread_list)
    1fc8:	689c                	ld	a5,16(s1)
    1fca:	639c                	ld	a5,0(a5)
    1fcc:	faf43423          	sd	a5,-88(s0)
    1fd0:	fa843783          	ld	a5,-88(s0)
    1fd4:	17e1                	addi	a5,a5,-8
    1fd6:	fcf43823          	sd	a5,-48(s0)
    1fda:	a211                	j	20de <schedule_lst+0x280>
        {
            // printf("rqe->thrd->ID: %d; ", rqe->thrd->ID);
            // printf("rqe->release_time: %d; ", rqe->release_time);
            // printf("rqe->thrd->processing_time: %d\n", rqe->thrd->processing_time);
            if (rqe->release_time < args.current_time + allocated_time &&
    1fdc:	fd043783          	ld	a5,-48(s0)
    1fe0:	4f8c                	lw	a1,24(a5)
    1fe2:	409c                	lw	a5,0(s1)
    1fe4:	fcc42703          	lw	a4,-52(s0)
    1fe8:	9fb9                	addw	a5,a5,a4
    1fea:	2781                	sext.w	a5,a5
    1fec:	872e                	mv	a4,a1
    1fee:	0cf75e63          	bge	a4,a5,20ca <schedule_lst+0x26c>
                (release_queue_slack_time(rqe->thrd) < slack_time(least_slack_time_thread) ||
    1ff2:	fd043783          	ld	a5,-48(s0)
    1ff6:	639c                	ld	a5,0(a5)
    1ff8:	47f8                	lw	a4,76(a5)
    1ffa:	fd043783          	ld	a5,-48(s0)
    1ffe:	639c                	ld	a5,0(a5)
    2000:	43fc                	lw	a5,68(a5)
    2002:	40f707bb          	subw	a5,a4,a5
    2006:	0007859b          	sext.w	a1,a5
    200a:	fe843783          	ld	a5,-24(s0)
    200e:	4ff8                	lw	a4,92(a5)
    2010:	409c                	lw	a5,0(s1)
    2012:	40f707bb          	subw	a5,a4,a5
    2016:	0007871b          	sext.w	a4,a5
    201a:	fe843783          	ld	a5,-24(s0)
    201e:	4fbc                	lw	a5,88(a5)
    2020:	40f707bb          	subw	a5,a4,a5
    2024:	2781                	sext.w	a5,a5
            if (rqe->release_time < args.current_time + allocated_time &&
    2026:	872e                	mv	a4,a1
    2028:	04f74863          	blt	a4,a5,2078 <schedule_lst+0x21a>
                 (release_queue_slack_time(rqe->thrd) == slack_time(least_slack_time_thread) && rqe->thrd->ID < least_slack_time_thread->ID)))
    202c:	fd043783          	ld	a5,-48(s0)
    2030:	639c                	ld	a5,0(a5)
    2032:	47f8                	lw	a4,76(a5)
    2034:	fd043783          	ld	a5,-48(s0)
    2038:	639c                	ld	a5,0(a5)
    203a:	43fc                	lw	a5,68(a5)
    203c:	40f707bb          	subw	a5,a4,a5
    2040:	0007859b          	sext.w	a1,a5
    2044:	fe843783          	ld	a5,-24(s0)
    2048:	4ff8                	lw	a4,92(a5)
    204a:	409c                	lw	a5,0(s1)
    204c:	40f707bb          	subw	a5,a4,a5
    2050:	0007871b          	sext.w	a4,a5
    2054:	fe843783          	ld	a5,-24(s0)
    2058:	4fbc                	lw	a5,88(a5)
    205a:	40f707bb          	subw	a5,a4,a5
    205e:	2781                	sext.w	a5,a5
                (release_queue_slack_time(rqe->thrd) < slack_time(least_slack_time_thread) ||
    2060:	872e                	mv	a4,a1
    2062:	06f71463          	bne	a4,a5,20ca <schedule_lst+0x26c>
                 (release_queue_slack_time(rqe->thrd) == slack_time(least_slack_time_thread) && rqe->thrd->ID < least_slack_time_thread->ID)))
    2066:	fd043783          	ld	a5,-48(s0)
    206a:	639c                	ld	a5,0(a5)
    206c:	5fd8                	lw	a4,60(a5)
    206e:	fe843783          	ld	a5,-24(s0)
    2072:	5fdc                	lw	a5,60(a5)
    2074:	04f75b63          	bge	a4,a5,20ca <schedule_lst+0x26c>
            {
                if (smallest_release_time == 0 ||
    2078:	fc842783          	lw	a5,-56(s0)
    207c:	2781                	sext.w	a5,a5
    207e:	cb95                	beqz	a5,20b2 <schedule_lst+0x254>
                    rqe->release_time < smallest_release_time ||
    2080:	fd043783          	ld	a5,-48(s0)
    2084:	4f98                	lw	a4,24(a5)
                if (smallest_release_time == 0 ||
    2086:	fc842783          	lw	a5,-56(s0)
    208a:	2781                	sext.w	a5,a5
    208c:	02f74363          	blt	a4,a5,20b2 <schedule_lst+0x254>
                    (rqe->release_time == smallest_release_time && rqe->thrd->ID < least_slack_time_thread->ID))
    2090:	fd043783          	ld	a5,-48(s0)
    2094:	4f98                	lw	a4,24(a5)
                    rqe->release_time < smallest_release_time ||
    2096:	fc842783          	lw	a5,-56(s0)
    209a:	2781                	sext.w	a5,a5
    209c:	02e79763          	bne	a5,a4,20ca <schedule_lst+0x26c>
                    (rqe->release_time == smallest_release_time && rqe->thrd->ID < least_slack_time_thread->ID))
    20a0:	fd043783          	ld	a5,-48(s0)
    20a4:	639c                	ld	a5,0(a5)
    20a6:	5fd8                	lw	a4,60(a5)
    20a8:	fe843783          	ld	a5,-24(s0)
    20ac:	5fdc                	lw	a5,60(a5)
    20ae:	00f75e63          	bge	a4,a5,20ca <schedule_lst+0x26c>
                {
                    smallest_release_time = rqe->release_time;
    20b2:	fd043783          	ld	a5,-48(s0)
    20b6:	4f9c                	lw	a5,24(a5)
    20b8:	fcf42423          	sw	a5,-56(s0)
                    allocated_time = smallest_release_time - args.current_time;
    20bc:	409c                	lw	a5,0(s1)
    20be:	fc842703          	lw	a4,-56(s0)
    20c2:	40f707bb          	subw	a5,a4,a5
    20c6:	fcf42623          	sw	a5,-52(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list)
    20ca:	fd043783          	ld	a5,-48(s0)
    20ce:	679c                	ld	a5,8(a5)
    20d0:	faf43023          	sd	a5,-96(s0)
    20d4:	fa043783          	ld	a5,-96(s0)
    20d8:	17e1                	addi	a5,a5,-8
    20da:	fcf43823          	sd	a5,-48(s0)
    20de:	fd043783          	ld	a5,-48(s0)
    20e2:	00878713          	addi	a4,a5,8
    20e6:	689c                	ld	a5,16(s1)
    20e8:	eef71ae3          	bne	a4,a5,1fdc <schedule_lst+0x17e>
        }
    }

    struct threads_sched_result r;
    // TODO: implement the least-slack-time scheduling algorithm
    if (least_slack_time_thread != NULL)
    20ec:	fe843783          	ld	a5,-24(s0)
    20f0:	cf81                	beqz	a5,2108 <schedule_lst+0x2aa>
    {
        r.scheduled_thread_list_member = &least_slack_time_thread->thread_list;
    20f2:	fe843783          	ld	a5,-24(s0)
    20f6:	02878793          	addi	a5,a5,40
    20fa:	f6f43423          	sd	a5,-152(s0)
        r.allocated_time = allocated_time;
    20fe:	fcc42783          	lw	a5,-52(s0)
    2102:	f6f42823          	sw	a5,-144(s0)
    2106:	a065                	j	21ae <schedule_lst+0x350>
    }
    else
    {
        r.scheduled_thread_list_member = args.run_queue;
    2108:	649c                	ld	a5,8(s1)
    210a:	f6f43423          	sd	a5,-152(s0)

        struct release_queue_entry *next_rqe = NULL;
    210e:	fc043023          	sd	zero,-64(s0)
        struct release_queue_entry *rqe = NULL;
    2112:	fa043c23          	sd	zero,-72(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list)
    2116:	689c                	ld	a5,16(s1)
    2118:	639c                	ld	a5,0(a5)
    211a:	f8f43c23          	sd	a5,-104(s0)
    211e:	f9843783          	ld	a5,-104(s0)
    2122:	17e1                	addi	a5,a5,-8
    2124:	faf43c23          	sd	a5,-72(s0)
    2128:	a8a1                	j	2180 <schedule_lst+0x322>
        {
            if (rqe == NULL ||
    212a:	fb843783          	ld	a5,-72(s0)
    212e:	cb9d                	beqz	a5,2164 <schedule_lst+0x306>
                rqe->release_time < next_rqe->release_time ||
    2130:	fb843783          	ld	a5,-72(s0)
    2134:	4f98                	lw	a4,24(a5)
    2136:	fc043783          	ld	a5,-64(s0)
    213a:	4f9c                	lw	a5,24(a5)
            if (rqe == NULL ||
    213c:	02f74463          	blt	a4,a5,2164 <schedule_lst+0x306>
                (rqe->release_time == next_rqe->release_time && rqe->thrd->ID < next_rqe->thrd->ID))
    2140:	fb843783          	ld	a5,-72(s0)
    2144:	4f98                	lw	a4,24(a5)
    2146:	fc043783          	ld	a5,-64(s0)
    214a:	4f9c                	lw	a5,24(a5)
                rqe->release_time < next_rqe->release_time ||
    214c:	02f71063          	bne	a4,a5,216c <schedule_lst+0x30e>
                (rqe->release_time == next_rqe->release_time && rqe->thrd->ID < next_rqe->thrd->ID))
    2150:	fb843783          	ld	a5,-72(s0)
    2154:	639c                	ld	a5,0(a5)
    2156:	5fd8                	lw	a4,60(a5)
    2158:	fc043783          	ld	a5,-64(s0)
    215c:	639c                	ld	a5,0(a5)
    215e:	5fdc                	lw	a5,60(a5)
    2160:	00f75663          	bge	a4,a5,216c <schedule_lst+0x30e>
                next_rqe = rqe;
    2164:	fb843783          	ld	a5,-72(s0)
    2168:	fcf43023          	sd	a5,-64(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list)
    216c:	fb843783          	ld	a5,-72(s0)
    2170:	679c                	ld	a5,8(a5)
    2172:	f8f43823          	sd	a5,-112(s0)
    2176:	f9043783          	ld	a5,-112(s0)
    217a:	17e1                	addi	a5,a5,-8
    217c:	faf43c23          	sd	a5,-72(s0)
    2180:	fb843783          	ld	a5,-72(s0)
    2184:	00878713          	addi	a4,a5,8
    2188:	689c                	ld	a5,16(s1)
    218a:	faf710e3          	bne	a4,a5,212a <schedule_lst+0x2cc>
        }
        if (next_rqe != NULL)
    218e:	fc043783          	ld	a5,-64(s0)
    2192:	cb99                	beqz	a5,21a8 <schedule_lst+0x34a>
            r.allocated_time = next_rqe->release_time - args.current_time;
    2194:	fc043783          	ld	a5,-64(s0)
    2198:	4f98                	lw	a4,24(a5)
    219a:	409c                	lw	a5,0(s1)
    219c:	40f707bb          	subw	a5,a4,a5
    21a0:	2781                	sext.w	a5,a5
    21a2:	f6f42823          	sw	a5,-144(s0)
    21a6:	a021                	j	21ae <schedule_lst+0x350>
        else
            r.allocated_time = 1;
    21a8:	4785                	li	a5,1
    21aa:	f6f42823          	sw	a5,-144(s0)
    }

    return r;
    21ae:	f6843783          	ld	a5,-152(s0)
    21b2:	f6f43c23          	sd	a5,-136(s0)
    21b6:	f7043783          	ld	a5,-144(s0)
    21ba:	f8f43023          	sd	a5,-128(s0)
    21be:	4701                	li	a4,0
    21c0:	f7843703          	ld	a4,-136(s0)
    21c4:	4781                	li	a5,0
    21c6:	f8043783          	ld	a5,-128(s0)
    21ca:	863a                	mv	a2,a4
    21cc:	86be                	mv	a3,a5
    21ce:	8732                	mv	a4,a2
    21d0:	87b6                	mv	a5,a3
}
    21d2:	853a                	mv	a0,a4
    21d4:	85be                	mv	a1,a5
    21d6:	646a                	ld	s0,152(sp)
    21d8:	64ca                	ld	s1,144(sp)
    21da:	610d                	addi	sp,sp,160
    21dc:	8082                	ret

00000000000021de <schedule_dm>:

/* Deadline-Monotonic Scheduling */
struct threads_sched_result schedule_dm(struct threads_sched_args args)
{
    21de:	7135                	addi	sp,sp,-160
    21e0:	ed22                	sd	s0,152(sp)
    21e2:	e926                	sd	s1,144(sp)
    21e4:	1100                	addi	s0,sp,160
    21e6:	84aa                	mv	s1,a0
    struct thread *shortest_deadline_thread = NULL;
    21e8:	fe043423          	sd	zero,-24(s0)
    struct thread *miss_deadline_thread = NULL;
    21ec:	fe043023          	sd	zero,-32(s0)
    struct thread *th = NULL;
    21f0:	fc043c23          	sd	zero,-40(s0)
    struct release_queue_entry *rqe = NULL;
    21f4:	fc043823          	sd	zero,-48(s0)
    int allocated_time = 0;
    21f8:	fc042623          	sw	zero,-52(s0)
    int smallest_release_time = 0;
    21fc:	fc042423          	sw	zero,-56(s0)

    list_for_each_entry(th, args.run_queue, thread_list)
    2200:	649c                	ld	a5,8(s1)
    2202:	639c                	ld	a5,0(a5)
    2204:	faf43823          	sd	a5,-80(s0)
    2208:	fb043783          	ld	a5,-80(s0)
    220c:	fd878793          	addi	a5,a5,-40
    2210:	fcf43c23          	sd	a5,-40(s0)
    2214:	a059                	j	229a <schedule_dm+0xbc>
    {
        if (args.current_time >= th->current_deadline &&
    2216:	4098                	lw	a4,0(s1)
    2218:	fd843783          	ld	a5,-40(s0)
    221c:	4ffc                	lw	a5,92(a5)
    221e:	02f74163          	blt	a4,a5,2240 <schedule_dm+0x62>
    2222:	fe043783          	ld	a5,-32(s0)
    2226:	cb89                	beqz	a5,2238 <schedule_dm+0x5a>
            (miss_deadline_thread == NULL || th->ID < miss_deadline_thread->ID))
    2228:	fd843783          	ld	a5,-40(s0)
    222c:	5fd8                	lw	a4,60(a5)
    222e:	fe043783          	ld	a5,-32(s0)
    2232:	5fdc                	lw	a5,60(a5)
    2234:	00f75663          	bge	a4,a5,2240 <schedule_dm+0x62>
        {
            miss_deadline_thread = th;
    2238:	fd843783          	ld	a5,-40(s0)
    223c:	fef43023          	sd	a5,-32(s0)
        }

        if (miss_deadline_thread == NULL && (shortest_deadline_thread == NULL ||
    2240:	fe043783          	ld	a5,-32(s0)
    2244:	e3a1                	bnez	a5,2284 <schedule_dm+0xa6>
    2246:	fe843783          	ld	a5,-24(s0)
    224a:	cb8d                	beqz	a5,227c <schedule_dm+0x9e>
                                             th->deadline < shortest_deadline_thread->deadline ||
    224c:	fd843783          	ld	a5,-40(s0)
    2250:	47f8                	lw	a4,76(a5)
    2252:	fe843783          	ld	a5,-24(s0)
    2256:	47fc                	lw	a5,76(a5)
        if (miss_deadline_thread == NULL && (shortest_deadline_thread == NULL ||
    2258:	02f74263          	blt	a4,a5,227c <schedule_dm+0x9e>
                                             (th->deadline == shortest_deadline_thread->deadline && th->ID < shortest_deadline_thread->ID)))
    225c:	fd843783          	ld	a5,-40(s0)
    2260:	47f8                	lw	a4,76(a5)
    2262:	fe843783          	ld	a5,-24(s0)
    2266:	47fc                	lw	a5,76(a5)
                                             th->deadline < shortest_deadline_thread->deadline ||
    2268:	00f71e63          	bne	a4,a5,2284 <schedule_dm+0xa6>
                                             (th->deadline == shortest_deadline_thread->deadline && th->ID < shortest_deadline_thread->ID)))
    226c:	fd843783          	ld	a5,-40(s0)
    2270:	5fd8                	lw	a4,60(a5)
    2272:	fe843783          	ld	a5,-24(s0)
    2276:	5fdc                	lw	a5,60(a5)
    2278:	00f75663          	bge	a4,a5,2284 <schedule_dm+0xa6>
        {
            shortest_deadline_thread = th;
    227c:	fd843783          	ld	a5,-40(s0)
    2280:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list)
    2284:	fd843783          	ld	a5,-40(s0)
    2288:	779c                	ld	a5,40(a5)
    228a:	f8f43423          	sd	a5,-120(s0)
    228e:	f8843783          	ld	a5,-120(s0)
    2292:	fd878793          	addi	a5,a5,-40
    2296:	fcf43c23          	sd	a5,-40(s0)
    229a:	fd843783          	ld	a5,-40(s0)
    229e:	02878713          	addi	a4,a5,40
    22a2:	649c                	ld	a5,8(s1)
    22a4:	f6f719e3          	bne	a4,a5,2216 <schedule_dm+0x38>
        }
    }

    if (miss_deadline_thread != NULL)
    22a8:	fe043783          	ld	a5,-32(s0)
    22ac:	cb81                	beqz	a5,22bc <schedule_dm+0xde>
    {
        shortest_deadline_thread = miss_deadline_thread;
    22ae:	fe043783          	ld	a5,-32(s0)
    22b2:	fef43423          	sd	a5,-24(s0)
        allocated_time = 0;
    22b6:	fc042623          	sw	zero,-52(s0)
    22ba:	a209                	j	23bc <schedule_dm+0x1de>
    }
    else
    {
        allocated_time = min(shortest_deadline_thread->remaining_time, shortest_deadline_thread->current_deadline - args.current_time);
    22bc:	fe843783          	ld	a5,-24(s0)
    22c0:	4ff8                	lw	a4,92(a5)
    22c2:	409c                	lw	a5,0(s1)
    22c4:	40f707bb          	subw	a5,a4,a5
    22c8:	0007871b          	sext.w	a4,a5
    22cc:	fe843783          	ld	a5,-24(s0)
    22d0:	4fbc                	lw	a5,88(a5)
    22d2:	853e                	mv	a0,a5
    22d4:	87ba                	mv	a5,a4
    22d6:	0007859b          	sext.w	a1,a5
    22da:	0005071b          	sext.w	a4,a0
    22de:	00b75363          	bge	a4,a1,22e4 <schedule_dm+0x106>
    22e2:	87aa                	mv	a5,a0
    22e4:	fcf42623          	sw	a5,-52(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list)
    22e8:	689c                	ld	a5,16(s1)
    22ea:	639c                	ld	a5,0(a5)
    22ec:	faf43423          	sd	a5,-88(s0)
    22f0:	fa843783          	ld	a5,-88(s0)
    22f4:	17e1                	addi	a5,a5,-8
    22f6:	fcf43823          	sd	a5,-48(s0)
    22fa:	a855                	j	23ae <schedule_dm+0x1d0>
        {
            if (rqe->release_time < args.current_time + allocated_time &&
    22fc:	fd043783          	ld	a5,-48(s0)
    2300:	4f8c                	lw	a1,24(a5)
    2302:	409c                	lw	a5,0(s1)
    2304:	fcc42703          	lw	a4,-52(s0)
    2308:	9fb9                	addw	a5,a5,a4
    230a:	2781                	sext.w	a5,a5
    230c:	872e                	mv	a4,a1
    230e:	08f75663          	bge	a4,a5,239a <schedule_dm+0x1bc>
                (rqe->thrd->deadline < shortest_deadline_thread->deadline ||
    2312:	fd043783          	ld	a5,-48(s0)
    2316:	639c                	ld	a5,0(a5)
    2318:	47f8                	lw	a4,76(a5)
    231a:	fe843783          	ld	a5,-24(s0)
    231e:	47fc                	lw	a5,76(a5)
            if (rqe->release_time < args.current_time + allocated_time &&
    2320:	02f74463          	blt	a4,a5,2348 <schedule_dm+0x16a>
                 (rqe->thrd->deadline == shortest_deadline_thread->deadline && rqe->thrd->ID < shortest_deadline_thread->ID)))
    2324:	fd043783          	ld	a5,-48(s0)
    2328:	639c                	ld	a5,0(a5)
    232a:	47f8                	lw	a4,76(a5)
    232c:	fe843783          	ld	a5,-24(s0)
    2330:	47fc                	lw	a5,76(a5)
                (rqe->thrd->deadline < shortest_deadline_thread->deadline ||
    2332:	06f71463          	bne	a4,a5,239a <schedule_dm+0x1bc>
                 (rqe->thrd->deadline == shortest_deadline_thread->deadline && rqe->thrd->ID < shortest_deadline_thread->ID)))
    2336:	fd043783          	ld	a5,-48(s0)
    233a:	639c                	ld	a5,0(a5)
    233c:	5fd8                	lw	a4,60(a5)
    233e:	fe843783          	ld	a5,-24(s0)
    2342:	5fdc                	lw	a5,60(a5)
    2344:	04f75b63          	bge	a4,a5,239a <schedule_dm+0x1bc>
            {
                if (smallest_release_time == 0 ||
    2348:	fc842783          	lw	a5,-56(s0)
    234c:	2781                	sext.w	a5,a5
    234e:	cb95                	beqz	a5,2382 <schedule_dm+0x1a4>
                    rqe->release_time < smallest_release_time ||
    2350:	fd043783          	ld	a5,-48(s0)
    2354:	4f98                	lw	a4,24(a5)
                if (smallest_release_time == 0 ||
    2356:	fc842783          	lw	a5,-56(s0)
    235a:	2781                	sext.w	a5,a5
    235c:	02f74363          	blt	a4,a5,2382 <schedule_dm+0x1a4>
                    (rqe->release_time == smallest_release_time && rqe->thrd->ID < shortest_deadline_thread->ID))
    2360:	fd043783          	ld	a5,-48(s0)
    2364:	4f98                	lw	a4,24(a5)
                    rqe->release_time < smallest_release_time ||
    2366:	fc842783          	lw	a5,-56(s0)
    236a:	2781                	sext.w	a5,a5
    236c:	02e79763          	bne	a5,a4,239a <schedule_dm+0x1bc>
                    (rqe->release_time == smallest_release_time && rqe->thrd->ID < shortest_deadline_thread->ID))
    2370:	fd043783          	ld	a5,-48(s0)
    2374:	639c                	ld	a5,0(a5)
    2376:	5fd8                	lw	a4,60(a5)
    2378:	fe843783          	ld	a5,-24(s0)
    237c:	5fdc                	lw	a5,60(a5)
    237e:	00f75e63          	bge	a4,a5,239a <schedule_dm+0x1bc>
                {
                    smallest_release_time = rqe->release_time;
    2382:	fd043783          	ld	a5,-48(s0)
    2386:	4f9c                	lw	a5,24(a5)
    2388:	fcf42423          	sw	a5,-56(s0)
                    allocated_time = smallest_release_time - args.current_time;
    238c:	409c                	lw	a5,0(s1)
    238e:	fc842703          	lw	a4,-56(s0)
    2392:	40f707bb          	subw	a5,a4,a5
    2396:	fcf42623          	sw	a5,-52(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list)
    239a:	fd043783          	ld	a5,-48(s0)
    239e:	679c                	ld	a5,8(a5)
    23a0:	faf43023          	sd	a5,-96(s0)
    23a4:	fa043783          	ld	a5,-96(s0)
    23a8:	17e1                	addi	a5,a5,-8
    23aa:	fcf43823          	sd	a5,-48(s0)
    23ae:	fd043783          	ld	a5,-48(s0)
    23b2:	00878713          	addi	a4,a5,8
    23b6:	689c                	ld	a5,16(s1)
    23b8:	f4f712e3          	bne	a4,a5,22fc <schedule_dm+0x11e>
        }
    }

    struct threads_sched_result r;
    // TODO: implement the deadline-monotonic scheduling algorithm
    if (shortest_deadline_thread != NULL)
    23bc:	fe843783          	ld	a5,-24(s0)
    23c0:	cf81                	beqz	a5,23d8 <schedule_dm+0x1fa>
    {
        r.scheduled_thread_list_member = &shortest_deadline_thread->thread_list;
    23c2:	fe843783          	ld	a5,-24(s0)
    23c6:	02878793          	addi	a5,a5,40
    23ca:	f6f43423          	sd	a5,-152(s0)
        r.allocated_time = allocated_time;
    23ce:	fcc42783          	lw	a5,-52(s0)
    23d2:	f6f42823          	sw	a5,-144(s0)
    23d6:	a065                	j	247e <schedule_dm+0x2a0>
    }
    else
    {
        r.scheduled_thread_list_member = args.run_queue;
    23d8:	649c                	ld	a5,8(s1)
    23da:	f6f43423          	sd	a5,-152(s0)

        // Handle sleep time
        struct release_queue_entry *next_rqe = NULL;
    23de:	fc043023          	sd	zero,-64(s0)
        struct release_queue_entry *rqe = NULL;
    23e2:	fa043c23          	sd	zero,-72(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list)
    23e6:	689c                	ld	a5,16(s1)
    23e8:	639c                	ld	a5,0(a5)
    23ea:	f8f43c23          	sd	a5,-104(s0)
    23ee:	f9843783          	ld	a5,-104(s0)
    23f2:	17e1                	addi	a5,a5,-8
    23f4:	faf43c23          	sd	a5,-72(s0)
    23f8:	a8a1                	j	2450 <schedule_dm+0x272>
        {
            if (rqe == NULL ||
    23fa:	fb843783          	ld	a5,-72(s0)
    23fe:	cb9d                	beqz	a5,2434 <schedule_dm+0x256>
                rqe->release_time < next_rqe->release_time ||
    2400:	fb843783          	ld	a5,-72(s0)
    2404:	4f98                	lw	a4,24(a5)
    2406:	fc043783          	ld	a5,-64(s0)
    240a:	4f9c                	lw	a5,24(a5)
            if (rqe == NULL ||
    240c:	02f74463          	blt	a4,a5,2434 <schedule_dm+0x256>
                (rqe->release_time == next_rqe->release_time && rqe->thrd->ID < next_rqe->thrd->ID))
    2410:	fb843783          	ld	a5,-72(s0)
    2414:	4f98                	lw	a4,24(a5)
    2416:	fc043783          	ld	a5,-64(s0)
    241a:	4f9c                	lw	a5,24(a5)
                rqe->release_time < next_rqe->release_time ||
    241c:	02f71063          	bne	a4,a5,243c <schedule_dm+0x25e>
                (rqe->release_time == next_rqe->release_time && rqe->thrd->ID < next_rqe->thrd->ID))
    2420:	fb843783          	ld	a5,-72(s0)
    2424:	639c                	ld	a5,0(a5)
    2426:	5fd8                	lw	a4,60(a5)
    2428:	fc043783          	ld	a5,-64(s0)
    242c:	639c                	ld	a5,0(a5)
    242e:	5fdc                	lw	a5,60(a5)
    2430:	00f75663          	bge	a4,a5,243c <schedule_dm+0x25e>
                next_rqe = rqe;
    2434:	fb843783          	ld	a5,-72(s0)
    2438:	fcf43023          	sd	a5,-64(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list)
    243c:	fb843783          	ld	a5,-72(s0)
    2440:	679c                	ld	a5,8(a5)
    2442:	f8f43823          	sd	a5,-112(s0)
    2446:	f9043783          	ld	a5,-112(s0)
    244a:	17e1                	addi	a5,a5,-8
    244c:	faf43c23          	sd	a5,-72(s0)
    2450:	fb843783          	ld	a5,-72(s0)
    2454:	00878713          	addi	a4,a5,8
    2458:	689c                	ld	a5,16(s1)
    245a:	faf710e3          	bne	a4,a5,23fa <schedule_dm+0x21c>
        }
        if (next_rqe != NULL)
    245e:	fc043783          	ld	a5,-64(s0)
    2462:	cb99                	beqz	a5,2478 <schedule_dm+0x29a>
            r.allocated_time = next_rqe->release_time - args.current_time;
    2464:	fc043783          	ld	a5,-64(s0)
    2468:	4f98                	lw	a4,24(a5)
    246a:	409c                	lw	a5,0(s1)
    246c:	40f707bb          	subw	a5,a4,a5
    2470:	2781                	sext.w	a5,a5
    2472:	f6f42823          	sw	a5,-144(s0)
    2476:	a021                	j	247e <schedule_dm+0x2a0>
        else
            r.allocated_time = 1;
    2478:	4785                	li	a5,1
    247a:	f6f42823          	sw	a5,-144(s0)
    }

    return r;
    247e:	f6843783          	ld	a5,-152(s0)
    2482:	f6f43c23          	sd	a5,-136(s0)
    2486:	f7043783          	ld	a5,-144(s0)
    248a:	f8f43023          	sd	a5,-128(s0)
    248e:	4701                	li	a4,0
    2490:	f7843703          	ld	a4,-136(s0)
    2494:	4781                	li	a5,0
    2496:	f8043783          	ld	a5,-128(s0)
    249a:	863a                	mv	a2,a4
    249c:	86be                	mv	a3,a5
    249e:	8732                	mv	a4,a2
    24a0:	87b6                	mv	a5,a3
}
    24a2:	853a                	mv	a0,a4
    24a4:	85be                	mv	a1,a5
    24a6:	646a                	ld	s0,152(sp)
    24a8:	64ca                	ld	s1,144(sp)
    24aa:	610d                	addi	sp,sp,160
    24ac:	8082                	ret
