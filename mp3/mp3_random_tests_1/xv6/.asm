
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
       e:	55e78793          	addi	a5,a5,1374 # 2568 <k>
      12:	439c                	lw	a5,0(a5)
      14:	2785                	addiw	a5,a5,1
      16:	0007871b          	sext.w	a4,a5
      1a:	00002797          	auipc	a5,0x2
      1e:	54e78793          	addi	a5,a5,1358 # 2568 <k>
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
          struct thread *t1 = thread_create(f, NULL, 1, 9, 54, 10);
      38:	47a9                	li	a5,10
      3a:	03600713          	li	a4,54
      3e:	46a5                	li	a3,9
      40:	4605                	li	a2,1
      42:	4581                	li	a1,0
      44:	00000517          	auipc	a0,0x0
      48:	fbc50513          	addi	a0,a0,-68 # 0 <f>
      4c:	00001097          	auipc	ra,0x1
      50:	f16080e7          	jalr	-234(ra) # f62 <thread_create>
      54:	fea43423          	sd	a0,-24(s0)
thread_set_weight(t1, 1);
      58:	4585                	li	a1,1
      5a:	fe843503          	ld	a0,-24(s0)
      5e:	00001097          	auipc	ra,0x1
      62:	00e080e7          	jalr	14(ra) # 106c <thread_set_weight>
thread_add_at(t1, 64);
      66:	04000593          	li	a1,64
      6a:	fe843503          	ld	a0,-24(s0)
      6e:	00001097          	auipc	ra,0x1
      72:	020080e7          	jalr	32(ra) # 108e <thread_add_at>
struct thread *t2 = thread_create(f, NULL, 1, 3, 5, 8);
      76:	47a1                	li	a5,8
      78:	4715                	li	a4,5
      7a:	468d                	li	a3,3
      7c:	4605                	li	a2,1
      7e:	4581                	li	a1,0
      80:	00000517          	auipc	a0,0x0
      84:	f8050513          	addi	a0,a0,-128 # 0 <f>
      88:	00001097          	auipc	ra,0x1
      8c:	eda080e7          	jalr	-294(ra) # f62 <thread_create>
      90:	fea43023          	sd	a0,-32(s0)
thread_set_weight(t2, 1);
      94:	4585                	li	a1,1
      96:	fe043503          	ld	a0,-32(s0)
      9a:	00001097          	auipc	ra,0x1
      9e:	fd2080e7          	jalr	-46(ra) # 106c <thread_set_weight>
thread_add_at(t2, 74);
      a2:	04a00593          	li	a1,74
      a6:	fe043503          	ld	a0,-32(s0)
      aa:	00001097          	auipc	ra,0x1
      ae:	fe4080e7          	jalr	-28(ra) # 108e <thread_add_at>
thread_start_threading();
      b2:	00001097          	auipc	ra,0x1
      b6:	7ea080e7          	jalr	2026(ra) # 189c <thread_start_threading>
          printf("\nexited\n");
      ba:	00002517          	auipc	a0,0x2
      be:	31650513          	addi	a0,a0,790 # 23d0 <schedule_dm+0x290>
      c2:	00001097          	auipc	ra,0x1
      c6:	9e8080e7          	jalr	-1560(ra) # aaa <printf>
          exit(0);
      ca:	4501                	li	a0,0
      cc:	00000097          	auipc	ra,0x0
      d0:	498080e7          	jalr	1176(ra) # 564 <exit>

00000000000000d4 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
      d4:	7179                	addi	sp,sp,-48
      d6:	f422                	sd	s0,40(sp)
      d8:	1800                	addi	s0,sp,48
      da:	fca43c23          	sd	a0,-40(s0)
      de:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
      e2:	fd843783          	ld	a5,-40(s0)
      e6:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
      ea:	0001                	nop
      ec:	fd043703          	ld	a4,-48(s0)
      f0:	00170793          	addi	a5,a4,1
      f4:	fcf43823          	sd	a5,-48(s0)
      f8:	fd843783          	ld	a5,-40(s0)
      fc:	00178693          	addi	a3,a5,1
     100:	fcd43c23          	sd	a3,-40(s0)
     104:	00074703          	lbu	a4,0(a4)
     108:	00e78023          	sb	a4,0(a5)
     10c:	0007c783          	lbu	a5,0(a5)
     110:	fff1                	bnez	a5,ec <strcpy+0x18>
    ;
  return os;
     112:	fe843783          	ld	a5,-24(s0)
}
     116:	853e                	mv	a0,a5
     118:	7422                	ld	s0,40(sp)
     11a:	6145                	addi	sp,sp,48
     11c:	8082                	ret

000000000000011e <strcmp>:

int
strcmp(const char *p, const char *q)
{
     11e:	1101                	addi	sp,sp,-32
     120:	ec22                	sd	s0,24(sp)
     122:	1000                	addi	s0,sp,32
     124:	fea43423          	sd	a0,-24(s0)
     128:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     12c:	a819                	j	142 <strcmp+0x24>
    p++, q++;
     12e:	fe843783          	ld	a5,-24(s0)
     132:	0785                	addi	a5,a5,1
     134:	fef43423          	sd	a5,-24(s0)
     138:	fe043783          	ld	a5,-32(s0)
     13c:	0785                	addi	a5,a5,1
     13e:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     142:	fe843783          	ld	a5,-24(s0)
     146:	0007c783          	lbu	a5,0(a5)
     14a:	cb99                	beqz	a5,160 <strcmp+0x42>
     14c:	fe843783          	ld	a5,-24(s0)
     150:	0007c703          	lbu	a4,0(a5)
     154:	fe043783          	ld	a5,-32(s0)
     158:	0007c783          	lbu	a5,0(a5)
     15c:	fcf709e3          	beq	a4,a5,12e <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     160:	fe843783          	ld	a5,-24(s0)
     164:	0007c783          	lbu	a5,0(a5)
     168:	0007871b          	sext.w	a4,a5
     16c:	fe043783          	ld	a5,-32(s0)
     170:	0007c783          	lbu	a5,0(a5)
     174:	2781                	sext.w	a5,a5
     176:	40f707bb          	subw	a5,a4,a5
     17a:	2781                	sext.w	a5,a5
}
     17c:	853e                	mv	a0,a5
     17e:	6462                	ld	s0,24(sp)
     180:	6105                	addi	sp,sp,32
     182:	8082                	ret

0000000000000184 <strlen>:

uint
strlen(const char *s)
{
     184:	7179                	addi	sp,sp,-48
     186:	f422                	sd	s0,40(sp)
     188:	1800                	addi	s0,sp,48
     18a:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     18e:	fe042623          	sw	zero,-20(s0)
     192:	a031                	j	19e <strlen+0x1a>
     194:	fec42783          	lw	a5,-20(s0)
     198:	2785                	addiw	a5,a5,1
     19a:	fef42623          	sw	a5,-20(s0)
     19e:	fec42783          	lw	a5,-20(s0)
     1a2:	fd843703          	ld	a4,-40(s0)
     1a6:	97ba                	add	a5,a5,a4
     1a8:	0007c783          	lbu	a5,0(a5)
     1ac:	f7e5                	bnez	a5,194 <strlen+0x10>
    ;
  return n;
     1ae:	fec42783          	lw	a5,-20(s0)
}
     1b2:	853e                	mv	a0,a5
     1b4:	7422                	ld	s0,40(sp)
     1b6:	6145                	addi	sp,sp,48
     1b8:	8082                	ret

00000000000001ba <memset>:

void*
memset(void *dst, int c, uint n)
{
     1ba:	7179                	addi	sp,sp,-48
     1bc:	f422                	sd	s0,40(sp)
     1be:	1800                	addi	s0,sp,48
     1c0:	fca43c23          	sd	a0,-40(s0)
     1c4:	87ae                	mv	a5,a1
     1c6:	8732                	mv	a4,a2
     1c8:	fcf42a23          	sw	a5,-44(s0)
     1cc:	87ba                	mv	a5,a4
     1ce:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     1d2:	fd843783          	ld	a5,-40(s0)
     1d6:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     1da:	fe042623          	sw	zero,-20(s0)
     1de:	a00d                	j	200 <memset+0x46>
    cdst[i] = c;
     1e0:	fec42783          	lw	a5,-20(s0)
     1e4:	fe043703          	ld	a4,-32(s0)
     1e8:	97ba                	add	a5,a5,a4
     1ea:	fd442703          	lw	a4,-44(s0)
     1ee:	0ff77713          	andi	a4,a4,255
     1f2:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     1f6:	fec42783          	lw	a5,-20(s0)
     1fa:	2785                	addiw	a5,a5,1
     1fc:	fef42623          	sw	a5,-20(s0)
     200:	fec42703          	lw	a4,-20(s0)
     204:	fd042783          	lw	a5,-48(s0)
     208:	2781                	sext.w	a5,a5
     20a:	fcf76be3          	bltu	a4,a5,1e0 <memset+0x26>
  }
  return dst;
     20e:	fd843783          	ld	a5,-40(s0)
}
     212:	853e                	mv	a0,a5
     214:	7422                	ld	s0,40(sp)
     216:	6145                	addi	sp,sp,48
     218:	8082                	ret

000000000000021a <strchr>:

char*
strchr(const char *s, char c)
{
     21a:	1101                	addi	sp,sp,-32
     21c:	ec22                	sd	s0,24(sp)
     21e:	1000                	addi	s0,sp,32
     220:	fea43423          	sd	a0,-24(s0)
     224:	87ae                	mv	a5,a1
     226:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     22a:	a01d                	j	250 <strchr+0x36>
    if(*s == c)
     22c:	fe843783          	ld	a5,-24(s0)
     230:	0007c703          	lbu	a4,0(a5)
     234:	fe744783          	lbu	a5,-25(s0)
     238:	0ff7f793          	andi	a5,a5,255
     23c:	00e79563          	bne	a5,a4,246 <strchr+0x2c>
      return (char*)s;
     240:	fe843783          	ld	a5,-24(s0)
     244:	a821                	j	25c <strchr+0x42>
  for(; *s; s++)
     246:	fe843783          	ld	a5,-24(s0)
     24a:	0785                	addi	a5,a5,1
     24c:	fef43423          	sd	a5,-24(s0)
     250:	fe843783          	ld	a5,-24(s0)
     254:	0007c783          	lbu	a5,0(a5)
     258:	fbf1                	bnez	a5,22c <strchr+0x12>
  return 0;
     25a:	4781                	li	a5,0
}
     25c:	853e                	mv	a0,a5
     25e:	6462                	ld	s0,24(sp)
     260:	6105                	addi	sp,sp,32
     262:	8082                	ret

0000000000000264 <gets>:

char*
gets(char *buf, int max)
{
     264:	7179                	addi	sp,sp,-48
     266:	f406                	sd	ra,40(sp)
     268:	f022                	sd	s0,32(sp)
     26a:	1800                	addi	s0,sp,48
     26c:	fca43c23          	sd	a0,-40(s0)
     270:	87ae                	mv	a5,a1
     272:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     276:	fe042623          	sw	zero,-20(s0)
     27a:	a8a1                	j	2d2 <gets+0x6e>
    cc = read(0, &c, 1);
     27c:	fe740793          	addi	a5,s0,-25
     280:	4605                	li	a2,1
     282:	85be                	mv	a1,a5
     284:	4501                	li	a0,0
     286:	00000097          	auipc	ra,0x0
     28a:	2f6080e7          	jalr	758(ra) # 57c <read>
     28e:	87aa                	mv	a5,a0
     290:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     294:	fe842783          	lw	a5,-24(s0)
     298:	2781                	sext.w	a5,a5
     29a:	04f05763          	blez	a5,2e8 <gets+0x84>
      break;
    buf[i++] = c;
     29e:	fec42783          	lw	a5,-20(s0)
     2a2:	0017871b          	addiw	a4,a5,1
     2a6:	fee42623          	sw	a4,-20(s0)
     2aa:	873e                	mv	a4,a5
     2ac:	fd843783          	ld	a5,-40(s0)
     2b0:	97ba                	add	a5,a5,a4
     2b2:	fe744703          	lbu	a4,-25(s0)
     2b6:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     2ba:	fe744783          	lbu	a5,-25(s0)
     2be:	873e                	mv	a4,a5
     2c0:	47a9                	li	a5,10
     2c2:	02f70463          	beq	a4,a5,2ea <gets+0x86>
     2c6:	fe744783          	lbu	a5,-25(s0)
     2ca:	873e                	mv	a4,a5
     2cc:	47b5                	li	a5,13
     2ce:	00f70e63          	beq	a4,a5,2ea <gets+0x86>
  for(i=0; i+1 < max; ){
     2d2:	fec42783          	lw	a5,-20(s0)
     2d6:	2785                	addiw	a5,a5,1
     2d8:	0007871b          	sext.w	a4,a5
     2dc:	fd442783          	lw	a5,-44(s0)
     2e0:	2781                	sext.w	a5,a5
     2e2:	f8f74de3          	blt	a4,a5,27c <gets+0x18>
     2e6:	a011                	j	2ea <gets+0x86>
      break;
     2e8:	0001                	nop
      break;
  }
  buf[i] = '\0';
     2ea:	fec42783          	lw	a5,-20(s0)
     2ee:	fd843703          	ld	a4,-40(s0)
     2f2:	97ba                	add	a5,a5,a4
     2f4:	00078023          	sb	zero,0(a5)
  return buf;
     2f8:	fd843783          	ld	a5,-40(s0)
}
     2fc:	853e                	mv	a0,a5
     2fe:	70a2                	ld	ra,40(sp)
     300:	7402                	ld	s0,32(sp)
     302:	6145                	addi	sp,sp,48
     304:	8082                	ret

0000000000000306 <stat>:

int
stat(const char *n, struct stat *st)
{
     306:	7179                	addi	sp,sp,-48
     308:	f406                	sd	ra,40(sp)
     30a:	f022                	sd	s0,32(sp)
     30c:	1800                	addi	s0,sp,48
     30e:	fca43c23          	sd	a0,-40(s0)
     312:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     316:	4581                	li	a1,0
     318:	fd843503          	ld	a0,-40(s0)
     31c:	00000097          	auipc	ra,0x0
     320:	288080e7          	jalr	648(ra) # 5a4 <open>
     324:	87aa                	mv	a5,a0
     326:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     32a:	fec42783          	lw	a5,-20(s0)
     32e:	2781                	sext.w	a5,a5
     330:	0007d463          	bgez	a5,338 <stat+0x32>
    return -1;
     334:	57fd                	li	a5,-1
     336:	a035                	j	362 <stat+0x5c>
  r = fstat(fd, st);
     338:	fec42783          	lw	a5,-20(s0)
     33c:	fd043583          	ld	a1,-48(s0)
     340:	853e                	mv	a0,a5
     342:	00000097          	auipc	ra,0x0
     346:	27a080e7          	jalr	634(ra) # 5bc <fstat>
     34a:	87aa                	mv	a5,a0
     34c:	fef42423          	sw	a5,-24(s0)
  close(fd);
     350:	fec42783          	lw	a5,-20(s0)
     354:	853e                	mv	a0,a5
     356:	00000097          	auipc	ra,0x0
     35a:	236080e7          	jalr	566(ra) # 58c <close>
  return r;
     35e:	fe842783          	lw	a5,-24(s0)
}
     362:	853e                	mv	a0,a5
     364:	70a2                	ld	ra,40(sp)
     366:	7402                	ld	s0,32(sp)
     368:	6145                	addi	sp,sp,48
     36a:	8082                	ret

000000000000036c <atoi>:

int
atoi(const char *s)
{
     36c:	7179                	addi	sp,sp,-48
     36e:	f422                	sd	s0,40(sp)
     370:	1800                	addi	s0,sp,48
     372:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     376:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     37a:	a815                	j	3ae <atoi+0x42>
    n = n*10 + *s++ - '0';
     37c:	fec42703          	lw	a4,-20(s0)
     380:	87ba                	mv	a5,a4
     382:	0027979b          	slliw	a5,a5,0x2
     386:	9fb9                	addw	a5,a5,a4
     388:	0017979b          	slliw	a5,a5,0x1
     38c:	0007871b          	sext.w	a4,a5
     390:	fd843783          	ld	a5,-40(s0)
     394:	00178693          	addi	a3,a5,1
     398:	fcd43c23          	sd	a3,-40(s0)
     39c:	0007c783          	lbu	a5,0(a5)
     3a0:	2781                	sext.w	a5,a5
     3a2:	9fb9                	addw	a5,a5,a4
     3a4:	2781                	sext.w	a5,a5
     3a6:	fd07879b          	addiw	a5,a5,-48
     3aa:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     3ae:	fd843783          	ld	a5,-40(s0)
     3b2:	0007c783          	lbu	a5,0(a5)
     3b6:	873e                	mv	a4,a5
     3b8:	02f00793          	li	a5,47
     3bc:	00e7fb63          	bgeu	a5,a4,3d2 <atoi+0x66>
     3c0:	fd843783          	ld	a5,-40(s0)
     3c4:	0007c783          	lbu	a5,0(a5)
     3c8:	873e                	mv	a4,a5
     3ca:	03900793          	li	a5,57
     3ce:	fae7f7e3          	bgeu	a5,a4,37c <atoi+0x10>
  return n;
     3d2:	fec42783          	lw	a5,-20(s0)
}
     3d6:	853e                	mv	a0,a5
     3d8:	7422                	ld	s0,40(sp)
     3da:	6145                	addi	sp,sp,48
     3dc:	8082                	ret

00000000000003de <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     3de:	7139                	addi	sp,sp,-64
     3e0:	fc22                	sd	s0,56(sp)
     3e2:	0080                	addi	s0,sp,64
     3e4:	fca43c23          	sd	a0,-40(s0)
     3e8:	fcb43823          	sd	a1,-48(s0)
     3ec:	87b2                	mv	a5,a2
     3ee:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     3f2:	fd843783          	ld	a5,-40(s0)
     3f6:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     3fa:	fd043783          	ld	a5,-48(s0)
     3fe:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     402:	fe043703          	ld	a4,-32(s0)
     406:	fe843783          	ld	a5,-24(s0)
     40a:	02e7fc63          	bgeu	a5,a4,442 <memmove+0x64>
    while(n-- > 0)
     40e:	a00d                	j	430 <memmove+0x52>
      *dst++ = *src++;
     410:	fe043703          	ld	a4,-32(s0)
     414:	00170793          	addi	a5,a4,1
     418:	fef43023          	sd	a5,-32(s0)
     41c:	fe843783          	ld	a5,-24(s0)
     420:	00178693          	addi	a3,a5,1
     424:	fed43423          	sd	a3,-24(s0)
     428:	00074703          	lbu	a4,0(a4)
     42c:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     430:	fcc42783          	lw	a5,-52(s0)
     434:	fff7871b          	addiw	a4,a5,-1
     438:	fce42623          	sw	a4,-52(s0)
     43c:	fcf04ae3          	bgtz	a5,410 <memmove+0x32>
     440:	a891                	j	494 <memmove+0xb6>
  } else {
    dst += n;
     442:	fcc42783          	lw	a5,-52(s0)
     446:	fe843703          	ld	a4,-24(s0)
     44a:	97ba                	add	a5,a5,a4
     44c:	fef43423          	sd	a5,-24(s0)
    src += n;
     450:	fcc42783          	lw	a5,-52(s0)
     454:	fe043703          	ld	a4,-32(s0)
     458:	97ba                	add	a5,a5,a4
     45a:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     45e:	a01d                	j	484 <memmove+0xa6>
      *--dst = *--src;
     460:	fe043783          	ld	a5,-32(s0)
     464:	17fd                	addi	a5,a5,-1
     466:	fef43023          	sd	a5,-32(s0)
     46a:	fe843783          	ld	a5,-24(s0)
     46e:	17fd                	addi	a5,a5,-1
     470:	fef43423          	sd	a5,-24(s0)
     474:	fe043783          	ld	a5,-32(s0)
     478:	0007c703          	lbu	a4,0(a5)
     47c:	fe843783          	ld	a5,-24(s0)
     480:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     484:	fcc42783          	lw	a5,-52(s0)
     488:	fff7871b          	addiw	a4,a5,-1
     48c:	fce42623          	sw	a4,-52(s0)
     490:	fcf048e3          	bgtz	a5,460 <memmove+0x82>
  }
  return vdst;
     494:	fd843783          	ld	a5,-40(s0)
}
     498:	853e                	mv	a0,a5
     49a:	7462                	ld	s0,56(sp)
     49c:	6121                	addi	sp,sp,64
     49e:	8082                	ret

00000000000004a0 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     4a0:	7139                	addi	sp,sp,-64
     4a2:	fc22                	sd	s0,56(sp)
     4a4:	0080                	addi	s0,sp,64
     4a6:	fca43c23          	sd	a0,-40(s0)
     4aa:	fcb43823          	sd	a1,-48(s0)
     4ae:	87b2                	mv	a5,a2
     4b0:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     4b4:	fd843783          	ld	a5,-40(s0)
     4b8:	fef43423          	sd	a5,-24(s0)
     4bc:	fd043783          	ld	a5,-48(s0)
     4c0:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     4c4:	a0a1                	j	50c <memcmp+0x6c>
    if (*p1 != *p2) {
     4c6:	fe843783          	ld	a5,-24(s0)
     4ca:	0007c703          	lbu	a4,0(a5)
     4ce:	fe043783          	ld	a5,-32(s0)
     4d2:	0007c783          	lbu	a5,0(a5)
     4d6:	02f70163          	beq	a4,a5,4f8 <memcmp+0x58>
      return *p1 - *p2;
     4da:	fe843783          	ld	a5,-24(s0)
     4de:	0007c783          	lbu	a5,0(a5)
     4e2:	0007871b          	sext.w	a4,a5
     4e6:	fe043783          	ld	a5,-32(s0)
     4ea:	0007c783          	lbu	a5,0(a5)
     4ee:	2781                	sext.w	a5,a5
     4f0:	40f707bb          	subw	a5,a4,a5
     4f4:	2781                	sext.w	a5,a5
     4f6:	a01d                	j	51c <memcmp+0x7c>
    }
    p1++;
     4f8:	fe843783          	ld	a5,-24(s0)
     4fc:	0785                	addi	a5,a5,1
     4fe:	fef43423          	sd	a5,-24(s0)
    p2++;
     502:	fe043783          	ld	a5,-32(s0)
     506:	0785                	addi	a5,a5,1
     508:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     50c:	fcc42783          	lw	a5,-52(s0)
     510:	fff7871b          	addiw	a4,a5,-1
     514:	fce42623          	sw	a4,-52(s0)
     518:	f7dd                	bnez	a5,4c6 <memcmp+0x26>
  }
  return 0;
     51a:	4781                	li	a5,0
}
     51c:	853e                	mv	a0,a5
     51e:	7462                	ld	s0,56(sp)
     520:	6121                	addi	sp,sp,64
     522:	8082                	ret

0000000000000524 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     524:	7179                	addi	sp,sp,-48
     526:	f406                	sd	ra,40(sp)
     528:	f022                	sd	s0,32(sp)
     52a:	1800                	addi	s0,sp,48
     52c:	fea43423          	sd	a0,-24(s0)
     530:	feb43023          	sd	a1,-32(s0)
     534:	87b2                	mv	a5,a2
     536:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     53a:	fdc42783          	lw	a5,-36(s0)
     53e:	863e                	mv	a2,a5
     540:	fe043583          	ld	a1,-32(s0)
     544:	fe843503          	ld	a0,-24(s0)
     548:	00000097          	auipc	ra,0x0
     54c:	e96080e7          	jalr	-362(ra) # 3de <memmove>
     550:	87aa                	mv	a5,a0
}
     552:	853e                	mv	a0,a5
     554:	70a2                	ld	ra,40(sp)
     556:	7402                	ld	s0,32(sp)
     558:	6145                	addi	sp,sp,48
     55a:	8082                	ret

000000000000055c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     55c:	4885                	li	a7,1
 ecall
     55e:	00000073          	ecall
 ret
     562:	8082                	ret

0000000000000564 <exit>:
.global exit
exit:
 li a7, SYS_exit
     564:	4889                	li	a7,2
 ecall
     566:	00000073          	ecall
 ret
     56a:	8082                	ret

000000000000056c <wait>:
.global wait
wait:
 li a7, SYS_wait
     56c:	488d                	li	a7,3
 ecall
     56e:	00000073          	ecall
 ret
     572:	8082                	ret

0000000000000574 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     574:	4891                	li	a7,4
 ecall
     576:	00000073          	ecall
 ret
     57a:	8082                	ret

000000000000057c <read>:
.global read
read:
 li a7, SYS_read
     57c:	4895                	li	a7,5
 ecall
     57e:	00000073          	ecall
 ret
     582:	8082                	ret

0000000000000584 <write>:
.global write
write:
 li a7, SYS_write
     584:	48c1                	li	a7,16
 ecall
     586:	00000073          	ecall
 ret
     58a:	8082                	ret

000000000000058c <close>:
.global close
close:
 li a7, SYS_close
     58c:	48d5                	li	a7,21
 ecall
     58e:	00000073          	ecall
 ret
     592:	8082                	ret

0000000000000594 <kill>:
.global kill
kill:
 li a7, SYS_kill
     594:	4899                	li	a7,6
 ecall
     596:	00000073          	ecall
 ret
     59a:	8082                	ret

000000000000059c <exec>:
.global exec
exec:
 li a7, SYS_exec
     59c:	489d                	li	a7,7
 ecall
     59e:	00000073          	ecall
 ret
     5a2:	8082                	ret

00000000000005a4 <open>:
.global open
open:
 li a7, SYS_open
     5a4:	48bd                	li	a7,15
 ecall
     5a6:	00000073          	ecall
 ret
     5aa:	8082                	ret

00000000000005ac <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     5ac:	48c5                	li	a7,17
 ecall
     5ae:	00000073          	ecall
 ret
     5b2:	8082                	ret

00000000000005b4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     5b4:	48c9                	li	a7,18
 ecall
     5b6:	00000073          	ecall
 ret
     5ba:	8082                	ret

00000000000005bc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     5bc:	48a1                	li	a7,8
 ecall
     5be:	00000073          	ecall
 ret
     5c2:	8082                	ret

00000000000005c4 <link>:
.global link
link:
 li a7, SYS_link
     5c4:	48cd                	li	a7,19
 ecall
     5c6:	00000073          	ecall
 ret
     5ca:	8082                	ret

00000000000005cc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     5cc:	48d1                	li	a7,20
 ecall
     5ce:	00000073          	ecall
 ret
     5d2:	8082                	ret

00000000000005d4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     5d4:	48a5                	li	a7,9
 ecall
     5d6:	00000073          	ecall
 ret
     5da:	8082                	ret

00000000000005dc <dup>:
.global dup
dup:
 li a7, SYS_dup
     5dc:	48a9                	li	a7,10
 ecall
     5de:	00000073          	ecall
 ret
     5e2:	8082                	ret

00000000000005e4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     5e4:	48ad                	li	a7,11
 ecall
     5e6:	00000073          	ecall
 ret
     5ea:	8082                	ret

00000000000005ec <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     5ec:	48b1                	li	a7,12
 ecall
     5ee:	00000073          	ecall
 ret
     5f2:	8082                	ret

00000000000005f4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     5f4:	48b5                	li	a7,13
 ecall
     5f6:	00000073          	ecall
 ret
     5fa:	8082                	ret

00000000000005fc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     5fc:	48b9                	li	a7,14
 ecall
     5fe:	00000073          	ecall
 ret
     602:	8082                	ret

0000000000000604 <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     604:	48d9                	li	a7,22
 ecall
     606:	00000073          	ecall
 ret
     60a:	8082                	ret

000000000000060c <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     60c:	48dd                	li	a7,23
 ecall
     60e:	00000073          	ecall
 ret
     612:	8082                	ret

0000000000000614 <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     614:	48e1                	li	a7,24
 ecall
     616:	00000073          	ecall
 ret
     61a:	8082                	ret

000000000000061c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     61c:	1101                	addi	sp,sp,-32
     61e:	ec06                	sd	ra,24(sp)
     620:	e822                	sd	s0,16(sp)
     622:	1000                	addi	s0,sp,32
     624:	87aa                	mv	a5,a0
     626:	872e                	mv	a4,a1
     628:	fef42623          	sw	a5,-20(s0)
     62c:	87ba                	mv	a5,a4
     62e:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     632:	feb40713          	addi	a4,s0,-21
     636:	fec42783          	lw	a5,-20(s0)
     63a:	4605                	li	a2,1
     63c:	85ba                	mv	a1,a4
     63e:	853e                	mv	a0,a5
     640:	00000097          	auipc	ra,0x0
     644:	f44080e7          	jalr	-188(ra) # 584 <write>
}
     648:	0001                	nop
     64a:	60e2                	ld	ra,24(sp)
     64c:	6442                	ld	s0,16(sp)
     64e:	6105                	addi	sp,sp,32
     650:	8082                	ret

0000000000000652 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     652:	7139                	addi	sp,sp,-64
     654:	fc06                	sd	ra,56(sp)
     656:	f822                	sd	s0,48(sp)
     658:	0080                	addi	s0,sp,64
     65a:	87aa                	mv	a5,a0
     65c:	8736                	mv	a4,a3
     65e:	fcf42623          	sw	a5,-52(s0)
     662:	87ae                	mv	a5,a1
     664:	fcf42423          	sw	a5,-56(s0)
     668:	87b2                	mv	a5,a2
     66a:	fcf42223          	sw	a5,-60(s0)
     66e:	87ba                	mv	a5,a4
     670:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     674:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     678:	fc042783          	lw	a5,-64(s0)
     67c:	2781                	sext.w	a5,a5
     67e:	c38d                	beqz	a5,6a0 <printint+0x4e>
     680:	fc842783          	lw	a5,-56(s0)
     684:	2781                	sext.w	a5,a5
     686:	0007dd63          	bgez	a5,6a0 <printint+0x4e>
    neg = 1;
     68a:	4785                	li	a5,1
     68c:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     690:	fc842783          	lw	a5,-56(s0)
     694:	40f007bb          	negw	a5,a5
     698:	2781                	sext.w	a5,a5
     69a:	fef42223          	sw	a5,-28(s0)
     69e:	a029                	j	6a8 <printint+0x56>
  } else {
    x = xx;
     6a0:	fc842783          	lw	a5,-56(s0)
     6a4:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     6a8:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     6ac:	fc442783          	lw	a5,-60(s0)
     6b0:	fe442703          	lw	a4,-28(s0)
     6b4:	02f777bb          	remuw	a5,a4,a5
     6b8:	0007861b          	sext.w	a2,a5
     6bc:	fec42783          	lw	a5,-20(s0)
     6c0:	0017871b          	addiw	a4,a5,1
     6c4:	fee42623          	sw	a4,-20(s0)
     6c8:	00002697          	auipc	a3,0x2
     6cc:	e6068693          	addi	a3,a3,-416 # 2528 <digits>
     6d0:	02061713          	slli	a4,a2,0x20
     6d4:	9301                	srli	a4,a4,0x20
     6d6:	9736                	add	a4,a4,a3
     6d8:	00074703          	lbu	a4,0(a4)
     6dc:	ff040693          	addi	a3,s0,-16
     6e0:	97b6                	add	a5,a5,a3
     6e2:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     6e6:	fc442783          	lw	a5,-60(s0)
     6ea:	fe442703          	lw	a4,-28(s0)
     6ee:	02f757bb          	divuw	a5,a4,a5
     6f2:	fef42223          	sw	a5,-28(s0)
     6f6:	fe442783          	lw	a5,-28(s0)
     6fa:	2781                	sext.w	a5,a5
     6fc:	fbc5                	bnez	a5,6ac <printint+0x5a>
  if(neg)
     6fe:	fe842783          	lw	a5,-24(s0)
     702:	2781                	sext.w	a5,a5
     704:	cf95                	beqz	a5,740 <printint+0xee>
    buf[i++] = '-';
     706:	fec42783          	lw	a5,-20(s0)
     70a:	0017871b          	addiw	a4,a5,1
     70e:	fee42623          	sw	a4,-20(s0)
     712:	ff040713          	addi	a4,s0,-16
     716:	97ba                	add	a5,a5,a4
     718:	02d00713          	li	a4,45
     71c:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     720:	a005                	j	740 <printint+0xee>
    putc(fd, buf[i]);
     722:	fec42783          	lw	a5,-20(s0)
     726:	ff040713          	addi	a4,s0,-16
     72a:	97ba                	add	a5,a5,a4
     72c:	fe07c703          	lbu	a4,-32(a5)
     730:	fcc42783          	lw	a5,-52(s0)
     734:	85ba                	mv	a1,a4
     736:	853e                	mv	a0,a5
     738:	00000097          	auipc	ra,0x0
     73c:	ee4080e7          	jalr	-284(ra) # 61c <putc>
  while(--i >= 0)
     740:	fec42783          	lw	a5,-20(s0)
     744:	37fd                	addiw	a5,a5,-1
     746:	fef42623          	sw	a5,-20(s0)
     74a:	fec42783          	lw	a5,-20(s0)
     74e:	2781                	sext.w	a5,a5
     750:	fc07d9e3          	bgez	a5,722 <printint+0xd0>
}
     754:	0001                	nop
     756:	0001                	nop
     758:	70e2                	ld	ra,56(sp)
     75a:	7442                	ld	s0,48(sp)
     75c:	6121                	addi	sp,sp,64
     75e:	8082                	ret

0000000000000760 <printptr>:

static void
printptr(int fd, uint64 x) {
     760:	7179                	addi	sp,sp,-48
     762:	f406                	sd	ra,40(sp)
     764:	f022                	sd	s0,32(sp)
     766:	1800                	addi	s0,sp,48
     768:	87aa                	mv	a5,a0
     76a:	fcb43823          	sd	a1,-48(s0)
     76e:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     772:	fdc42783          	lw	a5,-36(s0)
     776:	03000593          	li	a1,48
     77a:	853e                	mv	a0,a5
     77c:	00000097          	auipc	ra,0x0
     780:	ea0080e7          	jalr	-352(ra) # 61c <putc>
  putc(fd, 'x');
     784:	fdc42783          	lw	a5,-36(s0)
     788:	07800593          	li	a1,120
     78c:	853e                	mv	a0,a5
     78e:	00000097          	auipc	ra,0x0
     792:	e8e080e7          	jalr	-370(ra) # 61c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     796:	fe042623          	sw	zero,-20(s0)
     79a:	a82d                	j	7d4 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     79c:	fd043783          	ld	a5,-48(s0)
     7a0:	93f1                	srli	a5,a5,0x3c
     7a2:	00002717          	auipc	a4,0x2
     7a6:	d8670713          	addi	a4,a4,-634 # 2528 <digits>
     7aa:	97ba                	add	a5,a5,a4
     7ac:	0007c703          	lbu	a4,0(a5)
     7b0:	fdc42783          	lw	a5,-36(s0)
     7b4:	85ba                	mv	a1,a4
     7b6:	853e                	mv	a0,a5
     7b8:	00000097          	auipc	ra,0x0
     7bc:	e64080e7          	jalr	-412(ra) # 61c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     7c0:	fec42783          	lw	a5,-20(s0)
     7c4:	2785                	addiw	a5,a5,1
     7c6:	fef42623          	sw	a5,-20(s0)
     7ca:	fd043783          	ld	a5,-48(s0)
     7ce:	0792                	slli	a5,a5,0x4
     7d0:	fcf43823          	sd	a5,-48(s0)
     7d4:	fec42783          	lw	a5,-20(s0)
     7d8:	873e                	mv	a4,a5
     7da:	47bd                	li	a5,15
     7dc:	fce7f0e3          	bgeu	a5,a4,79c <printptr+0x3c>
}
     7e0:	0001                	nop
     7e2:	0001                	nop
     7e4:	70a2                	ld	ra,40(sp)
     7e6:	7402                	ld	s0,32(sp)
     7e8:	6145                	addi	sp,sp,48
     7ea:	8082                	ret

00000000000007ec <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     7ec:	715d                	addi	sp,sp,-80
     7ee:	e486                	sd	ra,72(sp)
     7f0:	e0a2                	sd	s0,64(sp)
     7f2:	0880                	addi	s0,sp,80
     7f4:	87aa                	mv	a5,a0
     7f6:	fcb43023          	sd	a1,-64(s0)
     7fa:	fac43c23          	sd	a2,-72(s0)
     7fe:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     802:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     806:	fe042223          	sw	zero,-28(s0)
     80a:	a42d                	j	a34 <vprintf+0x248>
    c = fmt[i] & 0xff;
     80c:	fe442783          	lw	a5,-28(s0)
     810:	fc043703          	ld	a4,-64(s0)
     814:	97ba                	add	a5,a5,a4
     816:	0007c783          	lbu	a5,0(a5)
     81a:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     81e:	fe042783          	lw	a5,-32(s0)
     822:	2781                	sext.w	a5,a5
     824:	eb9d                	bnez	a5,85a <vprintf+0x6e>
      if(c == '%'){
     826:	fdc42783          	lw	a5,-36(s0)
     82a:	0007871b          	sext.w	a4,a5
     82e:	02500793          	li	a5,37
     832:	00f71763          	bne	a4,a5,840 <vprintf+0x54>
        state = '%';
     836:	02500793          	li	a5,37
     83a:	fef42023          	sw	a5,-32(s0)
     83e:	a2f5                	j	a2a <vprintf+0x23e>
      } else {
        putc(fd, c);
     840:	fdc42783          	lw	a5,-36(s0)
     844:	0ff7f713          	andi	a4,a5,255
     848:	fcc42783          	lw	a5,-52(s0)
     84c:	85ba                	mv	a1,a4
     84e:	853e                	mv	a0,a5
     850:	00000097          	auipc	ra,0x0
     854:	dcc080e7          	jalr	-564(ra) # 61c <putc>
     858:	aac9                	j	a2a <vprintf+0x23e>
      }
    } else if(state == '%'){
     85a:	fe042783          	lw	a5,-32(s0)
     85e:	0007871b          	sext.w	a4,a5
     862:	02500793          	li	a5,37
     866:	1cf71263          	bne	a4,a5,a2a <vprintf+0x23e>
      if(c == 'd'){
     86a:	fdc42783          	lw	a5,-36(s0)
     86e:	0007871b          	sext.w	a4,a5
     872:	06400793          	li	a5,100
     876:	02f71463          	bne	a4,a5,89e <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     87a:	fb843783          	ld	a5,-72(s0)
     87e:	00878713          	addi	a4,a5,8
     882:	fae43c23          	sd	a4,-72(s0)
     886:	4398                	lw	a4,0(a5)
     888:	fcc42783          	lw	a5,-52(s0)
     88c:	4685                	li	a3,1
     88e:	4629                	li	a2,10
     890:	85ba                	mv	a1,a4
     892:	853e                	mv	a0,a5
     894:	00000097          	auipc	ra,0x0
     898:	dbe080e7          	jalr	-578(ra) # 652 <printint>
     89c:	a269                	j	a26 <vprintf+0x23a>
      } else if(c == 'l') {
     89e:	fdc42783          	lw	a5,-36(s0)
     8a2:	0007871b          	sext.w	a4,a5
     8a6:	06c00793          	li	a5,108
     8aa:	02f71663          	bne	a4,a5,8d6 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     8ae:	fb843783          	ld	a5,-72(s0)
     8b2:	00878713          	addi	a4,a5,8
     8b6:	fae43c23          	sd	a4,-72(s0)
     8ba:	639c                	ld	a5,0(a5)
     8bc:	0007871b          	sext.w	a4,a5
     8c0:	fcc42783          	lw	a5,-52(s0)
     8c4:	4681                	li	a3,0
     8c6:	4629                	li	a2,10
     8c8:	85ba                	mv	a1,a4
     8ca:	853e                	mv	a0,a5
     8cc:	00000097          	auipc	ra,0x0
     8d0:	d86080e7          	jalr	-634(ra) # 652 <printint>
     8d4:	aa89                	j	a26 <vprintf+0x23a>
      } else if(c == 'x') {
     8d6:	fdc42783          	lw	a5,-36(s0)
     8da:	0007871b          	sext.w	a4,a5
     8de:	07800793          	li	a5,120
     8e2:	02f71463          	bne	a4,a5,90a <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     8e6:	fb843783          	ld	a5,-72(s0)
     8ea:	00878713          	addi	a4,a5,8
     8ee:	fae43c23          	sd	a4,-72(s0)
     8f2:	4398                	lw	a4,0(a5)
     8f4:	fcc42783          	lw	a5,-52(s0)
     8f8:	4681                	li	a3,0
     8fa:	4641                	li	a2,16
     8fc:	85ba                	mv	a1,a4
     8fe:	853e                	mv	a0,a5
     900:	00000097          	auipc	ra,0x0
     904:	d52080e7          	jalr	-686(ra) # 652 <printint>
     908:	aa39                	j	a26 <vprintf+0x23a>
      } else if(c == 'p') {
     90a:	fdc42783          	lw	a5,-36(s0)
     90e:	0007871b          	sext.w	a4,a5
     912:	07000793          	li	a5,112
     916:	02f71263          	bne	a4,a5,93a <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     91a:	fb843783          	ld	a5,-72(s0)
     91e:	00878713          	addi	a4,a5,8
     922:	fae43c23          	sd	a4,-72(s0)
     926:	6398                	ld	a4,0(a5)
     928:	fcc42783          	lw	a5,-52(s0)
     92c:	85ba                	mv	a1,a4
     92e:	853e                	mv	a0,a5
     930:	00000097          	auipc	ra,0x0
     934:	e30080e7          	jalr	-464(ra) # 760 <printptr>
     938:	a0fd                	j	a26 <vprintf+0x23a>
      } else if(c == 's'){
     93a:	fdc42783          	lw	a5,-36(s0)
     93e:	0007871b          	sext.w	a4,a5
     942:	07300793          	li	a5,115
     946:	04f71c63          	bne	a4,a5,99e <vprintf+0x1b2>
        s = va_arg(ap, char*);
     94a:	fb843783          	ld	a5,-72(s0)
     94e:	00878713          	addi	a4,a5,8
     952:	fae43c23          	sd	a4,-72(s0)
     956:	639c                	ld	a5,0(a5)
     958:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     95c:	fe843783          	ld	a5,-24(s0)
     960:	eb8d                	bnez	a5,992 <vprintf+0x1a6>
          s = "(null)";
     962:	00002797          	auipc	a5,0x2
     966:	a7e78793          	addi	a5,a5,-1410 # 23e0 <schedule_dm+0x2a0>
     96a:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     96e:	a015                	j	992 <vprintf+0x1a6>
          putc(fd, *s);
     970:	fe843783          	ld	a5,-24(s0)
     974:	0007c703          	lbu	a4,0(a5)
     978:	fcc42783          	lw	a5,-52(s0)
     97c:	85ba                	mv	a1,a4
     97e:	853e                	mv	a0,a5
     980:	00000097          	auipc	ra,0x0
     984:	c9c080e7          	jalr	-868(ra) # 61c <putc>
          s++;
     988:	fe843783          	ld	a5,-24(s0)
     98c:	0785                	addi	a5,a5,1
     98e:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     992:	fe843783          	ld	a5,-24(s0)
     996:	0007c783          	lbu	a5,0(a5)
     99a:	fbf9                	bnez	a5,970 <vprintf+0x184>
     99c:	a069                	j	a26 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     99e:	fdc42783          	lw	a5,-36(s0)
     9a2:	0007871b          	sext.w	a4,a5
     9a6:	06300793          	li	a5,99
     9aa:	02f71463          	bne	a4,a5,9d2 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     9ae:	fb843783          	ld	a5,-72(s0)
     9b2:	00878713          	addi	a4,a5,8
     9b6:	fae43c23          	sd	a4,-72(s0)
     9ba:	439c                	lw	a5,0(a5)
     9bc:	0ff7f713          	andi	a4,a5,255
     9c0:	fcc42783          	lw	a5,-52(s0)
     9c4:	85ba                	mv	a1,a4
     9c6:	853e                	mv	a0,a5
     9c8:	00000097          	auipc	ra,0x0
     9cc:	c54080e7          	jalr	-940(ra) # 61c <putc>
     9d0:	a899                	j	a26 <vprintf+0x23a>
      } else if(c == '%'){
     9d2:	fdc42783          	lw	a5,-36(s0)
     9d6:	0007871b          	sext.w	a4,a5
     9da:	02500793          	li	a5,37
     9de:	00f71f63          	bne	a4,a5,9fc <vprintf+0x210>
        putc(fd, c);
     9e2:	fdc42783          	lw	a5,-36(s0)
     9e6:	0ff7f713          	andi	a4,a5,255
     9ea:	fcc42783          	lw	a5,-52(s0)
     9ee:	85ba                	mv	a1,a4
     9f0:	853e                	mv	a0,a5
     9f2:	00000097          	auipc	ra,0x0
     9f6:	c2a080e7          	jalr	-982(ra) # 61c <putc>
     9fa:	a035                	j	a26 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     9fc:	fcc42783          	lw	a5,-52(s0)
     a00:	02500593          	li	a1,37
     a04:	853e                	mv	a0,a5
     a06:	00000097          	auipc	ra,0x0
     a0a:	c16080e7          	jalr	-1002(ra) # 61c <putc>
        putc(fd, c);
     a0e:	fdc42783          	lw	a5,-36(s0)
     a12:	0ff7f713          	andi	a4,a5,255
     a16:	fcc42783          	lw	a5,-52(s0)
     a1a:	85ba                	mv	a1,a4
     a1c:	853e                	mv	a0,a5
     a1e:	00000097          	auipc	ra,0x0
     a22:	bfe080e7          	jalr	-1026(ra) # 61c <putc>
      }
      state = 0;
     a26:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     a2a:	fe442783          	lw	a5,-28(s0)
     a2e:	2785                	addiw	a5,a5,1
     a30:	fef42223          	sw	a5,-28(s0)
     a34:	fe442783          	lw	a5,-28(s0)
     a38:	fc043703          	ld	a4,-64(s0)
     a3c:	97ba                	add	a5,a5,a4
     a3e:	0007c783          	lbu	a5,0(a5)
     a42:	dc0795e3          	bnez	a5,80c <vprintf+0x20>
    }
  }
}
     a46:	0001                	nop
     a48:	0001                	nop
     a4a:	60a6                	ld	ra,72(sp)
     a4c:	6406                	ld	s0,64(sp)
     a4e:	6161                	addi	sp,sp,80
     a50:	8082                	ret

0000000000000a52 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     a52:	7159                	addi	sp,sp,-112
     a54:	fc06                	sd	ra,56(sp)
     a56:	f822                	sd	s0,48(sp)
     a58:	0080                	addi	s0,sp,64
     a5a:	fcb43823          	sd	a1,-48(s0)
     a5e:	e010                	sd	a2,0(s0)
     a60:	e414                	sd	a3,8(s0)
     a62:	e818                	sd	a4,16(s0)
     a64:	ec1c                	sd	a5,24(s0)
     a66:	03043023          	sd	a6,32(s0)
     a6a:	03143423          	sd	a7,40(s0)
     a6e:	87aa                	mv	a5,a0
     a70:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     a74:	03040793          	addi	a5,s0,48
     a78:	fcf43423          	sd	a5,-56(s0)
     a7c:	fc843783          	ld	a5,-56(s0)
     a80:	fd078793          	addi	a5,a5,-48
     a84:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     a88:	fe843703          	ld	a4,-24(s0)
     a8c:	fdc42783          	lw	a5,-36(s0)
     a90:	863a                	mv	a2,a4
     a92:	fd043583          	ld	a1,-48(s0)
     a96:	853e                	mv	a0,a5
     a98:	00000097          	auipc	ra,0x0
     a9c:	d54080e7          	jalr	-684(ra) # 7ec <vprintf>
}
     aa0:	0001                	nop
     aa2:	70e2                	ld	ra,56(sp)
     aa4:	7442                	ld	s0,48(sp)
     aa6:	6165                	addi	sp,sp,112
     aa8:	8082                	ret

0000000000000aaa <printf>:

void
printf(const char *fmt, ...)
{
     aaa:	7159                	addi	sp,sp,-112
     aac:	f406                	sd	ra,40(sp)
     aae:	f022                	sd	s0,32(sp)
     ab0:	1800                	addi	s0,sp,48
     ab2:	fca43c23          	sd	a0,-40(s0)
     ab6:	e40c                	sd	a1,8(s0)
     ab8:	e810                	sd	a2,16(s0)
     aba:	ec14                	sd	a3,24(s0)
     abc:	f018                	sd	a4,32(s0)
     abe:	f41c                	sd	a5,40(s0)
     ac0:	03043823          	sd	a6,48(s0)
     ac4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     ac8:	04040793          	addi	a5,s0,64
     acc:	fcf43823          	sd	a5,-48(s0)
     ad0:	fd043783          	ld	a5,-48(s0)
     ad4:	fc878793          	addi	a5,a5,-56
     ad8:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     adc:	fe843783          	ld	a5,-24(s0)
     ae0:	863e                	mv	a2,a5
     ae2:	fd843583          	ld	a1,-40(s0)
     ae6:	4505                	li	a0,1
     ae8:	00000097          	auipc	ra,0x0
     aec:	d04080e7          	jalr	-764(ra) # 7ec <vprintf>
}
     af0:	0001                	nop
     af2:	70a2                	ld	ra,40(sp)
     af4:	7402                	ld	s0,32(sp)
     af6:	6165                	addi	sp,sp,112
     af8:	8082                	ret

0000000000000afa <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     afa:	7179                	addi	sp,sp,-48
     afc:	f422                	sd	s0,40(sp)
     afe:	1800                	addi	s0,sp,48
     b00:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     b04:	fd843783          	ld	a5,-40(s0)
     b08:	17c1                	addi	a5,a5,-16
     b0a:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     b0e:	00002797          	auipc	a5,0x2
     b12:	a7278793          	addi	a5,a5,-1422 # 2580 <freep>
     b16:	639c                	ld	a5,0(a5)
     b18:	fef43423          	sd	a5,-24(s0)
     b1c:	a815                	j	b50 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     b1e:	fe843783          	ld	a5,-24(s0)
     b22:	639c                	ld	a5,0(a5)
     b24:	fe843703          	ld	a4,-24(s0)
     b28:	00f76f63          	bltu	a4,a5,b46 <free+0x4c>
     b2c:	fe043703          	ld	a4,-32(s0)
     b30:	fe843783          	ld	a5,-24(s0)
     b34:	02e7eb63          	bltu	a5,a4,b6a <free+0x70>
     b38:	fe843783          	ld	a5,-24(s0)
     b3c:	639c                	ld	a5,0(a5)
     b3e:	fe043703          	ld	a4,-32(s0)
     b42:	02f76463          	bltu	a4,a5,b6a <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     b46:	fe843783          	ld	a5,-24(s0)
     b4a:	639c                	ld	a5,0(a5)
     b4c:	fef43423          	sd	a5,-24(s0)
     b50:	fe043703          	ld	a4,-32(s0)
     b54:	fe843783          	ld	a5,-24(s0)
     b58:	fce7f3e3          	bgeu	a5,a4,b1e <free+0x24>
     b5c:	fe843783          	ld	a5,-24(s0)
     b60:	639c                	ld	a5,0(a5)
     b62:	fe043703          	ld	a4,-32(s0)
     b66:	faf77ce3          	bgeu	a4,a5,b1e <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     b6a:	fe043783          	ld	a5,-32(s0)
     b6e:	479c                	lw	a5,8(a5)
     b70:	1782                	slli	a5,a5,0x20
     b72:	9381                	srli	a5,a5,0x20
     b74:	0792                	slli	a5,a5,0x4
     b76:	fe043703          	ld	a4,-32(s0)
     b7a:	973e                	add	a4,a4,a5
     b7c:	fe843783          	ld	a5,-24(s0)
     b80:	639c                	ld	a5,0(a5)
     b82:	02f71763          	bne	a4,a5,bb0 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     b86:	fe043783          	ld	a5,-32(s0)
     b8a:	4798                	lw	a4,8(a5)
     b8c:	fe843783          	ld	a5,-24(s0)
     b90:	639c                	ld	a5,0(a5)
     b92:	479c                	lw	a5,8(a5)
     b94:	9fb9                	addw	a5,a5,a4
     b96:	0007871b          	sext.w	a4,a5
     b9a:	fe043783          	ld	a5,-32(s0)
     b9e:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     ba0:	fe843783          	ld	a5,-24(s0)
     ba4:	639c                	ld	a5,0(a5)
     ba6:	6398                	ld	a4,0(a5)
     ba8:	fe043783          	ld	a5,-32(s0)
     bac:	e398                	sd	a4,0(a5)
     bae:	a039                	j	bbc <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     bb0:	fe843783          	ld	a5,-24(s0)
     bb4:	6398                	ld	a4,0(a5)
     bb6:	fe043783          	ld	a5,-32(s0)
     bba:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     bbc:	fe843783          	ld	a5,-24(s0)
     bc0:	479c                	lw	a5,8(a5)
     bc2:	1782                	slli	a5,a5,0x20
     bc4:	9381                	srli	a5,a5,0x20
     bc6:	0792                	slli	a5,a5,0x4
     bc8:	fe843703          	ld	a4,-24(s0)
     bcc:	97ba                	add	a5,a5,a4
     bce:	fe043703          	ld	a4,-32(s0)
     bd2:	02f71563          	bne	a4,a5,bfc <free+0x102>
    p->s.size += bp->s.size;
     bd6:	fe843783          	ld	a5,-24(s0)
     bda:	4798                	lw	a4,8(a5)
     bdc:	fe043783          	ld	a5,-32(s0)
     be0:	479c                	lw	a5,8(a5)
     be2:	9fb9                	addw	a5,a5,a4
     be4:	0007871b          	sext.w	a4,a5
     be8:	fe843783          	ld	a5,-24(s0)
     bec:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     bee:	fe043783          	ld	a5,-32(s0)
     bf2:	6398                	ld	a4,0(a5)
     bf4:	fe843783          	ld	a5,-24(s0)
     bf8:	e398                	sd	a4,0(a5)
     bfa:	a031                	j	c06 <free+0x10c>
  } else
    p->s.ptr = bp;
     bfc:	fe843783          	ld	a5,-24(s0)
     c00:	fe043703          	ld	a4,-32(s0)
     c04:	e398                	sd	a4,0(a5)
  freep = p;
     c06:	00002797          	auipc	a5,0x2
     c0a:	97a78793          	addi	a5,a5,-1670 # 2580 <freep>
     c0e:	fe843703          	ld	a4,-24(s0)
     c12:	e398                	sd	a4,0(a5)
}
     c14:	0001                	nop
     c16:	7422                	ld	s0,40(sp)
     c18:	6145                	addi	sp,sp,48
     c1a:	8082                	ret

0000000000000c1c <morecore>:

static Header*
morecore(uint nu)
{
     c1c:	7179                	addi	sp,sp,-48
     c1e:	f406                	sd	ra,40(sp)
     c20:	f022                	sd	s0,32(sp)
     c22:	1800                	addi	s0,sp,48
     c24:	87aa                	mv	a5,a0
     c26:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     c2a:	fdc42783          	lw	a5,-36(s0)
     c2e:	0007871b          	sext.w	a4,a5
     c32:	6785                	lui	a5,0x1
     c34:	00f77563          	bgeu	a4,a5,c3e <morecore+0x22>
    nu = 4096;
     c38:	6785                	lui	a5,0x1
     c3a:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     c3e:	fdc42783          	lw	a5,-36(s0)
     c42:	0047979b          	slliw	a5,a5,0x4
     c46:	2781                	sext.w	a5,a5
     c48:	2781                	sext.w	a5,a5
     c4a:	853e                	mv	a0,a5
     c4c:	00000097          	auipc	ra,0x0
     c50:	9a0080e7          	jalr	-1632(ra) # 5ec <sbrk>
     c54:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     c58:	fe843703          	ld	a4,-24(s0)
     c5c:	57fd                	li	a5,-1
     c5e:	00f71463          	bne	a4,a5,c66 <morecore+0x4a>
    return 0;
     c62:	4781                	li	a5,0
     c64:	a03d                	j	c92 <morecore+0x76>
  hp = (Header*)p;
     c66:	fe843783          	ld	a5,-24(s0)
     c6a:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     c6e:	fe043783          	ld	a5,-32(s0)
     c72:	fdc42703          	lw	a4,-36(s0)
     c76:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     c78:	fe043783          	ld	a5,-32(s0)
     c7c:	07c1                	addi	a5,a5,16
     c7e:	853e                	mv	a0,a5
     c80:	00000097          	auipc	ra,0x0
     c84:	e7a080e7          	jalr	-390(ra) # afa <free>
  return freep;
     c88:	00002797          	auipc	a5,0x2
     c8c:	8f878793          	addi	a5,a5,-1800 # 2580 <freep>
     c90:	639c                	ld	a5,0(a5)
}
     c92:	853e                	mv	a0,a5
     c94:	70a2                	ld	ra,40(sp)
     c96:	7402                	ld	s0,32(sp)
     c98:	6145                	addi	sp,sp,48
     c9a:	8082                	ret

0000000000000c9c <malloc>:

void*
malloc(uint nbytes)
{
     c9c:	7139                	addi	sp,sp,-64
     c9e:	fc06                	sd	ra,56(sp)
     ca0:	f822                	sd	s0,48(sp)
     ca2:	0080                	addi	s0,sp,64
     ca4:	87aa                	mv	a5,a0
     ca6:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     caa:	fcc46783          	lwu	a5,-52(s0)
     cae:	07bd                	addi	a5,a5,15
     cb0:	8391                	srli	a5,a5,0x4
     cb2:	2781                	sext.w	a5,a5
     cb4:	2785                	addiw	a5,a5,1
     cb6:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     cba:	00002797          	auipc	a5,0x2
     cbe:	8c678793          	addi	a5,a5,-1850 # 2580 <freep>
     cc2:	639c                	ld	a5,0(a5)
     cc4:	fef43023          	sd	a5,-32(s0)
     cc8:	fe043783          	ld	a5,-32(s0)
     ccc:	ef95                	bnez	a5,d08 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     cce:	00002797          	auipc	a5,0x2
     cd2:	8a278793          	addi	a5,a5,-1886 # 2570 <base>
     cd6:	fef43023          	sd	a5,-32(s0)
     cda:	00002797          	auipc	a5,0x2
     cde:	8a678793          	addi	a5,a5,-1882 # 2580 <freep>
     ce2:	fe043703          	ld	a4,-32(s0)
     ce6:	e398                	sd	a4,0(a5)
     ce8:	00002797          	auipc	a5,0x2
     cec:	89878793          	addi	a5,a5,-1896 # 2580 <freep>
     cf0:	6398                	ld	a4,0(a5)
     cf2:	00002797          	auipc	a5,0x2
     cf6:	87e78793          	addi	a5,a5,-1922 # 2570 <base>
     cfa:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     cfc:	00002797          	auipc	a5,0x2
     d00:	87478793          	addi	a5,a5,-1932 # 2570 <base>
     d04:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     d08:	fe043783          	ld	a5,-32(s0)
     d0c:	639c                	ld	a5,0(a5)
     d0e:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     d12:	fe843783          	ld	a5,-24(s0)
     d16:	4798                	lw	a4,8(a5)
     d18:	fdc42783          	lw	a5,-36(s0)
     d1c:	2781                	sext.w	a5,a5
     d1e:	06f76863          	bltu	a4,a5,d8e <malloc+0xf2>
      if(p->s.size == nunits)
     d22:	fe843783          	ld	a5,-24(s0)
     d26:	4798                	lw	a4,8(a5)
     d28:	fdc42783          	lw	a5,-36(s0)
     d2c:	2781                	sext.w	a5,a5
     d2e:	00e79963          	bne	a5,a4,d40 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     d32:	fe843783          	ld	a5,-24(s0)
     d36:	6398                	ld	a4,0(a5)
     d38:	fe043783          	ld	a5,-32(s0)
     d3c:	e398                	sd	a4,0(a5)
     d3e:	a82d                	j	d78 <malloc+0xdc>
      else {
        p->s.size -= nunits;
     d40:	fe843783          	ld	a5,-24(s0)
     d44:	4798                	lw	a4,8(a5)
     d46:	fdc42783          	lw	a5,-36(s0)
     d4a:	40f707bb          	subw	a5,a4,a5
     d4e:	0007871b          	sext.w	a4,a5
     d52:	fe843783          	ld	a5,-24(s0)
     d56:	c798                	sw	a4,8(a5)
        p += p->s.size;
     d58:	fe843783          	ld	a5,-24(s0)
     d5c:	479c                	lw	a5,8(a5)
     d5e:	1782                	slli	a5,a5,0x20
     d60:	9381                	srli	a5,a5,0x20
     d62:	0792                	slli	a5,a5,0x4
     d64:	fe843703          	ld	a4,-24(s0)
     d68:	97ba                	add	a5,a5,a4
     d6a:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     d6e:	fe843783          	ld	a5,-24(s0)
     d72:	fdc42703          	lw	a4,-36(s0)
     d76:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     d78:	00002797          	auipc	a5,0x2
     d7c:	80878793          	addi	a5,a5,-2040 # 2580 <freep>
     d80:	fe043703          	ld	a4,-32(s0)
     d84:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     d86:	fe843783          	ld	a5,-24(s0)
     d8a:	07c1                	addi	a5,a5,16
     d8c:	a091                	j	dd0 <malloc+0x134>
    }
    if(p == freep)
     d8e:	00001797          	auipc	a5,0x1
     d92:	7f278793          	addi	a5,a5,2034 # 2580 <freep>
     d96:	639c                	ld	a5,0(a5)
     d98:	fe843703          	ld	a4,-24(s0)
     d9c:	02f71063          	bne	a4,a5,dbc <malloc+0x120>
      if((p = morecore(nunits)) == 0)
     da0:	fdc42783          	lw	a5,-36(s0)
     da4:	853e                	mv	a0,a5
     da6:	00000097          	auipc	ra,0x0
     daa:	e76080e7          	jalr	-394(ra) # c1c <morecore>
     dae:	fea43423          	sd	a0,-24(s0)
     db2:	fe843783          	ld	a5,-24(s0)
     db6:	e399                	bnez	a5,dbc <malloc+0x120>
        return 0;
     db8:	4781                	li	a5,0
     dba:	a819                	j	dd0 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     dbc:	fe843783          	ld	a5,-24(s0)
     dc0:	fef43023          	sd	a5,-32(s0)
     dc4:	fe843783          	ld	a5,-24(s0)
     dc8:	639c                	ld	a5,0(a5)
     dca:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     dce:	b791                	j	d12 <malloc+0x76>
  }
}
     dd0:	853e                	mv	a0,a5
     dd2:	70e2                	ld	ra,56(sp)
     dd4:	7442                	ld	s0,48(sp)
     dd6:	6121                	addi	sp,sp,64
     dd8:	8082                	ret

0000000000000dda <setjmp>:
     dda:	e100                	sd	s0,0(a0)
     ddc:	e504                	sd	s1,8(a0)
     dde:	01253823          	sd	s2,16(a0)
     de2:	01353c23          	sd	s3,24(a0)
     de6:	03453023          	sd	s4,32(a0)
     dea:	03553423          	sd	s5,40(a0)
     dee:	03653823          	sd	s6,48(a0)
     df2:	03753c23          	sd	s7,56(a0)
     df6:	05853023          	sd	s8,64(a0)
     dfa:	05953423          	sd	s9,72(a0)
     dfe:	05a53823          	sd	s10,80(a0)
     e02:	05b53c23          	sd	s11,88(a0)
     e06:	06153023          	sd	ra,96(a0)
     e0a:	06253423          	sd	sp,104(a0)
     e0e:	4501                	li	a0,0
     e10:	8082                	ret

0000000000000e12 <longjmp>:
     e12:	6100                	ld	s0,0(a0)
     e14:	6504                	ld	s1,8(a0)
     e16:	01053903          	ld	s2,16(a0)
     e1a:	01853983          	ld	s3,24(a0)
     e1e:	02053a03          	ld	s4,32(a0)
     e22:	02853a83          	ld	s5,40(a0)
     e26:	03053b03          	ld	s6,48(a0)
     e2a:	03853b83          	ld	s7,56(a0)
     e2e:	04053c03          	ld	s8,64(a0)
     e32:	04853c83          	ld	s9,72(a0)
     e36:	05053d03          	ld	s10,80(a0)
     e3a:	05853d83          	ld	s11,88(a0)
     e3e:	06053083          	ld	ra,96(a0)
     e42:	06853103          	ld	sp,104(a0)
     e46:	c199                	beqz	a1,e4c <longjmp_1>
     e48:	852e                	mv	a0,a1
     e4a:	8082                	ret

0000000000000e4c <longjmp_1>:
     e4c:	4505                	li	a0,1
     e4e:	8082                	ret

0000000000000e50 <__list_add>:
 * the prev/next entries already!
 */
static inline void __list_add(struct list_head *new_entry,
                              struct list_head *prev,
                              struct list_head *next)
{
     e50:	7179                	addi	sp,sp,-48
     e52:	f422                	sd	s0,40(sp)
     e54:	1800                	addi	s0,sp,48
     e56:	fea43423          	sd	a0,-24(s0)
     e5a:	feb43023          	sd	a1,-32(s0)
     e5e:	fcc43c23          	sd	a2,-40(s0)
    next->prev = new_entry;
     e62:	fd843783          	ld	a5,-40(s0)
     e66:	fe843703          	ld	a4,-24(s0)
     e6a:	e798                	sd	a4,8(a5)
    new_entry->next = next;
     e6c:	fe843783          	ld	a5,-24(s0)
     e70:	fd843703          	ld	a4,-40(s0)
     e74:	e398                	sd	a4,0(a5)
    new_entry->prev = prev;
     e76:	fe843783          	ld	a5,-24(s0)
     e7a:	fe043703          	ld	a4,-32(s0)
     e7e:	e798                	sd	a4,8(a5)
    prev->next = new_entry;
     e80:	fe043783          	ld	a5,-32(s0)
     e84:	fe843703          	ld	a4,-24(s0)
     e88:	e398                	sd	a4,0(a5)
}
     e8a:	0001                	nop
     e8c:	7422                	ld	s0,40(sp)
     e8e:	6145                	addi	sp,sp,48
     e90:	8082                	ret

0000000000000e92 <list_add_tail>:
 *
 * Insert a new entry before the specified head.
 * This is useful for implementing queues.
 */
static inline void list_add_tail(struct list_head *new_entry, struct list_head *head)
{
     e92:	1101                	addi	sp,sp,-32
     e94:	ec06                	sd	ra,24(sp)
     e96:	e822                	sd	s0,16(sp)
     e98:	1000                	addi	s0,sp,32
     e9a:	fea43423          	sd	a0,-24(s0)
     e9e:	feb43023          	sd	a1,-32(s0)
    __list_add(new_entry, head->prev, head);
     ea2:	fe043783          	ld	a5,-32(s0)
     ea6:	679c                	ld	a5,8(a5)
     ea8:	fe043603          	ld	a2,-32(s0)
     eac:	85be                	mv	a1,a5
     eae:	fe843503          	ld	a0,-24(s0)
     eb2:	00000097          	auipc	ra,0x0
     eb6:	f9e080e7          	jalr	-98(ra) # e50 <__list_add>
}
     eba:	0001                	nop
     ebc:	60e2                	ld	ra,24(sp)
     ebe:	6442                	ld	s0,16(sp)
     ec0:	6105                	addi	sp,sp,32
     ec2:	8082                	ret

0000000000000ec4 <__list_del>:
 *
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 */
static inline void __list_del(struct list_head *prev, struct list_head *next)
{
     ec4:	1101                	addi	sp,sp,-32
     ec6:	ec22                	sd	s0,24(sp)
     ec8:	1000                	addi	s0,sp,32
     eca:	fea43423          	sd	a0,-24(s0)
     ece:	feb43023          	sd	a1,-32(s0)
    next->prev = prev;
     ed2:	fe043783          	ld	a5,-32(s0)
     ed6:	fe843703          	ld	a4,-24(s0)
     eda:	e798                	sd	a4,8(a5)
    prev->next = next;
     edc:	fe843783          	ld	a5,-24(s0)
     ee0:	fe043703          	ld	a4,-32(s0)
     ee4:	e398                	sd	a4,0(a5)
}
     ee6:	0001                	nop
     ee8:	6462                	ld	s0,24(sp)
     eea:	6105                	addi	sp,sp,32
     eec:	8082                	ret

0000000000000eee <list_del>:
 * @entry: the element to delete from the list.
 * Note: list_empty on entry does not return true after this, the entry is
 * in an undefined state.
 */
static inline void list_del(struct list_head *entry)
{
     eee:	1101                	addi	sp,sp,-32
     ef0:	ec06                	sd	ra,24(sp)
     ef2:	e822                	sd	s0,16(sp)
     ef4:	1000                	addi	s0,sp,32
     ef6:	fea43423          	sd	a0,-24(s0)
    __list_del(entry->prev, entry->next);
     efa:	fe843783          	ld	a5,-24(s0)
     efe:	6798                	ld	a4,8(a5)
     f00:	fe843783          	ld	a5,-24(s0)
     f04:	639c                	ld	a5,0(a5)
     f06:	85be                	mv	a1,a5
     f08:	853a                	mv	a0,a4
     f0a:	00000097          	auipc	ra,0x0
     f0e:	fba080e7          	jalr	-70(ra) # ec4 <__list_del>
    entry->next = LIST_POISON1;
     f12:	fe843783          	ld	a5,-24(s0)
     f16:	00100737          	lui	a4,0x100
     f1a:	10070713          	addi	a4,a4,256 # 100100 <__global_pointer$+0xfd3d8>
     f1e:	e398                	sd	a4,0(a5)
    entry->prev = LIST_POISON2;
     f20:	fe843783          	ld	a5,-24(s0)
     f24:	00200737          	lui	a4,0x200
     f28:	20070713          	addi	a4,a4,512 # 200200 <__global_pointer$+0x1fd4d8>
     f2c:	e798                	sd	a4,8(a5)
}
     f2e:	0001                	nop
     f30:	60e2                	ld	ra,24(sp)
     f32:	6442                	ld	s0,16(sp)
     f34:	6105                	addi	sp,sp,32
     f36:	8082                	ret

0000000000000f38 <list_empty>:
/**
 * list_empty - tests whether a list is empty
 * @head: the list to test.
 */
static inline int list_empty(const struct list_head *head)
{
     f38:	1101                	addi	sp,sp,-32
     f3a:	ec22                	sd	s0,24(sp)
     f3c:	1000                	addi	s0,sp,32
     f3e:	fea43423          	sd	a0,-24(s0)
    return head->next == head;
     f42:	fe843783          	ld	a5,-24(s0)
     f46:	639c                	ld	a5,0(a5)
     f48:	fe843703          	ld	a4,-24(s0)
     f4c:	40f707b3          	sub	a5,a4,a5
     f50:	0017b793          	seqz	a5,a5
     f54:	0ff7f793          	andi	a5,a5,255
     f58:	2781                	sext.w	a5,a5
}
     f5a:	853e                	mv	a0,a5
     f5c:	6462                	ld	s0,24(sp)
     f5e:	6105                	addi	sp,sp,32
     f60:	8082                	ret

0000000000000f62 <thread_create>:

void __dispatch(void);
void __schedule(void);

struct thread *thread_create(void (*f)(void *), void *arg, int is_real_time, int processing_time, int period, int n)
{
     f62:	715d                	addi	sp,sp,-80
     f64:	e486                	sd	ra,72(sp)
     f66:	e0a2                	sd	s0,64(sp)
     f68:	0880                	addi	s0,sp,80
     f6a:	fca43423          	sd	a0,-56(s0)
     f6e:	fcb43023          	sd	a1,-64(s0)
     f72:	85b2                	mv	a1,a2
     f74:	8636                	mv	a2,a3
     f76:	86ba                	mv	a3,a4
     f78:	873e                	mv	a4,a5
     f7a:	87ae                	mv	a5,a1
     f7c:	faf42e23          	sw	a5,-68(s0)
     f80:	87b2                	mv	a5,a2
     f82:	faf42c23          	sw	a5,-72(s0)
     f86:	87b6                	mv	a5,a3
     f88:	faf42a23          	sw	a5,-76(s0)
     f8c:	87ba                	mv	a5,a4
     f8e:	faf42823          	sw	a5,-80(s0)
    static int _id = 1;
    struct thread *t = (struct thread *)malloc(sizeof(struct thread));
     f92:	06000513          	li	a0,96
     f96:	00000097          	auipc	ra,0x0
     f9a:	d06080e7          	jalr	-762(ra) # c9c <malloc>
     f9e:	fea43423          	sd	a0,-24(s0)
    unsigned long new_stack_p;
    unsigned long new_stack;
    new_stack = (unsigned long)malloc(sizeof(unsigned long) * 0x200);
     fa2:	6505                	lui	a0,0x1
     fa4:	00000097          	auipc	ra,0x0
     fa8:	cf8080e7          	jalr	-776(ra) # c9c <malloc>
     fac:	87aa                	mv	a5,a0
     fae:	fef43023          	sd	a5,-32(s0)
    new_stack_p = new_stack + 0x200 * 8 - 0x2 * 8;
     fb2:	fe043703          	ld	a4,-32(s0)
     fb6:	6785                	lui	a5,0x1
     fb8:	17c1                	addi	a5,a5,-16
     fba:	97ba                	add	a5,a5,a4
     fbc:	fcf43c23          	sd	a5,-40(s0)
    t->fp = f;
     fc0:	fe843783          	ld	a5,-24(s0)
     fc4:	fc843703          	ld	a4,-56(s0)
     fc8:	e398                	sd	a4,0(a5)
    t->arg = arg;
     fca:	fe843783          	ld	a5,-24(s0)
     fce:	fc043703          	ld	a4,-64(s0)
     fd2:	e798                	sd	a4,8(a5)
    t->ID = _id++;
     fd4:	00001797          	auipc	a5,0x1
     fd8:	59078793          	addi	a5,a5,1424 # 2564 <_id.1229>
     fdc:	439c                	lw	a5,0(a5)
     fde:	0017871b          	addiw	a4,a5,1
     fe2:	0007069b          	sext.w	a3,a4
     fe6:	00001717          	auipc	a4,0x1
     fea:	57e70713          	addi	a4,a4,1406 # 2564 <_id.1229>
     fee:	c314                	sw	a3,0(a4)
     ff0:	fe843703          	ld	a4,-24(s0)
     ff4:	df5c                	sw	a5,60(a4)
    t->buf_set = 0;
     ff6:	fe843783          	ld	a5,-24(s0)
     ffa:	0207a023          	sw	zero,32(a5)
    t->stack = (void *)new_stack;
     ffe:	fe043703          	ld	a4,-32(s0)
    1002:	fe843783          	ld	a5,-24(s0)
    1006:	eb98                	sd	a4,16(a5)
    t->stack_p = (void *)new_stack_p;
    1008:	fd843703          	ld	a4,-40(s0)
    100c:	fe843783          	ld	a5,-24(s0)
    1010:	ef98                	sd	a4,24(a5)

    t->processing_time = processing_time;
    1012:	fe843783          	ld	a5,-24(s0)
    1016:	fb842703          	lw	a4,-72(s0)
    101a:	c3f8                	sw	a4,68(a5)
    t->period = period;
    101c:	fe843783          	ld	a5,-24(s0)
    1020:	fb442703          	lw	a4,-76(s0)
    1024:	cbb8                	sw	a4,80(a5)
    t->deadline = period;
    1026:	fe843783          	ld	a5,-24(s0)
    102a:	fb442703          	lw	a4,-76(s0)
    102e:	c7f8                	sw	a4,76(a5)
    t->n = n;
    1030:	fe843783          	ld	a5,-24(s0)
    1034:	fb042703          	lw	a4,-80(s0)
    1038:	cbf8                	sw	a4,84(a5)
    t->is_real_time = is_real_time;
    103a:	fe843783          	ld	a5,-24(s0)
    103e:	fbc42703          	lw	a4,-68(s0)
    1042:	c3b8                	sw	a4,64(a5)
    t->weight = 1;
    1044:	fe843783          	ld	a5,-24(s0)
    1048:	4705                	li	a4,1
    104a:	c7b8                	sw	a4,72(a5)
    t->remaining_time = processing_time;
    104c:	fe843783          	ld	a5,-24(s0)
    1050:	fb842703          	lw	a4,-72(s0)
    1054:	cfb8                	sw	a4,88(a5)
    t->current_deadline = 0;
    1056:	fe843783          	ld	a5,-24(s0)
    105a:	0407ae23          	sw	zero,92(a5)
    return t;
    105e:	fe843783          	ld	a5,-24(s0)
}
    1062:	853e                	mv	a0,a5
    1064:	60a6                	ld	ra,72(sp)
    1066:	6406                	ld	s0,64(sp)
    1068:	6161                	addi	sp,sp,80
    106a:	8082                	ret

000000000000106c <thread_set_weight>:

void thread_set_weight(struct thread *t, int weight)
{
    106c:	1101                	addi	sp,sp,-32
    106e:	ec22                	sd	s0,24(sp)
    1070:	1000                	addi	s0,sp,32
    1072:	fea43423          	sd	a0,-24(s0)
    1076:	87ae                	mv	a5,a1
    1078:	fef42223          	sw	a5,-28(s0)
    t->weight = weight;
    107c:	fe843783          	ld	a5,-24(s0)
    1080:	fe442703          	lw	a4,-28(s0)
    1084:	c7b8                	sw	a4,72(a5)
}
    1086:	0001                	nop
    1088:	6462                	ld	s0,24(sp)
    108a:	6105                	addi	sp,sp,32
    108c:	8082                	ret

000000000000108e <thread_add_at>:

void thread_add_at(struct thread *t, int arrival_time)
{
    108e:	7179                	addi	sp,sp,-48
    1090:	f406                	sd	ra,40(sp)
    1092:	f022                	sd	s0,32(sp)
    1094:	1800                	addi	s0,sp,48
    1096:	fca43c23          	sd	a0,-40(s0)
    109a:	87ae                	mv	a5,a1
    109c:	fcf42a23          	sw	a5,-44(s0)
    struct release_queue_entry *new_entry = (struct release_queue_entry *)malloc(sizeof(struct release_queue_entry));
    10a0:	02000513          	li	a0,32
    10a4:	00000097          	auipc	ra,0x0
    10a8:	bf8080e7          	jalr	-1032(ra) # c9c <malloc>
    10ac:	fea43423          	sd	a0,-24(s0)
    new_entry->thrd = t;
    10b0:	fe843783          	ld	a5,-24(s0)
    10b4:	fd843703          	ld	a4,-40(s0)
    10b8:	e398                	sd	a4,0(a5)
    new_entry->release_time = arrival_time;
    10ba:	fe843783          	ld	a5,-24(s0)
    10be:	fd442703          	lw	a4,-44(s0)
    10c2:	cf98                	sw	a4,24(a5)
    if (t->is_real_time) {
    10c4:	fd843783          	ld	a5,-40(s0)
    10c8:	43bc                	lw	a5,64(a5)
    10ca:	c38d                	beqz	a5,10ec <thread_add_at+0x5e>
        t->current_deadline = arrival_time;
    10cc:	fd843783          	ld	a5,-40(s0)
    10d0:	fd442703          	lw	a4,-44(s0)
    10d4:	cff8                	sw	a4,92(a5)
        t->current_deadline = arrival_time + t->deadline;
    10d6:	fd843783          	ld	a5,-40(s0)
    10da:	47fc                	lw	a5,76(a5)
    10dc:	fd442703          	lw	a4,-44(s0)
    10e0:	9fb9                	addw	a5,a5,a4
    10e2:	0007871b          	sext.w	a4,a5
    10e6:	fd843783          	ld	a5,-40(s0)
    10ea:	cff8                	sw	a4,92(a5)
    }
    list_add_tail(&new_entry->thread_list, &release_queue);
    10ec:	fe843783          	ld	a5,-24(s0)
    10f0:	07a1                	addi	a5,a5,8
    10f2:	00001597          	auipc	a1,0x1
    10f6:	45e58593          	addi	a1,a1,1118 # 2550 <release_queue>
    10fa:	853e                	mv	a0,a5
    10fc:	00000097          	auipc	ra,0x0
    1100:	d96080e7          	jalr	-618(ra) # e92 <list_add_tail>
}
    1104:	0001                	nop
    1106:	70a2                	ld	ra,40(sp)
    1108:	7402                	ld	s0,32(sp)
    110a:	6145                	addi	sp,sp,48
    110c:	8082                	ret

000000000000110e <__release>:

void __release()
{
    110e:	7139                	addi	sp,sp,-64
    1110:	fc06                	sd	ra,56(sp)
    1112:	f822                	sd	s0,48(sp)
    1114:	0080                	addi	s0,sp,64
    struct release_queue_entry *cur, *nxt;
    list_for_each_entry_safe(cur, nxt, &release_queue, thread_list) {
    1116:	00001797          	auipc	a5,0x1
    111a:	43a78793          	addi	a5,a5,1082 # 2550 <release_queue>
    111e:	639c                	ld	a5,0(a5)
    1120:	fcf43c23          	sd	a5,-40(s0)
    1124:	fd843783          	ld	a5,-40(s0)
    1128:	17e1                	addi	a5,a5,-8
    112a:	fef43423          	sd	a5,-24(s0)
    112e:	fe843783          	ld	a5,-24(s0)
    1132:	679c                	ld	a5,8(a5)
    1134:	fcf43823          	sd	a5,-48(s0)
    1138:	fd043783          	ld	a5,-48(s0)
    113c:	17e1                	addi	a5,a5,-8
    113e:	fef43023          	sd	a5,-32(s0)
    1142:	a851                	j	11d6 <__release+0xc8>
        if (threading_system_time >= cur->release_time) {
    1144:	fe843783          	ld	a5,-24(s0)
    1148:	4f98                	lw	a4,24(a5)
    114a:	00001797          	auipc	a5,0x1
    114e:	44678793          	addi	a5,a5,1094 # 2590 <threading_system_time>
    1152:	439c                	lw	a5,0(a5)
    1154:	06e7c363          	blt	a5,a4,11ba <__release+0xac>
            cur->thrd->remaining_time = cur->thrd->processing_time;
    1158:	fe843783          	ld	a5,-24(s0)
    115c:	6398                	ld	a4,0(a5)
    115e:	fe843783          	ld	a5,-24(s0)
    1162:	639c                	ld	a5,0(a5)
    1164:	4378                	lw	a4,68(a4)
    1166:	cfb8                	sw	a4,88(a5)
            cur->thrd->current_deadline = cur->release_time + cur->thrd->deadline;
    1168:	fe843783          	ld	a5,-24(s0)
    116c:	4f94                	lw	a3,24(a5)
    116e:	fe843783          	ld	a5,-24(s0)
    1172:	639c                	ld	a5,0(a5)
    1174:	47f8                	lw	a4,76(a5)
    1176:	fe843783          	ld	a5,-24(s0)
    117a:	639c                	ld	a5,0(a5)
    117c:	9f35                	addw	a4,a4,a3
    117e:	2701                	sext.w	a4,a4
    1180:	cff8                	sw	a4,92(a5)
            list_add_tail(&cur->thrd->thread_list, &run_queue);
    1182:	fe843783          	ld	a5,-24(s0)
    1186:	639c                	ld	a5,0(a5)
    1188:	02878793          	addi	a5,a5,40
    118c:	00001597          	auipc	a1,0x1
    1190:	3b458593          	addi	a1,a1,948 # 2540 <run_queue>
    1194:	853e                	mv	a0,a5
    1196:	00000097          	auipc	ra,0x0
    119a:	cfc080e7          	jalr	-772(ra) # e92 <list_add_tail>
            list_del(&cur->thread_list);
    119e:	fe843783          	ld	a5,-24(s0)
    11a2:	07a1                	addi	a5,a5,8
    11a4:	853e                	mv	a0,a5
    11a6:	00000097          	auipc	ra,0x0
    11aa:	d48080e7          	jalr	-696(ra) # eee <list_del>
            free(cur);
    11ae:	fe843503          	ld	a0,-24(s0)
    11b2:	00000097          	auipc	ra,0x0
    11b6:	948080e7          	jalr	-1720(ra) # afa <free>
    list_for_each_entry_safe(cur, nxt, &release_queue, thread_list) {
    11ba:	fe043783          	ld	a5,-32(s0)
    11be:	fef43423          	sd	a5,-24(s0)
    11c2:	fe043783          	ld	a5,-32(s0)
    11c6:	679c                	ld	a5,8(a5)
    11c8:	fcf43423          	sd	a5,-56(s0)
    11cc:	fc843783          	ld	a5,-56(s0)
    11d0:	17e1                	addi	a5,a5,-8
    11d2:	fef43023          	sd	a5,-32(s0)
    11d6:	fe843783          	ld	a5,-24(s0)
    11da:	00878713          	addi	a4,a5,8
    11de:	00001797          	auipc	a5,0x1
    11e2:	37278793          	addi	a5,a5,882 # 2550 <release_queue>
    11e6:	f4f71fe3          	bne	a4,a5,1144 <__release+0x36>
        }
    }
}
    11ea:	0001                	nop
    11ec:	0001                	nop
    11ee:	70e2                	ld	ra,56(sp)
    11f0:	7442                	ld	s0,48(sp)
    11f2:	6121                	addi	sp,sp,64
    11f4:	8082                	ret

00000000000011f6 <__thread_exit>:

void __thread_exit(struct thread *to_remove)
{
    11f6:	1101                	addi	sp,sp,-32
    11f8:	ec06                	sd	ra,24(sp)
    11fa:	e822                	sd	s0,16(sp)
    11fc:	1000                	addi	s0,sp,32
    11fe:	fea43423          	sd	a0,-24(s0)
    current = to_remove->thread_list.prev;
    1202:	fe843783          	ld	a5,-24(s0)
    1206:	7b98                	ld	a4,48(a5)
    1208:	00001797          	auipc	a5,0x1
    120c:	38078793          	addi	a5,a5,896 # 2588 <current>
    1210:	e398                	sd	a4,0(a5)
    list_del(&to_remove->thread_list);
    1212:	fe843783          	ld	a5,-24(s0)
    1216:	02878793          	addi	a5,a5,40
    121a:	853e                	mv	a0,a5
    121c:	00000097          	auipc	ra,0x0
    1220:	cd2080e7          	jalr	-814(ra) # eee <list_del>

    free(to_remove->stack);
    1224:	fe843783          	ld	a5,-24(s0)
    1228:	6b9c                	ld	a5,16(a5)
    122a:	853e                	mv	a0,a5
    122c:	00000097          	auipc	ra,0x0
    1230:	8ce080e7          	jalr	-1842(ra) # afa <free>
    free(to_remove);
    1234:	fe843503          	ld	a0,-24(s0)
    1238:	00000097          	auipc	ra,0x0
    123c:	8c2080e7          	jalr	-1854(ra) # afa <free>

    __schedule();
    1240:	00000097          	auipc	ra,0x0
    1244:	572080e7          	jalr	1394(ra) # 17b2 <__schedule>
    __dispatch();
    1248:	00000097          	auipc	ra,0x0
    124c:	3da080e7          	jalr	986(ra) # 1622 <__dispatch>
    thrdresume(main_thrd_id);
    1250:	00001797          	auipc	a5,0x1
    1254:	31078793          	addi	a5,a5,784 # 2560 <main_thrd_id>
    1258:	439c                	lw	a5,0(a5)
    125a:	853e                	mv	a0,a5
    125c:	fffff097          	auipc	ra,0xfffff
    1260:	3b0080e7          	jalr	944(ra) # 60c <thrdresume>
}
    1264:	0001                	nop
    1266:	60e2                	ld	ra,24(sp)
    1268:	6442                	ld	s0,16(sp)
    126a:	6105                	addi	sp,sp,32
    126c:	8082                	ret

000000000000126e <thread_exit>:

void thread_exit(void)
{
    126e:	7179                	addi	sp,sp,-48
    1270:	f406                	sd	ra,40(sp)
    1272:	f022                	sd	s0,32(sp)
    1274:	1800                	addi	s0,sp,48
    if (current == &run_queue) {
    1276:	00001797          	auipc	a5,0x1
    127a:	31278793          	addi	a5,a5,786 # 2588 <current>
    127e:	6398                	ld	a4,0(a5)
    1280:	00001797          	auipc	a5,0x1
    1284:	2c078793          	addi	a5,a5,704 # 2540 <run_queue>
    1288:	02f71063          	bne	a4,a5,12a8 <thread_exit+0x3a>
        fprintf(2, "[FATAL] thread_exit is called on a nonexistent thread\n");
    128c:	00001597          	auipc	a1,0x1
    1290:	15c58593          	addi	a1,a1,348 # 23e8 <schedule_dm+0x2a8>
    1294:	4509                	li	a0,2
    1296:	fffff097          	auipc	ra,0xfffff
    129a:	7bc080e7          	jalr	1980(ra) # a52 <fprintf>
        exit(1);
    129e:	4505                	li	a0,1
    12a0:	fffff097          	auipc	ra,0xfffff
    12a4:	2c4080e7          	jalr	708(ra) # 564 <exit>
    }

    struct thread *to_remove = list_entry(current, struct thread, thread_list);
    12a8:	00001797          	auipc	a5,0x1
    12ac:	2e078793          	addi	a5,a5,736 # 2588 <current>
    12b0:	639c                	ld	a5,0(a5)
    12b2:	fef43423          	sd	a5,-24(s0)
    12b6:	fe843783          	ld	a5,-24(s0)
    12ba:	fd878793          	addi	a5,a5,-40
    12be:	fef43023          	sd	a5,-32(s0)
    int consume_ticks = cancelthrdstop(to_remove->thrdstop_context_id, 1);
    12c2:	fe043783          	ld	a5,-32(s0)
    12c6:	5f9c                	lw	a5,56(a5)
    12c8:	4585                	li	a1,1
    12ca:	853e                	mv	a0,a5
    12cc:	fffff097          	auipc	ra,0xfffff
    12d0:	348080e7          	jalr	840(ra) # 614 <cancelthrdstop>
    12d4:	87aa                	mv	a5,a0
    12d6:	fcf42e23          	sw	a5,-36(s0)
    threading_system_time += consume_ticks;
    12da:	00001797          	auipc	a5,0x1
    12de:	2b678793          	addi	a5,a5,694 # 2590 <threading_system_time>
    12e2:	439c                	lw	a5,0(a5)
    12e4:	fdc42703          	lw	a4,-36(s0)
    12e8:	9fb9                	addw	a5,a5,a4
    12ea:	0007871b          	sext.w	a4,a5
    12ee:	00001797          	auipc	a5,0x1
    12f2:	2a278793          	addi	a5,a5,674 # 2590 <threading_system_time>
    12f6:	c398                	sw	a4,0(a5)

    __release();
    12f8:	00000097          	auipc	ra,0x0
    12fc:	e16080e7          	jalr	-490(ra) # 110e <__release>
    __thread_exit(to_remove);
    1300:	fe043503          	ld	a0,-32(s0)
    1304:	00000097          	auipc	ra,0x0
    1308:	ef2080e7          	jalr	-270(ra) # 11f6 <__thread_exit>
}
    130c:	0001                	nop
    130e:	70a2                	ld	ra,40(sp)
    1310:	7402                	ld	s0,32(sp)
    1312:	6145                	addi	sp,sp,48
    1314:	8082                	ret

0000000000001316 <__finish_current>:

void __finish_current()
{
    1316:	7179                	addi	sp,sp,-48
    1318:	f406                	sd	ra,40(sp)
    131a:	f022                	sd	s0,32(sp)
    131c:	1800                	addi	s0,sp,48
    struct thread *current_thread = list_entry(current, struct thread, thread_list);
    131e:	00001797          	auipc	a5,0x1
    1322:	26a78793          	addi	a5,a5,618 # 2588 <current>
    1326:	639c                	ld	a5,0(a5)
    1328:	fef43423          	sd	a5,-24(s0)
    132c:	fe843783          	ld	a5,-24(s0)
    1330:	fd878793          	addi	a5,a5,-40
    1334:	fef43023          	sd	a5,-32(s0)
    --current_thread->n;
    1338:	fe043783          	ld	a5,-32(s0)
    133c:	4bfc                	lw	a5,84(a5)
    133e:	37fd                	addiw	a5,a5,-1
    1340:	0007871b          	sext.w	a4,a5
    1344:	fe043783          	ld	a5,-32(s0)
    1348:	cbf8                	sw	a4,84(a5)

    printf("thread#%d finish at %d\n",
    134a:	fe043783          	ld	a5,-32(s0)
    134e:	5fd8                	lw	a4,60(a5)
    1350:	00001797          	auipc	a5,0x1
    1354:	24078793          	addi	a5,a5,576 # 2590 <threading_system_time>
    1358:	4390                	lw	a2,0(a5)
    135a:	fe043783          	ld	a5,-32(s0)
    135e:	4bfc                	lw	a5,84(a5)
    1360:	86be                	mv	a3,a5
    1362:	85ba                	mv	a1,a4
    1364:	00001517          	auipc	a0,0x1
    1368:	0bc50513          	addi	a0,a0,188 # 2420 <schedule_dm+0x2e0>
    136c:	fffff097          	auipc	ra,0xfffff
    1370:	73e080e7          	jalr	1854(ra) # aaa <printf>
           current_thread->ID, threading_system_time, current_thread->n);

    if (current_thread->n > 0) {
    1374:	fe043783          	ld	a5,-32(s0)
    1378:	4bfc                	lw	a5,84(a5)
    137a:	04f05563          	blez	a5,13c4 <__finish_current+0xae>
        struct list_head *to_remove = current;
    137e:	00001797          	auipc	a5,0x1
    1382:	20a78793          	addi	a5,a5,522 # 2588 <current>
    1386:	639c                	ld	a5,0(a5)
    1388:	fcf43c23          	sd	a5,-40(s0)
        current = current->prev;
    138c:	00001797          	auipc	a5,0x1
    1390:	1fc78793          	addi	a5,a5,508 # 2588 <current>
    1394:	639c                	ld	a5,0(a5)
    1396:	6798                	ld	a4,8(a5)
    1398:	00001797          	auipc	a5,0x1
    139c:	1f078793          	addi	a5,a5,496 # 2588 <current>
    13a0:	e398                	sd	a4,0(a5)
        list_del(to_remove);
    13a2:	fd843503          	ld	a0,-40(s0)
    13a6:	00000097          	auipc	ra,0x0
    13aa:	b48080e7          	jalr	-1208(ra) # eee <list_del>
        thread_add_at(current_thread, current_thread->current_deadline);
    13ae:	fe043783          	ld	a5,-32(s0)
    13b2:	4ffc                	lw	a5,92(a5)
    13b4:	85be                	mv	a1,a5
    13b6:	fe043503          	ld	a0,-32(s0)
    13ba:	00000097          	auipc	ra,0x0
    13be:	cd4080e7          	jalr	-812(ra) # 108e <thread_add_at>
    } else {
        __thread_exit(current_thread);
    }
}
    13c2:	a039                	j	13d0 <__finish_current+0xba>
        __thread_exit(current_thread);
    13c4:	fe043503          	ld	a0,-32(s0)
    13c8:	00000097          	auipc	ra,0x0
    13cc:	e2e080e7          	jalr	-466(ra) # 11f6 <__thread_exit>
}
    13d0:	0001                	nop
    13d2:	70a2                	ld	ra,40(sp)
    13d4:	7402                	ld	s0,32(sp)
    13d6:	6145                	addi	sp,sp,48
    13d8:	8082                	ret

00000000000013da <__rt_finish_current>:
void __rt_finish_current()
{
    13da:	7179                	addi	sp,sp,-48
    13dc:	f406                	sd	ra,40(sp)
    13de:	f022                	sd	s0,32(sp)
    13e0:	1800                	addi	s0,sp,48
    struct thread *current_thread = list_entry(current, struct thread, thread_list);
    13e2:	00001797          	auipc	a5,0x1
    13e6:	1a678793          	addi	a5,a5,422 # 2588 <current>
    13ea:	639c                	ld	a5,0(a5)
    13ec:	fef43423          	sd	a5,-24(s0)
    13f0:	fe843783          	ld	a5,-24(s0)
    13f4:	fd878793          	addi	a5,a5,-40
    13f8:	fef43023          	sd	a5,-32(s0)
    --current_thread->n;
    13fc:	fe043783          	ld	a5,-32(s0)
    1400:	4bfc                	lw	a5,84(a5)
    1402:	37fd                	addiw	a5,a5,-1
    1404:	0007871b          	sext.w	a4,a5
    1408:	fe043783          	ld	a5,-32(s0)
    140c:	cbf8                	sw	a4,84(a5)

    printf("thread#%d finish one cycle at %d: %d cycles left\n",
    140e:	fe043783          	ld	a5,-32(s0)
    1412:	5fd8                	lw	a4,60(a5)
    1414:	00001797          	auipc	a5,0x1
    1418:	17c78793          	addi	a5,a5,380 # 2590 <threading_system_time>
    141c:	4390                	lw	a2,0(a5)
    141e:	fe043783          	ld	a5,-32(s0)
    1422:	4bfc                	lw	a5,84(a5)
    1424:	86be                	mv	a3,a5
    1426:	85ba                	mv	a1,a4
    1428:	00001517          	auipc	a0,0x1
    142c:	01050513          	addi	a0,a0,16 # 2438 <schedule_dm+0x2f8>
    1430:	fffff097          	auipc	ra,0xfffff
    1434:	67a080e7          	jalr	1658(ra) # aaa <printf>
           current_thread->ID, threading_system_time, current_thread->n);

    if (current_thread->n > 0) {
    1438:	fe043783          	ld	a5,-32(s0)
    143c:	4bfc                	lw	a5,84(a5)
    143e:	04f05563          	blez	a5,1488 <__rt_finish_current+0xae>
        struct list_head *to_remove = current;
    1442:	00001797          	auipc	a5,0x1
    1446:	14678793          	addi	a5,a5,326 # 2588 <current>
    144a:	639c                	ld	a5,0(a5)
    144c:	fcf43c23          	sd	a5,-40(s0)
        current = current->prev;
    1450:	00001797          	auipc	a5,0x1
    1454:	13878793          	addi	a5,a5,312 # 2588 <current>
    1458:	639c                	ld	a5,0(a5)
    145a:	6798                	ld	a4,8(a5)
    145c:	00001797          	auipc	a5,0x1
    1460:	12c78793          	addi	a5,a5,300 # 2588 <current>
    1464:	e398                	sd	a4,0(a5)
        list_del(to_remove);
    1466:	fd843503          	ld	a0,-40(s0)
    146a:	00000097          	auipc	ra,0x0
    146e:	a84080e7          	jalr	-1404(ra) # eee <list_del>
        thread_add_at(current_thread, current_thread->current_deadline);
    1472:	fe043783          	ld	a5,-32(s0)
    1476:	4ffc                	lw	a5,92(a5)
    1478:	85be                	mv	a1,a5
    147a:	fe043503          	ld	a0,-32(s0)
    147e:	00000097          	auipc	ra,0x0
    1482:	c10080e7          	jalr	-1008(ra) # 108e <thread_add_at>
    } else {
        __thread_exit(current_thread);
    }
}
    1486:	a039                	j	1494 <__rt_finish_current+0xba>
        __thread_exit(current_thread);
    1488:	fe043503          	ld	a0,-32(s0)
    148c:	00000097          	auipc	ra,0x0
    1490:	d6a080e7          	jalr	-662(ra) # 11f6 <__thread_exit>
}
    1494:	0001                	nop
    1496:	70a2                	ld	ra,40(sp)
    1498:	7402                	ld	s0,32(sp)
    149a:	6145                	addi	sp,sp,48
    149c:	8082                	ret

000000000000149e <switch_handler>:

void switch_handler(void *arg)
{
    149e:	7139                	addi	sp,sp,-64
    14a0:	fc06                	sd	ra,56(sp)
    14a2:	f822                	sd	s0,48(sp)
    14a4:	0080                	addi	s0,sp,64
    14a6:	fca43423          	sd	a0,-56(s0)
    uint64 elapsed_time = (uint64)arg;
    14aa:	fc843783          	ld	a5,-56(s0)
    14ae:	fef43423          	sd	a5,-24(s0)
    struct thread *current_thread = list_entry(current, struct thread, thread_list);
    14b2:	00001797          	auipc	a5,0x1
    14b6:	0d678793          	addi	a5,a5,214 # 2588 <current>
    14ba:	639c                	ld	a5,0(a5)
    14bc:	fef43023          	sd	a5,-32(s0)
    14c0:	fe043783          	ld	a5,-32(s0)
    14c4:	fd878793          	addi	a5,a5,-40
    14c8:	fcf43c23          	sd	a5,-40(s0)

    threading_system_time += elapsed_time;
    14cc:	fe843783          	ld	a5,-24(s0)
    14d0:	0007871b          	sext.w	a4,a5
    14d4:	00001797          	auipc	a5,0x1
    14d8:	0bc78793          	addi	a5,a5,188 # 2590 <threading_system_time>
    14dc:	439c                	lw	a5,0(a5)
    14de:	2781                	sext.w	a5,a5
    14e0:	9fb9                	addw	a5,a5,a4
    14e2:	2781                	sext.w	a5,a5
    14e4:	0007871b          	sext.w	a4,a5
    14e8:	00001797          	auipc	a5,0x1
    14ec:	0a878793          	addi	a5,a5,168 # 2590 <threading_system_time>
    14f0:	c398                	sw	a4,0(a5)
     __release();
    14f2:	00000097          	auipc	ra,0x0
    14f6:	c1c080e7          	jalr	-996(ra) # 110e <__release>
    current_thread->remaining_time -= elapsed_time;
    14fa:	fd843783          	ld	a5,-40(s0)
    14fe:	4fbc                	lw	a5,88(a5)
    1500:	0007871b          	sext.w	a4,a5
    1504:	fe843783          	ld	a5,-24(s0)
    1508:	2781                	sext.w	a5,a5
    150a:	40f707bb          	subw	a5,a4,a5
    150e:	2781                	sext.w	a5,a5
    1510:	0007871b          	sext.w	a4,a5
    1514:	fd843783          	ld	a5,-40(s0)
    1518:	cfb8                	sw	a4,88(a5)

    if (current_thread->is_real_time)
    151a:	fd843783          	ld	a5,-40(s0)
    151e:	43bc                	lw	a5,64(a5)
    1520:	c3ad                	beqz	a5,1582 <switch_handler+0xe4>
        if (threading_system_time > current_thread->current_deadline || 
    1522:	fd843783          	ld	a5,-40(s0)
    1526:	4ff8                	lw	a4,92(a5)
    1528:	00001797          	auipc	a5,0x1
    152c:	06878793          	addi	a5,a5,104 # 2590 <threading_system_time>
    1530:	439c                	lw	a5,0(a5)
    1532:	02f74163          	blt	a4,a5,1554 <switch_handler+0xb6>
            (threading_system_time == current_thread->current_deadline && current_thread->remaining_time > 0)) {
    1536:	fd843783          	ld	a5,-40(s0)
    153a:	4ff8                	lw	a4,92(a5)
    153c:	00001797          	auipc	a5,0x1
    1540:	05478793          	addi	a5,a5,84 # 2590 <threading_system_time>
    1544:	439c                	lw	a5,0(a5)
        if (threading_system_time > current_thread->current_deadline || 
    1546:	02f71e63          	bne	a4,a5,1582 <switch_handler+0xe4>
            (threading_system_time == current_thread->current_deadline && current_thread->remaining_time > 0)) {
    154a:	fd843783          	ld	a5,-40(s0)
    154e:	4fbc                	lw	a5,88(a5)
    1550:	02f05963          	blez	a5,1582 <switch_handler+0xe4>
            printf("thread#%d misses a deadline at %d\n", current_thread->ID, threading_system_time);
    1554:	fd843783          	ld	a5,-40(s0)
    1558:	5fd8                	lw	a4,60(a5)
    155a:	00001797          	auipc	a5,0x1
    155e:	03678793          	addi	a5,a5,54 # 2590 <threading_system_time>
    1562:	439c                	lw	a5,0(a5)
    1564:	863e                	mv	a2,a5
    1566:	85ba                	mv	a1,a4
    1568:	00001517          	auipc	a0,0x1
    156c:	f0850513          	addi	a0,a0,-248 # 2470 <schedule_dm+0x330>
    1570:	fffff097          	auipc	ra,0xfffff
    1574:	53a080e7          	jalr	1338(ra) # aaa <printf>
            exit(0);
    1578:	4501                	li	a0,0
    157a:	fffff097          	auipc	ra,0xfffff
    157e:	fea080e7          	jalr	-22(ra) # 564 <exit>
        }

    if (current_thread->remaining_time <= 0) {
    1582:	fd843783          	ld	a5,-40(s0)
    1586:	4fbc                	lw	a5,88(a5)
    1588:	02f04063          	bgtz	a5,15a8 <switch_handler+0x10a>
        if (current_thread->is_real_time)
    158c:	fd843783          	ld	a5,-40(s0)
    1590:	43bc                	lw	a5,64(a5)
    1592:	c791                	beqz	a5,159e <switch_handler+0x100>
            __rt_finish_current();
    1594:	00000097          	auipc	ra,0x0
    1598:	e46080e7          	jalr	-442(ra) # 13da <__rt_finish_current>
    159c:	a881                	j	15ec <switch_handler+0x14e>
        else
            __finish_current();
    159e:	00000097          	auipc	ra,0x0
    15a2:	d78080e7          	jalr	-648(ra) # 1316 <__finish_current>
    15a6:	a099                	j	15ec <switch_handler+0x14e>
    } else {
        // move the current thread to the end of the run_queue
        struct list_head *to_remove = current;
    15a8:	00001797          	auipc	a5,0x1
    15ac:	fe078793          	addi	a5,a5,-32 # 2588 <current>
    15b0:	639c                	ld	a5,0(a5)
    15b2:	fcf43823          	sd	a5,-48(s0)
        current = current->prev;
    15b6:	00001797          	auipc	a5,0x1
    15ba:	fd278793          	addi	a5,a5,-46 # 2588 <current>
    15be:	639c                	ld	a5,0(a5)
    15c0:	6798                	ld	a4,8(a5)
    15c2:	00001797          	auipc	a5,0x1
    15c6:	fc678793          	addi	a5,a5,-58 # 2588 <current>
    15ca:	e398                	sd	a4,0(a5)
        list_del(to_remove);
    15cc:	fd043503          	ld	a0,-48(s0)
    15d0:	00000097          	auipc	ra,0x0
    15d4:	91e080e7          	jalr	-1762(ra) # eee <list_del>
        list_add_tail(to_remove, &run_queue);
    15d8:	00001597          	auipc	a1,0x1
    15dc:	f6858593          	addi	a1,a1,-152 # 2540 <run_queue>
    15e0:	fd043503          	ld	a0,-48(s0)
    15e4:	00000097          	auipc	ra,0x0
    15e8:	8ae080e7          	jalr	-1874(ra) # e92 <list_add_tail>
    }

    __release();
    15ec:	00000097          	auipc	ra,0x0
    15f0:	b22080e7          	jalr	-1246(ra) # 110e <__release>
    __schedule();
    15f4:	00000097          	auipc	ra,0x0
    15f8:	1be080e7          	jalr	446(ra) # 17b2 <__schedule>
    __dispatch();
    15fc:	00000097          	auipc	ra,0x0
    1600:	026080e7          	jalr	38(ra) # 1622 <__dispatch>
    thrdresume(main_thrd_id);
    1604:	00001797          	auipc	a5,0x1
    1608:	f5c78793          	addi	a5,a5,-164 # 2560 <main_thrd_id>
    160c:	439c                	lw	a5,0(a5)
    160e:	853e                	mv	a0,a5
    1610:	fffff097          	auipc	ra,0xfffff
    1614:	ffc080e7          	jalr	-4(ra) # 60c <thrdresume>
}
    1618:	0001                	nop
    161a:	70e2                	ld	ra,56(sp)
    161c:	7442                	ld	s0,48(sp)
    161e:	6121                	addi	sp,sp,64
    1620:	8082                	ret

0000000000001622 <__dispatch>:

void __dispatch()
{
    1622:	7179                	addi	sp,sp,-48
    1624:	f406                	sd	ra,40(sp)
    1626:	f022                	sd	s0,32(sp)
    1628:	1800                	addi	s0,sp,48
    if (current == &run_queue) {
    162a:	00001797          	auipc	a5,0x1
    162e:	f5e78793          	addi	a5,a5,-162 # 2588 <current>
    1632:	6398                	ld	a4,0(a5)
    1634:	00001797          	auipc	a5,0x1
    1638:	f0c78793          	addi	a5,a5,-244 # 2540 <run_queue>
    163c:	16f70663          	beq	a4,a5,17a8 <__dispatch+0x186>
    if (allocated_time < 0) {
        fprintf(2, "[FATAL] allocated_time is negative\n");
        exit(1);
    }

    struct thread *current_thread = list_entry(current, struct thread, thread_list);
    1640:	00001797          	auipc	a5,0x1
    1644:	f4878793          	addi	a5,a5,-184 # 2588 <current>
    1648:	639c                	ld	a5,0(a5)
    164a:	fef43423          	sd	a5,-24(s0)
    164e:	fe843783          	ld	a5,-24(s0)
    1652:	fd878793          	addi	a5,a5,-40
    1656:	fef43023          	sd	a5,-32(s0)
    if (current_thread->is_real_time && allocated_time == 0) { // miss deadline, abort
    165a:	fe043783          	ld	a5,-32(s0)
    165e:	43bc                	lw	a5,64(a5)
    1660:	cf85                	beqz	a5,1698 <__dispatch+0x76>
    1662:	00001797          	auipc	a5,0x1
    1666:	f3678793          	addi	a5,a5,-202 # 2598 <allocated_time>
    166a:	639c                	ld	a5,0(a5)
    166c:	e795                	bnez	a5,1698 <__dispatch+0x76>
        printf("thread#%d misses a deadline at %d\n", current_thread->ID, current_thread->current_deadline);
    166e:	fe043783          	ld	a5,-32(s0)
    1672:	5fd8                	lw	a4,60(a5)
    1674:	fe043783          	ld	a5,-32(s0)
    1678:	4ffc                	lw	a5,92(a5)
    167a:	863e                	mv	a2,a5
    167c:	85ba                	mv	a1,a4
    167e:	00001517          	auipc	a0,0x1
    1682:	df250513          	addi	a0,a0,-526 # 2470 <schedule_dm+0x330>
    1686:	fffff097          	auipc	ra,0xfffff
    168a:	424080e7          	jalr	1060(ra) # aaa <printf>
        exit(0);
    168e:	4501                	li	a0,0
    1690:	fffff097          	auipc	ra,0xfffff
    1694:	ed4080e7          	jalr	-300(ra) # 564 <exit>
    }

    printf("dispatch thread#%d at %d: allocated_time=%d\n", current_thread->ID, threading_system_time, allocated_time);
    1698:	fe043783          	ld	a5,-32(s0)
    169c:	5fd8                	lw	a4,60(a5)
    169e:	00001797          	auipc	a5,0x1
    16a2:	ef278793          	addi	a5,a5,-270 # 2590 <threading_system_time>
    16a6:	4390                	lw	a2,0(a5)
    16a8:	00001797          	auipc	a5,0x1
    16ac:	ef078793          	addi	a5,a5,-272 # 2598 <allocated_time>
    16b0:	639c                	ld	a5,0(a5)
    16b2:	86be                	mv	a3,a5
    16b4:	85ba                	mv	a1,a4
    16b6:	00001517          	auipc	a0,0x1
    16ba:	de250513          	addi	a0,a0,-542 # 2498 <schedule_dm+0x358>
    16be:	fffff097          	auipc	ra,0xfffff
    16c2:	3ec080e7          	jalr	1004(ra) # aaa <printf>

    if (current_thread->buf_set) {
    16c6:	fe043783          	ld	a5,-32(s0)
    16ca:	539c                	lw	a5,32(a5)
    16cc:	c7a1                	beqz	a5,1714 <__dispatch+0xf2>
        thrdstop(allocated_time, &(current_thread->thrdstop_context_id), switch_handler, (void *)allocated_time);
    16ce:	00001797          	auipc	a5,0x1
    16d2:	eca78793          	addi	a5,a5,-310 # 2598 <allocated_time>
    16d6:	639c                	ld	a5,0(a5)
    16d8:	0007871b          	sext.w	a4,a5
    16dc:	fe043783          	ld	a5,-32(s0)
    16e0:	03878593          	addi	a1,a5,56
    16e4:	00001797          	auipc	a5,0x1
    16e8:	eb478793          	addi	a5,a5,-332 # 2598 <allocated_time>
    16ec:	639c                	ld	a5,0(a5)
    16ee:	86be                	mv	a3,a5
    16f0:	00000617          	auipc	a2,0x0
    16f4:	dae60613          	addi	a2,a2,-594 # 149e <switch_handler>
    16f8:	853a                	mv	a0,a4
    16fa:	fffff097          	auipc	ra,0xfffff
    16fe:	f0a080e7          	jalr	-246(ra) # 604 <thrdstop>
        thrdresume(current_thread->thrdstop_context_id);
    1702:	fe043783          	ld	a5,-32(s0)
    1706:	5f9c                	lw	a5,56(a5)
    1708:	853e                	mv	a0,a5
    170a:	fffff097          	auipc	ra,0xfffff
    170e:	f02080e7          	jalr	-254(ra) # 60c <thrdresume>
    1712:	a071                	j	179e <__dispatch+0x17c>
    } else {
        current_thread->buf_set = 1;
    1714:	fe043783          	ld	a5,-32(s0)
    1718:	4705                	li	a4,1
    171a:	d398                	sw	a4,32(a5)
        unsigned long new_stack_p = (unsigned long)current_thread->stack_p;
    171c:	fe043783          	ld	a5,-32(s0)
    1720:	6f9c                	ld	a5,24(a5)
    1722:	fcf43c23          	sd	a5,-40(s0)
        current_thread->thrdstop_context_id = -1;
    1726:	fe043783          	ld	a5,-32(s0)
    172a:	577d                	li	a4,-1
    172c:	df98                	sw	a4,56(a5)
        thrdstop(allocated_time, &(current_thread->thrdstop_context_id), switch_handler, (void *)allocated_time);
    172e:	00001797          	auipc	a5,0x1
    1732:	e6a78793          	addi	a5,a5,-406 # 2598 <allocated_time>
    1736:	639c                	ld	a5,0(a5)
    1738:	0007871b          	sext.w	a4,a5
    173c:	fe043783          	ld	a5,-32(s0)
    1740:	03878593          	addi	a1,a5,56
    1744:	00001797          	auipc	a5,0x1
    1748:	e5478793          	addi	a5,a5,-428 # 2598 <allocated_time>
    174c:	639c                	ld	a5,0(a5)
    174e:	86be                	mv	a3,a5
    1750:	00000617          	auipc	a2,0x0
    1754:	d4e60613          	addi	a2,a2,-690 # 149e <switch_handler>
    1758:	853a                	mv	a0,a4
    175a:	fffff097          	auipc	ra,0xfffff
    175e:	eaa080e7          	jalr	-342(ra) # 604 <thrdstop>
        if (current_thread->thrdstop_context_id < 0) {
    1762:	fe043783          	ld	a5,-32(s0)
    1766:	5f9c                	lw	a5,56(a5)
    1768:	0207d063          	bgez	a5,1788 <__dispatch+0x166>
            fprintf(2, "[ERROR] number of threads may exceed MAX_THRD_NUM\n");
    176c:	00001597          	auipc	a1,0x1
    1770:	d5c58593          	addi	a1,a1,-676 # 24c8 <schedule_dm+0x388>
    1774:	4509                	li	a0,2
    1776:	fffff097          	auipc	ra,0xfffff
    177a:	2dc080e7          	jalr	732(ra) # a52 <fprintf>
            exit(1);
    177e:	4505                	li	a0,1
    1780:	fffff097          	auipc	ra,0xfffff
    1784:	de4080e7          	jalr	-540(ra) # 564 <exit>
        }

        // set sp to stack pointer of current thread.
        asm volatile("mv sp, %0"
    1788:	fd843783          	ld	a5,-40(s0)
    178c:	813e                	mv	sp,a5
                     :
                     : "r"(new_stack_p));
        current_thread->fp(current_thread->arg);
    178e:	fe043783          	ld	a5,-32(s0)
    1792:	6398                	ld	a4,0(a5)
    1794:	fe043783          	ld	a5,-32(s0)
    1798:	679c                	ld	a5,8(a5)
    179a:	853e                	mv	a0,a5
    179c:	9702                	jalr	a4
    }
    thread_exit();
    179e:	00000097          	auipc	ra,0x0
    17a2:	ad0080e7          	jalr	-1328(ra) # 126e <thread_exit>
    17a6:	a011                	j	17aa <__dispatch+0x188>
        return;
    17a8:	0001                	nop
}
    17aa:	70a2                	ld	ra,40(sp)
    17ac:	7402                	ld	s0,32(sp)
    17ae:	6145                	addi	sp,sp,48
    17b0:	8082                	ret

00000000000017b2 <__schedule>:

void __schedule()
{
    17b2:	711d                	addi	sp,sp,-96
    17b4:	ec86                	sd	ra,88(sp)
    17b6:	e8a2                	sd	s0,80(sp)
    17b8:	1080                	addi	s0,sp,96
    struct threads_sched_args args = {
    17ba:	00001797          	auipc	a5,0x1
    17be:	dd678793          	addi	a5,a5,-554 # 2590 <threading_system_time>
    17c2:	439c                	lw	a5,0(a5)
    17c4:	fcf42c23          	sw	a5,-40(s0)
    17c8:	4789                	li	a5,2
    17ca:	fcf42e23          	sw	a5,-36(s0)
    17ce:	00001797          	auipc	a5,0x1
    17d2:	d7278793          	addi	a5,a5,-654 # 2540 <run_queue>
    17d6:	fef43023          	sd	a5,-32(s0)
    17da:	00001797          	auipc	a5,0x1
    17de:	d7678793          	addi	a5,a5,-650 # 2550 <release_queue>
    17e2:	fef43423          	sd	a5,-24(s0)
#ifdef THREAD_SCHEDULER_LST
    r = schedule_lst(args);
#endif

#ifdef THREAD_SCHEDULER_DM
    r = schedule_dm(args);
    17e6:	fd843783          	ld	a5,-40(s0)
    17ea:	faf43023          	sd	a5,-96(s0)
    17ee:	fe043783          	ld	a5,-32(s0)
    17f2:	faf43423          	sd	a5,-88(s0)
    17f6:	fe843783          	ld	a5,-24(s0)
    17fa:	faf43823          	sd	a5,-80(s0)
    17fe:	fa040793          	addi	a5,s0,-96
    1802:	853e                	mv	a0,a5
    1804:	00001097          	auipc	ra,0x1
    1808:	93c080e7          	jalr	-1732(ra) # 2140 <schedule_dm>
    180c:	872a                	mv	a4,a0
    180e:	87ae                	mv	a5,a1
    1810:	fce43423          	sd	a4,-56(s0)
    1814:	fcf43823          	sd	a5,-48(s0)
#endif

    current = r.scheduled_thread_list_member;
    1818:	fc843703          	ld	a4,-56(s0)
    181c:	00001797          	auipc	a5,0x1
    1820:	d6c78793          	addi	a5,a5,-660 # 2588 <current>
    1824:	e398                	sd	a4,0(a5)
    allocated_time = r.allocated_time;
    1826:	fd042783          	lw	a5,-48(s0)
    182a:	873e                	mv	a4,a5
    182c:	00001797          	auipc	a5,0x1
    1830:	d6c78793          	addi	a5,a5,-660 # 2598 <allocated_time>
    1834:	e398                	sd	a4,0(a5)
}
    1836:	0001                	nop
    1838:	60e6                	ld	ra,88(sp)
    183a:	6446                	ld	s0,80(sp)
    183c:	6125                	addi	sp,sp,96
    183e:	8082                	ret

0000000000001840 <back_to_main_handler>:

void back_to_main_handler(void *arg)
{
    1840:	1101                	addi	sp,sp,-32
    1842:	ec06                	sd	ra,24(sp)
    1844:	e822                	sd	s0,16(sp)
    1846:	1000                	addi	s0,sp,32
    1848:	fea43423          	sd	a0,-24(s0)
    sleeping = 0;
    184c:	00001797          	auipc	a5,0x1
    1850:	d4878793          	addi	a5,a5,-696 # 2594 <sleeping>
    1854:	0007a023          	sw	zero,0(a5)
    threading_system_time += (uint64)arg;
    1858:	fe843783          	ld	a5,-24(s0)
    185c:	0007871b          	sext.w	a4,a5
    1860:	00001797          	auipc	a5,0x1
    1864:	d3078793          	addi	a5,a5,-720 # 2590 <threading_system_time>
    1868:	439c                	lw	a5,0(a5)
    186a:	2781                	sext.w	a5,a5
    186c:	9fb9                	addw	a5,a5,a4
    186e:	2781                	sext.w	a5,a5
    1870:	0007871b          	sext.w	a4,a5
    1874:	00001797          	auipc	a5,0x1
    1878:	d1c78793          	addi	a5,a5,-740 # 2590 <threading_system_time>
    187c:	c398                	sw	a4,0(a5)
    thrdresume(main_thrd_id);
    187e:	00001797          	auipc	a5,0x1
    1882:	ce278793          	addi	a5,a5,-798 # 2560 <main_thrd_id>
    1886:	439c                	lw	a5,0(a5)
    1888:	853e                	mv	a0,a5
    188a:	fffff097          	auipc	ra,0xfffff
    188e:	d82080e7          	jalr	-638(ra) # 60c <thrdresume>
}
    1892:	0001                	nop
    1894:	60e2                	ld	ra,24(sp)
    1896:	6442                	ld	s0,16(sp)
    1898:	6105                	addi	sp,sp,32
    189a:	8082                	ret

000000000000189c <thread_start_threading>:

void thread_start_threading()
{
    189c:	1141                	addi	sp,sp,-16
    189e:	e406                	sd	ra,8(sp)
    18a0:	e022                	sd	s0,0(sp)
    18a2:	0800                	addi	s0,sp,16
    threading_system_time = 0;
    18a4:	00001797          	auipc	a5,0x1
    18a8:	cec78793          	addi	a5,a5,-788 # 2590 <threading_system_time>
    18ac:	0007a023          	sw	zero,0(a5)
    current = &run_queue;
    18b0:	00001797          	auipc	a5,0x1
    18b4:	cd878793          	addi	a5,a5,-808 # 2588 <current>
    18b8:	00001717          	auipc	a4,0x1
    18bc:	c8870713          	addi	a4,a4,-888 # 2540 <run_queue>
    18c0:	e398                	sd	a4,0(a5)

    // call thrdstop just for obtain an ID
    thrdstop(1000, &main_thrd_id, back_to_main_handler, (void *)0);
    18c2:	4681                	li	a3,0
    18c4:	00000617          	auipc	a2,0x0
    18c8:	f7c60613          	addi	a2,a2,-132 # 1840 <back_to_main_handler>
    18cc:	00001597          	auipc	a1,0x1
    18d0:	c9458593          	addi	a1,a1,-876 # 2560 <main_thrd_id>
    18d4:	3e800513          	li	a0,1000
    18d8:	fffff097          	auipc	ra,0xfffff
    18dc:	d2c080e7          	jalr	-724(ra) # 604 <thrdstop>
    cancelthrdstop(main_thrd_id, 0);
    18e0:	00001797          	auipc	a5,0x1
    18e4:	c8078793          	addi	a5,a5,-896 # 2560 <main_thrd_id>
    18e8:	439c                	lw	a5,0(a5)
    18ea:	4581                	li	a1,0
    18ec:	853e                	mv	a0,a5
    18ee:	fffff097          	auipc	ra,0xfffff
    18f2:	d26080e7          	jalr	-730(ra) # 614 <cancelthrdstop>

    while (!list_empty(&run_queue) || !list_empty(&release_queue)) {
    18f6:	a0c9                	j	19b8 <thread_start_threading+0x11c>
        __release();
    18f8:	00000097          	auipc	ra,0x0
    18fc:	816080e7          	jalr	-2026(ra) # 110e <__release>
        __schedule();
    1900:	00000097          	auipc	ra,0x0
    1904:	eb2080e7          	jalr	-334(ra) # 17b2 <__schedule>
        cancelthrdstop(main_thrd_id, 0);
    1908:	00001797          	auipc	a5,0x1
    190c:	c5878793          	addi	a5,a5,-936 # 2560 <main_thrd_id>
    1910:	439c                	lw	a5,0(a5)
    1912:	4581                	li	a1,0
    1914:	853e                	mv	a0,a5
    1916:	fffff097          	auipc	ra,0xfffff
    191a:	cfe080e7          	jalr	-770(ra) # 614 <cancelthrdstop>
        __dispatch();
    191e:	00000097          	auipc	ra,0x0
    1922:	d04080e7          	jalr	-764(ra) # 1622 <__dispatch>

        if (list_empty(&run_queue) && list_empty(&release_queue)) {
    1926:	00001517          	auipc	a0,0x1
    192a:	c1a50513          	addi	a0,a0,-998 # 2540 <run_queue>
    192e:	fffff097          	auipc	ra,0xfffff
    1932:	60a080e7          	jalr	1546(ra) # f38 <list_empty>
    1936:	87aa                	mv	a5,a0
    1938:	cb99                	beqz	a5,194e <thread_start_threading+0xb2>
    193a:	00001517          	auipc	a0,0x1
    193e:	c1650513          	addi	a0,a0,-1002 # 2550 <release_queue>
    1942:	fffff097          	auipc	ra,0xfffff
    1946:	5f6080e7          	jalr	1526(ra) # f38 <list_empty>
    194a:	87aa                	mv	a5,a0
    194c:	ebd9                	bnez	a5,19e2 <thread_start_threading+0x146>
            break;
        }

        // no thread in run_queue, release_queue not empty
        printf("run_queue is empty, sleep for %d ticks\n", allocated_time);
    194e:	00001797          	auipc	a5,0x1
    1952:	c4a78793          	addi	a5,a5,-950 # 2598 <allocated_time>
    1956:	639c                	ld	a5,0(a5)
    1958:	85be                	mv	a1,a5
    195a:	00001517          	auipc	a0,0x1
    195e:	ba650513          	addi	a0,a0,-1114 # 2500 <schedule_dm+0x3c0>
    1962:	fffff097          	auipc	ra,0xfffff
    1966:	148080e7          	jalr	328(ra) # aaa <printf>
        sleeping = 1;
    196a:	00001797          	auipc	a5,0x1
    196e:	c2a78793          	addi	a5,a5,-982 # 2594 <sleeping>
    1972:	4705                	li	a4,1
    1974:	c398                	sw	a4,0(a5)
        thrdstop(allocated_time, &main_thrd_id, back_to_main_handler, (void *)allocated_time);
    1976:	00001797          	auipc	a5,0x1
    197a:	c2278793          	addi	a5,a5,-990 # 2598 <allocated_time>
    197e:	639c                	ld	a5,0(a5)
    1980:	0007871b          	sext.w	a4,a5
    1984:	00001797          	auipc	a5,0x1
    1988:	c1478793          	addi	a5,a5,-1004 # 2598 <allocated_time>
    198c:	639c                	ld	a5,0(a5)
    198e:	86be                	mv	a3,a5
    1990:	00000617          	auipc	a2,0x0
    1994:	eb060613          	addi	a2,a2,-336 # 1840 <back_to_main_handler>
    1998:	00001597          	auipc	a1,0x1
    199c:	bc858593          	addi	a1,a1,-1080 # 2560 <main_thrd_id>
    19a0:	853a                	mv	a0,a4
    19a2:	fffff097          	auipc	ra,0xfffff
    19a6:	c62080e7          	jalr	-926(ra) # 604 <thrdstop>
        while (sleeping) {
    19aa:	0001                	nop
    19ac:	00001797          	auipc	a5,0x1
    19b0:	be878793          	addi	a5,a5,-1048 # 2594 <sleeping>
    19b4:	439c                	lw	a5,0(a5)
    19b6:	fbfd                	bnez	a5,19ac <thread_start_threading+0x110>
    while (!list_empty(&run_queue) || !list_empty(&release_queue)) {
    19b8:	00001517          	auipc	a0,0x1
    19bc:	b8850513          	addi	a0,a0,-1144 # 2540 <run_queue>
    19c0:	fffff097          	auipc	ra,0xfffff
    19c4:	578080e7          	jalr	1400(ra) # f38 <list_empty>
    19c8:	87aa                	mv	a5,a0
    19ca:	d79d                	beqz	a5,18f8 <thread_start_threading+0x5c>
    19cc:	00001517          	auipc	a0,0x1
    19d0:	b8450513          	addi	a0,a0,-1148 # 2550 <release_queue>
    19d4:	fffff097          	auipc	ra,0xfffff
    19d8:	564080e7          	jalr	1380(ra) # f38 <list_empty>
    19dc:	87aa                	mv	a5,a0
    19de:	df89                	beqz	a5,18f8 <thread_start_threading+0x5c>
            // zzz...
        }
    }
}
    19e0:	a011                	j	19e4 <thread_start_threading+0x148>
            break;
    19e2:	0001                	nop
}
    19e4:	0001                	nop
    19e6:	60a2                	ld	ra,8(sp)
    19e8:	6402                	ld	s0,0(sp)
    19ea:	0141                	addi	sp,sp,16
    19ec:	8082                	ret

00000000000019ee <schedule_default>:
#define NULL 0
#define min(a, b) ((a) < (b) ? (a) : (b))

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
    19ee:	715d                	addi	sp,sp,-80
    19f0:	e4a2                	sd	s0,72(sp)
    19f2:	e0a6                	sd	s1,64(sp)
    19f4:	0880                	addi	s0,sp,80
    19f6:	84aa                	mv	s1,a0
    struct thread *thread_with_smallest_id = NULL;
    19f8:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
    19fc:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, args.run_queue, thread_list)
    1a00:	649c                	ld	a5,8(s1)
    1a02:	639c                	ld	a5,0(a5)
    1a04:	fcf43c23          	sd	a5,-40(s0)
    1a08:	fd843783          	ld	a5,-40(s0)
    1a0c:	fd878793          	addi	a5,a5,-40
    1a10:	fef43023          	sd	a5,-32(s0)
    1a14:	a81d                	j	1a4a <schedule_default+0x5c>
    {
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID)
    1a16:	fe843783          	ld	a5,-24(s0)
    1a1a:	cb89                	beqz	a5,1a2c <schedule_default+0x3e>
    1a1c:	fe043783          	ld	a5,-32(s0)
    1a20:	5fd8                	lw	a4,60(a5)
    1a22:	fe843783          	ld	a5,-24(s0)
    1a26:	5fdc                	lw	a5,60(a5)
    1a28:	00f75663          	bge	a4,a5,1a34 <schedule_default+0x46>
            thread_with_smallest_id = th;
    1a2c:	fe043783          	ld	a5,-32(s0)
    1a30:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list)
    1a34:	fe043783          	ld	a5,-32(s0)
    1a38:	779c                	ld	a5,40(a5)
    1a3a:	fcf43823          	sd	a5,-48(s0)
    1a3e:	fd043783          	ld	a5,-48(s0)
    1a42:	fd878793          	addi	a5,a5,-40
    1a46:	fef43023          	sd	a5,-32(s0)
    1a4a:	fe043783          	ld	a5,-32(s0)
    1a4e:	02878713          	addi	a4,a5,40
    1a52:	649c                	ld	a5,8(s1)
    1a54:	fcf711e3          	bne	a4,a5,1a16 <schedule_default+0x28>
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL)
    1a58:	fe843783          	ld	a5,-24(s0)
    1a5c:	cf89                	beqz	a5,1a76 <schedule_default+0x88>
    {
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
    1a5e:	fe843783          	ld	a5,-24(s0)
    1a62:	02878793          	addi	a5,a5,40
    1a66:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = thread_with_smallest_id->remaining_time;
    1a6a:	fe843783          	ld	a5,-24(s0)
    1a6e:	4fbc                	lw	a5,88(a5)
    1a70:	faf42c23          	sw	a5,-72(s0)
    1a74:	a039                	j	1a82 <schedule_default+0x94>
    }
    else
    {
        r.scheduled_thread_list_member = args.run_queue;
    1a76:	649c                	ld	a5,8(s1)
    1a78:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = 1;
    1a7c:	4785                	li	a5,1
    1a7e:	faf42c23          	sw	a5,-72(s0)
    }

    return r;
    1a82:	fb043783          	ld	a5,-80(s0)
    1a86:	fcf43023          	sd	a5,-64(s0)
    1a8a:	fb843783          	ld	a5,-72(s0)
    1a8e:	fcf43423          	sd	a5,-56(s0)
    1a92:	4701                	li	a4,0
    1a94:	fc043703          	ld	a4,-64(s0)
    1a98:	4781                	li	a5,0
    1a9a:	fc843783          	ld	a5,-56(s0)
    1a9e:	863a                	mv	a2,a4
    1aa0:	86be                	mv	a3,a5
    1aa2:	8732                	mv	a4,a2
    1aa4:	87b6                	mv	a5,a3
}
    1aa6:	853a                	mv	a0,a4
    1aa8:	85be                	mv	a1,a5
    1aaa:	6426                	ld	s0,72(sp)
    1aac:	6486                	ld	s1,64(sp)
    1aae:	6161                	addi	sp,sp,80
    1ab0:	8082                	ret

0000000000001ab2 <schedule_wrr>:

/* MP3 Part 1 - Non-Real-Time Scheduling */
/* Weighted-Round-Robin Scheduling */
struct threads_sched_result schedule_wrr(struct threads_sched_args args)
{
    1ab2:	7119                	addi	sp,sp,-128
    1ab4:	fca2                	sd	s0,120(sp)
    1ab6:	f8a6                	sd	s1,112(sp)
    1ab8:	0100                	addi	s0,sp,128
    1aba:	84aa                	mv	s1,a0
    struct thread *next_thread = NULL;
    1abc:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
    1ac0:	fe043023          	sd	zero,-32(s0)
    // printf("\nrun_queue: \n");
    list_for_each_entry(th, args.run_queue, thread_list)
    1ac4:	649c                	ld	a5,8(s1)
    1ac6:	639c                	ld	a5,0(a5)
    1ac8:	fcf43423          	sd	a5,-56(s0)
    1acc:	fc843783          	ld	a5,-56(s0)
    1ad0:	fd878793          	addi	a5,a5,-40
    1ad4:	fef43023          	sd	a5,-32(s0)
    1ad8:	a01d                	j	1afe <schedule_wrr+0x4c>
    {
        // printf("th->ID: %d; ", th->ID);
        // printf("th->arrival_time: %d\n", th->current_deadline - th->deadline);
        // if (current_thread == NULL || (th->remaining_time == th->processing_time && th->ID < current_thread->ID))
        //     current_thread = th;
        if (next_thread == NULL)
    1ada:	fe843783          	ld	a5,-24(s0)
    1ade:	e789                	bnez	a5,1ae8 <schedule_wrr+0x36>
            next_thread = th;
    1ae0:	fe043783          	ld	a5,-32(s0)
    1ae4:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list)
    1ae8:	fe043783          	ld	a5,-32(s0)
    1aec:	779c                	ld	a5,40(a5)
    1aee:	faf43423          	sd	a5,-88(s0)
    1af2:	fa843783          	ld	a5,-88(s0)
    1af6:	fd878793          	addi	a5,a5,-40
    1afa:	fef43023          	sd	a5,-32(s0)
    1afe:	fe043783          	ld	a5,-32(s0)
    1b02:	02878713          	addi	a4,a5,40
    1b06:	649c                	ld	a5,8(s1)
    1b08:	fcf719e3          	bne	a4,a5,1ada <schedule_wrr+0x28>
    }

    struct threads_sched_result r;
    // TODO: implement the weighted round-robin scheduling algorithm
    int weighted_time = args.time_quantum * next_thread->weight;
    1b0c:	40d8                	lw	a4,4(s1)
    1b0e:	fe843783          	ld	a5,-24(s0)
    1b12:	47bc                	lw	a5,72(a5)
    1b14:	02f707bb          	mulw	a5,a4,a5
    1b18:	fcf42223          	sw	a5,-60(s0)
    int remaining_time = next_thread->remaining_time;
    1b1c:	fe843783          	ld	a5,-24(s0)
    1b20:	4fbc                	lw	a5,88(a5)
    1b22:	fcf42023          	sw	a5,-64(s0)
    if (next_thread != NULL)
    1b26:	fe843783          	ld	a5,-24(s0)
    1b2a:	c795                	beqz	a5,1b56 <schedule_wrr+0xa4>
    {
        r.scheduled_thread_list_member = &next_thread->thread_list;
    1b2c:	fe843783          	ld	a5,-24(s0)
    1b30:	02878793          	addi	a5,a5,40
    1b34:	f8f43423          	sd	a5,-120(s0)
        r.allocated_time = min(weighted_time, remaining_time);
    1b38:	fc442503          	lw	a0,-60(s0)
    1b3c:	fc042783          	lw	a5,-64(s0)
    1b40:	0007859b          	sext.w	a1,a5
    1b44:	0005071b          	sext.w	a4,a0
    1b48:	00b75363          	bge	a4,a1,1b4e <schedule_wrr+0x9c>
    1b4c:	87aa                	mv	a5,a0
    1b4e:	2781                	sext.w	a5,a5
    1b50:	f8f42823          	sw	a5,-112(s0)
    1b54:	a051                	j	1bd8 <schedule_wrr+0x126>
    }
    else
    {
        struct release_queue_entry *next_rqe = NULL;
    1b56:	fc043c23          	sd	zero,-40(s0)
        struct release_queue_entry *rqe = NULL;
    1b5a:	fc043823          	sd	zero,-48(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list)
    1b5e:	689c                	ld	a5,16(s1)
    1b60:	639c                	ld	a5,0(a5)
    1b62:	faf43c23          	sd	a5,-72(s0)
    1b66:	fb843783          	ld	a5,-72(s0)
    1b6a:	17e1                	addi	a5,a5,-8
    1b6c:	fcf43823          	sd	a5,-48(s0)
    1b70:	a815                	j	1ba4 <schedule_wrr+0xf2>
        {
            if (rqe == NULL || rqe->release_time < next_rqe->release_time)
    1b72:	fd043783          	ld	a5,-48(s0)
    1b76:	cb89                	beqz	a5,1b88 <schedule_wrr+0xd6>
    1b78:	fd043783          	ld	a5,-48(s0)
    1b7c:	4f98                	lw	a4,24(a5)
    1b7e:	fd843783          	ld	a5,-40(s0)
    1b82:	4f9c                	lw	a5,24(a5)
    1b84:	00f75663          	bge	a4,a5,1b90 <schedule_wrr+0xde>
                next_rqe = rqe;
    1b88:	fd043783          	ld	a5,-48(s0)
    1b8c:	fcf43c23          	sd	a5,-40(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list)
    1b90:	fd043783          	ld	a5,-48(s0)
    1b94:	679c                	ld	a5,8(a5)
    1b96:	faf43823          	sd	a5,-80(s0)
    1b9a:	fb043783          	ld	a5,-80(s0)
    1b9e:	17e1                	addi	a5,a5,-8
    1ba0:	fcf43823          	sd	a5,-48(s0)
    1ba4:	fd043783          	ld	a5,-48(s0)
    1ba8:	00878713          	addi	a4,a5,8
    1bac:	689c                	ld	a5,16(s1)
    1bae:	fcf712e3          	bne	a4,a5,1b72 <schedule_wrr+0xc0>
        }

        r.scheduled_thread_list_member = args.run_queue;
    1bb2:	649c                	ld	a5,8(s1)
    1bb4:	f8f43423          	sd	a5,-120(s0)
        if (next_rqe != NULL)
    1bb8:	fd843783          	ld	a5,-40(s0)
    1bbc:	cb99                	beqz	a5,1bd2 <schedule_wrr+0x120>
            r.allocated_time = next_rqe->release_time - args.current_time;
    1bbe:	fd843783          	ld	a5,-40(s0)
    1bc2:	4f98                	lw	a4,24(a5)
    1bc4:	409c                	lw	a5,0(s1)
    1bc6:	40f707bb          	subw	a5,a4,a5
    1bca:	2781                	sext.w	a5,a5
    1bcc:	f8f42823          	sw	a5,-112(s0)
    1bd0:	a021                	j	1bd8 <schedule_wrr+0x126>
        else
            r.allocated_time = 1;
    1bd2:	4785                	li	a5,1
    1bd4:	f8f42823          	sw	a5,-112(s0)
    }

    return r;
    1bd8:	f8843783          	ld	a5,-120(s0)
    1bdc:	f8f43c23          	sd	a5,-104(s0)
    1be0:	f9043783          	ld	a5,-112(s0)
    1be4:	faf43023          	sd	a5,-96(s0)
    1be8:	4701                	li	a4,0
    1bea:	f9843703          	ld	a4,-104(s0)
    1bee:	4781                	li	a5,0
    1bf0:	fa043783          	ld	a5,-96(s0)
    1bf4:	863a                	mv	a2,a4
    1bf6:	86be                	mv	a3,a5
    1bf8:	8732                	mv	a4,a2
    1bfa:	87b6                	mv	a5,a3
}
    1bfc:	853a                	mv	a0,a4
    1bfe:	85be                	mv	a1,a5
    1c00:	7466                	ld	s0,120(sp)
    1c02:	74c6                	ld	s1,112(sp)
    1c04:	6109                	addi	sp,sp,128
    1c06:	8082                	ret

0000000000001c08 <schedule_sjf>:

/* Shortest-Job-First Scheduling */
struct threads_sched_result schedule_sjf(struct threads_sched_args args)
{
    1c08:	7175                	addi	sp,sp,-144
    1c0a:	e522                	sd	s0,136(sp)
    1c0c:	e126                	sd	s1,128(sp)
    1c0e:	0900                	addi	s0,sp,144
    1c10:	84aa                	mv	s1,a0
    struct thread *shortest_job = NULL;
    1c12:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
    1c16:	fe043023          	sd	zero,-32(s0)
    struct release_queue_entry *rqe = NULL;
    1c1a:	fc043c23          	sd	zero,-40(s0)
    int smallest_release_time = 0;
    1c1e:	fc042a23          	sw	zero,-44(s0)
    int allocated_time = 0;
    1c22:	fc042823          	sw	zero,-48(s0)

    // printf("\n>> run_queue: \n");
    list_for_each_entry(th, args.run_queue, thread_list)
    1c26:	649c                	ld	a5,8(s1)
    1c28:	639c                	ld	a5,0(a5)
    1c2a:	faf43c23          	sd	a5,-72(s0)
    1c2e:	fb843783          	ld	a5,-72(s0)
    1c32:	fd878793          	addi	a5,a5,-40
    1c36:	fef43023          	sd	a5,-32(s0)
    1c3a:	a899                	j	1c90 <schedule_sjf+0x88>
        // printf("th->arrival_time: %d; ", th->current_deadline - th->deadline);
        // printf("th->remaining_time: %d; ", th->remaining_time);
        // printf("th->finish time: %d\n", args.current_time + th->remaining_time);

        // Find the shortest job in the run queue
        if (shortest_job == NULL ||
    1c3c:	fe843783          	ld	a5,-24(s0)
    1c40:	cb8d                	beqz	a5,1c72 <schedule_sjf+0x6a>
            th->remaining_time < shortest_job->remaining_time ||
    1c42:	fe043783          	ld	a5,-32(s0)
    1c46:	4fb8                	lw	a4,88(a5)
    1c48:	fe843783          	ld	a5,-24(s0)
    1c4c:	4fbc                	lw	a5,88(a5)
        if (shortest_job == NULL ||
    1c4e:	02f74263          	blt	a4,a5,1c72 <schedule_sjf+0x6a>
            (th->remaining_time == shortest_job->remaining_time && th->ID < shortest_job->ID))
    1c52:	fe043783          	ld	a5,-32(s0)
    1c56:	4fb8                	lw	a4,88(a5)
    1c58:	fe843783          	ld	a5,-24(s0)
    1c5c:	4fbc                	lw	a5,88(a5)
            th->remaining_time < shortest_job->remaining_time ||
    1c5e:	00f71e63          	bne	a4,a5,1c7a <schedule_sjf+0x72>
            (th->remaining_time == shortest_job->remaining_time && th->ID < shortest_job->ID))
    1c62:	fe043783          	ld	a5,-32(s0)
    1c66:	5fd8                	lw	a4,60(a5)
    1c68:	fe843783          	ld	a5,-24(s0)
    1c6c:	5fdc                	lw	a5,60(a5)
    1c6e:	00f75663          	bge	a4,a5,1c7a <schedule_sjf+0x72>
            shortest_job = th;
    1c72:	fe043783          	ld	a5,-32(s0)
    1c76:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list)
    1c7a:	fe043783          	ld	a5,-32(s0)
    1c7e:	779c                	ld	a5,40(a5)
    1c80:	f8f43823          	sd	a5,-112(s0)
    1c84:	f9043783          	ld	a5,-112(s0)
    1c88:	fd878793          	addi	a5,a5,-40
    1c8c:	fef43023          	sd	a5,-32(s0)
    1c90:	fe043783          	ld	a5,-32(s0)
    1c94:	02878713          	addi	a4,a5,40
    1c98:	649c                	ld	a5,8(s1)
    1c9a:	faf711e3          	bne	a4,a5,1c3c <schedule_sjf+0x34>
    }
    allocated_time = shortest_job->remaining_time;
    1c9e:	fe843783          	ld	a5,-24(s0)
    1ca2:	4fbc                	lw	a5,88(a5)
    1ca4:	fcf42823          	sw	a5,-48(s0)

    // printf("\n>> release_queue: \n");
    list_for_each_entry(rqe, args.release_queue, thread_list)
    1ca8:	689c                	ld	a5,16(s1)
    1caa:	639c                	ld	a5,0(a5)
    1cac:	faf43823          	sd	a5,-80(s0)
    1cb0:	fb043783          	ld	a5,-80(s0)
    1cb4:	17e1                	addi	a5,a5,-8
    1cb6:	fcf43c23          	sd	a5,-40(s0)
    1cba:	a885                	j	1d2a <schedule_sjf+0x122>
        // printf("rqe->release_time: %d; ", rqe->release_time);
        // printf("rqe->thrd->processing_time: %d\n", rqe->thrd->processing_time);

        // If any job in the release queue has a shorter processing time than the shortest job
        // and the job is released before the shortest job finishes
        if (rqe->thrd->processing_time < shortest_job->remaining_time &&            // shorter job
    1cbc:	fd843783          	ld	a5,-40(s0)
    1cc0:	639c                	ld	a5,0(a5)
    1cc2:	43f8                	lw	a4,68(a5)
    1cc4:	fe843783          	ld	a5,-24(s0)
    1cc8:	4fbc                	lw	a5,88(a5)
    1cca:	04f75663          	bge	a4,a5,1d16 <schedule_sjf+0x10e>
            rqe->release_time < (args.current_time + shortest_job->remaining_time)) // released before the shortest job finishes
    1cce:	fd843783          	ld	a5,-40(s0)
    1cd2:	4f8c                	lw	a1,24(a5)
    1cd4:	4098                	lw	a4,0(s1)
    1cd6:	fe843783          	ld	a5,-24(s0)
    1cda:	4fbc                	lw	a5,88(a5)
    1cdc:	9fb9                	addw	a5,a5,a4
    1cde:	2781                	sext.w	a5,a5
        if (rqe->thrd->processing_time < shortest_job->remaining_time &&            // shorter job
    1ce0:	872e                	mv	a4,a1
    1ce2:	02f75a63          	bge	a4,a5,1d16 <schedule_sjf+0x10e>
        {
            if (smallest_release_time == 0 || rqe->release_time < smallest_release_time)
    1ce6:	fd442783          	lw	a5,-44(s0)
    1cea:	2781                	sext.w	a5,a5
    1cec:	cb89                	beqz	a5,1cfe <schedule_sjf+0xf6>
    1cee:	fd843783          	ld	a5,-40(s0)
    1cf2:	4f98                	lw	a4,24(a5)
    1cf4:	fd442783          	lw	a5,-44(s0)
    1cf8:	2781                	sext.w	a5,a5
    1cfa:	00f75e63          	bge	a4,a5,1d16 <schedule_sjf+0x10e>
            {
                smallest_release_time = rqe->release_time;
    1cfe:	fd843783          	ld	a5,-40(s0)
    1d02:	4f9c                	lw	a5,24(a5)
    1d04:	fcf42a23          	sw	a5,-44(s0)
                allocated_time = smallest_release_time - args.current_time;
    1d08:	409c                	lw	a5,0(s1)
    1d0a:	fd442703          	lw	a4,-44(s0)
    1d0e:	40f707bb          	subw	a5,a4,a5
    1d12:	fcf42823          	sw	a5,-48(s0)
    list_for_each_entry(rqe, args.release_queue, thread_list)
    1d16:	fd843783          	ld	a5,-40(s0)
    1d1a:	679c                	ld	a5,8(a5)
    1d1c:	f8f43c23          	sd	a5,-104(s0)
    1d20:	f9843783          	ld	a5,-104(s0)
    1d24:	17e1                	addi	a5,a5,-8
    1d26:	fcf43c23          	sd	a5,-40(s0)
    1d2a:	fd843783          	ld	a5,-40(s0)
    1d2e:	00878713          	addi	a4,a5,8
    1d32:	689c                	ld	a5,16(s1)
    1d34:	f8f714e3          	bne	a4,a5,1cbc <schedule_sjf+0xb4>
        }
    }

    struct threads_sched_result r;
    // TODO: implement the shortest-job-first scheduling algorithm
    if (shortest_job != NULL)
    1d38:	fe843783          	ld	a5,-24(s0)
    1d3c:	cf81                	beqz	a5,1d54 <schedule_sjf+0x14c>
    {
        r.scheduled_thread_list_member = &shortest_job->thread_list;
    1d3e:	fe843783          	ld	a5,-24(s0)
    1d42:	02878793          	addi	a5,a5,40
    1d46:	f6f43823          	sd	a5,-144(s0)
        r.allocated_time = allocated_time;
    1d4a:	fd042783          	lw	a5,-48(s0)
    1d4e:	f6f42c23          	sw	a5,-136(s0)
    1d52:	a051                	j	1dd6 <schedule_sjf+0x1ce>
    }
    else
    {
        struct release_queue_entry *next_rqe = NULL;
    1d54:	fc043423          	sd	zero,-56(s0)
        struct release_queue_entry *rqe = NULL;
    1d58:	fc043023          	sd	zero,-64(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list)
    1d5c:	689c                	ld	a5,16(s1)
    1d5e:	639c                	ld	a5,0(a5)
    1d60:	faf43423          	sd	a5,-88(s0)
    1d64:	fa843783          	ld	a5,-88(s0)
    1d68:	17e1                	addi	a5,a5,-8
    1d6a:	fcf43023          	sd	a5,-64(s0)
    1d6e:	a815                	j	1da2 <schedule_sjf+0x19a>
        {
            if (rqe == NULL || rqe->release_time < next_rqe->release_time)
    1d70:	fc043783          	ld	a5,-64(s0)
    1d74:	cb89                	beqz	a5,1d86 <schedule_sjf+0x17e>
    1d76:	fc043783          	ld	a5,-64(s0)
    1d7a:	4f98                	lw	a4,24(a5)
    1d7c:	fc843783          	ld	a5,-56(s0)
    1d80:	4f9c                	lw	a5,24(a5)
    1d82:	00f75663          	bge	a4,a5,1d8e <schedule_sjf+0x186>
                next_rqe = rqe;
    1d86:	fc043783          	ld	a5,-64(s0)
    1d8a:	fcf43423          	sd	a5,-56(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list)
    1d8e:	fc043783          	ld	a5,-64(s0)
    1d92:	679c                	ld	a5,8(a5)
    1d94:	faf43023          	sd	a5,-96(s0)
    1d98:	fa043783          	ld	a5,-96(s0)
    1d9c:	17e1                	addi	a5,a5,-8
    1d9e:	fcf43023          	sd	a5,-64(s0)
    1da2:	fc043783          	ld	a5,-64(s0)
    1da6:	00878713          	addi	a4,a5,8
    1daa:	689c                	ld	a5,16(s1)
    1dac:	fcf712e3          	bne	a4,a5,1d70 <schedule_sjf+0x168>
        }

        r.scheduled_thread_list_member = args.run_queue;
    1db0:	649c                	ld	a5,8(s1)
    1db2:	f6f43823          	sd	a5,-144(s0)
        if (next_rqe != NULL)
    1db6:	fc843783          	ld	a5,-56(s0)
    1dba:	cb99                	beqz	a5,1dd0 <schedule_sjf+0x1c8>
            r.allocated_time = next_rqe->release_time - args.current_time;
    1dbc:	fc843783          	ld	a5,-56(s0)
    1dc0:	4f98                	lw	a4,24(a5)
    1dc2:	409c                	lw	a5,0(s1)
    1dc4:	40f707bb          	subw	a5,a4,a5
    1dc8:	2781                	sext.w	a5,a5
    1dca:	f6f42c23          	sw	a5,-136(s0)
    1dce:	a021                	j	1dd6 <schedule_sjf+0x1ce>
        else
            r.allocated_time = 1;
    1dd0:	4785                	li	a5,1
    1dd2:	f6f42c23          	sw	a5,-136(s0)
    }

    return r;
    1dd6:	f7043783          	ld	a5,-144(s0)
    1dda:	f8f43023          	sd	a5,-128(s0)
    1dde:	f7843783          	ld	a5,-136(s0)
    1de2:	f8f43423          	sd	a5,-120(s0)
    1de6:	4701                	li	a4,0
    1de8:	f8043703          	ld	a4,-128(s0)
    1dec:	4781                	li	a5,0
    1dee:	f8843783          	ld	a5,-120(s0)
    1df2:	863a                	mv	a2,a4
    1df4:	86be                	mv	a3,a5
    1df6:	8732                	mv	a4,a2
    1df8:	87b6                	mv	a5,a3
}
    1dfa:	853a                	mv	a0,a4
    1dfc:	85be                	mv	a1,a5
    1dfe:	642a                	ld	s0,136(sp)
    1e00:	648a                	ld	s1,128(sp)
    1e02:	6149                	addi	sp,sp,144
    1e04:	8082                	ret

0000000000001e06 <schedule_lst>:

/* MP3 Part 2 - Real-Time Scheduling*/
/* Least-Slack-Time Scheduling */
struct threads_sched_result schedule_lst(struct threads_sched_args args)
{
    1e06:	7135                	addi	sp,sp,-160
    1e08:	ed22                	sd	s0,152(sp)
    1e0a:	e926                	sd	s1,144(sp)
    1e0c:	1100                	addi	s0,sp,160
    1e0e:	84aa                	mv	s1,a0
    struct thread *least_slack_time_thread = NULL;
    1e10:	fe043423          	sd	zero,-24(s0)
    struct thread *miss_deadline_thread = NULL;
    1e14:	fe043023          	sd	zero,-32(s0)
    struct thread *th = NULL;
    1e18:	fc043c23          	sd	zero,-40(s0)
    struct release_queue_entry *rqe = NULL;
    1e1c:	fc043823          	sd	zero,-48(s0)
    int allocated_time = 0;
    1e20:	fc042623          	sw	zero,-52(s0)
    int smallest_release_time = 0;
    1e24:	fc042423          	sw	zero,-56(s0)
#define slack_time(th) (th->current_deadline - args.current_time - th->remaining_time)
#define release_queue_slack_time(th) (th->deadline - th->processing_time)
    // printf("\n>> run_queue: \n");
    list_for_each_entry(th, args.run_queue, thread_list)
    1e28:	649c                	ld	a5,8(s1)
    1e2a:	639c                	ld	a5,0(a5)
    1e2c:	faf43823          	sd	a5,-80(s0)
    1e30:	fb043783          	ld	a5,-80(s0)
    1e34:	fd878793          	addi	a5,a5,-40
    1e38:	fcf43c23          	sd	a5,-40(s0)
    1e3c:	a0dd                	j	1f22 <schedule_lst+0x11c>
    {
        // printf("th->ID: %d; ", th->ID);
        // printf("th->slack_time: %d\n", slack_time(th));
        if (args.current_time >= th->current_deadline &&
    1e3e:	4098                	lw	a4,0(s1)
    1e40:	fd843783          	ld	a5,-40(s0)
    1e44:	4ffc                	lw	a5,92(a5)
    1e46:	02f74163          	blt	a4,a5,1e68 <schedule_lst+0x62>
    1e4a:	fe043783          	ld	a5,-32(s0)
    1e4e:	cb89                	beqz	a5,1e60 <schedule_lst+0x5a>
            (miss_deadline_thread == NULL || th->ID < miss_deadline_thread->ID))
    1e50:	fd843783          	ld	a5,-40(s0)
    1e54:	5fd8                	lw	a4,60(a5)
    1e56:	fe043783          	ld	a5,-32(s0)
    1e5a:	5fdc                	lw	a5,60(a5)
    1e5c:	00f75663          	bge	a4,a5,1e68 <schedule_lst+0x62>
        {
            miss_deadline_thread = th;
    1e60:	fd843783          	ld	a5,-40(s0)
    1e64:	fef43023          	sd	a5,-32(s0)
        }

        if (miss_deadline_thread == NULL && (least_slack_time_thread == NULL ||
    1e68:	fe043783          	ld	a5,-32(s0)
    1e6c:	e3c5                	bnez	a5,1f0c <schedule_lst+0x106>
    1e6e:	fe843783          	ld	a5,-24(s0)
    1e72:	cbc9                	beqz	a5,1f04 <schedule_lst+0xfe>
                                             slack_time(th) < slack_time(least_slack_time_thread) ||
    1e74:	fd843783          	ld	a5,-40(s0)
    1e78:	4ff8                	lw	a4,92(a5)
    1e7a:	409c                	lw	a5,0(s1)
    1e7c:	40f707bb          	subw	a5,a4,a5
    1e80:	0007871b          	sext.w	a4,a5
    1e84:	fd843783          	ld	a5,-40(s0)
    1e88:	4fbc                	lw	a5,88(a5)
    1e8a:	40f707bb          	subw	a5,a4,a5
    1e8e:	0007859b          	sext.w	a1,a5
    1e92:	fe843783          	ld	a5,-24(s0)
    1e96:	4ff8                	lw	a4,92(a5)
    1e98:	409c                	lw	a5,0(s1)
    1e9a:	40f707bb          	subw	a5,a4,a5
    1e9e:	0007871b          	sext.w	a4,a5
    1ea2:	fe843783          	ld	a5,-24(s0)
    1ea6:	4fbc                	lw	a5,88(a5)
    1ea8:	40f707bb          	subw	a5,a4,a5
    1eac:	2781                	sext.w	a5,a5
        if (miss_deadline_thread == NULL && (least_slack_time_thread == NULL ||
    1eae:	872e                	mv	a4,a1
    1eb0:	04f74a63          	blt	a4,a5,1f04 <schedule_lst+0xfe>
                                             (slack_time(th) == slack_time(least_slack_time_thread) && th->ID < least_slack_time_thread->ID)))
    1eb4:	fd843783          	ld	a5,-40(s0)
    1eb8:	4ff8                	lw	a4,92(a5)
    1eba:	409c                	lw	a5,0(s1)
    1ebc:	40f707bb          	subw	a5,a4,a5
    1ec0:	0007871b          	sext.w	a4,a5
    1ec4:	fd843783          	ld	a5,-40(s0)
    1ec8:	4fbc                	lw	a5,88(a5)
    1eca:	40f707bb          	subw	a5,a4,a5
    1ece:	0007859b          	sext.w	a1,a5
    1ed2:	fe843783          	ld	a5,-24(s0)
    1ed6:	4ff8                	lw	a4,92(a5)
    1ed8:	409c                	lw	a5,0(s1)
    1eda:	40f707bb          	subw	a5,a4,a5
    1ede:	0007871b          	sext.w	a4,a5
    1ee2:	fe843783          	ld	a5,-24(s0)
    1ee6:	4fbc                	lw	a5,88(a5)
    1ee8:	40f707bb          	subw	a5,a4,a5
    1eec:	2781                	sext.w	a5,a5
                                             slack_time(th) < slack_time(least_slack_time_thread) ||
    1eee:	872e                	mv	a4,a1
    1ef0:	00f71e63          	bne	a4,a5,1f0c <schedule_lst+0x106>
                                             (slack_time(th) == slack_time(least_slack_time_thread) && th->ID < least_slack_time_thread->ID)))
    1ef4:	fd843783          	ld	a5,-40(s0)
    1ef8:	5fd8                	lw	a4,60(a5)
    1efa:	fe843783          	ld	a5,-24(s0)
    1efe:	5fdc                	lw	a5,60(a5)
    1f00:	00f75663          	bge	a4,a5,1f0c <schedule_lst+0x106>
        {
            least_slack_time_thread = th;
    1f04:	fd843783          	ld	a5,-40(s0)
    1f08:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list)
    1f0c:	fd843783          	ld	a5,-40(s0)
    1f10:	779c                	ld	a5,40(a5)
    1f12:	f8f43423          	sd	a5,-120(s0)
    1f16:	f8843783          	ld	a5,-120(s0)
    1f1a:	fd878793          	addi	a5,a5,-40
    1f1e:	fcf43c23          	sd	a5,-40(s0)
    1f22:	fd843783          	ld	a5,-40(s0)
    1f26:	02878713          	addi	a4,a5,40
    1f2a:	649c                	ld	a5,8(s1)
    1f2c:	f0f719e3          	bne	a4,a5,1e3e <schedule_lst+0x38>
        }
    }

    if (miss_deadline_thread != NULL)
    1f30:	fe043783          	ld	a5,-32(s0)
    1f34:	cb81                	beqz	a5,1f44 <schedule_lst+0x13e>
    {
        least_slack_time_thread = miss_deadline_thread;
    1f36:	fe043783          	ld	a5,-32(s0)
    1f3a:	fef43423          	sd	a5,-24(s0)
        allocated_time = 0;
    1f3e:	fc042623          	sw	zero,-52(s0)
    1f42:	aa05                	j	2072 <schedule_lst+0x26c>
    }
    else
    {
        allocated_time = min(least_slack_time_thread->remaining_time, least_slack_time_thread->current_deadline - args.current_time);
    1f44:	fe843783          	ld	a5,-24(s0)
    1f48:	4ff8                	lw	a4,92(a5)
    1f4a:	409c                	lw	a5,0(s1)
    1f4c:	40f707bb          	subw	a5,a4,a5
    1f50:	0007871b          	sext.w	a4,a5
    1f54:	fe843783          	ld	a5,-24(s0)
    1f58:	4fbc                	lw	a5,88(a5)
    1f5a:	853e                	mv	a0,a5
    1f5c:	87ba                	mv	a5,a4
    1f5e:	0007859b          	sext.w	a1,a5
    1f62:	0005071b          	sext.w	a4,a0
    1f66:	00b75363          	bge	a4,a1,1f6c <schedule_lst+0x166>
    1f6a:	87aa                	mv	a5,a0
    1f6c:	fcf42623          	sw	a5,-52(s0)
        // printf("\n>> release_queue: \n");
        list_for_each_entry(rqe, args.release_queue, thread_list)
    1f70:	689c                	ld	a5,16(s1)
    1f72:	639c                	ld	a5,0(a5)
    1f74:	faf43423          	sd	a5,-88(s0)
    1f78:	fa843783          	ld	a5,-88(s0)
    1f7c:	17e1                	addi	a5,a5,-8
    1f7e:	fcf43823          	sd	a5,-48(s0)
    1f82:	a0cd                	j	2064 <schedule_lst+0x25e>
        {
            // printf("rqe->thrd->ID: %d; ", rqe->thrd->ID);
            // printf("rqe->release_time: %d; ", rqe->release_time);
            // printf("rqe->thrd->processing_time: %d\n", rqe->thrd->processing_time);
            if (rqe->release_time < args.current_time + allocated_time &&
    1f84:	fd043783          	ld	a5,-48(s0)
    1f88:	4f8c                	lw	a1,24(a5)
    1f8a:	409c                	lw	a5,0(s1)
    1f8c:	fcc42703          	lw	a4,-52(s0)
    1f90:	9fb9                	addw	a5,a5,a4
    1f92:	2781                	sext.w	a5,a5
    1f94:	872e                	mv	a4,a1
    1f96:	0af75d63          	bge	a4,a5,2050 <schedule_lst+0x24a>
                (release_queue_slack_time(rqe->thrd) < slack_time(least_slack_time_thread) ||
    1f9a:	fd043783          	ld	a5,-48(s0)
    1f9e:	639c                	ld	a5,0(a5)
    1fa0:	47f8                	lw	a4,76(a5)
    1fa2:	fd043783          	ld	a5,-48(s0)
    1fa6:	639c                	ld	a5,0(a5)
    1fa8:	43fc                	lw	a5,68(a5)
    1faa:	40f707bb          	subw	a5,a4,a5
    1fae:	0007859b          	sext.w	a1,a5
    1fb2:	fe843783          	ld	a5,-24(s0)
    1fb6:	4ff8                	lw	a4,92(a5)
    1fb8:	409c                	lw	a5,0(s1)
    1fba:	40f707bb          	subw	a5,a4,a5
    1fbe:	0007871b          	sext.w	a4,a5
    1fc2:	fe843783          	ld	a5,-24(s0)
    1fc6:	4fbc                	lw	a5,88(a5)
    1fc8:	40f707bb          	subw	a5,a4,a5
    1fcc:	2781                	sext.w	a5,a5
            if (rqe->release_time < args.current_time + allocated_time &&
    1fce:	872e                	mv	a4,a1
    1fd0:	04f74863          	blt	a4,a5,2020 <schedule_lst+0x21a>
                 (release_queue_slack_time(rqe->thrd) == slack_time(least_slack_time_thread) && rqe->thrd->ID < least_slack_time_thread->ID)))
    1fd4:	fd043783          	ld	a5,-48(s0)
    1fd8:	639c                	ld	a5,0(a5)
    1fda:	47f8                	lw	a4,76(a5)
    1fdc:	fd043783          	ld	a5,-48(s0)
    1fe0:	639c                	ld	a5,0(a5)
    1fe2:	43fc                	lw	a5,68(a5)
    1fe4:	40f707bb          	subw	a5,a4,a5
    1fe8:	0007859b          	sext.w	a1,a5
    1fec:	fe843783          	ld	a5,-24(s0)
    1ff0:	4ff8                	lw	a4,92(a5)
    1ff2:	409c                	lw	a5,0(s1)
    1ff4:	40f707bb          	subw	a5,a4,a5
    1ff8:	0007871b          	sext.w	a4,a5
    1ffc:	fe843783          	ld	a5,-24(s0)
    2000:	4fbc                	lw	a5,88(a5)
    2002:	40f707bb          	subw	a5,a4,a5
    2006:	2781                	sext.w	a5,a5
                (release_queue_slack_time(rqe->thrd) < slack_time(least_slack_time_thread) ||
    2008:	872e                	mv	a4,a1
    200a:	04f71363          	bne	a4,a5,2050 <schedule_lst+0x24a>
                 (release_queue_slack_time(rqe->thrd) == slack_time(least_slack_time_thread) && rqe->thrd->ID < least_slack_time_thread->ID)))
    200e:	fd043783          	ld	a5,-48(s0)
    2012:	639c                	ld	a5,0(a5)
    2014:	5fd8                	lw	a4,60(a5)
    2016:	fe843783          	ld	a5,-24(s0)
    201a:	5fdc                	lw	a5,60(a5)
    201c:	02f75a63          	bge	a4,a5,2050 <schedule_lst+0x24a>
            {
                if (smallest_release_time == 0 || rqe->release_time < smallest_release_time)
    2020:	fc842783          	lw	a5,-56(s0)
    2024:	2781                	sext.w	a5,a5
    2026:	cb89                	beqz	a5,2038 <schedule_lst+0x232>
    2028:	fd043783          	ld	a5,-48(s0)
    202c:	4f98                	lw	a4,24(a5)
    202e:	fc842783          	lw	a5,-56(s0)
    2032:	2781                	sext.w	a5,a5
    2034:	00f75e63          	bge	a4,a5,2050 <schedule_lst+0x24a>
                {
                    smallest_release_time = rqe->release_time;
    2038:	fd043783          	ld	a5,-48(s0)
    203c:	4f9c                	lw	a5,24(a5)
    203e:	fcf42423          	sw	a5,-56(s0)
                    allocated_time = smallest_release_time - args.current_time;
    2042:	409c                	lw	a5,0(s1)
    2044:	fc842703          	lw	a4,-56(s0)
    2048:	40f707bb          	subw	a5,a4,a5
    204c:	fcf42623          	sw	a5,-52(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list)
    2050:	fd043783          	ld	a5,-48(s0)
    2054:	679c                	ld	a5,8(a5)
    2056:	faf43023          	sd	a5,-96(s0)
    205a:	fa043783          	ld	a5,-96(s0)
    205e:	17e1                	addi	a5,a5,-8
    2060:	fcf43823          	sd	a5,-48(s0)
    2064:	fd043783          	ld	a5,-48(s0)
    2068:	00878713          	addi	a4,a5,8
    206c:	689c                	ld	a5,16(s1)
    206e:	f0f71be3          	bne	a4,a5,1f84 <schedule_lst+0x17e>
        }
    }

    struct threads_sched_result r;
    // TODO: implement the least-slack-time scheduling algorithm
    if (least_slack_time_thread != NULL)
    2072:	fe843783          	ld	a5,-24(s0)
    2076:	cf81                	beqz	a5,208e <schedule_lst+0x288>
    {
        r.scheduled_thread_list_member = &least_slack_time_thread->thread_list;
    2078:	fe843783          	ld	a5,-24(s0)
    207c:	02878793          	addi	a5,a5,40
    2080:	f6f43423          	sd	a5,-152(s0)
        r.allocated_time = allocated_time;
    2084:	fcc42783          	lw	a5,-52(s0)
    2088:	f6f42823          	sw	a5,-144(s0)
    208c:	a051                	j	2110 <schedule_lst+0x30a>
    }
    else
    {
        r.scheduled_thread_list_member = args.run_queue;
    208e:	649c                	ld	a5,8(s1)
    2090:	f6f43423          	sd	a5,-152(s0)

        struct release_queue_entry *next_rqe = NULL;
    2094:	fc043023          	sd	zero,-64(s0)
        struct release_queue_entry *rqe = NULL;
    2098:	fa043c23          	sd	zero,-72(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list)
    209c:	689c                	ld	a5,16(s1)
    209e:	639c                	ld	a5,0(a5)
    20a0:	f8f43c23          	sd	a5,-104(s0)
    20a4:	f9843783          	ld	a5,-104(s0)
    20a8:	17e1                	addi	a5,a5,-8
    20aa:	faf43c23          	sd	a5,-72(s0)
    20ae:	a815                	j	20e2 <schedule_lst+0x2dc>
        {
            if (rqe == NULL || rqe->release_time < next_rqe->release_time)
    20b0:	fb843783          	ld	a5,-72(s0)
    20b4:	cb89                	beqz	a5,20c6 <schedule_lst+0x2c0>
    20b6:	fb843783          	ld	a5,-72(s0)
    20ba:	4f98                	lw	a4,24(a5)
    20bc:	fc043783          	ld	a5,-64(s0)
    20c0:	4f9c                	lw	a5,24(a5)
    20c2:	00f75663          	bge	a4,a5,20ce <schedule_lst+0x2c8>
                next_rqe = rqe;
    20c6:	fb843783          	ld	a5,-72(s0)
    20ca:	fcf43023          	sd	a5,-64(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list)
    20ce:	fb843783          	ld	a5,-72(s0)
    20d2:	679c                	ld	a5,8(a5)
    20d4:	f8f43823          	sd	a5,-112(s0)
    20d8:	f9043783          	ld	a5,-112(s0)
    20dc:	17e1                	addi	a5,a5,-8
    20de:	faf43c23          	sd	a5,-72(s0)
    20e2:	fb843783          	ld	a5,-72(s0)
    20e6:	00878713          	addi	a4,a5,8
    20ea:	689c                	ld	a5,16(s1)
    20ec:	fcf712e3          	bne	a4,a5,20b0 <schedule_lst+0x2aa>
        }
        if (next_rqe != NULL)
    20f0:	fc043783          	ld	a5,-64(s0)
    20f4:	cb99                	beqz	a5,210a <schedule_lst+0x304>
            r.allocated_time = next_rqe->release_time - args.current_time;
    20f6:	fc043783          	ld	a5,-64(s0)
    20fa:	4f98                	lw	a4,24(a5)
    20fc:	409c                	lw	a5,0(s1)
    20fe:	40f707bb          	subw	a5,a4,a5
    2102:	2781                	sext.w	a5,a5
    2104:	f6f42823          	sw	a5,-144(s0)
    2108:	a021                	j	2110 <schedule_lst+0x30a>
        else
            r.allocated_time = 1;
    210a:	4785                	li	a5,1
    210c:	f6f42823          	sw	a5,-144(s0)
    }

    return r;
    2110:	f6843783          	ld	a5,-152(s0)
    2114:	f6f43c23          	sd	a5,-136(s0)
    2118:	f7043783          	ld	a5,-144(s0)
    211c:	f8f43023          	sd	a5,-128(s0)
    2120:	4701                	li	a4,0
    2122:	f7843703          	ld	a4,-136(s0)
    2126:	4781                	li	a5,0
    2128:	f8043783          	ld	a5,-128(s0)
    212c:	863a                	mv	a2,a4
    212e:	86be                	mv	a3,a5
    2130:	8732                	mv	a4,a2
    2132:	87b6                	mv	a5,a3
}
    2134:	853a                	mv	a0,a4
    2136:	85be                	mv	a1,a5
    2138:	646a                	ld	s0,152(sp)
    213a:	64ca                	ld	s1,144(sp)
    213c:	610d                	addi	sp,sp,160
    213e:	8082                	ret

0000000000002140 <schedule_dm>:

/* Deadline-Monotonic Scheduling */
struct threads_sched_result schedule_dm(struct threads_sched_args args)
{
    2140:	7135                	addi	sp,sp,-160
    2142:	ed22                	sd	s0,152(sp)
    2144:	e926                	sd	s1,144(sp)
    2146:	1100                	addi	s0,sp,160
    2148:	84aa                	mv	s1,a0
    struct thread *shortest_deadline_thread = NULL;
    214a:	fe043423          	sd	zero,-24(s0)
    struct thread *miss_deadline_thread = NULL;
    214e:	fe043023          	sd	zero,-32(s0)
    struct thread *th = NULL;
    2152:	fc043c23          	sd	zero,-40(s0)
    struct release_queue_entry *rqe = NULL;
    2156:	fc043823          	sd	zero,-48(s0)
    int allocated_time = 0;
    215a:	fc042623          	sw	zero,-52(s0)
    int smallest_release_time = 0;
    215e:	fc042423          	sw	zero,-56(s0)

    list_for_each_entry(th, args.run_queue, thread_list)
    2162:	649c                	ld	a5,8(s1)
    2164:	639c                	ld	a5,0(a5)
    2166:	faf43823          	sd	a5,-80(s0)
    216a:	fb043783          	ld	a5,-80(s0)
    216e:	fd878793          	addi	a5,a5,-40
    2172:	fcf43c23          	sd	a5,-40(s0)
    2176:	a059                	j	21fc <schedule_dm+0xbc>
    {
        if (args.current_time >= th->current_deadline &&
    2178:	4098                	lw	a4,0(s1)
    217a:	fd843783          	ld	a5,-40(s0)
    217e:	4ffc                	lw	a5,92(a5)
    2180:	02f74163          	blt	a4,a5,21a2 <schedule_dm+0x62>
    2184:	fe043783          	ld	a5,-32(s0)
    2188:	cb89                	beqz	a5,219a <schedule_dm+0x5a>
            (miss_deadline_thread == NULL || th->ID < miss_deadline_thread->ID))
    218a:	fd843783          	ld	a5,-40(s0)
    218e:	5fd8                	lw	a4,60(a5)
    2190:	fe043783          	ld	a5,-32(s0)
    2194:	5fdc                	lw	a5,60(a5)
    2196:	00f75663          	bge	a4,a5,21a2 <schedule_dm+0x62>
        {
            miss_deadline_thread = th;
    219a:	fd843783          	ld	a5,-40(s0)
    219e:	fef43023          	sd	a5,-32(s0)
        }

        if (miss_deadline_thread == NULL && (shortest_deadline_thread == NULL ||
    21a2:	fe043783          	ld	a5,-32(s0)
    21a6:	e3a1                	bnez	a5,21e6 <schedule_dm+0xa6>
    21a8:	fe843783          	ld	a5,-24(s0)
    21ac:	cb8d                	beqz	a5,21de <schedule_dm+0x9e>
                                             th->deadline < shortest_deadline_thread->deadline ||
    21ae:	fd843783          	ld	a5,-40(s0)
    21b2:	47f8                	lw	a4,76(a5)
    21b4:	fe843783          	ld	a5,-24(s0)
    21b8:	47fc                	lw	a5,76(a5)
        if (miss_deadline_thread == NULL && (shortest_deadline_thread == NULL ||
    21ba:	02f74263          	blt	a4,a5,21de <schedule_dm+0x9e>
                                             (th->deadline == shortest_deadline_thread->deadline && th->ID < shortest_deadline_thread->ID)))
    21be:	fd843783          	ld	a5,-40(s0)
    21c2:	47f8                	lw	a4,76(a5)
    21c4:	fe843783          	ld	a5,-24(s0)
    21c8:	47fc                	lw	a5,76(a5)
                                             th->deadline < shortest_deadline_thread->deadline ||
    21ca:	00f71e63          	bne	a4,a5,21e6 <schedule_dm+0xa6>
                                             (th->deadline == shortest_deadline_thread->deadline && th->ID < shortest_deadline_thread->ID)))
    21ce:	fd843783          	ld	a5,-40(s0)
    21d2:	5fd8                	lw	a4,60(a5)
    21d4:	fe843783          	ld	a5,-24(s0)
    21d8:	5fdc                	lw	a5,60(a5)
    21da:	00f75663          	bge	a4,a5,21e6 <schedule_dm+0xa6>
        {
            shortest_deadline_thread = th;
    21de:	fd843783          	ld	a5,-40(s0)
    21e2:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list)
    21e6:	fd843783          	ld	a5,-40(s0)
    21ea:	779c                	ld	a5,40(a5)
    21ec:	f8f43423          	sd	a5,-120(s0)
    21f0:	f8843783          	ld	a5,-120(s0)
    21f4:	fd878793          	addi	a5,a5,-40
    21f8:	fcf43c23          	sd	a5,-40(s0)
    21fc:	fd843783          	ld	a5,-40(s0)
    2200:	02878713          	addi	a4,a5,40
    2204:	649c                	ld	a5,8(s1)
    2206:	f6f719e3          	bne	a4,a5,2178 <schedule_dm+0x38>
        }
    }

    if (miss_deadline_thread != NULL)
    220a:	fe043783          	ld	a5,-32(s0)
    220e:	cb81                	beqz	a5,221e <schedule_dm+0xde>
    {
        shortest_deadline_thread = miss_deadline_thread;
    2210:	fe043783          	ld	a5,-32(s0)
    2214:	fef43423          	sd	a5,-24(s0)
        allocated_time = 0;
    2218:	fc042623          	sw	zero,-52(s0)
    221c:	a0c5                	j	22fc <schedule_dm+0x1bc>
    }
    else
    {
        allocated_time = min(shortest_deadline_thread->remaining_time, shortest_deadline_thread->current_deadline - args.current_time);
    221e:	fe843783          	ld	a5,-24(s0)
    2222:	4ff8                	lw	a4,92(a5)
    2224:	409c                	lw	a5,0(s1)
    2226:	40f707bb          	subw	a5,a4,a5
    222a:	0007871b          	sext.w	a4,a5
    222e:	fe843783          	ld	a5,-24(s0)
    2232:	4fbc                	lw	a5,88(a5)
    2234:	853e                	mv	a0,a5
    2236:	87ba                	mv	a5,a4
    2238:	0007859b          	sext.w	a1,a5
    223c:	0005071b          	sext.w	a4,a0
    2240:	00b75363          	bge	a4,a1,2246 <schedule_dm+0x106>
    2244:	87aa                	mv	a5,a0
    2246:	fcf42623          	sw	a5,-52(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list)
    224a:	689c                	ld	a5,16(s1)
    224c:	639c                	ld	a5,0(a5)
    224e:	faf43423          	sd	a5,-88(s0)
    2252:	fa843783          	ld	a5,-88(s0)
    2256:	17e1                	addi	a5,a5,-8
    2258:	fcf43823          	sd	a5,-48(s0)
    225c:	a849                	j	22ee <schedule_dm+0x1ae>
        {
            if (rqe->release_time < args.current_time + allocated_time &&
    225e:	fd043783          	ld	a5,-48(s0)
    2262:	4f8c                	lw	a1,24(a5)
    2264:	409c                	lw	a5,0(s1)
    2266:	fcc42703          	lw	a4,-52(s0)
    226a:	9fb9                	addw	a5,a5,a4
    226c:	2781                	sext.w	a5,a5
    226e:	872e                	mv	a4,a1
    2270:	06f75563          	bge	a4,a5,22da <schedule_dm+0x19a>
                (rqe->thrd->deadline < shortest_deadline_thread->deadline ||
    2274:	fd043783          	ld	a5,-48(s0)
    2278:	639c                	ld	a5,0(a5)
    227a:	47f8                	lw	a4,76(a5)
    227c:	fe843783          	ld	a5,-24(s0)
    2280:	47fc                	lw	a5,76(a5)
            if (rqe->release_time < args.current_time + allocated_time &&
    2282:	02f74463          	blt	a4,a5,22aa <schedule_dm+0x16a>
                 (rqe->thrd->deadline == shortest_deadline_thread->deadline && rqe->thrd->ID < shortest_deadline_thread->ID)))
    2286:	fd043783          	ld	a5,-48(s0)
    228a:	639c                	ld	a5,0(a5)
    228c:	47f8                	lw	a4,76(a5)
    228e:	fe843783          	ld	a5,-24(s0)
    2292:	47fc                	lw	a5,76(a5)
                (rqe->thrd->deadline < shortest_deadline_thread->deadline ||
    2294:	04f71363          	bne	a4,a5,22da <schedule_dm+0x19a>
                 (rqe->thrd->deadline == shortest_deadline_thread->deadline && rqe->thrd->ID < shortest_deadline_thread->ID)))
    2298:	fd043783          	ld	a5,-48(s0)
    229c:	639c                	ld	a5,0(a5)
    229e:	5fd8                	lw	a4,60(a5)
    22a0:	fe843783          	ld	a5,-24(s0)
    22a4:	5fdc                	lw	a5,60(a5)
    22a6:	02f75a63          	bge	a4,a5,22da <schedule_dm+0x19a>
            {
                if (smallest_release_time == 0 || rqe->release_time < smallest_release_time)
    22aa:	fc842783          	lw	a5,-56(s0)
    22ae:	2781                	sext.w	a5,a5
    22b0:	cb89                	beqz	a5,22c2 <schedule_dm+0x182>
    22b2:	fd043783          	ld	a5,-48(s0)
    22b6:	4f98                	lw	a4,24(a5)
    22b8:	fc842783          	lw	a5,-56(s0)
    22bc:	2781                	sext.w	a5,a5
    22be:	00f75e63          	bge	a4,a5,22da <schedule_dm+0x19a>
                {
                    smallest_release_time = rqe->release_time;
    22c2:	fd043783          	ld	a5,-48(s0)
    22c6:	4f9c                	lw	a5,24(a5)
    22c8:	fcf42423          	sw	a5,-56(s0)
                    allocated_time = smallest_release_time - args.current_time;
    22cc:	409c                	lw	a5,0(s1)
    22ce:	fc842703          	lw	a4,-56(s0)
    22d2:	40f707bb          	subw	a5,a4,a5
    22d6:	fcf42623          	sw	a5,-52(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list)
    22da:	fd043783          	ld	a5,-48(s0)
    22de:	679c                	ld	a5,8(a5)
    22e0:	faf43023          	sd	a5,-96(s0)
    22e4:	fa043783          	ld	a5,-96(s0)
    22e8:	17e1                	addi	a5,a5,-8
    22ea:	fcf43823          	sd	a5,-48(s0)
    22ee:	fd043783          	ld	a5,-48(s0)
    22f2:	00878713          	addi	a4,a5,8
    22f6:	689c                	ld	a5,16(s1)
    22f8:	f6f713e3          	bne	a4,a5,225e <schedule_dm+0x11e>
        }
    }

    struct threads_sched_result r;
    // TODO: implement the deadline-monotonic scheduling algorithm
    if (shortest_deadline_thread != NULL)
    22fc:	fe843783          	ld	a5,-24(s0)
    2300:	cf81                	beqz	a5,2318 <schedule_dm+0x1d8>
    {
        r.scheduled_thread_list_member = &shortest_deadline_thread->thread_list;
    2302:	fe843783          	ld	a5,-24(s0)
    2306:	02878793          	addi	a5,a5,40
    230a:	f6f43423          	sd	a5,-152(s0)
        r.allocated_time = allocated_time;
    230e:	fcc42783          	lw	a5,-52(s0)
    2312:	f6f42823          	sw	a5,-144(s0)
    2316:	a051                	j	239a <schedule_dm+0x25a>
    }
    else
    {
        r.scheduled_thread_list_member = args.run_queue;
    2318:	649c                	ld	a5,8(s1)
    231a:	f6f43423          	sd	a5,-152(s0)

        // Handle sleep time
        struct release_queue_entry *next_rqe = NULL;
    231e:	fc043023          	sd	zero,-64(s0)
        struct release_queue_entry *rqe = NULL;
    2322:	fa043c23          	sd	zero,-72(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list)
    2326:	689c                	ld	a5,16(s1)
    2328:	639c                	ld	a5,0(a5)
    232a:	f8f43c23          	sd	a5,-104(s0)
    232e:	f9843783          	ld	a5,-104(s0)
    2332:	17e1                	addi	a5,a5,-8
    2334:	faf43c23          	sd	a5,-72(s0)
    2338:	a815                	j	236c <schedule_dm+0x22c>
        {
            if (rqe == NULL || rqe->release_time < next_rqe->release_time)
    233a:	fb843783          	ld	a5,-72(s0)
    233e:	cb89                	beqz	a5,2350 <schedule_dm+0x210>
    2340:	fb843783          	ld	a5,-72(s0)
    2344:	4f98                	lw	a4,24(a5)
    2346:	fc043783          	ld	a5,-64(s0)
    234a:	4f9c                	lw	a5,24(a5)
    234c:	00f75663          	bge	a4,a5,2358 <schedule_dm+0x218>
                next_rqe = rqe;
    2350:	fb843783          	ld	a5,-72(s0)
    2354:	fcf43023          	sd	a5,-64(s0)
        list_for_each_entry(rqe, args.release_queue, thread_list)
    2358:	fb843783          	ld	a5,-72(s0)
    235c:	679c                	ld	a5,8(a5)
    235e:	f8f43823          	sd	a5,-112(s0)
    2362:	f9043783          	ld	a5,-112(s0)
    2366:	17e1                	addi	a5,a5,-8
    2368:	faf43c23          	sd	a5,-72(s0)
    236c:	fb843783          	ld	a5,-72(s0)
    2370:	00878713          	addi	a4,a5,8
    2374:	689c                	ld	a5,16(s1)
    2376:	fcf712e3          	bne	a4,a5,233a <schedule_dm+0x1fa>
        }
        if (next_rqe != NULL)
    237a:	fc043783          	ld	a5,-64(s0)
    237e:	cb99                	beqz	a5,2394 <schedule_dm+0x254>
            r.allocated_time = next_rqe->release_time - args.current_time;
    2380:	fc043783          	ld	a5,-64(s0)
    2384:	4f98                	lw	a4,24(a5)
    2386:	409c                	lw	a5,0(s1)
    2388:	40f707bb          	subw	a5,a4,a5
    238c:	2781                	sext.w	a5,a5
    238e:	f6f42823          	sw	a5,-144(s0)
    2392:	a021                	j	239a <schedule_dm+0x25a>
        else
            r.allocated_time = 1;
    2394:	4785                	li	a5,1
    2396:	f6f42823          	sw	a5,-144(s0)
    }

    return r;
    239a:	f6843783          	ld	a5,-152(s0)
    239e:	f6f43c23          	sd	a5,-136(s0)
    23a2:	f7043783          	ld	a5,-144(s0)
    23a6:	f8f43023          	sd	a5,-128(s0)
    23aa:	4701                	li	a4,0
    23ac:	f7843703          	ld	a4,-136(s0)
    23b0:	4781                	li	a5,0
    23b2:	f8043783          	ld	a5,-128(s0)
    23b6:	863a                	mv	a2,a4
    23b8:	86be                	mv	a3,a5
    23ba:	8732                	mv	a4,a2
    23bc:	87b6                	mv	a5,a3
}
    23be:	853a                	mv	a0,a4
    23c0:	85be                	mv	a1,a5
    23c2:	646a                	ld	s0,152(sp)
    23c4:	64ca                	ld	s1,144(sp)
    23c6:	610d                	addi	sp,sp,160
    23c8:	8082                	ret
