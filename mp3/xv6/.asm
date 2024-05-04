
user/_task3:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <f>:
#define NULL 0

int k = 0;

void f(void *arg)
{
       0:	1101                	addi	sp,sp,-32
       2:	ec22                	sd	s0,24(sp)
       4:	1000                	addi	s0,sp,32
       6:	fea43423          	sd	a0,-24(s0)
    while (1)
    {
        k++;
       a:	00002797          	auipc	a5,0x2
       e:	de678793          	addi	a5,a5,-538 # 1df0 <k>
      12:	439c                	lw	a5,0(a5)
      14:	2785                	addiw	a5,a5,1
      16:	0007871b          	sext.w	a4,a5
      1a:	00002797          	auipc	a5,0x2
      1e:	dd678793          	addi	a5,a5,-554 # 1df0 <k>
      22:	c398                	sw	a4,0(a5)
      24:	b7dd                	j	a <f+0xa>

0000000000000026 <main>:
    }
}

int main(int argc, char **argv)
{
      26:	7139                	addi	sp,sp,-64
      28:	fc06                	sd	ra,56(sp)
      2a:	f822                	sd	s0,48(sp)
      2c:	0080                	addi	s0,sp,64
      2e:	87aa                	mv	a5,a0
      30:	fcb43023          	sd	a1,-64(s0)
      34:	fcf42623          	sw	a5,-52(s0)
    struct thread *t1 = thread_create(f, NULL, 0, 5, -1, 1);
      38:	4785                	li	a5,1
      3a:	577d                	li	a4,-1
      3c:	4695                	li	a3,5
      3e:	4601                	li	a2,0
      40:	4581                	li	a1,0
      42:	00000517          	auipc	a0,0x0
      46:	fbe50513          	addi	a0,a0,-66 # 0 <f>
      4a:	00001097          	auipc	ra,0x1
      4e:	f4c080e7          	jalr	-180(ra) # f96 <thread_create>
      52:	fea43423          	sd	a0,-24(s0)
    thread_set_weight(t1, 1);
      56:	4585                	li	a1,1
      58:	fe843503          	ld	a0,-24(s0)
      5c:	00001097          	auipc	ra,0x1
      60:	044080e7          	jalr	68(ra) # 10a0 <thread_set_weight>
    // thread_add_at(t1, 2);

    struct thread *t2 = thread_create(f, NULL, 0, 7, -1, 1);
      64:	4785                	li	a5,1
      66:	577d                	li	a4,-1
      68:	469d                	li	a3,7
      6a:	4601                	li	a2,0
      6c:	4581                	li	a1,0
      6e:	00000517          	auipc	a0,0x0
      72:	f9250513          	addi	a0,a0,-110 # 0 <f>
      76:	00001097          	auipc	ra,0x1
      7a:	f20080e7          	jalr	-224(ra) # f96 <thread_create>
      7e:	fea43023          	sd	a0,-32(s0)
    thread_set_weight(t2, 2);
      82:	4589                	li	a1,2
      84:	fe043503          	ld	a0,-32(s0)
      88:	00001097          	auipc	ra,0x1
      8c:	018080e7          	jalr	24(ra) # 10a0 <thread_set_weight>
    thread_add_at(t2, 0);
      90:	4581                	li	a1,0
      92:	fe043503          	ld	a0,-32(s0)
      96:	00001097          	auipc	ra,0x1
      9a:	02c080e7          	jalr	44(ra) # 10c2 <thread_add_at>

    struct thread *t3 = thread_create(f, NULL, 0, 5, -1, 1);
      9e:	4785                	li	a5,1
      a0:	577d                	li	a4,-1
      a2:	4695                	li	a3,5
      a4:	4601                	li	a2,0
      a6:	4581                	li	a1,0
      a8:	00000517          	auipc	a0,0x0
      ac:	f5850513          	addi	a0,a0,-168 # 0 <f>
      b0:	00001097          	auipc	ra,0x1
      b4:	ee6080e7          	jalr	-282(ra) # f96 <thread_create>
      b8:	fca43c23          	sd	a0,-40(s0)
    thread_set_weight(t3, 1);
      bc:	4585                	li	a1,1
      be:	fd843503          	ld	a0,-40(s0)
      c2:	00001097          	auipc	ra,0x1
      c6:	fde080e7          	jalr	-34(ra) # 10a0 <thread_set_weight>
    thread_add_at(t3, 1);
      ca:	4585                	li	a1,1
      cc:	fd843503          	ld	a0,-40(s0)
      d0:	00001097          	auipc	ra,0x1
      d4:	ff2080e7          	jalr	-14(ra) # 10c2 <thread_add_at>
    thread_add_at(t1, 1);
      d8:	4585                	li	a1,1
      da:	fe843503          	ld	a0,-24(s0)
      de:	00001097          	auipc	ra,0x1
      e2:	fe4080e7          	jalr	-28(ra) # 10c2 <thread_add_at>

    thread_start_threading();
      e6:	00001097          	auipc	ra,0x1
      ea:	7ea080e7          	jalr	2026(ra) # 18d0 <thread_start_threading>
    printf("\nexited\n");
      ee:	00002517          	auipc	a0,0x2
      f2:	b3250513          	addi	a0,a0,-1230 # 1c20 <schedule_wrr+0x13a>
      f6:	00001097          	auipc	ra,0x1
      fa:	9e8080e7          	jalr	-1560(ra) # ade <printf>
    exit(0);
      fe:	4501                	li	a0,0
     100:	00000097          	auipc	ra,0x0
     104:	498080e7          	jalr	1176(ra) # 598 <exit>

0000000000000108 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     108:	7179                	addi	sp,sp,-48
     10a:	f422                	sd	s0,40(sp)
     10c:	1800                	addi	s0,sp,48
     10e:	fca43c23          	sd	a0,-40(s0)
     112:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     116:	fd843783          	ld	a5,-40(s0)
     11a:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     11e:	0001                	nop
     120:	fd043703          	ld	a4,-48(s0)
     124:	00170793          	addi	a5,a4,1
     128:	fcf43823          	sd	a5,-48(s0)
     12c:	fd843783          	ld	a5,-40(s0)
     130:	00178693          	addi	a3,a5,1
     134:	fcd43c23          	sd	a3,-40(s0)
     138:	00074703          	lbu	a4,0(a4)
     13c:	00e78023          	sb	a4,0(a5)
     140:	0007c783          	lbu	a5,0(a5)
     144:	fff1                	bnez	a5,120 <strcpy+0x18>
    ;
  return os;
     146:	fe843783          	ld	a5,-24(s0)
}
     14a:	853e                	mv	a0,a5
     14c:	7422                	ld	s0,40(sp)
     14e:	6145                	addi	sp,sp,48
     150:	8082                	ret

0000000000000152 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     152:	1101                	addi	sp,sp,-32
     154:	ec22                	sd	s0,24(sp)
     156:	1000                	addi	s0,sp,32
     158:	fea43423          	sd	a0,-24(s0)
     15c:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     160:	a819                	j	176 <strcmp+0x24>
    p++, q++;
     162:	fe843783          	ld	a5,-24(s0)
     166:	0785                	addi	a5,a5,1
     168:	fef43423          	sd	a5,-24(s0)
     16c:	fe043783          	ld	a5,-32(s0)
     170:	0785                	addi	a5,a5,1
     172:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     176:	fe843783          	ld	a5,-24(s0)
     17a:	0007c783          	lbu	a5,0(a5)
     17e:	cb99                	beqz	a5,194 <strcmp+0x42>
     180:	fe843783          	ld	a5,-24(s0)
     184:	0007c703          	lbu	a4,0(a5)
     188:	fe043783          	ld	a5,-32(s0)
     18c:	0007c783          	lbu	a5,0(a5)
     190:	fcf709e3          	beq	a4,a5,162 <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     194:	fe843783          	ld	a5,-24(s0)
     198:	0007c783          	lbu	a5,0(a5)
     19c:	0007871b          	sext.w	a4,a5
     1a0:	fe043783          	ld	a5,-32(s0)
     1a4:	0007c783          	lbu	a5,0(a5)
     1a8:	2781                	sext.w	a5,a5
     1aa:	40f707bb          	subw	a5,a4,a5
     1ae:	2781                	sext.w	a5,a5
}
     1b0:	853e                	mv	a0,a5
     1b2:	6462                	ld	s0,24(sp)
     1b4:	6105                	addi	sp,sp,32
     1b6:	8082                	ret

00000000000001b8 <strlen>:

uint
strlen(const char *s)
{
     1b8:	7179                	addi	sp,sp,-48
     1ba:	f422                	sd	s0,40(sp)
     1bc:	1800                	addi	s0,sp,48
     1be:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     1c2:	fe042623          	sw	zero,-20(s0)
     1c6:	a031                	j	1d2 <strlen+0x1a>
     1c8:	fec42783          	lw	a5,-20(s0)
     1cc:	2785                	addiw	a5,a5,1
     1ce:	fef42623          	sw	a5,-20(s0)
     1d2:	fec42783          	lw	a5,-20(s0)
     1d6:	fd843703          	ld	a4,-40(s0)
     1da:	97ba                	add	a5,a5,a4
     1dc:	0007c783          	lbu	a5,0(a5)
     1e0:	f7e5                	bnez	a5,1c8 <strlen+0x10>
    ;
  return n;
     1e2:	fec42783          	lw	a5,-20(s0)
}
     1e6:	853e                	mv	a0,a5
     1e8:	7422                	ld	s0,40(sp)
     1ea:	6145                	addi	sp,sp,48
     1ec:	8082                	ret

00000000000001ee <memset>:

void*
memset(void *dst, int c, uint n)
{
     1ee:	7179                	addi	sp,sp,-48
     1f0:	f422                	sd	s0,40(sp)
     1f2:	1800                	addi	s0,sp,48
     1f4:	fca43c23          	sd	a0,-40(s0)
     1f8:	87ae                	mv	a5,a1
     1fa:	8732                	mv	a4,a2
     1fc:	fcf42a23          	sw	a5,-44(s0)
     200:	87ba                	mv	a5,a4
     202:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     206:	fd843783          	ld	a5,-40(s0)
     20a:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     20e:	fe042623          	sw	zero,-20(s0)
     212:	a00d                	j	234 <memset+0x46>
    cdst[i] = c;
     214:	fec42783          	lw	a5,-20(s0)
     218:	fe043703          	ld	a4,-32(s0)
     21c:	97ba                	add	a5,a5,a4
     21e:	fd442703          	lw	a4,-44(s0)
     222:	0ff77713          	andi	a4,a4,255
     226:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     22a:	fec42783          	lw	a5,-20(s0)
     22e:	2785                	addiw	a5,a5,1
     230:	fef42623          	sw	a5,-20(s0)
     234:	fec42703          	lw	a4,-20(s0)
     238:	fd042783          	lw	a5,-48(s0)
     23c:	2781                	sext.w	a5,a5
     23e:	fcf76be3          	bltu	a4,a5,214 <memset+0x26>
  }
  return dst;
     242:	fd843783          	ld	a5,-40(s0)
}
     246:	853e                	mv	a0,a5
     248:	7422                	ld	s0,40(sp)
     24a:	6145                	addi	sp,sp,48
     24c:	8082                	ret

000000000000024e <strchr>:

char*
strchr(const char *s, char c)
{
     24e:	1101                	addi	sp,sp,-32
     250:	ec22                	sd	s0,24(sp)
     252:	1000                	addi	s0,sp,32
     254:	fea43423          	sd	a0,-24(s0)
     258:	87ae                	mv	a5,a1
     25a:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     25e:	a01d                	j	284 <strchr+0x36>
    if(*s == c)
     260:	fe843783          	ld	a5,-24(s0)
     264:	0007c703          	lbu	a4,0(a5)
     268:	fe744783          	lbu	a5,-25(s0)
     26c:	0ff7f793          	andi	a5,a5,255
     270:	00e79563          	bne	a5,a4,27a <strchr+0x2c>
      return (char*)s;
     274:	fe843783          	ld	a5,-24(s0)
     278:	a821                	j	290 <strchr+0x42>
  for(; *s; s++)
     27a:	fe843783          	ld	a5,-24(s0)
     27e:	0785                	addi	a5,a5,1
     280:	fef43423          	sd	a5,-24(s0)
     284:	fe843783          	ld	a5,-24(s0)
     288:	0007c783          	lbu	a5,0(a5)
     28c:	fbf1                	bnez	a5,260 <strchr+0x12>
  return 0;
     28e:	4781                	li	a5,0
}
     290:	853e                	mv	a0,a5
     292:	6462                	ld	s0,24(sp)
     294:	6105                	addi	sp,sp,32
     296:	8082                	ret

0000000000000298 <gets>:

char*
gets(char *buf, int max)
{
     298:	7179                	addi	sp,sp,-48
     29a:	f406                	sd	ra,40(sp)
     29c:	f022                	sd	s0,32(sp)
     29e:	1800                	addi	s0,sp,48
     2a0:	fca43c23          	sd	a0,-40(s0)
     2a4:	87ae                	mv	a5,a1
     2a6:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     2aa:	fe042623          	sw	zero,-20(s0)
     2ae:	a8a1                	j	306 <gets+0x6e>
    cc = read(0, &c, 1);
     2b0:	fe740793          	addi	a5,s0,-25
     2b4:	4605                	li	a2,1
     2b6:	85be                	mv	a1,a5
     2b8:	4501                	li	a0,0
     2ba:	00000097          	auipc	ra,0x0
     2be:	2f6080e7          	jalr	758(ra) # 5b0 <read>
     2c2:	87aa                	mv	a5,a0
     2c4:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     2c8:	fe842783          	lw	a5,-24(s0)
     2cc:	2781                	sext.w	a5,a5
     2ce:	04f05763          	blez	a5,31c <gets+0x84>
      break;
    buf[i++] = c;
     2d2:	fec42783          	lw	a5,-20(s0)
     2d6:	0017871b          	addiw	a4,a5,1
     2da:	fee42623          	sw	a4,-20(s0)
     2de:	873e                	mv	a4,a5
     2e0:	fd843783          	ld	a5,-40(s0)
     2e4:	97ba                	add	a5,a5,a4
     2e6:	fe744703          	lbu	a4,-25(s0)
     2ea:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     2ee:	fe744783          	lbu	a5,-25(s0)
     2f2:	873e                	mv	a4,a5
     2f4:	47a9                	li	a5,10
     2f6:	02f70463          	beq	a4,a5,31e <gets+0x86>
     2fa:	fe744783          	lbu	a5,-25(s0)
     2fe:	873e                	mv	a4,a5
     300:	47b5                	li	a5,13
     302:	00f70e63          	beq	a4,a5,31e <gets+0x86>
  for(i=0; i+1 < max; ){
     306:	fec42783          	lw	a5,-20(s0)
     30a:	2785                	addiw	a5,a5,1
     30c:	0007871b          	sext.w	a4,a5
     310:	fd442783          	lw	a5,-44(s0)
     314:	2781                	sext.w	a5,a5
     316:	f8f74de3          	blt	a4,a5,2b0 <gets+0x18>
     31a:	a011                	j	31e <gets+0x86>
      break;
     31c:	0001                	nop
      break;
  }
  buf[i] = '\0';
     31e:	fec42783          	lw	a5,-20(s0)
     322:	fd843703          	ld	a4,-40(s0)
     326:	97ba                	add	a5,a5,a4
     328:	00078023          	sb	zero,0(a5)
  return buf;
     32c:	fd843783          	ld	a5,-40(s0)
}
     330:	853e                	mv	a0,a5
     332:	70a2                	ld	ra,40(sp)
     334:	7402                	ld	s0,32(sp)
     336:	6145                	addi	sp,sp,48
     338:	8082                	ret

000000000000033a <stat>:

int
stat(const char *n, struct stat *st)
{
     33a:	7179                	addi	sp,sp,-48
     33c:	f406                	sd	ra,40(sp)
     33e:	f022                	sd	s0,32(sp)
     340:	1800                	addi	s0,sp,48
     342:	fca43c23          	sd	a0,-40(s0)
     346:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     34a:	4581                	li	a1,0
     34c:	fd843503          	ld	a0,-40(s0)
     350:	00000097          	auipc	ra,0x0
     354:	288080e7          	jalr	648(ra) # 5d8 <open>
     358:	87aa                	mv	a5,a0
     35a:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     35e:	fec42783          	lw	a5,-20(s0)
     362:	2781                	sext.w	a5,a5
     364:	0007d463          	bgez	a5,36c <stat+0x32>
    return -1;
     368:	57fd                	li	a5,-1
     36a:	a035                	j	396 <stat+0x5c>
  r = fstat(fd, st);
     36c:	fec42783          	lw	a5,-20(s0)
     370:	fd043583          	ld	a1,-48(s0)
     374:	853e                	mv	a0,a5
     376:	00000097          	auipc	ra,0x0
     37a:	27a080e7          	jalr	634(ra) # 5f0 <fstat>
     37e:	87aa                	mv	a5,a0
     380:	fef42423          	sw	a5,-24(s0)
  close(fd);
     384:	fec42783          	lw	a5,-20(s0)
     388:	853e                	mv	a0,a5
     38a:	00000097          	auipc	ra,0x0
     38e:	236080e7          	jalr	566(ra) # 5c0 <close>
  return r;
     392:	fe842783          	lw	a5,-24(s0)
}
     396:	853e                	mv	a0,a5
     398:	70a2                	ld	ra,40(sp)
     39a:	7402                	ld	s0,32(sp)
     39c:	6145                	addi	sp,sp,48
     39e:	8082                	ret

00000000000003a0 <atoi>:

int
atoi(const char *s)
{
     3a0:	7179                	addi	sp,sp,-48
     3a2:	f422                	sd	s0,40(sp)
     3a4:	1800                	addi	s0,sp,48
     3a6:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     3aa:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     3ae:	a815                	j	3e2 <atoi+0x42>
    n = n*10 + *s++ - '0';
     3b0:	fec42703          	lw	a4,-20(s0)
     3b4:	87ba                	mv	a5,a4
     3b6:	0027979b          	slliw	a5,a5,0x2
     3ba:	9fb9                	addw	a5,a5,a4
     3bc:	0017979b          	slliw	a5,a5,0x1
     3c0:	0007871b          	sext.w	a4,a5
     3c4:	fd843783          	ld	a5,-40(s0)
     3c8:	00178693          	addi	a3,a5,1
     3cc:	fcd43c23          	sd	a3,-40(s0)
     3d0:	0007c783          	lbu	a5,0(a5)
     3d4:	2781                	sext.w	a5,a5
     3d6:	9fb9                	addw	a5,a5,a4
     3d8:	2781                	sext.w	a5,a5
     3da:	fd07879b          	addiw	a5,a5,-48
     3de:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     3e2:	fd843783          	ld	a5,-40(s0)
     3e6:	0007c783          	lbu	a5,0(a5)
     3ea:	873e                	mv	a4,a5
     3ec:	02f00793          	li	a5,47
     3f0:	00e7fb63          	bgeu	a5,a4,406 <atoi+0x66>
     3f4:	fd843783          	ld	a5,-40(s0)
     3f8:	0007c783          	lbu	a5,0(a5)
     3fc:	873e                	mv	a4,a5
     3fe:	03900793          	li	a5,57
     402:	fae7f7e3          	bgeu	a5,a4,3b0 <atoi+0x10>
  return n;
     406:	fec42783          	lw	a5,-20(s0)
}
     40a:	853e                	mv	a0,a5
     40c:	7422                	ld	s0,40(sp)
     40e:	6145                	addi	sp,sp,48
     410:	8082                	ret

0000000000000412 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     412:	7139                	addi	sp,sp,-64
     414:	fc22                	sd	s0,56(sp)
     416:	0080                	addi	s0,sp,64
     418:	fca43c23          	sd	a0,-40(s0)
     41c:	fcb43823          	sd	a1,-48(s0)
     420:	87b2                	mv	a5,a2
     422:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     426:	fd843783          	ld	a5,-40(s0)
     42a:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     42e:	fd043783          	ld	a5,-48(s0)
     432:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     436:	fe043703          	ld	a4,-32(s0)
     43a:	fe843783          	ld	a5,-24(s0)
     43e:	02e7fc63          	bgeu	a5,a4,476 <memmove+0x64>
    while(n-- > 0)
     442:	a00d                	j	464 <memmove+0x52>
      *dst++ = *src++;
     444:	fe043703          	ld	a4,-32(s0)
     448:	00170793          	addi	a5,a4,1
     44c:	fef43023          	sd	a5,-32(s0)
     450:	fe843783          	ld	a5,-24(s0)
     454:	00178693          	addi	a3,a5,1
     458:	fed43423          	sd	a3,-24(s0)
     45c:	00074703          	lbu	a4,0(a4)
     460:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     464:	fcc42783          	lw	a5,-52(s0)
     468:	fff7871b          	addiw	a4,a5,-1
     46c:	fce42623          	sw	a4,-52(s0)
     470:	fcf04ae3          	bgtz	a5,444 <memmove+0x32>
     474:	a891                	j	4c8 <memmove+0xb6>
  } else {
    dst += n;
     476:	fcc42783          	lw	a5,-52(s0)
     47a:	fe843703          	ld	a4,-24(s0)
     47e:	97ba                	add	a5,a5,a4
     480:	fef43423          	sd	a5,-24(s0)
    src += n;
     484:	fcc42783          	lw	a5,-52(s0)
     488:	fe043703          	ld	a4,-32(s0)
     48c:	97ba                	add	a5,a5,a4
     48e:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     492:	a01d                	j	4b8 <memmove+0xa6>
      *--dst = *--src;
     494:	fe043783          	ld	a5,-32(s0)
     498:	17fd                	addi	a5,a5,-1
     49a:	fef43023          	sd	a5,-32(s0)
     49e:	fe843783          	ld	a5,-24(s0)
     4a2:	17fd                	addi	a5,a5,-1
     4a4:	fef43423          	sd	a5,-24(s0)
     4a8:	fe043783          	ld	a5,-32(s0)
     4ac:	0007c703          	lbu	a4,0(a5)
     4b0:	fe843783          	ld	a5,-24(s0)
     4b4:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     4b8:	fcc42783          	lw	a5,-52(s0)
     4bc:	fff7871b          	addiw	a4,a5,-1
     4c0:	fce42623          	sw	a4,-52(s0)
     4c4:	fcf048e3          	bgtz	a5,494 <memmove+0x82>
  }
  return vdst;
     4c8:	fd843783          	ld	a5,-40(s0)
}
     4cc:	853e                	mv	a0,a5
     4ce:	7462                	ld	s0,56(sp)
     4d0:	6121                	addi	sp,sp,64
     4d2:	8082                	ret

00000000000004d4 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     4d4:	7139                	addi	sp,sp,-64
     4d6:	fc22                	sd	s0,56(sp)
     4d8:	0080                	addi	s0,sp,64
     4da:	fca43c23          	sd	a0,-40(s0)
     4de:	fcb43823          	sd	a1,-48(s0)
     4e2:	87b2                	mv	a5,a2
     4e4:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     4e8:	fd843783          	ld	a5,-40(s0)
     4ec:	fef43423          	sd	a5,-24(s0)
     4f0:	fd043783          	ld	a5,-48(s0)
     4f4:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     4f8:	a0a1                	j	540 <memcmp+0x6c>
    if (*p1 != *p2) {
     4fa:	fe843783          	ld	a5,-24(s0)
     4fe:	0007c703          	lbu	a4,0(a5)
     502:	fe043783          	ld	a5,-32(s0)
     506:	0007c783          	lbu	a5,0(a5)
     50a:	02f70163          	beq	a4,a5,52c <memcmp+0x58>
      return *p1 - *p2;
     50e:	fe843783          	ld	a5,-24(s0)
     512:	0007c783          	lbu	a5,0(a5)
     516:	0007871b          	sext.w	a4,a5
     51a:	fe043783          	ld	a5,-32(s0)
     51e:	0007c783          	lbu	a5,0(a5)
     522:	2781                	sext.w	a5,a5
     524:	40f707bb          	subw	a5,a4,a5
     528:	2781                	sext.w	a5,a5
     52a:	a01d                	j	550 <memcmp+0x7c>
    }
    p1++;
     52c:	fe843783          	ld	a5,-24(s0)
     530:	0785                	addi	a5,a5,1
     532:	fef43423          	sd	a5,-24(s0)
    p2++;
     536:	fe043783          	ld	a5,-32(s0)
     53a:	0785                	addi	a5,a5,1
     53c:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     540:	fcc42783          	lw	a5,-52(s0)
     544:	fff7871b          	addiw	a4,a5,-1
     548:	fce42623          	sw	a4,-52(s0)
     54c:	f7dd                	bnez	a5,4fa <memcmp+0x26>
  }
  return 0;
     54e:	4781                	li	a5,0
}
     550:	853e                	mv	a0,a5
     552:	7462                	ld	s0,56(sp)
     554:	6121                	addi	sp,sp,64
     556:	8082                	ret

0000000000000558 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     558:	7179                	addi	sp,sp,-48
     55a:	f406                	sd	ra,40(sp)
     55c:	f022                	sd	s0,32(sp)
     55e:	1800                	addi	s0,sp,48
     560:	fea43423          	sd	a0,-24(s0)
     564:	feb43023          	sd	a1,-32(s0)
     568:	87b2                	mv	a5,a2
     56a:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     56e:	fdc42783          	lw	a5,-36(s0)
     572:	863e                	mv	a2,a5
     574:	fe043583          	ld	a1,-32(s0)
     578:	fe843503          	ld	a0,-24(s0)
     57c:	00000097          	auipc	ra,0x0
     580:	e96080e7          	jalr	-362(ra) # 412 <memmove>
     584:	87aa                	mv	a5,a0
}
     586:	853e                	mv	a0,a5
     588:	70a2                	ld	ra,40(sp)
     58a:	7402                	ld	s0,32(sp)
     58c:	6145                	addi	sp,sp,48
     58e:	8082                	ret

0000000000000590 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     590:	4885                	li	a7,1
 ecall
     592:	00000073          	ecall
 ret
     596:	8082                	ret

0000000000000598 <exit>:
.global exit
exit:
 li a7, SYS_exit
     598:	4889                	li	a7,2
 ecall
     59a:	00000073          	ecall
 ret
     59e:	8082                	ret

00000000000005a0 <wait>:
.global wait
wait:
 li a7, SYS_wait
     5a0:	488d                	li	a7,3
 ecall
     5a2:	00000073          	ecall
 ret
     5a6:	8082                	ret

00000000000005a8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     5a8:	4891                	li	a7,4
 ecall
     5aa:	00000073          	ecall
 ret
     5ae:	8082                	ret

00000000000005b0 <read>:
.global read
read:
 li a7, SYS_read
     5b0:	4895                	li	a7,5
 ecall
     5b2:	00000073          	ecall
 ret
     5b6:	8082                	ret

00000000000005b8 <write>:
.global write
write:
 li a7, SYS_write
     5b8:	48c1                	li	a7,16
 ecall
     5ba:	00000073          	ecall
 ret
     5be:	8082                	ret

00000000000005c0 <close>:
.global close
close:
 li a7, SYS_close
     5c0:	48d5                	li	a7,21
 ecall
     5c2:	00000073          	ecall
 ret
     5c6:	8082                	ret

00000000000005c8 <kill>:
.global kill
kill:
 li a7, SYS_kill
     5c8:	4899                	li	a7,6
 ecall
     5ca:	00000073          	ecall
 ret
     5ce:	8082                	ret

00000000000005d0 <exec>:
.global exec
exec:
 li a7, SYS_exec
     5d0:	489d                	li	a7,7
 ecall
     5d2:	00000073          	ecall
 ret
     5d6:	8082                	ret

00000000000005d8 <open>:
.global open
open:
 li a7, SYS_open
     5d8:	48bd                	li	a7,15
 ecall
     5da:	00000073          	ecall
 ret
     5de:	8082                	ret

00000000000005e0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     5e0:	48c5                	li	a7,17
 ecall
     5e2:	00000073          	ecall
 ret
     5e6:	8082                	ret

00000000000005e8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     5e8:	48c9                	li	a7,18
 ecall
     5ea:	00000073          	ecall
 ret
     5ee:	8082                	ret

00000000000005f0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     5f0:	48a1                	li	a7,8
 ecall
     5f2:	00000073          	ecall
 ret
     5f6:	8082                	ret

00000000000005f8 <link>:
.global link
link:
 li a7, SYS_link
     5f8:	48cd                	li	a7,19
 ecall
     5fa:	00000073          	ecall
 ret
     5fe:	8082                	ret

0000000000000600 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     600:	48d1                	li	a7,20
 ecall
     602:	00000073          	ecall
 ret
     606:	8082                	ret

0000000000000608 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     608:	48a5                	li	a7,9
 ecall
     60a:	00000073          	ecall
 ret
     60e:	8082                	ret

0000000000000610 <dup>:
.global dup
dup:
 li a7, SYS_dup
     610:	48a9                	li	a7,10
 ecall
     612:	00000073          	ecall
 ret
     616:	8082                	ret

0000000000000618 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     618:	48ad                	li	a7,11
 ecall
     61a:	00000073          	ecall
 ret
     61e:	8082                	ret

0000000000000620 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     620:	48b1                	li	a7,12
 ecall
     622:	00000073          	ecall
 ret
     626:	8082                	ret

0000000000000628 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     628:	48b5                	li	a7,13
 ecall
     62a:	00000073          	ecall
 ret
     62e:	8082                	ret

0000000000000630 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     630:	48b9                	li	a7,14
 ecall
     632:	00000073          	ecall
 ret
     636:	8082                	ret

0000000000000638 <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     638:	48d9                	li	a7,22
 ecall
     63a:	00000073          	ecall
 ret
     63e:	8082                	ret

0000000000000640 <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     640:	48dd                	li	a7,23
 ecall
     642:	00000073          	ecall
 ret
     646:	8082                	ret

0000000000000648 <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     648:	48e1                	li	a7,24
 ecall
     64a:	00000073          	ecall
 ret
     64e:	8082                	ret

0000000000000650 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     650:	1101                	addi	sp,sp,-32
     652:	ec06                	sd	ra,24(sp)
     654:	e822                	sd	s0,16(sp)
     656:	1000                	addi	s0,sp,32
     658:	87aa                	mv	a5,a0
     65a:	872e                	mv	a4,a1
     65c:	fef42623          	sw	a5,-20(s0)
     660:	87ba                	mv	a5,a4
     662:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     666:	feb40713          	addi	a4,s0,-21
     66a:	fec42783          	lw	a5,-20(s0)
     66e:	4605                	li	a2,1
     670:	85ba                	mv	a1,a4
     672:	853e                	mv	a0,a5
     674:	00000097          	auipc	ra,0x0
     678:	f44080e7          	jalr	-188(ra) # 5b8 <write>
}
     67c:	0001                	nop
     67e:	60e2                	ld	ra,24(sp)
     680:	6442                	ld	s0,16(sp)
     682:	6105                	addi	sp,sp,32
     684:	8082                	ret

0000000000000686 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     686:	7139                	addi	sp,sp,-64
     688:	fc06                	sd	ra,56(sp)
     68a:	f822                	sd	s0,48(sp)
     68c:	0080                	addi	s0,sp,64
     68e:	87aa                	mv	a5,a0
     690:	8736                	mv	a4,a3
     692:	fcf42623          	sw	a5,-52(s0)
     696:	87ae                	mv	a5,a1
     698:	fcf42423          	sw	a5,-56(s0)
     69c:	87b2                	mv	a5,a2
     69e:	fcf42223          	sw	a5,-60(s0)
     6a2:	87ba                	mv	a5,a4
     6a4:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     6a8:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     6ac:	fc042783          	lw	a5,-64(s0)
     6b0:	2781                	sext.w	a5,a5
     6b2:	c38d                	beqz	a5,6d4 <printint+0x4e>
     6b4:	fc842783          	lw	a5,-56(s0)
     6b8:	2781                	sext.w	a5,a5
     6ba:	0007dd63          	bgez	a5,6d4 <printint+0x4e>
    neg = 1;
     6be:	4785                	li	a5,1
     6c0:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     6c4:	fc842783          	lw	a5,-56(s0)
     6c8:	40f007bb          	negw	a5,a5
     6cc:	2781                	sext.w	a5,a5
     6ce:	fef42223          	sw	a5,-28(s0)
     6d2:	a029                	j	6dc <printint+0x56>
  } else {
    x = xx;
     6d4:	fc842783          	lw	a5,-56(s0)
     6d8:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     6dc:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     6e0:	fc442783          	lw	a5,-60(s0)
     6e4:	fe442703          	lw	a4,-28(s0)
     6e8:	02f777bb          	remuw	a5,a4,a5
     6ec:	0007861b          	sext.w	a2,a5
     6f0:	fec42783          	lw	a5,-20(s0)
     6f4:	0017871b          	addiw	a4,a5,1
     6f8:	fee42623          	sw	a4,-20(s0)
     6fc:	00001697          	auipc	a3,0x1
     700:	6b468693          	addi	a3,a3,1716 # 1db0 <digits>
     704:	02061713          	slli	a4,a2,0x20
     708:	9301                	srli	a4,a4,0x20
     70a:	9736                	add	a4,a4,a3
     70c:	00074703          	lbu	a4,0(a4)
     710:	ff040693          	addi	a3,s0,-16
     714:	97b6                	add	a5,a5,a3
     716:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     71a:	fc442783          	lw	a5,-60(s0)
     71e:	fe442703          	lw	a4,-28(s0)
     722:	02f757bb          	divuw	a5,a4,a5
     726:	fef42223          	sw	a5,-28(s0)
     72a:	fe442783          	lw	a5,-28(s0)
     72e:	2781                	sext.w	a5,a5
     730:	fbc5                	bnez	a5,6e0 <printint+0x5a>
  if(neg)
     732:	fe842783          	lw	a5,-24(s0)
     736:	2781                	sext.w	a5,a5
     738:	cf95                	beqz	a5,774 <printint+0xee>
    buf[i++] = '-';
     73a:	fec42783          	lw	a5,-20(s0)
     73e:	0017871b          	addiw	a4,a5,1
     742:	fee42623          	sw	a4,-20(s0)
     746:	ff040713          	addi	a4,s0,-16
     74a:	97ba                	add	a5,a5,a4
     74c:	02d00713          	li	a4,45
     750:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     754:	a005                	j	774 <printint+0xee>
    putc(fd, buf[i]);
     756:	fec42783          	lw	a5,-20(s0)
     75a:	ff040713          	addi	a4,s0,-16
     75e:	97ba                	add	a5,a5,a4
     760:	fe07c703          	lbu	a4,-32(a5)
     764:	fcc42783          	lw	a5,-52(s0)
     768:	85ba                	mv	a1,a4
     76a:	853e                	mv	a0,a5
     76c:	00000097          	auipc	ra,0x0
     770:	ee4080e7          	jalr	-284(ra) # 650 <putc>
  while(--i >= 0)
     774:	fec42783          	lw	a5,-20(s0)
     778:	37fd                	addiw	a5,a5,-1
     77a:	fef42623          	sw	a5,-20(s0)
     77e:	fec42783          	lw	a5,-20(s0)
     782:	2781                	sext.w	a5,a5
     784:	fc07d9e3          	bgez	a5,756 <printint+0xd0>
}
     788:	0001                	nop
     78a:	0001                	nop
     78c:	70e2                	ld	ra,56(sp)
     78e:	7442                	ld	s0,48(sp)
     790:	6121                	addi	sp,sp,64
     792:	8082                	ret

0000000000000794 <printptr>:

static void
printptr(int fd, uint64 x) {
     794:	7179                	addi	sp,sp,-48
     796:	f406                	sd	ra,40(sp)
     798:	f022                	sd	s0,32(sp)
     79a:	1800                	addi	s0,sp,48
     79c:	87aa                	mv	a5,a0
     79e:	fcb43823          	sd	a1,-48(s0)
     7a2:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     7a6:	fdc42783          	lw	a5,-36(s0)
     7aa:	03000593          	li	a1,48
     7ae:	853e                	mv	a0,a5
     7b0:	00000097          	auipc	ra,0x0
     7b4:	ea0080e7          	jalr	-352(ra) # 650 <putc>
  putc(fd, 'x');
     7b8:	fdc42783          	lw	a5,-36(s0)
     7bc:	07800593          	li	a1,120
     7c0:	853e                	mv	a0,a5
     7c2:	00000097          	auipc	ra,0x0
     7c6:	e8e080e7          	jalr	-370(ra) # 650 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     7ca:	fe042623          	sw	zero,-20(s0)
     7ce:	a82d                	j	808 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     7d0:	fd043783          	ld	a5,-48(s0)
     7d4:	93f1                	srli	a5,a5,0x3c
     7d6:	00001717          	auipc	a4,0x1
     7da:	5da70713          	addi	a4,a4,1498 # 1db0 <digits>
     7de:	97ba                	add	a5,a5,a4
     7e0:	0007c703          	lbu	a4,0(a5)
     7e4:	fdc42783          	lw	a5,-36(s0)
     7e8:	85ba                	mv	a1,a4
     7ea:	853e                	mv	a0,a5
     7ec:	00000097          	auipc	ra,0x0
     7f0:	e64080e7          	jalr	-412(ra) # 650 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     7f4:	fec42783          	lw	a5,-20(s0)
     7f8:	2785                	addiw	a5,a5,1
     7fa:	fef42623          	sw	a5,-20(s0)
     7fe:	fd043783          	ld	a5,-48(s0)
     802:	0792                	slli	a5,a5,0x4
     804:	fcf43823          	sd	a5,-48(s0)
     808:	fec42783          	lw	a5,-20(s0)
     80c:	873e                	mv	a4,a5
     80e:	47bd                	li	a5,15
     810:	fce7f0e3          	bgeu	a5,a4,7d0 <printptr+0x3c>
}
     814:	0001                	nop
     816:	0001                	nop
     818:	70a2                	ld	ra,40(sp)
     81a:	7402                	ld	s0,32(sp)
     81c:	6145                	addi	sp,sp,48
     81e:	8082                	ret

0000000000000820 <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     820:	715d                	addi	sp,sp,-80
     822:	e486                	sd	ra,72(sp)
     824:	e0a2                	sd	s0,64(sp)
     826:	0880                	addi	s0,sp,80
     828:	87aa                	mv	a5,a0
     82a:	fcb43023          	sd	a1,-64(s0)
     82e:	fac43c23          	sd	a2,-72(s0)
     832:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     836:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     83a:	fe042223          	sw	zero,-28(s0)
     83e:	a42d                	j	a68 <vprintf+0x248>
    c = fmt[i] & 0xff;
     840:	fe442783          	lw	a5,-28(s0)
     844:	fc043703          	ld	a4,-64(s0)
     848:	97ba                	add	a5,a5,a4
     84a:	0007c783          	lbu	a5,0(a5)
     84e:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     852:	fe042783          	lw	a5,-32(s0)
     856:	2781                	sext.w	a5,a5
     858:	eb9d                	bnez	a5,88e <vprintf+0x6e>
      if(c == '%'){
     85a:	fdc42783          	lw	a5,-36(s0)
     85e:	0007871b          	sext.w	a4,a5
     862:	02500793          	li	a5,37
     866:	00f71763          	bne	a4,a5,874 <vprintf+0x54>
        state = '%';
     86a:	02500793          	li	a5,37
     86e:	fef42023          	sw	a5,-32(s0)
     872:	a2f5                	j	a5e <vprintf+0x23e>
      } else {
        putc(fd, c);
     874:	fdc42783          	lw	a5,-36(s0)
     878:	0ff7f713          	andi	a4,a5,255
     87c:	fcc42783          	lw	a5,-52(s0)
     880:	85ba                	mv	a1,a4
     882:	853e                	mv	a0,a5
     884:	00000097          	auipc	ra,0x0
     888:	dcc080e7          	jalr	-564(ra) # 650 <putc>
     88c:	aac9                	j	a5e <vprintf+0x23e>
      }
    } else if(state == '%'){
     88e:	fe042783          	lw	a5,-32(s0)
     892:	0007871b          	sext.w	a4,a5
     896:	02500793          	li	a5,37
     89a:	1cf71263          	bne	a4,a5,a5e <vprintf+0x23e>
      if(c == 'd'){
     89e:	fdc42783          	lw	a5,-36(s0)
     8a2:	0007871b          	sext.w	a4,a5
     8a6:	06400793          	li	a5,100
     8aa:	02f71463          	bne	a4,a5,8d2 <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     8ae:	fb843783          	ld	a5,-72(s0)
     8b2:	00878713          	addi	a4,a5,8
     8b6:	fae43c23          	sd	a4,-72(s0)
     8ba:	4398                	lw	a4,0(a5)
     8bc:	fcc42783          	lw	a5,-52(s0)
     8c0:	4685                	li	a3,1
     8c2:	4629                	li	a2,10
     8c4:	85ba                	mv	a1,a4
     8c6:	853e                	mv	a0,a5
     8c8:	00000097          	auipc	ra,0x0
     8cc:	dbe080e7          	jalr	-578(ra) # 686 <printint>
     8d0:	a269                	j	a5a <vprintf+0x23a>
      } else if(c == 'l') {
     8d2:	fdc42783          	lw	a5,-36(s0)
     8d6:	0007871b          	sext.w	a4,a5
     8da:	06c00793          	li	a5,108
     8de:	02f71663          	bne	a4,a5,90a <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     8e2:	fb843783          	ld	a5,-72(s0)
     8e6:	00878713          	addi	a4,a5,8
     8ea:	fae43c23          	sd	a4,-72(s0)
     8ee:	639c                	ld	a5,0(a5)
     8f0:	0007871b          	sext.w	a4,a5
     8f4:	fcc42783          	lw	a5,-52(s0)
     8f8:	4681                	li	a3,0
     8fa:	4629                	li	a2,10
     8fc:	85ba                	mv	a1,a4
     8fe:	853e                	mv	a0,a5
     900:	00000097          	auipc	ra,0x0
     904:	d86080e7          	jalr	-634(ra) # 686 <printint>
     908:	aa89                	j	a5a <vprintf+0x23a>
      } else if(c == 'x') {
     90a:	fdc42783          	lw	a5,-36(s0)
     90e:	0007871b          	sext.w	a4,a5
     912:	07800793          	li	a5,120
     916:	02f71463          	bne	a4,a5,93e <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     91a:	fb843783          	ld	a5,-72(s0)
     91e:	00878713          	addi	a4,a5,8
     922:	fae43c23          	sd	a4,-72(s0)
     926:	4398                	lw	a4,0(a5)
     928:	fcc42783          	lw	a5,-52(s0)
     92c:	4681                	li	a3,0
     92e:	4641                	li	a2,16
     930:	85ba                	mv	a1,a4
     932:	853e                	mv	a0,a5
     934:	00000097          	auipc	ra,0x0
     938:	d52080e7          	jalr	-686(ra) # 686 <printint>
     93c:	aa39                	j	a5a <vprintf+0x23a>
      } else if(c == 'p') {
     93e:	fdc42783          	lw	a5,-36(s0)
     942:	0007871b          	sext.w	a4,a5
     946:	07000793          	li	a5,112
     94a:	02f71263          	bne	a4,a5,96e <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     94e:	fb843783          	ld	a5,-72(s0)
     952:	00878713          	addi	a4,a5,8
     956:	fae43c23          	sd	a4,-72(s0)
     95a:	6398                	ld	a4,0(a5)
     95c:	fcc42783          	lw	a5,-52(s0)
     960:	85ba                	mv	a1,a4
     962:	853e                	mv	a0,a5
     964:	00000097          	auipc	ra,0x0
     968:	e30080e7          	jalr	-464(ra) # 794 <printptr>
     96c:	a0fd                	j	a5a <vprintf+0x23a>
      } else if(c == 's'){
     96e:	fdc42783          	lw	a5,-36(s0)
     972:	0007871b          	sext.w	a4,a5
     976:	07300793          	li	a5,115
     97a:	04f71c63          	bne	a4,a5,9d2 <vprintf+0x1b2>
        s = va_arg(ap, char*);
     97e:	fb843783          	ld	a5,-72(s0)
     982:	00878713          	addi	a4,a5,8
     986:	fae43c23          	sd	a4,-72(s0)
     98a:	639c                	ld	a5,0(a5)
     98c:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     990:	fe843783          	ld	a5,-24(s0)
     994:	eb8d                	bnez	a5,9c6 <vprintf+0x1a6>
          s = "(null)";
     996:	00001797          	auipc	a5,0x1
     99a:	29a78793          	addi	a5,a5,666 # 1c30 <schedule_wrr+0x14a>
     99e:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     9a2:	a015                	j	9c6 <vprintf+0x1a6>
          putc(fd, *s);
     9a4:	fe843783          	ld	a5,-24(s0)
     9a8:	0007c703          	lbu	a4,0(a5)
     9ac:	fcc42783          	lw	a5,-52(s0)
     9b0:	85ba                	mv	a1,a4
     9b2:	853e                	mv	a0,a5
     9b4:	00000097          	auipc	ra,0x0
     9b8:	c9c080e7          	jalr	-868(ra) # 650 <putc>
          s++;
     9bc:	fe843783          	ld	a5,-24(s0)
     9c0:	0785                	addi	a5,a5,1
     9c2:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     9c6:	fe843783          	ld	a5,-24(s0)
     9ca:	0007c783          	lbu	a5,0(a5)
     9ce:	fbf9                	bnez	a5,9a4 <vprintf+0x184>
     9d0:	a069                	j	a5a <vprintf+0x23a>
        }
      } else if(c == 'c'){
     9d2:	fdc42783          	lw	a5,-36(s0)
     9d6:	0007871b          	sext.w	a4,a5
     9da:	06300793          	li	a5,99
     9de:	02f71463          	bne	a4,a5,a06 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     9e2:	fb843783          	ld	a5,-72(s0)
     9e6:	00878713          	addi	a4,a5,8
     9ea:	fae43c23          	sd	a4,-72(s0)
     9ee:	439c                	lw	a5,0(a5)
     9f0:	0ff7f713          	andi	a4,a5,255
     9f4:	fcc42783          	lw	a5,-52(s0)
     9f8:	85ba                	mv	a1,a4
     9fa:	853e                	mv	a0,a5
     9fc:	00000097          	auipc	ra,0x0
     a00:	c54080e7          	jalr	-940(ra) # 650 <putc>
     a04:	a899                	j	a5a <vprintf+0x23a>
      } else if(c == '%'){
     a06:	fdc42783          	lw	a5,-36(s0)
     a0a:	0007871b          	sext.w	a4,a5
     a0e:	02500793          	li	a5,37
     a12:	00f71f63          	bne	a4,a5,a30 <vprintf+0x210>
        putc(fd, c);
     a16:	fdc42783          	lw	a5,-36(s0)
     a1a:	0ff7f713          	andi	a4,a5,255
     a1e:	fcc42783          	lw	a5,-52(s0)
     a22:	85ba                	mv	a1,a4
     a24:	853e                	mv	a0,a5
     a26:	00000097          	auipc	ra,0x0
     a2a:	c2a080e7          	jalr	-982(ra) # 650 <putc>
     a2e:	a035                	j	a5a <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     a30:	fcc42783          	lw	a5,-52(s0)
     a34:	02500593          	li	a1,37
     a38:	853e                	mv	a0,a5
     a3a:	00000097          	auipc	ra,0x0
     a3e:	c16080e7          	jalr	-1002(ra) # 650 <putc>
        putc(fd, c);
     a42:	fdc42783          	lw	a5,-36(s0)
     a46:	0ff7f713          	andi	a4,a5,255
     a4a:	fcc42783          	lw	a5,-52(s0)
     a4e:	85ba                	mv	a1,a4
     a50:	853e                	mv	a0,a5
     a52:	00000097          	auipc	ra,0x0
     a56:	bfe080e7          	jalr	-1026(ra) # 650 <putc>
      }
      state = 0;
     a5a:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     a5e:	fe442783          	lw	a5,-28(s0)
     a62:	2785                	addiw	a5,a5,1
     a64:	fef42223          	sw	a5,-28(s0)
     a68:	fe442783          	lw	a5,-28(s0)
     a6c:	fc043703          	ld	a4,-64(s0)
     a70:	97ba                	add	a5,a5,a4
     a72:	0007c783          	lbu	a5,0(a5)
     a76:	dc0795e3          	bnez	a5,840 <vprintf+0x20>
    }
  }
}
     a7a:	0001                	nop
     a7c:	0001                	nop
     a7e:	60a6                	ld	ra,72(sp)
     a80:	6406                	ld	s0,64(sp)
     a82:	6161                	addi	sp,sp,80
     a84:	8082                	ret

0000000000000a86 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     a86:	7159                	addi	sp,sp,-112
     a88:	fc06                	sd	ra,56(sp)
     a8a:	f822                	sd	s0,48(sp)
     a8c:	0080                	addi	s0,sp,64
     a8e:	fcb43823          	sd	a1,-48(s0)
     a92:	e010                	sd	a2,0(s0)
     a94:	e414                	sd	a3,8(s0)
     a96:	e818                	sd	a4,16(s0)
     a98:	ec1c                	sd	a5,24(s0)
     a9a:	03043023          	sd	a6,32(s0)
     a9e:	03143423          	sd	a7,40(s0)
     aa2:	87aa                	mv	a5,a0
     aa4:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     aa8:	03040793          	addi	a5,s0,48
     aac:	fcf43423          	sd	a5,-56(s0)
     ab0:	fc843783          	ld	a5,-56(s0)
     ab4:	fd078793          	addi	a5,a5,-48
     ab8:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     abc:	fe843703          	ld	a4,-24(s0)
     ac0:	fdc42783          	lw	a5,-36(s0)
     ac4:	863a                	mv	a2,a4
     ac6:	fd043583          	ld	a1,-48(s0)
     aca:	853e                	mv	a0,a5
     acc:	00000097          	auipc	ra,0x0
     ad0:	d54080e7          	jalr	-684(ra) # 820 <vprintf>
}
     ad4:	0001                	nop
     ad6:	70e2                	ld	ra,56(sp)
     ad8:	7442                	ld	s0,48(sp)
     ada:	6165                	addi	sp,sp,112
     adc:	8082                	ret

0000000000000ade <printf>:

void
printf(const char *fmt, ...)
{
     ade:	7159                	addi	sp,sp,-112
     ae0:	f406                	sd	ra,40(sp)
     ae2:	f022                	sd	s0,32(sp)
     ae4:	1800                	addi	s0,sp,48
     ae6:	fca43c23          	sd	a0,-40(s0)
     aea:	e40c                	sd	a1,8(s0)
     aec:	e810                	sd	a2,16(s0)
     aee:	ec14                	sd	a3,24(s0)
     af0:	f018                	sd	a4,32(s0)
     af2:	f41c                	sd	a5,40(s0)
     af4:	03043823          	sd	a6,48(s0)
     af8:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     afc:	04040793          	addi	a5,s0,64
     b00:	fcf43823          	sd	a5,-48(s0)
     b04:	fd043783          	ld	a5,-48(s0)
     b08:	fc878793          	addi	a5,a5,-56
     b0c:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     b10:	fe843783          	ld	a5,-24(s0)
     b14:	863e                	mv	a2,a5
     b16:	fd843583          	ld	a1,-40(s0)
     b1a:	4505                	li	a0,1
     b1c:	00000097          	auipc	ra,0x0
     b20:	d04080e7          	jalr	-764(ra) # 820 <vprintf>
}
     b24:	0001                	nop
     b26:	70a2                	ld	ra,40(sp)
     b28:	7402                	ld	s0,32(sp)
     b2a:	6165                	addi	sp,sp,112
     b2c:	8082                	ret

0000000000000b2e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     b2e:	7179                	addi	sp,sp,-48
     b30:	f422                	sd	s0,40(sp)
     b32:	1800                	addi	s0,sp,48
     b34:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     b38:	fd843783          	ld	a5,-40(s0)
     b3c:	17c1                	addi	a5,a5,-16
     b3e:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     b42:	00001797          	auipc	a5,0x1
     b46:	2c678793          	addi	a5,a5,710 # 1e08 <freep>
     b4a:	639c                	ld	a5,0(a5)
     b4c:	fef43423          	sd	a5,-24(s0)
     b50:	a815                	j	b84 <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     b52:	fe843783          	ld	a5,-24(s0)
     b56:	639c                	ld	a5,0(a5)
     b58:	fe843703          	ld	a4,-24(s0)
     b5c:	00f76f63          	bltu	a4,a5,b7a <free+0x4c>
     b60:	fe043703          	ld	a4,-32(s0)
     b64:	fe843783          	ld	a5,-24(s0)
     b68:	02e7eb63          	bltu	a5,a4,b9e <free+0x70>
     b6c:	fe843783          	ld	a5,-24(s0)
     b70:	639c                	ld	a5,0(a5)
     b72:	fe043703          	ld	a4,-32(s0)
     b76:	02f76463          	bltu	a4,a5,b9e <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     b7a:	fe843783          	ld	a5,-24(s0)
     b7e:	639c                	ld	a5,0(a5)
     b80:	fef43423          	sd	a5,-24(s0)
     b84:	fe043703          	ld	a4,-32(s0)
     b88:	fe843783          	ld	a5,-24(s0)
     b8c:	fce7f3e3          	bgeu	a5,a4,b52 <free+0x24>
     b90:	fe843783          	ld	a5,-24(s0)
     b94:	639c                	ld	a5,0(a5)
     b96:	fe043703          	ld	a4,-32(s0)
     b9a:	faf77ce3          	bgeu	a4,a5,b52 <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     b9e:	fe043783          	ld	a5,-32(s0)
     ba2:	479c                	lw	a5,8(a5)
     ba4:	1782                	slli	a5,a5,0x20
     ba6:	9381                	srli	a5,a5,0x20
     ba8:	0792                	slli	a5,a5,0x4
     baa:	fe043703          	ld	a4,-32(s0)
     bae:	973e                	add	a4,a4,a5
     bb0:	fe843783          	ld	a5,-24(s0)
     bb4:	639c                	ld	a5,0(a5)
     bb6:	02f71763          	bne	a4,a5,be4 <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     bba:	fe043783          	ld	a5,-32(s0)
     bbe:	4798                	lw	a4,8(a5)
     bc0:	fe843783          	ld	a5,-24(s0)
     bc4:	639c                	ld	a5,0(a5)
     bc6:	479c                	lw	a5,8(a5)
     bc8:	9fb9                	addw	a5,a5,a4
     bca:	0007871b          	sext.w	a4,a5
     bce:	fe043783          	ld	a5,-32(s0)
     bd2:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     bd4:	fe843783          	ld	a5,-24(s0)
     bd8:	639c                	ld	a5,0(a5)
     bda:	6398                	ld	a4,0(a5)
     bdc:	fe043783          	ld	a5,-32(s0)
     be0:	e398                	sd	a4,0(a5)
     be2:	a039                	j	bf0 <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     be4:	fe843783          	ld	a5,-24(s0)
     be8:	6398                	ld	a4,0(a5)
     bea:	fe043783          	ld	a5,-32(s0)
     bee:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     bf0:	fe843783          	ld	a5,-24(s0)
     bf4:	479c                	lw	a5,8(a5)
     bf6:	1782                	slli	a5,a5,0x20
     bf8:	9381                	srli	a5,a5,0x20
     bfa:	0792                	slli	a5,a5,0x4
     bfc:	fe843703          	ld	a4,-24(s0)
     c00:	97ba                	add	a5,a5,a4
     c02:	fe043703          	ld	a4,-32(s0)
     c06:	02f71563          	bne	a4,a5,c30 <free+0x102>
    p->s.size += bp->s.size;
     c0a:	fe843783          	ld	a5,-24(s0)
     c0e:	4798                	lw	a4,8(a5)
     c10:	fe043783          	ld	a5,-32(s0)
     c14:	479c                	lw	a5,8(a5)
     c16:	9fb9                	addw	a5,a5,a4
     c18:	0007871b          	sext.w	a4,a5
     c1c:	fe843783          	ld	a5,-24(s0)
     c20:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     c22:	fe043783          	ld	a5,-32(s0)
     c26:	6398                	ld	a4,0(a5)
     c28:	fe843783          	ld	a5,-24(s0)
     c2c:	e398                	sd	a4,0(a5)
     c2e:	a031                	j	c3a <free+0x10c>
  } else
    p->s.ptr = bp;
     c30:	fe843783          	ld	a5,-24(s0)
     c34:	fe043703          	ld	a4,-32(s0)
     c38:	e398                	sd	a4,0(a5)
  freep = p;
     c3a:	00001797          	auipc	a5,0x1
     c3e:	1ce78793          	addi	a5,a5,462 # 1e08 <freep>
     c42:	fe843703          	ld	a4,-24(s0)
     c46:	e398                	sd	a4,0(a5)
}
     c48:	0001                	nop
     c4a:	7422                	ld	s0,40(sp)
     c4c:	6145                	addi	sp,sp,48
     c4e:	8082                	ret

0000000000000c50 <morecore>:

static Header*
morecore(uint nu)
{
     c50:	7179                	addi	sp,sp,-48
     c52:	f406                	sd	ra,40(sp)
     c54:	f022                	sd	s0,32(sp)
     c56:	1800                	addi	s0,sp,48
     c58:	87aa                	mv	a5,a0
     c5a:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     c5e:	fdc42783          	lw	a5,-36(s0)
     c62:	0007871b          	sext.w	a4,a5
     c66:	6785                	lui	a5,0x1
     c68:	00f77563          	bgeu	a4,a5,c72 <morecore+0x22>
    nu = 4096;
     c6c:	6785                	lui	a5,0x1
     c6e:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     c72:	fdc42783          	lw	a5,-36(s0)
     c76:	0047979b          	slliw	a5,a5,0x4
     c7a:	2781                	sext.w	a5,a5
     c7c:	2781                	sext.w	a5,a5
     c7e:	853e                	mv	a0,a5
     c80:	00000097          	auipc	ra,0x0
     c84:	9a0080e7          	jalr	-1632(ra) # 620 <sbrk>
     c88:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     c8c:	fe843703          	ld	a4,-24(s0)
     c90:	57fd                	li	a5,-1
     c92:	00f71463          	bne	a4,a5,c9a <morecore+0x4a>
    return 0;
     c96:	4781                	li	a5,0
     c98:	a03d                	j	cc6 <morecore+0x76>
  hp = (Header*)p;
     c9a:	fe843783          	ld	a5,-24(s0)
     c9e:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     ca2:	fe043783          	ld	a5,-32(s0)
     ca6:	fdc42703          	lw	a4,-36(s0)
     caa:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     cac:	fe043783          	ld	a5,-32(s0)
     cb0:	07c1                	addi	a5,a5,16
     cb2:	853e                	mv	a0,a5
     cb4:	00000097          	auipc	ra,0x0
     cb8:	e7a080e7          	jalr	-390(ra) # b2e <free>
  return freep;
     cbc:	00001797          	auipc	a5,0x1
     cc0:	14c78793          	addi	a5,a5,332 # 1e08 <freep>
     cc4:	639c                	ld	a5,0(a5)
}
     cc6:	853e                	mv	a0,a5
     cc8:	70a2                	ld	ra,40(sp)
     cca:	7402                	ld	s0,32(sp)
     ccc:	6145                	addi	sp,sp,48
     cce:	8082                	ret

0000000000000cd0 <malloc>:

void*
malloc(uint nbytes)
{
     cd0:	7139                	addi	sp,sp,-64
     cd2:	fc06                	sd	ra,56(sp)
     cd4:	f822                	sd	s0,48(sp)
     cd6:	0080                	addi	s0,sp,64
     cd8:	87aa                	mv	a5,a0
     cda:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     cde:	fcc46783          	lwu	a5,-52(s0)
     ce2:	07bd                	addi	a5,a5,15
     ce4:	8391                	srli	a5,a5,0x4
     ce6:	2781                	sext.w	a5,a5
     ce8:	2785                	addiw	a5,a5,1
     cea:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     cee:	00001797          	auipc	a5,0x1
     cf2:	11a78793          	addi	a5,a5,282 # 1e08 <freep>
     cf6:	639c                	ld	a5,0(a5)
     cf8:	fef43023          	sd	a5,-32(s0)
     cfc:	fe043783          	ld	a5,-32(s0)
     d00:	ef95                	bnez	a5,d3c <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     d02:	00001797          	auipc	a5,0x1
     d06:	0f678793          	addi	a5,a5,246 # 1df8 <base>
     d0a:	fef43023          	sd	a5,-32(s0)
     d0e:	00001797          	auipc	a5,0x1
     d12:	0fa78793          	addi	a5,a5,250 # 1e08 <freep>
     d16:	fe043703          	ld	a4,-32(s0)
     d1a:	e398                	sd	a4,0(a5)
     d1c:	00001797          	auipc	a5,0x1
     d20:	0ec78793          	addi	a5,a5,236 # 1e08 <freep>
     d24:	6398                	ld	a4,0(a5)
     d26:	00001797          	auipc	a5,0x1
     d2a:	0d278793          	addi	a5,a5,210 # 1df8 <base>
     d2e:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     d30:	00001797          	auipc	a5,0x1
     d34:	0c878793          	addi	a5,a5,200 # 1df8 <base>
     d38:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     d3c:	fe043783          	ld	a5,-32(s0)
     d40:	639c                	ld	a5,0(a5)
     d42:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     d46:	fe843783          	ld	a5,-24(s0)
     d4a:	4798                	lw	a4,8(a5)
     d4c:	fdc42783          	lw	a5,-36(s0)
     d50:	2781                	sext.w	a5,a5
     d52:	06f76863          	bltu	a4,a5,dc2 <malloc+0xf2>
      if(p->s.size == nunits)
     d56:	fe843783          	ld	a5,-24(s0)
     d5a:	4798                	lw	a4,8(a5)
     d5c:	fdc42783          	lw	a5,-36(s0)
     d60:	2781                	sext.w	a5,a5
     d62:	00e79963          	bne	a5,a4,d74 <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     d66:	fe843783          	ld	a5,-24(s0)
     d6a:	6398                	ld	a4,0(a5)
     d6c:	fe043783          	ld	a5,-32(s0)
     d70:	e398                	sd	a4,0(a5)
     d72:	a82d                	j	dac <malloc+0xdc>
      else {
        p->s.size -= nunits;
     d74:	fe843783          	ld	a5,-24(s0)
     d78:	4798                	lw	a4,8(a5)
     d7a:	fdc42783          	lw	a5,-36(s0)
     d7e:	40f707bb          	subw	a5,a4,a5
     d82:	0007871b          	sext.w	a4,a5
     d86:	fe843783          	ld	a5,-24(s0)
     d8a:	c798                	sw	a4,8(a5)
        p += p->s.size;
     d8c:	fe843783          	ld	a5,-24(s0)
     d90:	479c                	lw	a5,8(a5)
     d92:	1782                	slli	a5,a5,0x20
     d94:	9381                	srli	a5,a5,0x20
     d96:	0792                	slli	a5,a5,0x4
     d98:	fe843703          	ld	a4,-24(s0)
     d9c:	97ba                	add	a5,a5,a4
     d9e:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     da2:	fe843783          	ld	a5,-24(s0)
     da6:	fdc42703          	lw	a4,-36(s0)
     daa:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     dac:	00001797          	auipc	a5,0x1
     db0:	05c78793          	addi	a5,a5,92 # 1e08 <freep>
     db4:	fe043703          	ld	a4,-32(s0)
     db8:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     dba:	fe843783          	ld	a5,-24(s0)
     dbe:	07c1                	addi	a5,a5,16
     dc0:	a091                	j	e04 <malloc+0x134>
    }
    if(p == freep)
     dc2:	00001797          	auipc	a5,0x1
     dc6:	04678793          	addi	a5,a5,70 # 1e08 <freep>
     dca:	639c                	ld	a5,0(a5)
     dcc:	fe843703          	ld	a4,-24(s0)
     dd0:	02f71063          	bne	a4,a5,df0 <malloc+0x120>
      if((p = morecore(nunits)) == 0)
     dd4:	fdc42783          	lw	a5,-36(s0)
     dd8:	853e                	mv	a0,a5
     dda:	00000097          	auipc	ra,0x0
     dde:	e76080e7          	jalr	-394(ra) # c50 <morecore>
     de2:	fea43423          	sd	a0,-24(s0)
     de6:	fe843783          	ld	a5,-24(s0)
     dea:	e399                	bnez	a5,df0 <malloc+0x120>
        return 0;
     dec:	4781                	li	a5,0
     dee:	a819                	j	e04 <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     df0:	fe843783          	ld	a5,-24(s0)
     df4:	fef43023          	sd	a5,-32(s0)
     df8:	fe843783          	ld	a5,-24(s0)
     dfc:	639c                	ld	a5,0(a5)
     dfe:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     e02:	b791                	j	d46 <malloc+0x76>
  }
}
     e04:	853e                	mv	a0,a5
     e06:	70e2                	ld	ra,56(sp)
     e08:	7442                	ld	s0,48(sp)
     e0a:	6121                	addi	sp,sp,64
     e0c:	8082                	ret

0000000000000e0e <setjmp>:
     e0e:	e100                	sd	s0,0(a0)
     e10:	e504                	sd	s1,8(a0)
     e12:	01253823          	sd	s2,16(a0)
     e16:	01353c23          	sd	s3,24(a0)
     e1a:	03453023          	sd	s4,32(a0)
     e1e:	03553423          	sd	s5,40(a0)
     e22:	03653823          	sd	s6,48(a0)
     e26:	03753c23          	sd	s7,56(a0)
     e2a:	05853023          	sd	s8,64(a0)
     e2e:	05953423          	sd	s9,72(a0)
     e32:	05a53823          	sd	s10,80(a0)
     e36:	05b53c23          	sd	s11,88(a0)
     e3a:	06153023          	sd	ra,96(a0)
     e3e:	06253423          	sd	sp,104(a0)
     e42:	4501                	li	a0,0
     e44:	8082                	ret

0000000000000e46 <longjmp>:
     e46:	6100                	ld	s0,0(a0)
     e48:	6504                	ld	s1,8(a0)
     e4a:	01053903          	ld	s2,16(a0)
     e4e:	01853983          	ld	s3,24(a0)
     e52:	02053a03          	ld	s4,32(a0)
     e56:	02853a83          	ld	s5,40(a0)
     e5a:	03053b03          	ld	s6,48(a0)
     e5e:	03853b83          	ld	s7,56(a0)
     e62:	04053c03          	ld	s8,64(a0)
     e66:	04853c83          	ld	s9,72(a0)
     e6a:	05053d03          	ld	s10,80(a0)
     e6e:	05853d83          	ld	s11,88(a0)
     e72:	06053083          	ld	ra,96(a0)
     e76:	06853103          	ld	sp,104(a0)
     e7a:	c199                	beqz	a1,e80 <longjmp_1>
     e7c:	852e                	mv	a0,a1
     e7e:	8082                	ret

0000000000000e80 <longjmp_1>:
     e80:	4505                	li	a0,1
     e82:	8082                	ret

0000000000000e84 <__list_add>:
 * the prev/next entries already!
 */
static inline void __list_add(struct list_head *new_entry,
                              struct list_head *prev,
                              struct list_head *next)
{
     e84:	7179                	addi	sp,sp,-48
     e86:	f422                	sd	s0,40(sp)
     e88:	1800                	addi	s0,sp,48
     e8a:	fea43423          	sd	a0,-24(s0)
     e8e:	feb43023          	sd	a1,-32(s0)
     e92:	fcc43c23          	sd	a2,-40(s0)
    next->prev = new_entry;
     e96:	fd843783          	ld	a5,-40(s0)
     e9a:	fe843703          	ld	a4,-24(s0)
     e9e:	e798                	sd	a4,8(a5)
    new_entry->next = next;
     ea0:	fe843783          	ld	a5,-24(s0)
     ea4:	fd843703          	ld	a4,-40(s0)
     ea8:	e398                	sd	a4,0(a5)
    new_entry->prev = prev;
     eaa:	fe843783          	ld	a5,-24(s0)
     eae:	fe043703          	ld	a4,-32(s0)
     eb2:	e798                	sd	a4,8(a5)
    prev->next = new_entry;
     eb4:	fe043783          	ld	a5,-32(s0)
     eb8:	fe843703          	ld	a4,-24(s0)
     ebc:	e398                	sd	a4,0(a5)
}
     ebe:	0001                	nop
     ec0:	7422                	ld	s0,40(sp)
     ec2:	6145                	addi	sp,sp,48
     ec4:	8082                	ret

0000000000000ec6 <list_add_tail>:
 *
 * Insert a new entry before the specified head.
 * This is useful for implementing queues.
 */
static inline void list_add_tail(struct list_head *new_entry, struct list_head *head)
{
     ec6:	1101                	addi	sp,sp,-32
     ec8:	ec06                	sd	ra,24(sp)
     eca:	e822                	sd	s0,16(sp)
     ecc:	1000                	addi	s0,sp,32
     ece:	fea43423          	sd	a0,-24(s0)
     ed2:	feb43023          	sd	a1,-32(s0)
    __list_add(new_entry, head->prev, head);
     ed6:	fe043783          	ld	a5,-32(s0)
     eda:	679c                	ld	a5,8(a5)
     edc:	fe043603          	ld	a2,-32(s0)
     ee0:	85be                	mv	a1,a5
     ee2:	fe843503          	ld	a0,-24(s0)
     ee6:	00000097          	auipc	ra,0x0
     eea:	f9e080e7          	jalr	-98(ra) # e84 <__list_add>
}
     eee:	0001                	nop
     ef0:	60e2                	ld	ra,24(sp)
     ef2:	6442                	ld	s0,16(sp)
     ef4:	6105                	addi	sp,sp,32
     ef6:	8082                	ret

0000000000000ef8 <__list_del>:
 *
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 */
static inline void __list_del(struct list_head *prev, struct list_head *next)
{
     ef8:	1101                	addi	sp,sp,-32
     efa:	ec22                	sd	s0,24(sp)
     efc:	1000                	addi	s0,sp,32
     efe:	fea43423          	sd	a0,-24(s0)
     f02:	feb43023          	sd	a1,-32(s0)
    next->prev = prev;
     f06:	fe043783          	ld	a5,-32(s0)
     f0a:	fe843703          	ld	a4,-24(s0)
     f0e:	e798                	sd	a4,8(a5)
    prev->next = next;
     f10:	fe843783          	ld	a5,-24(s0)
     f14:	fe043703          	ld	a4,-32(s0)
     f18:	e398                	sd	a4,0(a5)
}
     f1a:	0001                	nop
     f1c:	6462                	ld	s0,24(sp)
     f1e:	6105                	addi	sp,sp,32
     f20:	8082                	ret

0000000000000f22 <list_del>:
 * @entry: the element to delete from the list.
 * Note: list_empty on entry does not return true after this, the entry is
 * in an undefined state.
 */
static inline void list_del(struct list_head *entry)
{
     f22:	1101                	addi	sp,sp,-32
     f24:	ec06                	sd	ra,24(sp)
     f26:	e822                	sd	s0,16(sp)
     f28:	1000                	addi	s0,sp,32
     f2a:	fea43423          	sd	a0,-24(s0)
    __list_del(entry->prev, entry->next);
     f2e:	fe843783          	ld	a5,-24(s0)
     f32:	6798                	ld	a4,8(a5)
     f34:	fe843783          	ld	a5,-24(s0)
     f38:	639c                	ld	a5,0(a5)
     f3a:	85be                	mv	a1,a5
     f3c:	853a                	mv	a0,a4
     f3e:	00000097          	auipc	ra,0x0
     f42:	fba080e7          	jalr	-70(ra) # ef8 <__list_del>
    entry->next = LIST_POISON1;
     f46:	fe843783          	ld	a5,-24(s0)
     f4a:	00100737          	lui	a4,0x100
     f4e:	10070713          	addi	a4,a4,256 # 100100 <__global_pointer$+0xfdb50>
     f52:	e398                	sd	a4,0(a5)
    entry->prev = LIST_POISON2;
     f54:	fe843783          	ld	a5,-24(s0)
     f58:	00200737          	lui	a4,0x200
     f5c:	20070713          	addi	a4,a4,512 # 200200 <__global_pointer$+0x1fdc50>
     f60:	e798                	sd	a4,8(a5)
}
     f62:	0001                	nop
     f64:	60e2                	ld	ra,24(sp)
     f66:	6442                	ld	s0,16(sp)
     f68:	6105                	addi	sp,sp,32
     f6a:	8082                	ret

0000000000000f6c <list_empty>:
/**
 * list_empty - tests whether a list is empty
 * @head: the list to test.
 */
static inline int list_empty(const struct list_head *head)
{
     f6c:	1101                	addi	sp,sp,-32
     f6e:	ec22                	sd	s0,24(sp)
     f70:	1000                	addi	s0,sp,32
     f72:	fea43423          	sd	a0,-24(s0)
    return head->next == head;
     f76:	fe843783          	ld	a5,-24(s0)
     f7a:	639c                	ld	a5,0(a5)
     f7c:	fe843703          	ld	a4,-24(s0)
     f80:	40f707b3          	sub	a5,a4,a5
     f84:	0017b793          	seqz	a5,a5
     f88:	0ff7f793          	andi	a5,a5,255
     f8c:	2781                	sext.w	a5,a5
}
     f8e:	853e                	mv	a0,a5
     f90:	6462                	ld	s0,24(sp)
     f92:	6105                	addi	sp,sp,32
     f94:	8082                	ret

0000000000000f96 <thread_create>:

void __dispatch(void);
void __schedule(void);

struct thread *thread_create(void (*f)(void *), void *arg, int is_real_time, int processing_time, int period, int n)
{
     f96:	715d                	addi	sp,sp,-80
     f98:	e486                	sd	ra,72(sp)
     f9a:	e0a2                	sd	s0,64(sp)
     f9c:	0880                	addi	s0,sp,80
     f9e:	fca43423          	sd	a0,-56(s0)
     fa2:	fcb43023          	sd	a1,-64(s0)
     fa6:	85b2                	mv	a1,a2
     fa8:	8636                	mv	a2,a3
     faa:	86ba                	mv	a3,a4
     fac:	873e                	mv	a4,a5
     fae:	87ae                	mv	a5,a1
     fb0:	faf42e23          	sw	a5,-68(s0)
     fb4:	87b2                	mv	a5,a2
     fb6:	faf42c23          	sw	a5,-72(s0)
     fba:	87b6                	mv	a5,a3
     fbc:	faf42a23          	sw	a5,-76(s0)
     fc0:	87ba                	mv	a5,a4
     fc2:	faf42823          	sw	a5,-80(s0)
    static int _id = 1;
    struct thread *t = (struct thread *)malloc(sizeof(struct thread));
     fc6:	06000513          	li	a0,96
     fca:	00000097          	auipc	ra,0x0
     fce:	d06080e7          	jalr	-762(ra) # cd0 <malloc>
     fd2:	fea43423          	sd	a0,-24(s0)
    unsigned long new_stack_p;
    unsigned long new_stack;
    new_stack = (unsigned long)malloc(sizeof(unsigned long) * 0x200);
     fd6:	6505                	lui	a0,0x1
     fd8:	00000097          	auipc	ra,0x0
     fdc:	cf8080e7          	jalr	-776(ra) # cd0 <malloc>
     fe0:	87aa                	mv	a5,a0
     fe2:	fef43023          	sd	a5,-32(s0)
    new_stack_p = new_stack + 0x200 * 8 - 0x2 * 8;
     fe6:	fe043703          	ld	a4,-32(s0)
     fea:	6785                	lui	a5,0x1
     fec:	17c1                	addi	a5,a5,-16
     fee:	97ba                	add	a5,a5,a4
     ff0:	fcf43c23          	sd	a5,-40(s0)
    t->fp = f;
     ff4:	fe843783          	ld	a5,-24(s0)
     ff8:	fc843703          	ld	a4,-56(s0)
     ffc:	e398                	sd	a4,0(a5)
    t->arg = arg;
     ffe:	fe843783          	ld	a5,-24(s0)
    1002:	fc043703          	ld	a4,-64(s0)
    1006:	e798                	sd	a4,8(a5)
    t->ID = _id++;
    1008:	00001797          	auipc	a5,0x1
    100c:	de478793          	addi	a5,a5,-540 # 1dec <_id.1229>
    1010:	439c                	lw	a5,0(a5)
    1012:	0017871b          	addiw	a4,a5,1
    1016:	0007069b          	sext.w	a3,a4
    101a:	00001717          	auipc	a4,0x1
    101e:	dd270713          	addi	a4,a4,-558 # 1dec <_id.1229>
    1022:	c314                	sw	a3,0(a4)
    1024:	fe843703          	ld	a4,-24(s0)
    1028:	df5c                	sw	a5,60(a4)
    t->buf_set = 0;
    102a:	fe843783          	ld	a5,-24(s0)
    102e:	0207a023          	sw	zero,32(a5)
    t->stack = (void *)new_stack;
    1032:	fe043703          	ld	a4,-32(s0)
    1036:	fe843783          	ld	a5,-24(s0)
    103a:	eb98                	sd	a4,16(a5)
    t->stack_p = (void *)new_stack_p;
    103c:	fd843703          	ld	a4,-40(s0)
    1040:	fe843783          	ld	a5,-24(s0)
    1044:	ef98                	sd	a4,24(a5)

    t->processing_time = processing_time;
    1046:	fe843783          	ld	a5,-24(s0)
    104a:	fb842703          	lw	a4,-72(s0)
    104e:	c3f8                	sw	a4,68(a5)
    t->period = period;
    1050:	fe843783          	ld	a5,-24(s0)
    1054:	fb442703          	lw	a4,-76(s0)
    1058:	cbb8                	sw	a4,80(a5)
    t->deadline = period;
    105a:	fe843783          	ld	a5,-24(s0)
    105e:	fb442703          	lw	a4,-76(s0)
    1062:	c7f8                	sw	a4,76(a5)
    t->n = n;
    1064:	fe843783          	ld	a5,-24(s0)
    1068:	fb042703          	lw	a4,-80(s0)
    106c:	cbf8                	sw	a4,84(a5)
    t->is_real_time = is_real_time;
    106e:	fe843783          	ld	a5,-24(s0)
    1072:	fbc42703          	lw	a4,-68(s0)
    1076:	c3b8                	sw	a4,64(a5)
    t->weight = 1;
    1078:	fe843783          	ld	a5,-24(s0)
    107c:	4705                	li	a4,1
    107e:	c7b8                	sw	a4,72(a5)
    t->remaining_time = processing_time;
    1080:	fe843783          	ld	a5,-24(s0)
    1084:	fb842703          	lw	a4,-72(s0)
    1088:	cfb8                	sw	a4,88(a5)
    t->current_deadline = 0;
    108a:	fe843783          	ld	a5,-24(s0)
    108e:	0407ae23          	sw	zero,92(a5)
    return t;
    1092:	fe843783          	ld	a5,-24(s0)
}
    1096:	853e                	mv	a0,a5
    1098:	60a6                	ld	ra,72(sp)
    109a:	6406                	ld	s0,64(sp)
    109c:	6161                	addi	sp,sp,80
    109e:	8082                	ret

00000000000010a0 <thread_set_weight>:

void thread_set_weight(struct thread *t, int weight)
{
    10a0:	1101                	addi	sp,sp,-32
    10a2:	ec22                	sd	s0,24(sp)
    10a4:	1000                	addi	s0,sp,32
    10a6:	fea43423          	sd	a0,-24(s0)
    10aa:	87ae                	mv	a5,a1
    10ac:	fef42223          	sw	a5,-28(s0)
    t->weight = weight;
    10b0:	fe843783          	ld	a5,-24(s0)
    10b4:	fe442703          	lw	a4,-28(s0)
    10b8:	c7b8                	sw	a4,72(a5)
}
    10ba:	0001                	nop
    10bc:	6462                	ld	s0,24(sp)
    10be:	6105                	addi	sp,sp,32
    10c0:	8082                	ret

00000000000010c2 <thread_add_at>:

void thread_add_at(struct thread *t, int arrival_time)
{
    10c2:	7179                	addi	sp,sp,-48
    10c4:	f406                	sd	ra,40(sp)
    10c6:	f022                	sd	s0,32(sp)
    10c8:	1800                	addi	s0,sp,48
    10ca:	fca43c23          	sd	a0,-40(s0)
    10ce:	87ae                	mv	a5,a1
    10d0:	fcf42a23          	sw	a5,-44(s0)
    struct release_queue_entry *new_entry = (struct release_queue_entry *)malloc(sizeof(struct release_queue_entry));
    10d4:	02000513          	li	a0,32
    10d8:	00000097          	auipc	ra,0x0
    10dc:	bf8080e7          	jalr	-1032(ra) # cd0 <malloc>
    10e0:	fea43423          	sd	a0,-24(s0)
    new_entry->thrd = t;
    10e4:	fe843783          	ld	a5,-24(s0)
    10e8:	fd843703          	ld	a4,-40(s0)
    10ec:	e398                	sd	a4,0(a5)
    new_entry->release_time = arrival_time;
    10ee:	fe843783          	ld	a5,-24(s0)
    10f2:	fd442703          	lw	a4,-44(s0)
    10f6:	cf98                	sw	a4,24(a5)
    if (t->is_real_time)
    10f8:	fd843783          	ld	a5,-40(s0)
    10fc:	43bc                	lw	a5,64(a5)
    10fe:	c38d                	beqz	a5,1120 <thread_add_at+0x5e>
    {
        t->current_deadline = arrival_time;
    1100:	fd843783          	ld	a5,-40(s0)
    1104:	fd442703          	lw	a4,-44(s0)
    1108:	cff8                	sw	a4,92(a5)
        t->current_deadline = arrival_time + t->deadline;
    110a:	fd843783          	ld	a5,-40(s0)
    110e:	47fc                	lw	a5,76(a5)
    1110:	fd442703          	lw	a4,-44(s0)
    1114:	9fb9                	addw	a5,a5,a4
    1116:	0007871b          	sext.w	a4,a5
    111a:	fd843783          	ld	a5,-40(s0)
    111e:	cff8                	sw	a4,92(a5)
    }
    list_add_tail(&new_entry->thread_list, &release_queue);
    1120:	fe843783          	ld	a5,-24(s0)
    1124:	07a1                	addi	a5,a5,8
    1126:	00001597          	auipc	a1,0x1
    112a:	cb258593          	addi	a1,a1,-846 # 1dd8 <release_queue>
    112e:	853e                	mv	a0,a5
    1130:	00000097          	auipc	ra,0x0
    1134:	d96080e7          	jalr	-618(ra) # ec6 <list_add_tail>
}
    1138:	0001                	nop
    113a:	70a2                	ld	ra,40(sp)
    113c:	7402                	ld	s0,32(sp)
    113e:	6145                	addi	sp,sp,48
    1140:	8082                	ret

0000000000001142 <__release>:

void __release()
{
    1142:	7139                	addi	sp,sp,-64
    1144:	fc06                	sd	ra,56(sp)
    1146:	f822                	sd	s0,48(sp)
    1148:	0080                	addi	s0,sp,64
    struct release_queue_entry *cur, *nxt;
    list_for_each_entry_safe(cur, nxt, &release_queue, thread_list)
    114a:	00001797          	auipc	a5,0x1
    114e:	c8e78793          	addi	a5,a5,-882 # 1dd8 <release_queue>
    1152:	639c                	ld	a5,0(a5)
    1154:	fcf43c23          	sd	a5,-40(s0)
    1158:	fd843783          	ld	a5,-40(s0)
    115c:	17e1                	addi	a5,a5,-8
    115e:	fef43423          	sd	a5,-24(s0)
    1162:	fe843783          	ld	a5,-24(s0)
    1166:	679c                	ld	a5,8(a5)
    1168:	fcf43823          	sd	a5,-48(s0)
    116c:	fd043783          	ld	a5,-48(s0)
    1170:	17e1                	addi	a5,a5,-8
    1172:	fef43023          	sd	a5,-32(s0)
    1176:	a851                	j	120a <__release+0xc8>
    {
        if (threading_system_time >= cur->release_time)
    1178:	fe843783          	ld	a5,-24(s0)
    117c:	4f98                	lw	a4,24(a5)
    117e:	00001797          	auipc	a5,0x1
    1182:	c9a78793          	addi	a5,a5,-870 # 1e18 <threading_system_time>
    1186:	439c                	lw	a5,0(a5)
    1188:	06e7c363          	blt	a5,a4,11ee <__release+0xac>
        {
            cur->thrd->remaining_time = cur->thrd->processing_time;
    118c:	fe843783          	ld	a5,-24(s0)
    1190:	6398                	ld	a4,0(a5)
    1192:	fe843783          	ld	a5,-24(s0)
    1196:	639c                	ld	a5,0(a5)
    1198:	4378                	lw	a4,68(a4)
    119a:	cfb8                	sw	a4,88(a5)
            cur->thrd->current_deadline = cur->release_time + cur->thrd->deadline;
    119c:	fe843783          	ld	a5,-24(s0)
    11a0:	4f94                	lw	a3,24(a5)
    11a2:	fe843783          	ld	a5,-24(s0)
    11a6:	639c                	ld	a5,0(a5)
    11a8:	47f8                	lw	a4,76(a5)
    11aa:	fe843783          	ld	a5,-24(s0)
    11ae:	639c                	ld	a5,0(a5)
    11b0:	9f35                	addw	a4,a4,a3
    11b2:	2701                	sext.w	a4,a4
    11b4:	cff8                	sw	a4,92(a5)
            list_add_tail(&cur->thrd->thread_list, &run_queue);
    11b6:	fe843783          	ld	a5,-24(s0)
    11ba:	639c                	ld	a5,0(a5)
    11bc:	02878793          	addi	a5,a5,40
    11c0:	00001597          	auipc	a1,0x1
    11c4:	c0858593          	addi	a1,a1,-1016 # 1dc8 <run_queue>
    11c8:	853e                	mv	a0,a5
    11ca:	00000097          	auipc	ra,0x0
    11ce:	cfc080e7          	jalr	-772(ra) # ec6 <list_add_tail>
            list_del(&cur->thread_list);
    11d2:	fe843783          	ld	a5,-24(s0)
    11d6:	07a1                	addi	a5,a5,8
    11d8:	853e                	mv	a0,a5
    11da:	00000097          	auipc	ra,0x0
    11de:	d48080e7          	jalr	-696(ra) # f22 <list_del>
            free(cur);
    11e2:	fe843503          	ld	a0,-24(s0)
    11e6:	00000097          	auipc	ra,0x0
    11ea:	948080e7          	jalr	-1720(ra) # b2e <free>
    list_for_each_entry_safe(cur, nxt, &release_queue, thread_list)
    11ee:	fe043783          	ld	a5,-32(s0)
    11f2:	fef43423          	sd	a5,-24(s0)
    11f6:	fe043783          	ld	a5,-32(s0)
    11fa:	679c                	ld	a5,8(a5)
    11fc:	fcf43423          	sd	a5,-56(s0)
    1200:	fc843783          	ld	a5,-56(s0)
    1204:	17e1                	addi	a5,a5,-8
    1206:	fef43023          	sd	a5,-32(s0)
    120a:	fe843783          	ld	a5,-24(s0)
    120e:	00878713          	addi	a4,a5,8
    1212:	00001797          	auipc	a5,0x1
    1216:	bc678793          	addi	a5,a5,-1082 # 1dd8 <release_queue>
    121a:	f4f71fe3          	bne	a4,a5,1178 <__release+0x36>
        }
    }
}
    121e:	0001                	nop
    1220:	0001                	nop
    1222:	70e2                	ld	ra,56(sp)
    1224:	7442                	ld	s0,48(sp)
    1226:	6121                	addi	sp,sp,64
    1228:	8082                	ret

000000000000122a <__thread_exit>:

void __thread_exit(struct thread *to_remove)
{
    122a:	1101                	addi	sp,sp,-32
    122c:	ec06                	sd	ra,24(sp)
    122e:	e822                	sd	s0,16(sp)
    1230:	1000                	addi	s0,sp,32
    1232:	fea43423          	sd	a0,-24(s0)
    current = to_remove->thread_list.prev;
    1236:	fe843783          	ld	a5,-24(s0)
    123a:	7b98                	ld	a4,48(a5)
    123c:	00001797          	auipc	a5,0x1
    1240:	bd478793          	addi	a5,a5,-1068 # 1e10 <current>
    1244:	e398                	sd	a4,0(a5)
    list_del(&to_remove->thread_list);
    1246:	fe843783          	ld	a5,-24(s0)
    124a:	02878793          	addi	a5,a5,40
    124e:	853e                	mv	a0,a5
    1250:	00000097          	auipc	ra,0x0
    1254:	cd2080e7          	jalr	-814(ra) # f22 <list_del>

    free(to_remove->stack);
    1258:	fe843783          	ld	a5,-24(s0)
    125c:	6b9c                	ld	a5,16(a5)
    125e:	853e                	mv	a0,a5
    1260:	00000097          	auipc	ra,0x0
    1264:	8ce080e7          	jalr	-1842(ra) # b2e <free>
    free(to_remove);
    1268:	fe843503          	ld	a0,-24(s0)
    126c:	00000097          	auipc	ra,0x0
    1270:	8c2080e7          	jalr	-1854(ra) # b2e <free>

    __schedule();
    1274:	00000097          	auipc	ra,0x0
    1278:	572080e7          	jalr	1394(ra) # 17e6 <__schedule>
    __dispatch();
    127c:	00000097          	auipc	ra,0x0
    1280:	3da080e7          	jalr	986(ra) # 1656 <__dispatch>
    thrdresume(main_thrd_id);
    1284:	00001797          	auipc	a5,0x1
    1288:	b6478793          	addi	a5,a5,-1180 # 1de8 <main_thrd_id>
    128c:	439c                	lw	a5,0(a5)
    128e:	853e                	mv	a0,a5
    1290:	fffff097          	auipc	ra,0xfffff
    1294:	3b0080e7          	jalr	944(ra) # 640 <thrdresume>
}
    1298:	0001                	nop
    129a:	60e2                	ld	ra,24(sp)
    129c:	6442                	ld	s0,16(sp)
    129e:	6105                	addi	sp,sp,32
    12a0:	8082                	ret

00000000000012a2 <thread_exit>:

void thread_exit(void)
{
    12a2:	7179                	addi	sp,sp,-48
    12a4:	f406                	sd	ra,40(sp)
    12a6:	f022                	sd	s0,32(sp)
    12a8:	1800                	addi	s0,sp,48
    if (current == &run_queue)
    12aa:	00001797          	auipc	a5,0x1
    12ae:	b6678793          	addi	a5,a5,-1178 # 1e10 <current>
    12b2:	6398                	ld	a4,0(a5)
    12b4:	00001797          	auipc	a5,0x1
    12b8:	b1478793          	addi	a5,a5,-1260 # 1dc8 <run_queue>
    12bc:	02f71063          	bne	a4,a5,12dc <thread_exit+0x3a>
    {
        fprintf(2, "[FATAL] thread_exit is called on a nonexistent thread\n");
    12c0:	00001597          	auipc	a1,0x1
    12c4:	97858593          	addi	a1,a1,-1672 # 1c38 <schedule_wrr+0x152>
    12c8:	4509                	li	a0,2
    12ca:	fffff097          	auipc	ra,0xfffff
    12ce:	7bc080e7          	jalr	1980(ra) # a86 <fprintf>
        exit(1);
    12d2:	4505                	li	a0,1
    12d4:	fffff097          	auipc	ra,0xfffff
    12d8:	2c4080e7          	jalr	708(ra) # 598 <exit>
    }

    struct thread *to_remove = list_entry(current, struct thread, thread_list);
    12dc:	00001797          	auipc	a5,0x1
    12e0:	b3478793          	addi	a5,a5,-1228 # 1e10 <current>
    12e4:	639c                	ld	a5,0(a5)
    12e6:	fef43423          	sd	a5,-24(s0)
    12ea:	fe843783          	ld	a5,-24(s0)
    12ee:	fd878793          	addi	a5,a5,-40
    12f2:	fef43023          	sd	a5,-32(s0)
    int consume_ticks = cancelthrdstop(to_remove->thrdstop_context_id, 1);
    12f6:	fe043783          	ld	a5,-32(s0)
    12fa:	5f9c                	lw	a5,56(a5)
    12fc:	4585                	li	a1,1
    12fe:	853e                	mv	a0,a5
    1300:	fffff097          	auipc	ra,0xfffff
    1304:	348080e7          	jalr	840(ra) # 648 <cancelthrdstop>
    1308:	87aa                	mv	a5,a0
    130a:	fcf42e23          	sw	a5,-36(s0)
    threading_system_time += consume_ticks;
    130e:	00001797          	auipc	a5,0x1
    1312:	b0a78793          	addi	a5,a5,-1270 # 1e18 <threading_system_time>
    1316:	439c                	lw	a5,0(a5)
    1318:	fdc42703          	lw	a4,-36(s0)
    131c:	9fb9                	addw	a5,a5,a4
    131e:	0007871b          	sext.w	a4,a5
    1322:	00001797          	auipc	a5,0x1
    1326:	af678793          	addi	a5,a5,-1290 # 1e18 <threading_system_time>
    132a:	c398                	sw	a4,0(a5)

    __release();
    132c:	00000097          	auipc	ra,0x0
    1330:	e16080e7          	jalr	-490(ra) # 1142 <__release>
    __thread_exit(to_remove);
    1334:	fe043503          	ld	a0,-32(s0)
    1338:	00000097          	auipc	ra,0x0
    133c:	ef2080e7          	jalr	-270(ra) # 122a <__thread_exit>
}
    1340:	0001                	nop
    1342:	70a2                	ld	ra,40(sp)
    1344:	7402                	ld	s0,32(sp)
    1346:	6145                	addi	sp,sp,48
    1348:	8082                	ret

000000000000134a <__finish_current>:

void __finish_current()
{
    134a:	7179                	addi	sp,sp,-48
    134c:	f406                	sd	ra,40(sp)
    134e:	f022                	sd	s0,32(sp)
    1350:	1800                	addi	s0,sp,48
    struct thread *current_thread = list_entry(current, struct thread, thread_list);
    1352:	00001797          	auipc	a5,0x1
    1356:	abe78793          	addi	a5,a5,-1346 # 1e10 <current>
    135a:	639c                	ld	a5,0(a5)
    135c:	fef43423          	sd	a5,-24(s0)
    1360:	fe843783          	ld	a5,-24(s0)
    1364:	fd878793          	addi	a5,a5,-40
    1368:	fef43023          	sd	a5,-32(s0)
    --current_thread->n;
    136c:	fe043783          	ld	a5,-32(s0)
    1370:	4bfc                	lw	a5,84(a5)
    1372:	37fd                	addiw	a5,a5,-1
    1374:	0007871b          	sext.w	a4,a5
    1378:	fe043783          	ld	a5,-32(s0)
    137c:	cbf8                	sw	a4,84(a5)

    printf("thread#%d finish at %d\n",
    137e:	fe043783          	ld	a5,-32(s0)
    1382:	5fd8                	lw	a4,60(a5)
    1384:	00001797          	auipc	a5,0x1
    1388:	a9478793          	addi	a5,a5,-1388 # 1e18 <threading_system_time>
    138c:	4390                	lw	a2,0(a5)
    138e:	fe043783          	ld	a5,-32(s0)
    1392:	4bfc                	lw	a5,84(a5)
    1394:	86be                	mv	a3,a5
    1396:	85ba                	mv	a1,a4
    1398:	00001517          	auipc	a0,0x1
    139c:	8d850513          	addi	a0,a0,-1832 # 1c70 <schedule_wrr+0x18a>
    13a0:	fffff097          	auipc	ra,0xfffff
    13a4:	73e080e7          	jalr	1854(ra) # ade <printf>
           current_thread->ID, threading_system_time, current_thread->n);

    if (current_thread->n > 0)
    13a8:	fe043783          	ld	a5,-32(s0)
    13ac:	4bfc                	lw	a5,84(a5)
    13ae:	04f05563          	blez	a5,13f8 <__finish_current+0xae>
    {
        struct list_head *to_remove = current;
    13b2:	00001797          	auipc	a5,0x1
    13b6:	a5e78793          	addi	a5,a5,-1442 # 1e10 <current>
    13ba:	639c                	ld	a5,0(a5)
    13bc:	fcf43c23          	sd	a5,-40(s0)
        current = current->prev;
    13c0:	00001797          	auipc	a5,0x1
    13c4:	a5078793          	addi	a5,a5,-1456 # 1e10 <current>
    13c8:	639c                	ld	a5,0(a5)
    13ca:	6798                	ld	a4,8(a5)
    13cc:	00001797          	auipc	a5,0x1
    13d0:	a4478793          	addi	a5,a5,-1468 # 1e10 <current>
    13d4:	e398                	sd	a4,0(a5)
        list_del(to_remove);
    13d6:	fd843503          	ld	a0,-40(s0)
    13da:	00000097          	auipc	ra,0x0
    13de:	b48080e7          	jalr	-1208(ra) # f22 <list_del>
        thread_add_at(current_thread, current_thread->current_deadline);
    13e2:	fe043783          	ld	a5,-32(s0)
    13e6:	4ffc                	lw	a5,92(a5)
    13e8:	85be                	mv	a1,a5
    13ea:	fe043503          	ld	a0,-32(s0)
    13ee:	00000097          	auipc	ra,0x0
    13f2:	cd4080e7          	jalr	-812(ra) # 10c2 <thread_add_at>
    }
    else
    {
        __thread_exit(current_thread);
    }
}
    13f6:	a039                	j	1404 <__finish_current+0xba>
        __thread_exit(current_thread);
    13f8:	fe043503          	ld	a0,-32(s0)
    13fc:	00000097          	auipc	ra,0x0
    1400:	e2e080e7          	jalr	-466(ra) # 122a <__thread_exit>
}
    1404:	0001                	nop
    1406:	70a2                	ld	ra,40(sp)
    1408:	7402                	ld	s0,32(sp)
    140a:	6145                	addi	sp,sp,48
    140c:	8082                	ret

000000000000140e <__rt_finish_current>:
void __rt_finish_current()
{
    140e:	7179                	addi	sp,sp,-48
    1410:	f406                	sd	ra,40(sp)
    1412:	f022                	sd	s0,32(sp)
    1414:	1800                	addi	s0,sp,48
    struct thread *current_thread = list_entry(current, struct thread, thread_list);
    1416:	00001797          	auipc	a5,0x1
    141a:	9fa78793          	addi	a5,a5,-1542 # 1e10 <current>
    141e:	639c                	ld	a5,0(a5)
    1420:	fef43423          	sd	a5,-24(s0)
    1424:	fe843783          	ld	a5,-24(s0)
    1428:	fd878793          	addi	a5,a5,-40
    142c:	fef43023          	sd	a5,-32(s0)
    --current_thread->n;
    1430:	fe043783          	ld	a5,-32(s0)
    1434:	4bfc                	lw	a5,84(a5)
    1436:	37fd                	addiw	a5,a5,-1
    1438:	0007871b          	sext.w	a4,a5
    143c:	fe043783          	ld	a5,-32(s0)
    1440:	cbf8                	sw	a4,84(a5)

    printf("thread#%d finish one cycle at %d: %d cycles left\n",
    1442:	fe043783          	ld	a5,-32(s0)
    1446:	5fd8                	lw	a4,60(a5)
    1448:	00001797          	auipc	a5,0x1
    144c:	9d078793          	addi	a5,a5,-1584 # 1e18 <threading_system_time>
    1450:	4390                	lw	a2,0(a5)
    1452:	fe043783          	ld	a5,-32(s0)
    1456:	4bfc                	lw	a5,84(a5)
    1458:	86be                	mv	a3,a5
    145a:	85ba                	mv	a1,a4
    145c:	00001517          	auipc	a0,0x1
    1460:	82c50513          	addi	a0,a0,-2004 # 1c88 <schedule_wrr+0x1a2>
    1464:	fffff097          	auipc	ra,0xfffff
    1468:	67a080e7          	jalr	1658(ra) # ade <printf>
           current_thread->ID, threading_system_time, current_thread->n);

    if (current_thread->n > 0)
    146c:	fe043783          	ld	a5,-32(s0)
    1470:	4bfc                	lw	a5,84(a5)
    1472:	04f05563          	blez	a5,14bc <__rt_finish_current+0xae>
    {
        struct list_head *to_remove = current;
    1476:	00001797          	auipc	a5,0x1
    147a:	99a78793          	addi	a5,a5,-1638 # 1e10 <current>
    147e:	639c                	ld	a5,0(a5)
    1480:	fcf43c23          	sd	a5,-40(s0)
        current = current->prev;
    1484:	00001797          	auipc	a5,0x1
    1488:	98c78793          	addi	a5,a5,-1652 # 1e10 <current>
    148c:	639c                	ld	a5,0(a5)
    148e:	6798                	ld	a4,8(a5)
    1490:	00001797          	auipc	a5,0x1
    1494:	98078793          	addi	a5,a5,-1664 # 1e10 <current>
    1498:	e398                	sd	a4,0(a5)
        list_del(to_remove);
    149a:	fd843503          	ld	a0,-40(s0)
    149e:	00000097          	auipc	ra,0x0
    14a2:	a84080e7          	jalr	-1404(ra) # f22 <list_del>
        thread_add_at(current_thread, current_thread->current_deadline);
    14a6:	fe043783          	ld	a5,-32(s0)
    14aa:	4ffc                	lw	a5,92(a5)
    14ac:	85be                	mv	a1,a5
    14ae:	fe043503          	ld	a0,-32(s0)
    14b2:	00000097          	auipc	ra,0x0
    14b6:	c10080e7          	jalr	-1008(ra) # 10c2 <thread_add_at>
    }
    else
    {
        __thread_exit(current_thread);
    }
}
    14ba:	a039                	j	14c8 <__rt_finish_current+0xba>
        __thread_exit(current_thread);
    14bc:	fe043503          	ld	a0,-32(s0)
    14c0:	00000097          	auipc	ra,0x0
    14c4:	d6a080e7          	jalr	-662(ra) # 122a <__thread_exit>
}
    14c8:	0001                	nop
    14ca:	70a2                	ld	ra,40(sp)
    14cc:	7402                	ld	s0,32(sp)
    14ce:	6145                	addi	sp,sp,48
    14d0:	8082                	ret

00000000000014d2 <switch_handler>:

void switch_handler(void *arg)
{
    14d2:	7139                	addi	sp,sp,-64
    14d4:	fc06                	sd	ra,56(sp)
    14d6:	f822                	sd	s0,48(sp)
    14d8:	0080                	addi	s0,sp,64
    14da:	fca43423          	sd	a0,-56(s0)
    uint64 elapsed_time = (uint64)arg;
    14de:	fc843783          	ld	a5,-56(s0)
    14e2:	fef43423          	sd	a5,-24(s0)
    struct thread *current_thread = list_entry(current, struct thread, thread_list);
    14e6:	00001797          	auipc	a5,0x1
    14ea:	92a78793          	addi	a5,a5,-1750 # 1e10 <current>
    14ee:	639c                	ld	a5,0(a5)
    14f0:	fef43023          	sd	a5,-32(s0)
    14f4:	fe043783          	ld	a5,-32(s0)
    14f8:	fd878793          	addi	a5,a5,-40
    14fc:	fcf43c23          	sd	a5,-40(s0)

    threading_system_time += elapsed_time;
    1500:	fe843783          	ld	a5,-24(s0)
    1504:	0007871b          	sext.w	a4,a5
    1508:	00001797          	auipc	a5,0x1
    150c:	91078793          	addi	a5,a5,-1776 # 1e18 <threading_system_time>
    1510:	439c                	lw	a5,0(a5)
    1512:	2781                	sext.w	a5,a5
    1514:	9fb9                	addw	a5,a5,a4
    1516:	2781                	sext.w	a5,a5
    1518:	0007871b          	sext.w	a4,a5
    151c:	00001797          	auipc	a5,0x1
    1520:	8fc78793          	addi	a5,a5,-1796 # 1e18 <threading_system_time>
    1524:	c398                	sw	a4,0(a5)
    __release();
    1526:	00000097          	auipc	ra,0x0
    152a:	c1c080e7          	jalr	-996(ra) # 1142 <__release>
    current_thread->remaining_time -= elapsed_time;
    152e:	fd843783          	ld	a5,-40(s0)
    1532:	4fbc                	lw	a5,88(a5)
    1534:	0007871b          	sext.w	a4,a5
    1538:	fe843783          	ld	a5,-24(s0)
    153c:	2781                	sext.w	a5,a5
    153e:	40f707bb          	subw	a5,a4,a5
    1542:	2781                	sext.w	a5,a5
    1544:	0007871b          	sext.w	a4,a5
    1548:	fd843783          	ld	a5,-40(s0)
    154c:	cfb8                	sw	a4,88(a5)

    if (current_thread->is_real_time)
    154e:	fd843783          	ld	a5,-40(s0)
    1552:	43bc                	lw	a5,64(a5)
    1554:	c3ad                	beqz	a5,15b6 <switch_handler+0xe4>
        if (threading_system_time > current_thread->current_deadline ||
    1556:	fd843783          	ld	a5,-40(s0)
    155a:	4ff8                	lw	a4,92(a5)
    155c:	00001797          	auipc	a5,0x1
    1560:	8bc78793          	addi	a5,a5,-1860 # 1e18 <threading_system_time>
    1564:	439c                	lw	a5,0(a5)
    1566:	02f74163          	blt	a4,a5,1588 <switch_handler+0xb6>
            (threading_system_time == current_thread->current_deadline && current_thread->remaining_time > 0))
    156a:	fd843783          	ld	a5,-40(s0)
    156e:	4ff8                	lw	a4,92(a5)
    1570:	00001797          	auipc	a5,0x1
    1574:	8a878793          	addi	a5,a5,-1880 # 1e18 <threading_system_time>
    1578:	439c                	lw	a5,0(a5)
        if (threading_system_time > current_thread->current_deadline ||
    157a:	02f71e63          	bne	a4,a5,15b6 <switch_handler+0xe4>
            (threading_system_time == current_thread->current_deadline && current_thread->remaining_time > 0))
    157e:	fd843783          	ld	a5,-40(s0)
    1582:	4fbc                	lw	a5,88(a5)
    1584:	02f05963          	blez	a5,15b6 <switch_handler+0xe4>
        {
            printf("thread#%d misses a deadline at %d\n", current_thread->ID, threading_system_time);
    1588:	fd843783          	ld	a5,-40(s0)
    158c:	5fd8                	lw	a4,60(a5)
    158e:	00001797          	auipc	a5,0x1
    1592:	88a78793          	addi	a5,a5,-1910 # 1e18 <threading_system_time>
    1596:	439c                	lw	a5,0(a5)
    1598:	863e                	mv	a2,a5
    159a:	85ba                	mv	a1,a4
    159c:	00000517          	auipc	a0,0x0
    15a0:	72450513          	addi	a0,a0,1828 # 1cc0 <schedule_wrr+0x1da>
    15a4:	fffff097          	auipc	ra,0xfffff
    15a8:	53a080e7          	jalr	1338(ra) # ade <printf>
            exit(0);
    15ac:	4501                	li	a0,0
    15ae:	fffff097          	auipc	ra,0xfffff
    15b2:	fea080e7          	jalr	-22(ra) # 598 <exit>
        }

    if (current_thread->remaining_time <= 0)
    15b6:	fd843783          	ld	a5,-40(s0)
    15ba:	4fbc                	lw	a5,88(a5)
    15bc:	02f04063          	bgtz	a5,15dc <switch_handler+0x10a>
    {
        if (current_thread->is_real_time)
    15c0:	fd843783          	ld	a5,-40(s0)
    15c4:	43bc                	lw	a5,64(a5)
    15c6:	c791                	beqz	a5,15d2 <switch_handler+0x100>
            __rt_finish_current();
    15c8:	00000097          	auipc	ra,0x0
    15cc:	e46080e7          	jalr	-442(ra) # 140e <__rt_finish_current>
    15d0:	a881                	j	1620 <switch_handler+0x14e>
        else
            __finish_current();
    15d2:	00000097          	auipc	ra,0x0
    15d6:	d78080e7          	jalr	-648(ra) # 134a <__finish_current>
    15da:	a099                	j	1620 <switch_handler+0x14e>
    }
    else
    {
        // move the current thread to the end of the run_queue
        struct list_head *to_remove = current;
    15dc:	00001797          	auipc	a5,0x1
    15e0:	83478793          	addi	a5,a5,-1996 # 1e10 <current>
    15e4:	639c                	ld	a5,0(a5)
    15e6:	fcf43823          	sd	a5,-48(s0)
        current = current->prev;
    15ea:	00001797          	auipc	a5,0x1
    15ee:	82678793          	addi	a5,a5,-2010 # 1e10 <current>
    15f2:	639c                	ld	a5,0(a5)
    15f4:	6798                	ld	a4,8(a5)
    15f6:	00001797          	auipc	a5,0x1
    15fa:	81a78793          	addi	a5,a5,-2022 # 1e10 <current>
    15fe:	e398                	sd	a4,0(a5)
        list_del(to_remove);
    1600:	fd043503          	ld	a0,-48(s0)
    1604:	00000097          	auipc	ra,0x0
    1608:	91e080e7          	jalr	-1762(ra) # f22 <list_del>
        list_add_tail(to_remove, &run_queue);
    160c:	00000597          	auipc	a1,0x0
    1610:	7bc58593          	addi	a1,a1,1980 # 1dc8 <run_queue>
    1614:	fd043503          	ld	a0,-48(s0)
    1618:	00000097          	auipc	ra,0x0
    161c:	8ae080e7          	jalr	-1874(ra) # ec6 <list_add_tail>
    }

    __release();
    1620:	00000097          	auipc	ra,0x0
    1624:	b22080e7          	jalr	-1246(ra) # 1142 <__release>
    __schedule();
    1628:	00000097          	auipc	ra,0x0
    162c:	1be080e7          	jalr	446(ra) # 17e6 <__schedule>
    __dispatch();
    1630:	00000097          	auipc	ra,0x0
    1634:	026080e7          	jalr	38(ra) # 1656 <__dispatch>
    thrdresume(main_thrd_id);
    1638:	00000797          	auipc	a5,0x0
    163c:	7b078793          	addi	a5,a5,1968 # 1de8 <main_thrd_id>
    1640:	439c                	lw	a5,0(a5)
    1642:	853e                	mv	a0,a5
    1644:	fffff097          	auipc	ra,0xfffff
    1648:	ffc080e7          	jalr	-4(ra) # 640 <thrdresume>
}
    164c:	0001                	nop
    164e:	70e2                	ld	ra,56(sp)
    1650:	7442                	ld	s0,48(sp)
    1652:	6121                	addi	sp,sp,64
    1654:	8082                	ret

0000000000001656 <__dispatch>:

void __dispatch()
{
    1656:	7179                	addi	sp,sp,-48
    1658:	f406                	sd	ra,40(sp)
    165a:	f022                	sd	s0,32(sp)
    165c:	1800                	addi	s0,sp,48
    if (current == &run_queue)
    165e:	00000797          	auipc	a5,0x0
    1662:	7b278793          	addi	a5,a5,1970 # 1e10 <current>
    1666:	6398                	ld	a4,0(a5)
    1668:	00000797          	auipc	a5,0x0
    166c:	76078793          	addi	a5,a5,1888 # 1dc8 <run_queue>
    1670:	16f70663          	beq	a4,a5,17dc <__dispatch+0x186>
    {
        fprintf(2, "[FATAL] allocated_time is negative\n");
        exit(1);
    }

    struct thread *current_thread = list_entry(current, struct thread, thread_list);
    1674:	00000797          	auipc	a5,0x0
    1678:	79c78793          	addi	a5,a5,1948 # 1e10 <current>
    167c:	639c                	ld	a5,0(a5)
    167e:	fef43423          	sd	a5,-24(s0)
    1682:	fe843783          	ld	a5,-24(s0)
    1686:	fd878793          	addi	a5,a5,-40
    168a:	fef43023          	sd	a5,-32(s0)
    if (current_thread->is_real_time && allocated_time == 0)
    168e:	fe043783          	ld	a5,-32(s0)
    1692:	43bc                	lw	a5,64(a5)
    1694:	cf85                	beqz	a5,16cc <__dispatch+0x76>
    1696:	00000797          	auipc	a5,0x0
    169a:	78a78793          	addi	a5,a5,1930 # 1e20 <allocated_time>
    169e:	639c                	ld	a5,0(a5)
    16a0:	e795                	bnez	a5,16cc <__dispatch+0x76>
    { // miss deadline, abort
        printf("thread#%d misses a deadline at %d\n", current_thread->ID, current_thread->current_deadline);
    16a2:	fe043783          	ld	a5,-32(s0)
    16a6:	5fd8                	lw	a4,60(a5)
    16a8:	fe043783          	ld	a5,-32(s0)
    16ac:	4ffc                	lw	a5,92(a5)
    16ae:	863e                	mv	a2,a5
    16b0:	85ba                	mv	a1,a4
    16b2:	00000517          	auipc	a0,0x0
    16b6:	60e50513          	addi	a0,a0,1550 # 1cc0 <schedule_wrr+0x1da>
    16ba:	fffff097          	auipc	ra,0xfffff
    16be:	424080e7          	jalr	1060(ra) # ade <printf>
        exit(0);
    16c2:	4501                	li	a0,0
    16c4:	fffff097          	auipc	ra,0xfffff
    16c8:	ed4080e7          	jalr	-300(ra) # 598 <exit>
    }

    printf("dispatch thread#%d at %d: allocated_time=%d\n", current_thread->ID, threading_system_time, allocated_time);
    16cc:	fe043783          	ld	a5,-32(s0)
    16d0:	5fd8                	lw	a4,60(a5)
    16d2:	00000797          	auipc	a5,0x0
    16d6:	74678793          	addi	a5,a5,1862 # 1e18 <threading_system_time>
    16da:	4390                	lw	a2,0(a5)
    16dc:	00000797          	auipc	a5,0x0
    16e0:	74478793          	addi	a5,a5,1860 # 1e20 <allocated_time>
    16e4:	639c                	ld	a5,0(a5)
    16e6:	86be                	mv	a3,a5
    16e8:	85ba                	mv	a1,a4
    16ea:	00000517          	auipc	a0,0x0
    16ee:	5fe50513          	addi	a0,a0,1534 # 1ce8 <schedule_wrr+0x202>
    16f2:	fffff097          	auipc	ra,0xfffff
    16f6:	3ec080e7          	jalr	1004(ra) # ade <printf>

    if (current_thread->buf_set)
    16fa:	fe043783          	ld	a5,-32(s0)
    16fe:	539c                	lw	a5,32(a5)
    1700:	c7a1                	beqz	a5,1748 <__dispatch+0xf2>
    {
        thrdstop(allocated_time, &(current_thread->thrdstop_context_id), switch_handler, (void *)allocated_time);
    1702:	00000797          	auipc	a5,0x0
    1706:	71e78793          	addi	a5,a5,1822 # 1e20 <allocated_time>
    170a:	639c                	ld	a5,0(a5)
    170c:	0007871b          	sext.w	a4,a5
    1710:	fe043783          	ld	a5,-32(s0)
    1714:	03878593          	addi	a1,a5,56
    1718:	00000797          	auipc	a5,0x0
    171c:	70878793          	addi	a5,a5,1800 # 1e20 <allocated_time>
    1720:	639c                	ld	a5,0(a5)
    1722:	86be                	mv	a3,a5
    1724:	00000617          	auipc	a2,0x0
    1728:	dae60613          	addi	a2,a2,-594 # 14d2 <switch_handler>
    172c:	853a                	mv	a0,a4
    172e:	fffff097          	auipc	ra,0xfffff
    1732:	f0a080e7          	jalr	-246(ra) # 638 <thrdstop>
        thrdresume(current_thread->thrdstop_context_id);
    1736:	fe043783          	ld	a5,-32(s0)
    173a:	5f9c                	lw	a5,56(a5)
    173c:	853e                	mv	a0,a5
    173e:	fffff097          	auipc	ra,0xfffff
    1742:	f02080e7          	jalr	-254(ra) # 640 <thrdresume>
    1746:	a071                	j	17d2 <__dispatch+0x17c>
    }
    else
    {
        current_thread->buf_set = 1;
    1748:	fe043783          	ld	a5,-32(s0)
    174c:	4705                	li	a4,1
    174e:	d398                	sw	a4,32(a5)
        unsigned long new_stack_p = (unsigned long)current_thread->stack_p;
    1750:	fe043783          	ld	a5,-32(s0)
    1754:	6f9c                	ld	a5,24(a5)
    1756:	fcf43c23          	sd	a5,-40(s0)
        current_thread->thrdstop_context_id = -1;
    175a:	fe043783          	ld	a5,-32(s0)
    175e:	577d                	li	a4,-1
    1760:	df98                	sw	a4,56(a5)
        thrdstop(allocated_time, &(current_thread->thrdstop_context_id), switch_handler, (void *)allocated_time);
    1762:	00000797          	auipc	a5,0x0
    1766:	6be78793          	addi	a5,a5,1726 # 1e20 <allocated_time>
    176a:	639c                	ld	a5,0(a5)
    176c:	0007871b          	sext.w	a4,a5
    1770:	fe043783          	ld	a5,-32(s0)
    1774:	03878593          	addi	a1,a5,56
    1778:	00000797          	auipc	a5,0x0
    177c:	6a878793          	addi	a5,a5,1704 # 1e20 <allocated_time>
    1780:	639c                	ld	a5,0(a5)
    1782:	86be                	mv	a3,a5
    1784:	00000617          	auipc	a2,0x0
    1788:	d4e60613          	addi	a2,a2,-690 # 14d2 <switch_handler>
    178c:	853a                	mv	a0,a4
    178e:	fffff097          	auipc	ra,0xfffff
    1792:	eaa080e7          	jalr	-342(ra) # 638 <thrdstop>
        if (current_thread->thrdstop_context_id < 0)
    1796:	fe043783          	ld	a5,-32(s0)
    179a:	5f9c                	lw	a5,56(a5)
    179c:	0207d063          	bgez	a5,17bc <__dispatch+0x166>
        {
            fprintf(2, "[ERROR] number of threads may exceed MAX_THRD_NUM\n");
    17a0:	00000597          	auipc	a1,0x0
    17a4:	57858593          	addi	a1,a1,1400 # 1d18 <schedule_wrr+0x232>
    17a8:	4509                	li	a0,2
    17aa:	fffff097          	auipc	ra,0xfffff
    17ae:	2dc080e7          	jalr	732(ra) # a86 <fprintf>
            exit(1);
    17b2:	4505                	li	a0,1
    17b4:	fffff097          	auipc	ra,0xfffff
    17b8:	de4080e7          	jalr	-540(ra) # 598 <exit>
        }

        // set sp to stack pointer of current thread.
        asm volatile("mv sp, %0"
    17bc:	fd843783          	ld	a5,-40(s0)
    17c0:	813e                	mv	sp,a5
                     :
                     : "r"(new_stack_p));
        current_thread->fp(current_thread->arg);
    17c2:	fe043783          	ld	a5,-32(s0)
    17c6:	6398                	ld	a4,0(a5)
    17c8:	fe043783          	ld	a5,-32(s0)
    17cc:	679c                	ld	a5,8(a5)
    17ce:	853e                	mv	a0,a5
    17d0:	9702                	jalr	a4
    }
    thread_exit();
    17d2:	00000097          	auipc	ra,0x0
    17d6:	ad0080e7          	jalr	-1328(ra) # 12a2 <thread_exit>
    17da:	a011                	j	17de <__dispatch+0x188>
        return;
    17dc:	0001                	nop
}
    17de:	70a2                	ld	ra,40(sp)
    17e0:	7402                	ld	s0,32(sp)
    17e2:	6145                	addi	sp,sp,48
    17e4:	8082                	ret

00000000000017e6 <__schedule>:

void __schedule()
{
    17e6:	711d                	addi	sp,sp,-96
    17e8:	ec86                	sd	ra,88(sp)
    17ea:	e8a2                	sd	s0,80(sp)
    17ec:	1080                	addi	s0,sp,96
    struct threads_sched_args args = {
    17ee:	00000797          	auipc	a5,0x0
    17f2:	62a78793          	addi	a5,a5,1578 # 1e18 <threading_system_time>
    17f6:	439c                	lw	a5,0(a5)
    17f8:	fcf42c23          	sw	a5,-40(s0)
    17fc:	4789                	li	a5,2
    17fe:	fcf42e23          	sw	a5,-36(s0)
    1802:	00000797          	auipc	a5,0x0
    1806:	5c678793          	addi	a5,a5,1478 # 1dc8 <run_queue>
    180a:	fef43023          	sd	a5,-32(s0)
    180e:	00000797          	auipc	a5,0x0
    1812:	5ca78793          	addi	a5,a5,1482 # 1dd8 <release_queue>
    1816:	fef43423          	sd	a5,-24(s0)
#ifdef THREAD_SCHEDULER_DEFAULT
    r = schedule_default(args);
#endif

#ifdef THREAD_SCHEDULER_WRR
    r = schedule_wrr(args);
    181a:	fd843783          	ld	a5,-40(s0)
    181e:	faf43023          	sd	a5,-96(s0)
    1822:	fe043783          	ld	a5,-32(s0)
    1826:	faf43423          	sd	a5,-88(s0)
    182a:	fe843783          	ld	a5,-24(s0)
    182e:	faf43823          	sd	a5,-80(s0)
    1832:	fa040793          	addi	a5,s0,-96
    1836:	853e                	mv	a0,a5
    1838:	00000097          	auipc	ra,0x0
    183c:	2ae080e7          	jalr	686(ra) # 1ae6 <schedule_wrr>
    1840:	872a                	mv	a4,a0
    1842:	87ae                	mv	a5,a1
    1844:	fce43423          	sd	a4,-56(s0)
    1848:	fcf43823          	sd	a5,-48(s0)

#ifdef THREAD_SCHEDULER_DM
    r = schedule_dm(args);
#endif

    current = r.scheduled_thread_list_member;
    184c:	fc843703          	ld	a4,-56(s0)
    1850:	00000797          	auipc	a5,0x0
    1854:	5c078793          	addi	a5,a5,1472 # 1e10 <current>
    1858:	e398                	sd	a4,0(a5)
    allocated_time = r.allocated_time;
    185a:	fd042783          	lw	a5,-48(s0)
    185e:	873e                	mv	a4,a5
    1860:	00000797          	auipc	a5,0x0
    1864:	5c078793          	addi	a5,a5,1472 # 1e20 <allocated_time>
    1868:	e398                	sd	a4,0(a5)
}
    186a:	0001                	nop
    186c:	60e6                	ld	ra,88(sp)
    186e:	6446                	ld	s0,80(sp)
    1870:	6125                	addi	sp,sp,96
    1872:	8082                	ret

0000000000001874 <back_to_main_handler>:

void back_to_main_handler(void *arg)
{
    1874:	1101                	addi	sp,sp,-32
    1876:	ec06                	sd	ra,24(sp)
    1878:	e822                	sd	s0,16(sp)
    187a:	1000                	addi	s0,sp,32
    187c:	fea43423          	sd	a0,-24(s0)
    sleeping = 0;
    1880:	00000797          	auipc	a5,0x0
    1884:	59c78793          	addi	a5,a5,1436 # 1e1c <sleeping>
    1888:	0007a023          	sw	zero,0(a5)
    threading_system_time += (uint64)arg;
    188c:	fe843783          	ld	a5,-24(s0)
    1890:	0007871b          	sext.w	a4,a5
    1894:	00000797          	auipc	a5,0x0
    1898:	58478793          	addi	a5,a5,1412 # 1e18 <threading_system_time>
    189c:	439c                	lw	a5,0(a5)
    189e:	2781                	sext.w	a5,a5
    18a0:	9fb9                	addw	a5,a5,a4
    18a2:	2781                	sext.w	a5,a5
    18a4:	0007871b          	sext.w	a4,a5
    18a8:	00000797          	auipc	a5,0x0
    18ac:	57078793          	addi	a5,a5,1392 # 1e18 <threading_system_time>
    18b0:	c398                	sw	a4,0(a5)
    thrdresume(main_thrd_id);
    18b2:	00000797          	auipc	a5,0x0
    18b6:	53678793          	addi	a5,a5,1334 # 1de8 <main_thrd_id>
    18ba:	439c                	lw	a5,0(a5)
    18bc:	853e                	mv	a0,a5
    18be:	fffff097          	auipc	ra,0xfffff
    18c2:	d82080e7          	jalr	-638(ra) # 640 <thrdresume>
}
    18c6:	0001                	nop
    18c8:	60e2                	ld	ra,24(sp)
    18ca:	6442                	ld	s0,16(sp)
    18cc:	6105                	addi	sp,sp,32
    18ce:	8082                	ret

00000000000018d0 <thread_start_threading>:

void thread_start_threading()
{
    18d0:	1141                	addi	sp,sp,-16
    18d2:	e406                	sd	ra,8(sp)
    18d4:	e022                	sd	s0,0(sp)
    18d6:	0800                	addi	s0,sp,16
    threading_system_time = 0;
    18d8:	00000797          	auipc	a5,0x0
    18dc:	54078793          	addi	a5,a5,1344 # 1e18 <threading_system_time>
    18e0:	0007a023          	sw	zero,0(a5)
    current = &run_queue;
    18e4:	00000797          	auipc	a5,0x0
    18e8:	52c78793          	addi	a5,a5,1324 # 1e10 <current>
    18ec:	00000717          	auipc	a4,0x0
    18f0:	4dc70713          	addi	a4,a4,1244 # 1dc8 <run_queue>
    18f4:	e398                	sd	a4,0(a5)

    // call thrdstop just for obtain an ID
    thrdstop(1000, &main_thrd_id, back_to_main_handler, (void *)0);
    18f6:	4681                	li	a3,0
    18f8:	00000617          	auipc	a2,0x0
    18fc:	f7c60613          	addi	a2,a2,-132 # 1874 <back_to_main_handler>
    1900:	00000597          	auipc	a1,0x0
    1904:	4e858593          	addi	a1,a1,1256 # 1de8 <main_thrd_id>
    1908:	3e800513          	li	a0,1000
    190c:	fffff097          	auipc	ra,0xfffff
    1910:	d2c080e7          	jalr	-724(ra) # 638 <thrdstop>
    cancelthrdstop(main_thrd_id, 0);
    1914:	00000797          	auipc	a5,0x0
    1918:	4d478793          	addi	a5,a5,1236 # 1de8 <main_thrd_id>
    191c:	439c                	lw	a5,0(a5)
    191e:	4581                	li	a1,0
    1920:	853e                	mv	a0,a5
    1922:	fffff097          	auipc	ra,0xfffff
    1926:	d26080e7          	jalr	-730(ra) # 648 <cancelthrdstop>

    while (!list_empty(&run_queue) || !list_empty(&release_queue))
    192a:	a0c9                	j	19ec <thread_start_threading+0x11c>
    {
        __release();
    192c:	00000097          	auipc	ra,0x0
    1930:	816080e7          	jalr	-2026(ra) # 1142 <__release>
        __schedule();
    1934:	00000097          	auipc	ra,0x0
    1938:	eb2080e7          	jalr	-334(ra) # 17e6 <__schedule>
        cancelthrdstop(main_thrd_id, 0);
    193c:	00000797          	auipc	a5,0x0
    1940:	4ac78793          	addi	a5,a5,1196 # 1de8 <main_thrd_id>
    1944:	439c                	lw	a5,0(a5)
    1946:	4581                	li	a1,0
    1948:	853e                	mv	a0,a5
    194a:	fffff097          	auipc	ra,0xfffff
    194e:	cfe080e7          	jalr	-770(ra) # 648 <cancelthrdstop>
        __dispatch();
    1952:	00000097          	auipc	ra,0x0
    1956:	d04080e7          	jalr	-764(ra) # 1656 <__dispatch>

        if (list_empty(&run_queue) && list_empty(&release_queue))
    195a:	00000517          	auipc	a0,0x0
    195e:	46e50513          	addi	a0,a0,1134 # 1dc8 <run_queue>
    1962:	fffff097          	auipc	ra,0xfffff
    1966:	60a080e7          	jalr	1546(ra) # f6c <list_empty>
    196a:	87aa                	mv	a5,a0
    196c:	cb99                	beqz	a5,1982 <thread_start_threading+0xb2>
    196e:	00000517          	auipc	a0,0x0
    1972:	46a50513          	addi	a0,a0,1130 # 1dd8 <release_queue>
    1976:	fffff097          	auipc	ra,0xfffff
    197a:	5f6080e7          	jalr	1526(ra) # f6c <list_empty>
    197e:	87aa                	mv	a5,a0
    1980:	ebd9                	bnez	a5,1a16 <thread_start_threading+0x146>
        {
            break;
        }

        // no thread in run_queue, release_queue not empty
        printf("run_queue is empty, sleep for %d ticks\n", allocated_time);
    1982:	00000797          	auipc	a5,0x0
    1986:	49e78793          	addi	a5,a5,1182 # 1e20 <allocated_time>
    198a:	639c                	ld	a5,0(a5)
    198c:	85be                	mv	a1,a5
    198e:	00000517          	auipc	a0,0x0
    1992:	3c250513          	addi	a0,a0,962 # 1d50 <schedule_wrr+0x26a>
    1996:	fffff097          	auipc	ra,0xfffff
    199a:	148080e7          	jalr	328(ra) # ade <printf>
        sleeping = 1;
    199e:	00000797          	auipc	a5,0x0
    19a2:	47e78793          	addi	a5,a5,1150 # 1e1c <sleeping>
    19a6:	4705                	li	a4,1
    19a8:	c398                	sw	a4,0(a5)
        thrdstop(allocated_time, &main_thrd_id, back_to_main_handler, (void *)allocated_time);
    19aa:	00000797          	auipc	a5,0x0
    19ae:	47678793          	addi	a5,a5,1142 # 1e20 <allocated_time>
    19b2:	639c                	ld	a5,0(a5)
    19b4:	0007871b          	sext.w	a4,a5
    19b8:	00000797          	auipc	a5,0x0
    19bc:	46878793          	addi	a5,a5,1128 # 1e20 <allocated_time>
    19c0:	639c                	ld	a5,0(a5)
    19c2:	86be                	mv	a3,a5
    19c4:	00000617          	auipc	a2,0x0
    19c8:	eb060613          	addi	a2,a2,-336 # 1874 <back_to_main_handler>
    19cc:	00000597          	auipc	a1,0x0
    19d0:	41c58593          	addi	a1,a1,1052 # 1de8 <main_thrd_id>
    19d4:	853a                	mv	a0,a4
    19d6:	fffff097          	auipc	ra,0xfffff
    19da:	c62080e7          	jalr	-926(ra) # 638 <thrdstop>
        while (sleeping)
    19de:	0001                	nop
    19e0:	00000797          	auipc	a5,0x0
    19e4:	43c78793          	addi	a5,a5,1084 # 1e1c <sleeping>
    19e8:	439c                	lw	a5,0(a5)
    19ea:	fbfd                	bnez	a5,19e0 <thread_start_threading+0x110>
    while (!list_empty(&run_queue) || !list_empty(&release_queue))
    19ec:	00000517          	auipc	a0,0x0
    19f0:	3dc50513          	addi	a0,a0,988 # 1dc8 <run_queue>
    19f4:	fffff097          	auipc	ra,0xfffff
    19f8:	578080e7          	jalr	1400(ra) # f6c <list_empty>
    19fc:	87aa                	mv	a5,a0
    19fe:	d79d                	beqz	a5,192c <thread_start_threading+0x5c>
    1a00:	00000517          	auipc	a0,0x0
    1a04:	3d850513          	addi	a0,a0,984 # 1dd8 <release_queue>
    1a08:	fffff097          	auipc	ra,0xfffff
    1a0c:	564080e7          	jalr	1380(ra) # f6c <list_empty>
    1a10:	87aa                	mv	a5,a0
    1a12:	df89                	beqz	a5,192c <thread_start_threading+0x5c>
        {
            // zzz...
        }
    }
}
    1a14:	a011                	j	1a18 <thread_start_threading+0x148>
            break;
    1a16:	0001                	nop
}
    1a18:	0001                	nop
    1a1a:	60a2                	ld	ra,8(sp)
    1a1c:	6402                	ld	s0,0(sp)
    1a1e:	0141                	addi	sp,sp,16
    1a20:	8082                	ret

0000000000001a22 <schedule_default>:
#define NULL 0
#define min(a, b) ((a) < (b) ? (a) : (b))

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
    1a22:	715d                	addi	sp,sp,-80
    1a24:	e4a2                	sd	s0,72(sp)
    1a26:	e0a6                	sd	s1,64(sp)
    1a28:	0880                	addi	s0,sp,80
    1a2a:	84aa                	mv	s1,a0
    struct thread *thread_with_smallest_id = NULL;
    1a2c:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
    1a30:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, args.run_queue, thread_list)
    1a34:	649c                	ld	a5,8(s1)
    1a36:	639c                	ld	a5,0(a5)
    1a38:	fcf43c23          	sd	a5,-40(s0)
    1a3c:	fd843783          	ld	a5,-40(s0)
    1a40:	fd878793          	addi	a5,a5,-40
    1a44:	fef43023          	sd	a5,-32(s0)
    1a48:	a81d                	j	1a7e <schedule_default+0x5c>
    {
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID)
    1a4a:	fe843783          	ld	a5,-24(s0)
    1a4e:	cb89                	beqz	a5,1a60 <schedule_default+0x3e>
    1a50:	fe043783          	ld	a5,-32(s0)
    1a54:	5fd8                	lw	a4,60(a5)
    1a56:	fe843783          	ld	a5,-24(s0)
    1a5a:	5fdc                	lw	a5,60(a5)
    1a5c:	00f75663          	bge	a4,a5,1a68 <schedule_default+0x46>
            thread_with_smallest_id = th;
    1a60:	fe043783          	ld	a5,-32(s0)
    1a64:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list)
    1a68:	fe043783          	ld	a5,-32(s0)
    1a6c:	779c                	ld	a5,40(a5)
    1a6e:	fcf43823          	sd	a5,-48(s0)
    1a72:	fd043783          	ld	a5,-48(s0)
    1a76:	fd878793          	addi	a5,a5,-40
    1a7a:	fef43023          	sd	a5,-32(s0)
    1a7e:	fe043783          	ld	a5,-32(s0)
    1a82:	02878713          	addi	a4,a5,40
    1a86:	649c                	ld	a5,8(s1)
    1a88:	fcf711e3          	bne	a4,a5,1a4a <schedule_default+0x28>
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL)
    1a8c:	fe843783          	ld	a5,-24(s0)
    1a90:	cf89                	beqz	a5,1aaa <schedule_default+0x88>
    {
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
    1a92:	fe843783          	ld	a5,-24(s0)
    1a96:	02878793          	addi	a5,a5,40
    1a9a:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = thread_with_smallest_id->remaining_time;
    1a9e:	fe843783          	ld	a5,-24(s0)
    1aa2:	4fbc                	lw	a5,88(a5)
    1aa4:	faf42c23          	sw	a5,-72(s0)
    1aa8:	a039                	j	1ab6 <schedule_default+0x94>
    }
    else
    {
        r.scheduled_thread_list_member = args.run_queue;
    1aaa:	649c                	ld	a5,8(s1)
    1aac:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = 1;
    1ab0:	4785                	li	a5,1
    1ab2:	faf42c23          	sw	a5,-72(s0)
    }

    return r;
    1ab6:	fb043783          	ld	a5,-80(s0)
    1aba:	fcf43023          	sd	a5,-64(s0)
    1abe:	fb843783          	ld	a5,-72(s0)
    1ac2:	fcf43423          	sd	a5,-56(s0)
    1ac6:	4701                	li	a4,0
    1ac8:	fc043703          	ld	a4,-64(s0)
    1acc:	4781                	li	a5,0
    1ace:	fc843783          	ld	a5,-56(s0)
    1ad2:	863a                	mv	a2,a4
    1ad4:	86be                	mv	a3,a5
    1ad6:	8732                	mv	a4,a2
    1ad8:	87b6                	mv	a5,a3
}
    1ada:	853a                	mv	a0,a4
    1adc:	85be                	mv	a1,a5
    1ade:	6426                	ld	s0,72(sp)
    1ae0:	6486                	ld	s1,64(sp)
    1ae2:	6161                	addi	sp,sp,80
    1ae4:	8082                	ret

0000000000001ae6 <schedule_wrr>:

/* MP3 Part 1 - Non-Real-Time Scheduling */
/* Weighted-Round-Robin Scheduling */
struct threads_sched_result schedule_wrr(struct threads_sched_args args)
{
    1ae6:	7119                	addi	sp,sp,-128
    1ae8:	fc86                	sd	ra,120(sp)
    1aea:	f8a2                	sd	s0,112(sp)
    1aec:	f4a6                	sd	s1,104(sp)
    1aee:	f0ca                	sd	s2,96(sp)
    1af0:	ecce                	sd	s3,88(sp)
    1af2:	0100                	addi	s0,sp,128
    1af4:	84aa                	mv	s1,a0
    struct thread *current_thread = NULL;
    1af6:	fc043423          	sd	zero,-56(s0)
    struct thread *th = NULL;
    1afa:	fc043023          	sd	zero,-64(s0)
    printf("\nrun_queue: \n");
    1afe:	00000517          	auipc	a0,0x0
    1b02:	27a50513          	addi	a0,a0,634 # 1d78 <schedule_wrr+0x292>
    1b06:	fffff097          	auipc	ra,0xfffff
    1b0a:	fd8080e7          	jalr	-40(ra) # ade <printf>
    list_for_each_entry(th, args.run_queue, thread_list)
    1b0e:	649c                	ld	a5,8(s1)
    1b10:	639c                	ld	a5,0(a5)
    1b12:	faf43c23          	sd	a5,-72(s0)
    1b16:	fb843783          	ld	a5,-72(s0)
    1b1a:	fd878793          	addi	a5,a5,-40
    1b1e:	fcf43023          	sd	a5,-64(s0)
    1b22:	a08d                	j	1b84 <schedule_wrr+0x9e>
    {
        printf("th->ID: %d; ", th->ID);
    1b24:	fc043783          	ld	a5,-64(s0)
    1b28:	5fdc                	lw	a5,60(a5)
    1b2a:	85be                	mv	a1,a5
    1b2c:	00000517          	auipc	a0,0x0
    1b30:	25c50513          	addi	a0,a0,604 # 1d88 <schedule_wrr+0x2a2>
    1b34:	fffff097          	auipc	ra,0xfffff
    1b38:	faa080e7          	jalr	-86(ra) # ade <printf>
        printf("th->arrival_time: %d\n", th->current_deadline - th->deadline);
    1b3c:	fc043783          	ld	a5,-64(s0)
    1b40:	4ff8                	lw	a4,92(a5)
    1b42:	fc043783          	ld	a5,-64(s0)
    1b46:	47fc                	lw	a5,76(a5)
    1b48:	40f707bb          	subw	a5,a4,a5
    1b4c:	2781                	sext.w	a5,a5
    1b4e:	85be                	mv	a1,a5
    1b50:	00000517          	auipc	a0,0x0
    1b54:	24850513          	addi	a0,a0,584 # 1d98 <schedule_wrr+0x2b2>
    1b58:	fffff097          	auipc	ra,0xfffff
    1b5c:	f86080e7          	jalr	-122(ra) # ade <printf>
        if (current_thread == NULL)
    1b60:	fc843783          	ld	a5,-56(s0)
    1b64:	e789                	bnez	a5,1b6e <schedule_wrr+0x88>
            current_thread = th;
    1b66:	fc043783          	ld	a5,-64(s0)
    1b6a:	fcf43423          	sd	a5,-56(s0)
    list_for_each_entry(th, args.run_queue, thread_list)
    1b6e:	fc043783          	ld	a5,-64(s0)
    1b72:	779c                	ld	a5,40(a5)
    1b74:	faf43423          	sd	a5,-88(s0)
    1b78:	fa843783          	ld	a5,-88(s0)
    1b7c:	fd878793          	addi	a5,a5,-40
    1b80:	fcf43023          	sd	a5,-64(s0)
    1b84:	fc043783          	ld	a5,-64(s0)
    1b88:	02878713          	addi	a4,a5,40
    1b8c:	649c                	ld	a5,8(s1)
    1b8e:	f8f71be3          	bne	a4,a5,1b24 <schedule_wrr+0x3e>
    }

    struct threads_sched_result r;
    // TODO: implement the weighted round-robin scheduling algorithm
    int weighted_time = args.time_quantum * current_thread->weight;
    1b92:	40d8                	lw	a4,4(s1)
    1b94:	fc843783          	ld	a5,-56(s0)
    1b98:	47bc                	lw	a5,72(a5)
    1b9a:	02f707bb          	mulw	a5,a4,a5
    1b9e:	faf42a23          	sw	a5,-76(s0)
    int remaining_time = current_thread->remaining_time;
    1ba2:	fc843783          	ld	a5,-56(s0)
    1ba6:	4fbc                	lw	a5,88(a5)
    1ba8:	faf42823          	sw	a5,-80(s0)
    if (current_thread != NULL)
    1bac:	fc843783          	ld	a5,-56(s0)
    1bb0:	c795                	beqz	a5,1bdc <schedule_wrr+0xf6>
    {
        r.scheduled_thread_list_member = &current_thread->thread_list;
    1bb2:	fc843783          	ld	a5,-56(s0)
    1bb6:	02878793          	addi	a5,a5,40
    1bba:	f8f43423          	sd	a5,-120(s0)
        r.allocated_time = min(weighted_time, remaining_time);
    1bbe:	fb442603          	lw	a2,-76(s0)
    1bc2:	fb042783          	lw	a5,-80(s0)
    1bc6:	0007869b          	sext.w	a3,a5
    1bca:	0006071b          	sext.w	a4,a2
    1bce:	00d75363          	bge	a4,a3,1bd4 <schedule_wrr+0xee>
    1bd2:	87b2                	mv	a5,a2
    1bd4:	2781                	sext.w	a5,a5
    1bd6:	f8f42823          	sw	a5,-112(s0)
    1bda:	a039                	j	1be8 <schedule_wrr+0x102>
    }
    else
    {
        r.scheduled_thread_list_member = args.run_queue;
    1bdc:	649c                	ld	a5,8(s1)
    1bde:	f8f43423          	sd	a5,-120(s0)
        r.allocated_time = 1;
    1be2:	4785                	li	a5,1
    1be4:	f8f42823          	sw	a5,-112(s0)
    }

    return r;
    1be8:	f8843783          	ld	a5,-120(s0)
    1bec:	f8f43c23          	sd	a5,-104(s0)
    1bf0:	f9043783          	ld	a5,-112(s0)
    1bf4:	faf43023          	sd	a5,-96(s0)
    1bf8:	4701                	li	a4,0
    1bfa:	f9843703          	ld	a4,-104(s0)
    1bfe:	4781                	li	a5,0
    1c00:	fa043783          	ld	a5,-96(s0)
    1c04:	893a                	mv	s2,a4
    1c06:	89be                	mv	s3,a5
    1c08:	874a                	mv	a4,s2
    1c0a:	87ce                	mv	a5,s3
}
    1c0c:	853a                	mv	a0,a4
    1c0e:	85be                	mv	a1,a5
    1c10:	70e6                	ld	ra,120(sp)
    1c12:	7446                	ld	s0,112(sp)
    1c14:	74a6                	ld	s1,104(sp)
    1c16:	7906                	ld	s2,96(sp)
    1c18:	69e6                	ld	s3,88(sp)
    1c1a:	6109                	addi	sp,sp,128
    1c1c:	8082                	ret
