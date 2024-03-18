
user/_custom-10:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fib>:
#define NULL 0

static struct thread *t;
static int cnt = 0;

void fib(void *arg) {
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
    cnt++;
   e:	00001797          	auipc	a5,0x1
  12:	cfa78793          	addi	a5,a5,-774 # d08 <cnt>
  16:	4390                	lw	a2,0(a5)
  18:	2605                	addiw	a2,a2,1
  1a:	c390                	sw	a2,0(a5)
    int k2 = (unsigned long)arg;
    int l = k2 / 1000;
  1c:	3e800493          	li	s1,1000
  20:	0295493b          	divw	s2,a0,s1
    int k = k2 % 1000;
  24:	029564bb          	remw	s1,a0,s1
    printf("fib %d %d %d\n", l, cnt, k);
  28:	0004869b          	sext.w	a3,s1
  2c:	2601                	sext.w	a2,a2
  2e:	0009059b          	sext.w	a1,s2
  32:	00001517          	auipc	a0,0x1
  36:	c8650513          	addi	a0,a0,-890 # cb8 <thread_start_threading+0x2c>
  3a:	00000097          	auipc	ra,0x0
  3e:	6d2080e7          	jalr	1746(ra) # 70c <printf>
    if(k % 2 == 0) return;
  42:	0014f793          	andi	a5,s1,1
  46:	c7b5                	beqz	a5,b2 <fib+0xb2>
  48:	0004871b          	sext.w	a4,s1

    if (k == 0 || k == 1) {
  4c:	4785                	li	a5,1
  4e:	04e7fe63          	bgeu	a5,a4,aa <fib+0xaa>
        thread_exit();
    } else {
        register void *k1 = (void *)(unsigned long)(k - 1 + 1000 * l);
  52:	3e800613          	li	a2,1000
  56:	0326063b          	mulw	a2,a2,s2
  5a:	fff4899b          	addiw	s3,s1,-1
  5e:	00c989bb          	addw	s3,s3,a2
        register void *k2 = (void *)(unsigned long)(k - 2 + 1000 * l);
  62:	34f9                	addiw	s1,s1,-2
        thread_assign_task(t, fib, k2);
  64:	00001917          	auipc	s2,0x1
  68:	cac90913          	addi	s2,s2,-852 # d10 <t>
  6c:	9e25                	addw	a2,a2,s1
  6e:	00000597          	auipc	a1,0x0
  72:	f9258593          	addi	a1,a1,-110 # 0 <fib>
  76:	00093503          	ld	a0,0(s2)
  7a:	00001097          	auipc	ra,0x1
  7e:	964080e7          	jalr	-1692(ra) # 9de <thread_assign_task>
        thread_assign_task(t, fib, k1);
  82:	864e                	mv	a2,s3
  84:	00000597          	auipc	a1,0x0
  88:	f7c58593          	addi	a1,a1,-132 # 0 <fib>
  8c:	00093503          	ld	a0,0(s2)
  90:	00001097          	auipc	ra,0x1
  94:	94e080e7          	jalr	-1714(ra) # 9de <thread_assign_task>
        if((unsigned long)k1 == 726) thread_yield();
  98:	2d600793          	li	a5,726
  9c:	00f99b63          	bne	s3,a5,b2 <fib+0xb2>
  a0:	00001097          	auipc	ra,0x1
  a4:	b0e080e7          	jalr	-1266(ra) # bae <thread_yield>
  a8:	a029                	j	b2 <fib+0xb2>
        thread_exit();
  aa:	00001097          	auipc	ra,0x1
  ae:	b64080e7          	jalr	-1180(ra) # c0e <thread_exit>
        else return;
    }
}
  b2:	70a2                	ld	ra,40(sp)
  b4:	7402                	ld	s0,32(sp)
  b6:	64e2                	ld	s1,24(sp)
  b8:	6942                	ld	s2,16(sp)
  ba:	69a2                	ld	s3,8(sp)
  bc:	6145                	addi	sp,sp,48
  be:	8082                	ret

00000000000000c0 <main>:

int main(int argc, char **argv) {
  c0:	1141                	addi	sp,sp,-16
  c2:	e406                	sd	ra,8(sp)
  c4:	e022                	sd	s0,0(sp)
  c6:	0800                	addi	s0,sp,16
    printf("custom-10\n");
  c8:	00001517          	auipc	a0,0x1
  cc:	c0050513          	addi	a0,a0,-1024 # cc8 <thread_start_threading+0x3c>
  d0:	00000097          	auipc	ra,0x0
  d4:	63c080e7          	jalr	1596(ra) # 70c <printf>
    for (int i = 0; i < 1; i++) {
        t = thread_create(fib, (void *)(unsigned long)(727 + 1000 * i));
  d8:	2d700593          	li	a1,727
  dc:	00000517          	auipc	a0,0x0
  e0:	f2450513          	addi	a0,a0,-220 # 0 <fib>
  e4:	00001097          	auipc	ra,0x1
  e8:	840080e7          	jalr	-1984(ra) # 924 <thread_create>
  ec:	00001797          	auipc	a5,0x1
  f0:	c2a7b223          	sd	a0,-988(a5) # d10 <t>
        thread_add_runqueue(t);
  f4:	00001097          	auipc	ra,0x1
  f8:	8a0080e7          	jalr	-1888(ra) # 994 <thread_add_runqueue>
        thread_start_threading();
  fc:	00001097          	auipc	ra,0x1
 100:	b90080e7          	jalr	-1136(ra) # c8c <thread_start_threading>
    }
    printf("\nexited\n");
 104:	00001517          	auipc	a0,0x1
 108:	bd450513          	addi	a0,a0,-1068 # cd8 <thread_start_threading+0x4c>
 10c:	00000097          	auipc	ra,0x0
 110:	600080e7          	jalr	1536(ra) # 70c <printf>
    exit(0);
 114:	4501                	li	a0,0
 116:	00000097          	auipc	ra,0x0
 11a:	27e080e7          	jalr	638(ra) # 394 <exit>

000000000000011e <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 11e:	1141                	addi	sp,sp,-16
 120:	e422                	sd	s0,8(sp)
 122:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 124:	87aa                	mv	a5,a0
 126:	0585                	addi	a1,a1,1
 128:	0785                	addi	a5,a5,1
 12a:	fff5c703          	lbu	a4,-1(a1)
 12e:	fee78fa3          	sb	a4,-1(a5)
 132:	fb75                	bnez	a4,126 <strcpy+0x8>
    ;
  return os;
}
 134:	6422                	ld	s0,8(sp)
 136:	0141                	addi	sp,sp,16
 138:	8082                	ret

000000000000013a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 13a:	1141                	addi	sp,sp,-16
 13c:	e422                	sd	s0,8(sp)
 13e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 140:	00054783          	lbu	a5,0(a0)
 144:	cb91                	beqz	a5,158 <strcmp+0x1e>
 146:	0005c703          	lbu	a4,0(a1)
 14a:	00f71763          	bne	a4,a5,158 <strcmp+0x1e>
    p++, q++;
 14e:	0505                	addi	a0,a0,1
 150:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 152:	00054783          	lbu	a5,0(a0)
 156:	fbe5                	bnez	a5,146 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 158:	0005c503          	lbu	a0,0(a1)
}
 15c:	40a7853b          	subw	a0,a5,a0
 160:	6422                	ld	s0,8(sp)
 162:	0141                	addi	sp,sp,16
 164:	8082                	ret

0000000000000166 <strlen>:

uint
strlen(const char *s)
{
 166:	1141                	addi	sp,sp,-16
 168:	e422                	sd	s0,8(sp)
 16a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 16c:	00054783          	lbu	a5,0(a0)
 170:	cf91                	beqz	a5,18c <strlen+0x26>
 172:	0505                	addi	a0,a0,1
 174:	87aa                	mv	a5,a0
 176:	4685                	li	a3,1
 178:	9e89                	subw	a3,a3,a0
 17a:	00f6853b          	addw	a0,a3,a5
 17e:	0785                	addi	a5,a5,1
 180:	fff7c703          	lbu	a4,-1(a5)
 184:	fb7d                	bnez	a4,17a <strlen+0x14>
    ;
  return n;
}
 186:	6422                	ld	s0,8(sp)
 188:	0141                	addi	sp,sp,16
 18a:	8082                	ret
  for(n = 0; s[n]; n++)
 18c:	4501                	li	a0,0
 18e:	bfe5                	j	186 <strlen+0x20>

0000000000000190 <memset>:

void*
memset(void *dst, int c, uint n)
{
 190:	1141                	addi	sp,sp,-16
 192:	e422                	sd	s0,8(sp)
 194:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 196:	ce09                	beqz	a2,1b0 <memset+0x20>
 198:	87aa                	mv	a5,a0
 19a:	fff6071b          	addiw	a4,a2,-1
 19e:	1702                	slli	a4,a4,0x20
 1a0:	9301                	srli	a4,a4,0x20
 1a2:	0705                	addi	a4,a4,1
 1a4:	972a                	add	a4,a4,a0
    cdst[i] = c;
 1a6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 1aa:	0785                	addi	a5,a5,1
 1ac:	fee79de3          	bne	a5,a4,1a6 <memset+0x16>
  }
  return dst;
}
 1b0:	6422                	ld	s0,8(sp)
 1b2:	0141                	addi	sp,sp,16
 1b4:	8082                	ret

00000000000001b6 <strchr>:

char*
strchr(const char *s, char c)
{
 1b6:	1141                	addi	sp,sp,-16
 1b8:	e422                	sd	s0,8(sp)
 1ba:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1bc:	00054783          	lbu	a5,0(a0)
 1c0:	cb99                	beqz	a5,1d6 <strchr+0x20>
    if(*s == c)
 1c2:	00f58763          	beq	a1,a5,1d0 <strchr+0x1a>
  for(; *s; s++)
 1c6:	0505                	addi	a0,a0,1
 1c8:	00054783          	lbu	a5,0(a0)
 1cc:	fbfd                	bnez	a5,1c2 <strchr+0xc>
      return (char*)s;
  return 0;
 1ce:	4501                	li	a0,0
}
 1d0:	6422                	ld	s0,8(sp)
 1d2:	0141                	addi	sp,sp,16
 1d4:	8082                	ret
  return 0;
 1d6:	4501                	li	a0,0
 1d8:	bfe5                	j	1d0 <strchr+0x1a>

00000000000001da <gets>:

char*
gets(char *buf, int max)
{
 1da:	711d                	addi	sp,sp,-96
 1dc:	ec86                	sd	ra,88(sp)
 1de:	e8a2                	sd	s0,80(sp)
 1e0:	e4a6                	sd	s1,72(sp)
 1e2:	e0ca                	sd	s2,64(sp)
 1e4:	fc4e                	sd	s3,56(sp)
 1e6:	f852                	sd	s4,48(sp)
 1e8:	f456                	sd	s5,40(sp)
 1ea:	f05a                	sd	s6,32(sp)
 1ec:	ec5e                	sd	s7,24(sp)
 1ee:	1080                	addi	s0,sp,96
 1f0:	8baa                	mv	s7,a0
 1f2:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1f4:	892a                	mv	s2,a0
 1f6:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1f8:	4aa9                	li	s5,10
 1fa:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1fc:	89a6                	mv	s3,s1
 1fe:	2485                	addiw	s1,s1,1
 200:	0344d863          	bge	s1,s4,230 <gets+0x56>
    cc = read(0, &c, 1);
 204:	4605                	li	a2,1
 206:	faf40593          	addi	a1,s0,-81
 20a:	4501                	li	a0,0
 20c:	00000097          	auipc	ra,0x0
 210:	1a0080e7          	jalr	416(ra) # 3ac <read>
    if(cc < 1)
 214:	00a05e63          	blez	a0,230 <gets+0x56>
    buf[i++] = c;
 218:	faf44783          	lbu	a5,-81(s0)
 21c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 220:	01578763          	beq	a5,s5,22e <gets+0x54>
 224:	0905                	addi	s2,s2,1
 226:	fd679be3          	bne	a5,s6,1fc <gets+0x22>
  for(i=0; i+1 < max; ){
 22a:	89a6                	mv	s3,s1
 22c:	a011                	j	230 <gets+0x56>
 22e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 230:	99de                	add	s3,s3,s7
 232:	00098023          	sb	zero,0(s3)
  return buf;
}
 236:	855e                	mv	a0,s7
 238:	60e6                	ld	ra,88(sp)
 23a:	6446                	ld	s0,80(sp)
 23c:	64a6                	ld	s1,72(sp)
 23e:	6906                	ld	s2,64(sp)
 240:	79e2                	ld	s3,56(sp)
 242:	7a42                	ld	s4,48(sp)
 244:	7aa2                	ld	s5,40(sp)
 246:	7b02                	ld	s6,32(sp)
 248:	6be2                	ld	s7,24(sp)
 24a:	6125                	addi	sp,sp,96
 24c:	8082                	ret

000000000000024e <stat>:

int
stat(const char *n, struct stat *st)
{
 24e:	1101                	addi	sp,sp,-32
 250:	ec06                	sd	ra,24(sp)
 252:	e822                	sd	s0,16(sp)
 254:	e426                	sd	s1,8(sp)
 256:	e04a                	sd	s2,0(sp)
 258:	1000                	addi	s0,sp,32
 25a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 25c:	4581                	li	a1,0
 25e:	00000097          	auipc	ra,0x0
 262:	176080e7          	jalr	374(ra) # 3d4 <open>
  if(fd < 0)
 266:	02054563          	bltz	a0,290 <stat+0x42>
 26a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 26c:	85ca                	mv	a1,s2
 26e:	00000097          	auipc	ra,0x0
 272:	17e080e7          	jalr	382(ra) # 3ec <fstat>
 276:	892a                	mv	s2,a0
  close(fd);
 278:	8526                	mv	a0,s1
 27a:	00000097          	auipc	ra,0x0
 27e:	142080e7          	jalr	322(ra) # 3bc <close>
  return r;
}
 282:	854a                	mv	a0,s2
 284:	60e2                	ld	ra,24(sp)
 286:	6442                	ld	s0,16(sp)
 288:	64a2                	ld	s1,8(sp)
 28a:	6902                	ld	s2,0(sp)
 28c:	6105                	addi	sp,sp,32
 28e:	8082                	ret
    return -1;
 290:	597d                	li	s2,-1
 292:	bfc5                	j	282 <stat+0x34>

0000000000000294 <atoi>:

int
atoi(const char *s)
{
 294:	1141                	addi	sp,sp,-16
 296:	e422                	sd	s0,8(sp)
 298:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 29a:	00054603          	lbu	a2,0(a0)
 29e:	fd06079b          	addiw	a5,a2,-48
 2a2:	0ff7f793          	andi	a5,a5,255
 2a6:	4725                	li	a4,9
 2a8:	02f76963          	bltu	a4,a5,2da <atoi+0x46>
 2ac:	86aa                	mv	a3,a0
  n = 0;
 2ae:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 2b0:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 2b2:	0685                	addi	a3,a3,1
 2b4:	0025179b          	slliw	a5,a0,0x2
 2b8:	9fa9                	addw	a5,a5,a0
 2ba:	0017979b          	slliw	a5,a5,0x1
 2be:	9fb1                	addw	a5,a5,a2
 2c0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2c4:	0006c603          	lbu	a2,0(a3)
 2c8:	fd06071b          	addiw	a4,a2,-48
 2cc:	0ff77713          	andi	a4,a4,255
 2d0:	fee5f1e3          	bgeu	a1,a4,2b2 <atoi+0x1e>
  return n;
}
 2d4:	6422                	ld	s0,8(sp)
 2d6:	0141                	addi	sp,sp,16
 2d8:	8082                	ret
  n = 0;
 2da:	4501                	li	a0,0
 2dc:	bfe5                	j	2d4 <atoi+0x40>

00000000000002de <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2de:	1141                	addi	sp,sp,-16
 2e0:	e422                	sd	s0,8(sp)
 2e2:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2e4:	02b57663          	bgeu	a0,a1,310 <memmove+0x32>
    while(n-- > 0)
 2e8:	02c05163          	blez	a2,30a <memmove+0x2c>
 2ec:	fff6079b          	addiw	a5,a2,-1
 2f0:	1782                	slli	a5,a5,0x20
 2f2:	9381                	srli	a5,a5,0x20
 2f4:	0785                	addi	a5,a5,1
 2f6:	97aa                	add	a5,a5,a0
  dst = vdst;
 2f8:	872a                	mv	a4,a0
      *dst++ = *src++;
 2fa:	0585                	addi	a1,a1,1
 2fc:	0705                	addi	a4,a4,1
 2fe:	fff5c683          	lbu	a3,-1(a1)
 302:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 306:	fee79ae3          	bne	a5,a4,2fa <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 30a:	6422                	ld	s0,8(sp)
 30c:	0141                	addi	sp,sp,16
 30e:	8082                	ret
    dst += n;
 310:	00c50733          	add	a4,a0,a2
    src += n;
 314:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 316:	fec05ae3          	blez	a2,30a <memmove+0x2c>
 31a:	fff6079b          	addiw	a5,a2,-1
 31e:	1782                	slli	a5,a5,0x20
 320:	9381                	srli	a5,a5,0x20
 322:	fff7c793          	not	a5,a5
 326:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 328:	15fd                	addi	a1,a1,-1
 32a:	177d                	addi	a4,a4,-1
 32c:	0005c683          	lbu	a3,0(a1)
 330:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 334:	fee79ae3          	bne	a5,a4,328 <memmove+0x4a>
 338:	bfc9                	j	30a <memmove+0x2c>

000000000000033a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 33a:	1141                	addi	sp,sp,-16
 33c:	e422                	sd	s0,8(sp)
 33e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 340:	ca05                	beqz	a2,370 <memcmp+0x36>
 342:	fff6069b          	addiw	a3,a2,-1
 346:	1682                	slli	a3,a3,0x20
 348:	9281                	srli	a3,a3,0x20
 34a:	0685                	addi	a3,a3,1
 34c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 34e:	00054783          	lbu	a5,0(a0)
 352:	0005c703          	lbu	a4,0(a1)
 356:	00e79863          	bne	a5,a4,366 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 35a:	0505                	addi	a0,a0,1
    p2++;
 35c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 35e:	fed518e3          	bne	a0,a3,34e <memcmp+0x14>
  }
  return 0;
 362:	4501                	li	a0,0
 364:	a019                	j	36a <memcmp+0x30>
      return *p1 - *p2;
 366:	40e7853b          	subw	a0,a5,a4
}
 36a:	6422                	ld	s0,8(sp)
 36c:	0141                	addi	sp,sp,16
 36e:	8082                	ret
  return 0;
 370:	4501                	li	a0,0
 372:	bfe5                	j	36a <memcmp+0x30>

0000000000000374 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 374:	1141                	addi	sp,sp,-16
 376:	e406                	sd	ra,8(sp)
 378:	e022                	sd	s0,0(sp)
 37a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 37c:	00000097          	auipc	ra,0x0
 380:	f62080e7          	jalr	-158(ra) # 2de <memmove>
}
 384:	60a2                	ld	ra,8(sp)
 386:	6402                	ld	s0,0(sp)
 388:	0141                	addi	sp,sp,16
 38a:	8082                	ret

000000000000038c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 38c:	4885                	li	a7,1
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <exit>:
.global exit
exit:
 li a7, SYS_exit
 394:	4889                	li	a7,2
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <wait>:
.global wait
wait:
 li a7, SYS_wait
 39c:	488d                	li	a7,3
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3a4:	4891                	li	a7,4
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <read>:
.global read
read:
 li a7, SYS_read
 3ac:	4895                	li	a7,5
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <write>:
.global write
write:
 li a7, SYS_write
 3b4:	48c1                	li	a7,16
 ecall
 3b6:	00000073          	ecall
 ret
 3ba:	8082                	ret

00000000000003bc <close>:
.global close
close:
 li a7, SYS_close
 3bc:	48d5                	li	a7,21
 ecall
 3be:	00000073          	ecall
 ret
 3c2:	8082                	ret

00000000000003c4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3c4:	4899                	li	a7,6
 ecall
 3c6:	00000073          	ecall
 ret
 3ca:	8082                	ret

00000000000003cc <exec>:
.global exec
exec:
 li a7, SYS_exec
 3cc:	489d                	li	a7,7
 ecall
 3ce:	00000073          	ecall
 ret
 3d2:	8082                	ret

00000000000003d4 <open>:
.global open
open:
 li a7, SYS_open
 3d4:	48bd                	li	a7,15
 ecall
 3d6:	00000073          	ecall
 ret
 3da:	8082                	ret

00000000000003dc <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3dc:	48c5                	li	a7,17
 ecall
 3de:	00000073          	ecall
 ret
 3e2:	8082                	ret

00000000000003e4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3e4:	48c9                	li	a7,18
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3ec:	48a1                	li	a7,8
 ecall
 3ee:	00000073          	ecall
 ret
 3f2:	8082                	ret

00000000000003f4 <link>:
.global link
link:
 li a7, SYS_link
 3f4:	48cd                	li	a7,19
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3fc:	48d1                	li	a7,20
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 404:	48a5                	li	a7,9
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <dup>:
.global dup
dup:
 li a7, SYS_dup
 40c:	48a9                	li	a7,10
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 414:	48ad                	li	a7,11
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 41c:	48b1                	li	a7,12
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 424:	48b5                	li	a7,13
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 42c:	48b9                	li	a7,14
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 434:	1101                	addi	sp,sp,-32
 436:	ec06                	sd	ra,24(sp)
 438:	e822                	sd	s0,16(sp)
 43a:	1000                	addi	s0,sp,32
 43c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 440:	4605                	li	a2,1
 442:	fef40593          	addi	a1,s0,-17
 446:	00000097          	auipc	ra,0x0
 44a:	f6e080e7          	jalr	-146(ra) # 3b4 <write>
}
 44e:	60e2                	ld	ra,24(sp)
 450:	6442                	ld	s0,16(sp)
 452:	6105                	addi	sp,sp,32
 454:	8082                	ret

0000000000000456 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 456:	7139                	addi	sp,sp,-64
 458:	fc06                	sd	ra,56(sp)
 45a:	f822                	sd	s0,48(sp)
 45c:	f426                	sd	s1,40(sp)
 45e:	f04a                	sd	s2,32(sp)
 460:	ec4e                	sd	s3,24(sp)
 462:	0080                	addi	s0,sp,64
 464:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 466:	c299                	beqz	a3,46c <printint+0x16>
 468:	0805c863          	bltz	a1,4f8 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 46c:	2581                	sext.w	a1,a1
  neg = 0;
 46e:	4881                	li	a7,0
 470:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 474:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 476:	2601                	sext.w	a2,a2
 478:	00001517          	auipc	a0,0x1
 47c:	87850513          	addi	a0,a0,-1928 # cf0 <digits>
 480:	883a                	mv	a6,a4
 482:	2705                	addiw	a4,a4,1
 484:	02c5f7bb          	remuw	a5,a1,a2
 488:	1782                	slli	a5,a5,0x20
 48a:	9381                	srli	a5,a5,0x20
 48c:	97aa                	add	a5,a5,a0
 48e:	0007c783          	lbu	a5,0(a5)
 492:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 496:	0005879b          	sext.w	a5,a1
 49a:	02c5d5bb          	divuw	a1,a1,a2
 49e:	0685                	addi	a3,a3,1
 4a0:	fec7f0e3          	bgeu	a5,a2,480 <printint+0x2a>
  if(neg)
 4a4:	00088b63          	beqz	a7,4ba <printint+0x64>
    buf[i++] = '-';
 4a8:	fd040793          	addi	a5,s0,-48
 4ac:	973e                	add	a4,a4,a5
 4ae:	02d00793          	li	a5,45
 4b2:	fef70823          	sb	a5,-16(a4)
 4b6:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 4ba:	02e05863          	blez	a4,4ea <printint+0x94>
 4be:	fc040793          	addi	a5,s0,-64
 4c2:	00e78933          	add	s2,a5,a4
 4c6:	fff78993          	addi	s3,a5,-1
 4ca:	99ba                	add	s3,s3,a4
 4cc:	377d                	addiw	a4,a4,-1
 4ce:	1702                	slli	a4,a4,0x20
 4d0:	9301                	srli	a4,a4,0x20
 4d2:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 4d6:	fff94583          	lbu	a1,-1(s2)
 4da:	8526                	mv	a0,s1
 4dc:	00000097          	auipc	ra,0x0
 4e0:	f58080e7          	jalr	-168(ra) # 434 <putc>
  while(--i >= 0)
 4e4:	197d                	addi	s2,s2,-1
 4e6:	ff3918e3          	bne	s2,s3,4d6 <printint+0x80>
}
 4ea:	70e2                	ld	ra,56(sp)
 4ec:	7442                	ld	s0,48(sp)
 4ee:	74a2                	ld	s1,40(sp)
 4f0:	7902                	ld	s2,32(sp)
 4f2:	69e2                	ld	s3,24(sp)
 4f4:	6121                	addi	sp,sp,64
 4f6:	8082                	ret
    x = -xx;
 4f8:	40b005bb          	negw	a1,a1
    neg = 1;
 4fc:	4885                	li	a7,1
    x = -xx;
 4fe:	bf8d                	j	470 <printint+0x1a>

0000000000000500 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 500:	7119                	addi	sp,sp,-128
 502:	fc86                	sd	ra,120(sp)
 504:	f8a2                	sd	s0,112(sp)
 506:	f4a6                	sd	s1,104(sp)
 508:	f0ca                	sd	s2,96(sp)
 50a:	ecce                	sd	s3,88(sp)
 50c:	e8d2                	sd	s4,80(sp)
 50e:	e4d6                	sd	s5,72(sp)
 510:	e0da                	sd	s6,64(sp)
 512:	fc5e                	sd	s7,56(sp)
 514:	f862                	sd	s8,48(sp)
 516:	f466                	sd	s9,40(sp)
 518:	f06a                	sd	s10,32(sp)
 51a:	ec6e                	sd	s11,24(sp)
 51c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 51e:	0005c903          	lbu	s2,0(a1)
 522:	18090f63          	beqz	s2,6c0 <vprintf+0x1c0>
 526:	8aaa                	mv	s5,a0
 528:	8b32                	mv	s6,a2
 52a:	00158493          	addi	s1,a1,1
  state = 0;
 52e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 530:	02500a13          	li	s4,37
      if(c == 'd'){
 534:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 538:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 53c:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 540:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 544:	00000b97          	auipc	s7,0x0
 548:	7acb8b93          	addi	s7,s7,1964 # cf0 <digits>
 54c:	a839                	j	56a <vprintf+0x6a>
        putc(fd, c);
 54e:	85ca                	mv	a1,s2
 550:	8556                	mv	a0,s5
 552:	00000097          	auipc	ra,0x0
 556:	ee2080e7          	jalr	-286(ra) # 434 <putc>
 55a:	a019                	j	560 <vprintf+0x60>
    } else if(state == '%'){
 55c:	01498f63          	beq	s3,s4,57a <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 560:	0485                	addi	s1,s1,1
 562:	fff4c903          	lbu	s2,-1(s1)
 566:	14090d63          	beqz	s2,6c0 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 56a:	0009079b          	sext.w	a5,s2
    if(state == 0){
 56e:	fe0997e3          	bnez	s3,55c <vprintf+0x5c>
      if(c == '%'){
 572:	fd479ee3          	bne	a5,s4,54e <vprintf+0x4e>
        state = '%';
 576:	89be                	mv	s3,a5
 578:	b7e5                	j	560 <vprintf+0x60>
      if(c == 'd'){
 57a:	05878063          	beq	a5,s8,5ba <vprintf+0xba>
      } else if(c == 'l') {
 57e:	05978c63          	beq	a5,s9,5d6 <vprintf+0xd6>
      } else if(c == 'x') {
 582:	07a78863          	beq	a5,s10,5f2 <vprintf+0xf2>
      } else if(c == 'p') {
 586:	09b78463          	beq	a5,s11,60e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 58a:	07300713          	li	a4,115
 58e:	0ce78663          	beq	a5,a4,65a <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 592:	06300713          	li	a4,99
 596:	0ee78e63          	beq	a5,a4,692 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 59a:	11478863          	beq	a5,s4,6aa <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 59e:	85d2                	mv	a1,s4
 5a0:	8556                	mv	a0,s5
 5a2:	00000097          	auipc	ra,0x0
 5a6:	e92080e7          	jalr	-366(ra) # 434 <putc>
        putc(fd, c);
 5aa:	85ca                	mv	a1,s2
 5ac:	8556                	mv	a0,s5
 5ae:	00000097          	auipc	ra,0x0
 5b2:	e86080e7          	jalr	-378(ra) # 434 <putc>
      }
      state = 0;
 5b6:	4981                	li	s3,0
 5b8:	b765                	j	560 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 5ba:	008b0913          	addi	s2,s6,8
 5be:	4685                	li	a3,1
 5c0:	4629                	li	a2,10
 5c2:	000b2583          	lw	a1,0(s6)
 5c6:	8556                	mv	a0,s5
 5c8:	00000097          	auipc	ra,0x0
 5cc:	e8e080e7          	jalr	-370(ra) # 456 <printint>
 5d0:	8b4a                	mv	s6,s2
      state = 0;
 5d2:	4981                	li	s3,0
 5d4:	b771                	j	560 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 5d6:	008b0913          	addi	s2,s6,8
 5da:	4681                	li	a3,0
 5dc:	4629                	li	a2,10
 5de:	000b2583          	lw	a1,0(s6)
 5e2:	8556                	mv	a0,s5
 5e4:	00000097          	auipc	ra,0x0
 5e8:	e72080e7          	jalr	-398(ra) # 456 <printint>
 5ec:	8b4a                	mv	s6,s2
      state = 0;
 5ee:	4981                	li	s3,0
 5f0:	bf85                	j	560 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 5f2:	008b0913          	addi	s2,s6,8
 5f6:	4681                	li	a3,0
 5f8:	4641                	li	a2,16
 5fa:	000b2583          	lw	a1,0(s6)
 5fe:	8556                	mv	a0,s5
 600:	00000097          	auipc	ra,0x0
 604:	e56080e7          	jalr	-426(ra) # 456 <printint>
 608:	8b4a                	mv	s6,s2
      state = 0;
 60a:	4981                	li	s3,0
 60c:	bf91                	j	560 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 60e:	008b0793          	addi	a5,s6,8
 612:	f8f43423          	sd	a5,-120(s0)
 616:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 61a:	03000593          	li	a1,48
 61e:	8556                	mv	a0,s5
 620:	00000097          	auipc	ra,0x0
 624:	e14080e7          	jalr	-492(ra) # 434 <putc>
  putc(fd, 'x');
 628:	85ea                	mv	a1,s10
 62a:	8556                	mv	a0,s5
 62c:	00000097          	auipc	ra,0x0
 630:	e08080e7          	jalr	-504(ra) # 434 <putc>
 634:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 636:	03c9d793          	srli	a5,s3,0x3c
 63a:	97de                	add	a5,a5,s7
 63c:	0007c583          	lbu	a1,0(a5)
 640:	8556                	mv	a0,s5
 642:	00000097          	auipc	ra,0x0
 646:	df2080e7          	jalr	-526(ra) # 434 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 64a:	0992                	slli	s3,s3,0x4
 64c:	397d                	addiw	s2,s2,-1
 64e:	fe0914e3          	bnez	s2,636 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 652:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 656:	4981                	li	s3,0
 658:	b721                	j	560 <vprintf+0x60>
        s = va_arg(ap, char*);
 65a:	008b0993          	addi	s3,s6,8
 65e:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 662:	02090163          	beqz	s2,684 <vprintf+0x184>
        while(*s != 0){
 666:	00094583          	lbu	a1,0(s2)
 66a:	c9a1                	beqz	a1,6ba <vprintf+0x1ba>
          putc(fd, *s);
 66c:	8556                	mv	a0,s5
 66e:	00000097          	auipc	ra,0x0
 672:	dc6080e7          	jalr	-570(ra) # 434 <putc>
          s++;
 676:	0905                	addi	s2,s2,1
        while(*s != 0){
 678:	00094583          	lbu	a1,0(s2)
 67c:	f9e5                	bnez	a1,66c <vprintf+0x16c>
        s = va_arg(ap, char*);
 67e:	8b4e                	mv	s6,s3
      state = 0;
 680:	4981                	li	s3,0
 682:	bdf9                	j	560 <vprintf+0x60>
          s = "(null)";
 684:	00000917          	auipc	s2,0x0
 688:	66490913          	addi	s2,s2,1636 # ce8 <thread_start_threading+0x5c>
        while(*s != 0){
 68c:	02800593          	li	a1,40
 690:	bff1                	j	66c <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 692:	008b0913          	addi	s2,s6,8
 696:	000b4583          	lbu	a1,0(s6)
 69a:	8556                	mv	a0,s5
 69c:	00000097          	auipc	ra,0x0
 6a0:	d98080e7          	jalr	-616(ra) # 434 <putc>
 6a4:	8b4a                	mv	s6,s2
      state = 0;
 6a6:	4981                	li	s3,0
 6a8:	bd65                	j	560 <vprintf+0x60>
        putc(fd, c);
 6aa:	85d2                	mv	a1,s4
 6ac:	8556                	mv	a0,s5
 6ae:	00000097          	auipc	ra,0x0
 6b2:	d86080e7          	jalr	-634(ra) # 434 <putc>
      state = 0;
 6b6:	4981                	li	s3,0
 6b8:	b565                	j	560 <vprintf+0x60>
        s = va_arg(ap, char*);
 6ba:	8b4e                	mv	s6,s3
      state = 0;
 6bc:	4981                	li	s3,0
 6be:	b54d                	j	560 <vprintf+0x60>
    }
  }
}
 6c0:	70e6                	ld	ra,120(sp)
 6c2:	7446                	ld	s0,112(sp)
 6c4:	74a6                	ld	s1,104(sp)
 6c6:	7906                	ld	s2,96(sp)
 6c8:	69e6                	ld	s3,88(sp)
 6ca:	6a46                	ld	s4,80(sp)
 6cc:	6aa6                	ld	s5,72(sp)
 6ce:	6b06                	ld	s6,64(sp)
 6d0:	7be2                	ld	s7,56(sp)
 6d2:	7c42                	ld	s8,48(sp)
 6d4:	7ca2                	ld	s9,40(sp)
 6d6:	7d02                	ld	s10,32(sp)
 6d8:	6de2                	ld	s11,24(sp)
 6da:	6109                	addi	sp,sp,128
 6dc:	8082                	ret

00000000000006de <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 6de:	715d                	addi	sp,sp,-80
 6e0:	ec06                	sd	ra,24(sp)
 6e2:	e822                	sd	s0,16(sp)
 6e4:	1000                	addi	s0,sp,32
 6e6:	e010                	sd	a2,0(s0)
 6e8:	e414                	sd	a3,8(s0)
 6ea:	e818                	sd	a4,16(s0)
 6ec:	ec1c                	sd	a5,24(s0)
 6ee:	03043023          	sd	a6,32(s0)
 6f2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 6f6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 6fa:	8622                	mv	a2,s0
 6fc:	00000097          	auipc	ra,0x0
 700:	e04080e7          	jalr	-508(ra) # 500 <vprintf>
}
 704:	60e2                	ld	ra,24(sp)
 706:	6442                	ld	s0,16(sp)
 708:	6161                	addi	sp,sp,80
 70a:	8082                	ret

000000000000070c <printf>:

void
printf(const char *fmt, ...)
{
 70c:	711d                	addi	sp,sp,-96
 70e:	ec06                	sd	ra,24(sp)
 710:	e822                	sd	s0,16(sp)
 712:	1000                	addi	s0,sp,32
 714:	e40c                	sd	a1,8(s0)
 716:	e810                	sd	a2,16(s0)
 718:	ec14                	sd	a3,24(s0)
 71a:	f018                	sd	a4,32(s0)
 71c:	f41c                	sd	a5,40(s0)
 71e:	03043823          	sd	a6,48(s0)
 722:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 726:	00840613          	addi	a2,s0,8
 72a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 72e:	85aa                	mv	a1,a0
 730:	4505                	li	a0,1
 732:	00000097          	auipc	ra,0x0
 736:	dce080e7          	jalr	-562(ra) # 500 <vprintf>
}
 73a:	60e2                	ld	ra,24(sp)
 73c:	6442                	ld	s0,16(sp)
 73e:	6125                	addi	sp,sp,96
 740:	8082                	ret

0000000000000742 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 742:	1141                	addi	sp,sp,-16
 744:	e422                	sd	s0,8(sp)
 746:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 748:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 74c:	00000797          	auipc	a5,0x0
 750:	5cc7b783          	ld	a5,1484(a5) # d18 <freep>
 754:	a805                	j	784 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 756:	4618                	lw	a4,8(a2)
 758:	9db9                	addw	a1,a1,a4
 75a:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 75e:	6398                	ld	a4,0(a5)
 760:	6318                	ld	a4,0(a4)
 762:	fee53823          	sd	a4,-16(a0)
 766:	a091                	j	7aa <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 768:	ff852703          	lw	a4,-8(a0)
 76c:	9e39                	addw	a2,a2,a4
 76e:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 770:	ff053703          	ld	a4,-16(a0)
 774:	e398                	sd	a4,0(a5)
 776:	a099                	j	7bc <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 778:	6398                	ld	a4,0(a5)
 77a:	00e7e463          	bltu	a5,a4,782 <free+0x40>
 77e:	00e6ea63          	bltu	a3,a4,792 <free+0x50>
{
 782:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 784:	fed7fae3          	bgeu	a5,a3,778 <free+0x36>
 788:	6398                	ld	a4,0(a5)
 78a:	00e6e463          	bltu	a3,a4,792 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 78e:	fee7eae3          	bltu	a5,a4,782 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 792:	ff852583          	lw	a1,-8(a0)
 796:	6390                	ld	a2,0(a5)
 798:	02059713          	slli	a4,a1,0x20
 79c:	9301                	srli	a4,a4,0x20
 79e:	0712                	slli	a4,a4,0x4
 7a0:	9736                	add	a4,a4,a3
 7a2:	fae60ae3          	beq	a2,a4,756 <free+0x14>
    bp->s.ptr = p->s.ptr;
 7a6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7aa:	4790                	lw	a2,8(a5)
 7ac:	02061713          	slli	a4,a2,0x20
 7b0:	9301                	srli	a4,a4,0x20
 7b2:	0712                	slli	a4,a4,0x4
 7b4:	973e                	add	a4,a4,a5
 7b6:	fae689e3          	beq	a3,a4,768 <free+0x26>
  } else
    p->s.ptr = bp;
 7ba:	e394                	sd	a3,0(a5)
  freep = p;
 7bc:	00000717          	auipc	a4,0x0
 7c0:	54f73e23          	sd	a5,1372(a4) # d18 <freep>
}
 7c4:	6422                	ld	s0,8(sp)
 7c6:	0141                	addi	sp,sp,16
 7c8:	8082                	ret

00000000000007ca <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7ca:	7139                	addi	sp,sp,-64
 7cc:	fc06                	sd	ra,56(sp)
 7ce:	f822                	sd	s0,48(sp)
 7d0:	f426                	sd	s1,40(sp)
 7d2:	f04a                	sd	s2,32(sp)
 7d4:	ec4e                	sd	s3,24(sp)
 7d6:	e852                	sd	s4,16(sp)
 7d8:	e456                	sd	s5,8(sp)
 7da:	e05a                	sd	s6,0(sp)
 7dc:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7de:	02051493          	slli	s1,a0,0x20
 7e2:	9081                	srli	s1,s1,0x20
 7e4:	04bd                	addi	s1,s1,15
 7e6:	8091                	srli	s1,s1,0x4
 7e8:	0014899b          	addiw	s3,s1,1
 7ec:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 7ee:	00000517          	auipc	a0,0x0
 7f2:	52a53503          	ld	a0,1322(a0) # d18 <freep>
 7f6:	c515                	beqz	a0,822 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7f8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 7fa:	4798                	lw	a4,8(a5)
 7fc:	02977f63          	bgeu	a4,s1,83a <malloc+0x70>
 800:	8a4e                	mv	s4,s3
 802:	0009871b          	sext.w	a4,s3
 806:	6685                	lui	a3,0x1
 808:	00d77363          	bgeu	a4,a3,80e <malloc+0x44>
 80c:	6a05                	lui	s4,0x1
 80e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 812:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 816:	00000917          	auipc	s2,0x0
 81a:	50290913          	addi	s2,s2,1282 # d18 <freep>
  if(p == (char*)-1)
 81e:	5afd                	li	s5,-1
 820:	a88d                	j	892 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 822:	00000797          	auipc	a5,0x0
 826:	50678793          	addi	a5,a5,1286 # d28 <base>
 82a:	00000717          	auipc	a4,0x0
 82e:	4ef73723          	sd	a5,1262(a4) # d18 <freep>
 832:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 834:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 838:	b7e1                	j	800 <malloc+0x36>
      if(p->s.size == nunits)
 83a:	02e48b63          	beq	s1,a4,870 <malloc+0xa6>
        p->s.size -= nunits;
 83e:	4137073b          	subw	a4,a4,s3
 842:	c798                	sw	a4,8(a5)
        p += p->s.size;
 844:	1702                	slli	a4,a4,0x20
 846:	9301                	srli	a4,a4,0x20
 848:	0712                	slli	a4,a4,0x4
 84a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 84c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 850:	00000717          	auipc	a4,0x0
 854:	4ca73423          	sd	a0,1224(a4) # d18 <freep>
      return (void*)(p + 1);
 858:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 85c:	70e2                	ld	ra,56(sp)
 85e:	7442                	ld	s0,48(sp)
 860:	74a2                	ld	s1,40(sp)
 862:	7902                	ld	s2,32(sp)
 864:	69e2                	ld	s3,24(sp)
 866:	6a42                	ld	s4,16(sp)
 868:	6aa2                	ld	s5,8(sp)
 86a:	6b02                	ld	s6,0(sp)
 86c:	6121                	addi	sp,sp,64
 86e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 870:	6398                	ld	a4,0(a5)
 872:	e118                	sd	a4,0(a0)
 874:	bff1                	j	850 <malloc+0x86>
  hp->s.size = nu;
 876:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 87a:	0541                	addi	a0,a0,16
 87c:	00000097          	auipc	ra,0x0
 880:	ec6080e7          	jalr	-314(ra) # 742 <free>
  return freep;
 884:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 888:	d971                	beqz	a0,85c <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 88a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 88c:	4798                	lw	a4,8(a5)
 88e:	fa9776e3          	bgeu	a4,s1,83a <malloc+0x70>
    if(p == freep)
 892:	00093703          	ld	a4,0(s2)
 896:	853e                	mv	a0,a5
 898:	fef719e3          	bne	a4,a5,88a <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 89c:	8552                	mv	a0,s4
 89e:	00000097          	auipc	ra,0x0
 8a2:	b7e080e7          	jalr	-1154(ra) # 41c <sbrk>
  if(p == (char*)-1)
 8a6:	fd5518e3          	bne	a0,s5,876 <malloc+0xac>
        return 0;
 8aa:	4501                	li	a0,0
 8ac:	bf45                	j	85c <malloc+0x92>

00000000000008ae <setjmp>:
 8ae:	e100                	sd	s0,0(a0)
 8b0:	e504                	sd	s1,8(a0)
 8b2:	01253823          	sd	s2,16(a0)
 8b6:	01353c23          	sd	s3,24(a0)
 8ba:	03453023          	sd	s4,32(a0)
 8be:	03553423          	sd	s5,40(a0)
 8c2:	03653823          	sd	s6,48(a0)
 8c6:	03753c23          	sd	s7,56(a0)
 8ca:	05853023          	sd	s8,64(a0)
 8ce:	05953423          	sd	s9,72(a0)
 8d2:	05a53823          	sd	s10,80(a0)
 8d6:	05b53c23          	sd	s11,88(a0)
 8da:	06153023          	sd	ra,96(a0)
 8de:	06253423          	sd	sp,104(a0)
 8e2:	4501                	li	a0,0
 8e4:	8082                	ret

00000000000008e6 <longjmp>:
 8e6:	6100                	ld	s0,0(a0)
 8e8:	6504                	ld	s1,8(a0)
 8ea:	01053903          	ld	s2,16(a0)
 8ee:	01853983          	ld	s3,24(a0)
 8f2:	02053a03          	ld	s4,32(a0)
 8f6:	02853a83          	ld	s5,40(a0)
 8fa:	03053b03          	ld	s6,48(a0)
 8fe:	03853b83          	ld	s7,56(a0)
 902:	04053c03          	ld	s8,64(a0)
 906:	04853c83          	ld	s9,72(a0)
 90a:	05053d03          	ld	s10,80(a0)
 90e:	05853d83          	ld	s11,88(a0)
 912:	06053083          	ld	ra,96(a0)
 916:	06853103          	ld	sp,104(a0)
 91a:	c199                	beqz	a1,920 <longjmp_1>
 91c:	852e                	mv	a0,a1
 91e:	8082                	ret

0000000000000920 <longjmp_1>:
 920:	4505                	li	a0,1
 922:	8082                	ret

0000000000000924 <thread_create>:
static int id = 1;
static jmp_buf env_st;
// static jmp_buf env_tmp;
static int verbose = 0;

struct thread *thread_create(void (*f)(void *), void *arg){
 924:	7179                	addi	sp,sp,-48
 926:	f406                	sd	ra,40(sp)
 928:	f022                	sd	s0,32(sp)
 92a:	ec26                	sd	s1,24(sp)
 92c:	e84a                	sd	s2,16(sp)
 92e:	e44e                	sd	s3,8(sp)
 930:	1800                	addi	s0,sp,48
 932:	89aa                	mv	s3,a0
 934:	892e                	mv	s2,a1
    struct thread *t = (struct thread*) malloc(sizeof(struct thread));
 936:	0c000513          	li	a0,192
 93a:	00000097          	auipc	ra,0x0
 93e:	e90080e7          	jalr	-368(ra) # 7ca <malloc>
 942:	84aa                	mv	s1,a0
    unsigned long new_stack_p;
    unsigned long new_stack;
    new_stack = (unsigned long) malloc(sizeof(unsigned long)*0x100);
 944:	6505                	lui	a0,0x1
 946:	80050513          	addi	a0,a0,-2048 # 800 <malloc+0x36>
 94a:	00000097          	auipc	ra,0x0
 94e:	e80080e7          	jalr	-384(ra) # 7ca <malloc>
    new_stack_p = new_stack +0x100*8-0x2*8;
    t->fp = f;
 952:	0134b023          	sd	s3,0(s1)
    t->arg = arg;
 956:	0124b423          	sd	s2,8(s1)
    t->ID  = id;
 95a:	00000717          	auipc	a4,0x0
 95e:	3aa70713          	addi	a4,a4,938 # d04 <id>
 962:	431c                	lw	a5,0(a4)
 964:	08f4aa23          	sw	a5,148(s1)
    t->buf_set = 0;
 968:	0804a823          	sw	zero,144(s1)
    t->stack = (void*) new_stack;
 96c:	e888                	sd	a0,16(s1)
    new_stack_p = new_stack +0x100*8-0x2*8;
 96e:	7f050513          	addi	a0,a0,2032
    t->stack_p = (void*) new_stack_p;
 972:	ec88                	sd	a0,24(s1)
    t->current_task = NULL;
 974:	0a04b823          	sd	zero,176(s1)
    t->task_count = 0;
 978:	0a04ae23          	sw	zero,188(s1)
    t->first_self_assign = 0;
 97c:	0a04ac23          	sw	zero,184(s1)
    id++;
 980:	2785                	addiw	a5,a5,1
 982:	c31c                	sw	a5,0(a4)
    return t;
}
 984:	8526                	mv	a0,s1
 986:	70a2                	ld	ra,40(sp)
 988:	7402                	ld	s0,32(sp)
 98a:	64e2                	ld	s1,24(sp)
 98c:	6942                	ld	s2,16(sp)
 98e:	69a2                	ld	s3,8(sp)
 990:	6145                	addi	sp,sp,48
 992:	8082                	ret

0000000000000994 <thread_add_runqueue>:
void thread_add_runqueue(struct thread *t){
 994:	1141                	addi	sp,sp,-16
 996:	e422                	sd	s0,8(sp)
 998:	0800                	addi	s0,sp,16
    if(current_thread == NULL){
 99a:	00000797          	auipc	a5,0x0
 99e:	3867b783          	ld	a5,902(a5) # d20 <current_thread>
 9a2:	cb91                	beqz	a5,9b6 <thread_add_runqueue+0x22>
    }
    else{
        // TODO
        // Insert the new thread at the end of the runqueue,
        // i.e. the newly inserted thread should be current_thread->previous.
        (current_thread->previous)->next = t;
 9a4:	6fd8                	ld	a4,152(a5)
 9a6:	f348                	sd	a0,160(a4)
        t->previous = current_thread->previous;
 9a8:	6fd8                	ld	a4,152(a5)
 9aa:	ed58                	sd	a4,152(a0)

        t->next = current_thread;
 9ac:	f15c                	sd	a5,160(a0)
        current_thread->previous = t;
 9ae:	efc8                	sd	a0,152(a5)
    }
    if(verbose) printf("[INFO] thread %d added to runqueue\n", t->ID);
}
 9b0:	6422                	ld	s0,8(sp)
 9b2:	0141                	addi	sp,sp,16
 9b4:	8082                	ret
        t->next = t;
 9b6:	f148                	sd	a0,160(a0)
        t->previous = t;
 9b8:	ed48                	sd	a0,152(a0)
        current_thread = t;
 9ba:	00000797          	auipc	a5,0x0
 9be:	36a7b323          	sd	a0,870(a5) # d20 <current_thread>
 9c2:	b7fd                	j	9b0 <thread_add_runqueue+0x1c>

00000000000009c4 <schedule>:
            thread_exit();
        }
    }
}

void schedule(void){
 9c4:	1141                	addi	sp,sp,-16
 9c6:	e422                	sd	s0,8(sp)
 9c8:	0800                	addi	s0,sp,16
    // TODO
    current_thread = current_thread->next;
 9ca:	00000797          	auipc	a5,0x0
 9ce:	35678793          	addi	a5,a5,854 # d20 <current_thread>
 9d2:	6398                	ld	a4,0(a5)
 9d4:	7358                	ld	a4,160(a4)
 9d6:	e398                	sd	a4,0(a5)
}
 9d8:	6422                	ld	s0,8(sp)
 9da:	0141                	addi	sp,sp,16
 9dc:	8082                	ret

00000000000009de <thread_assign_task>:
        dispatch();
    }
}

// part 2
void thread_assign_task(struct thread *t, void (*f)(void *), void *arg){
 9de:	7179                	addi	sp,sp,-48
 9e0:	f406                	sd	ra,40(sp)
 9e2:	f022                	sd	s0,32(sp)
 9e4:	ec26                	sd	s1,24(sp)
 9e6:	e84a                	sd	s2,16(sp)
 9e8:	e44e                	sd	s3,8(sp)
 9ea:	e052                	sd	s4,0(sp)
 9ec:	1800                	addi	s0,sp,48
 9ee:	892a                	mv	s2,a0
 9f0:	8a2e                	mv	s4,a1
 9f2:	89b2                	mv	s3,a2
    // TODO
    struct task *new_task = (struct task*) malloc(sizeof(struct task));
 9f4:	0a000513          	li	a0,160
 9f8:	00000097          	auipc	ra,0x0
 9fc:	dd2080e7          	jalr	-558(ra) # 7ca <malloc>
 a00:	84aa                	mv	s1,a0
    unsigned long new_stack;
    unsigned long new_stack_p;
    new_stack = (unsigned long) malloc(sizeof(unsigned long) * 0x100);
 a02:	6505                	lui	a0,0x1
 a04:	80050513          	addi	a0,a0,-2048 # 800 <malloc+0x36>
 a08:	00000097          	auipc	ra,0x0
 a0c:	dc2080e7          	jalr	-574(ra) # 7ca <malloc>
    new_stack_p = new_stack + (0x100 * 8 - 0x2 * 8);

    new_task->fp = f;
 a10:	0144b023          	sd	s4,0(s1)
    new_task->arg = arg;
 a14:	0134b423          	sd	s3,8(s1)
    new_task->buf_set = 0;
 a18:	0804a823          	sw	zero,144(s1)
    t->task_count++;
 a1c:	0bc92783          	lw	a5,188(s2)
 a20:	2785                	addiw	a5,a5,1
 a22:	0af92e23          	sw	a5,188(s2)
    new_task->ID = t->task_count;
 a26:	08f4aa23          	sw	a5,148(s1)
    new_task->stack = (void*) new_stack;
 a2a:	e888                	sd	a0,16(s1)
    new_stack_p = new_stack + (0x100 * 8 - 0x2 * 8);
 a2c:	7f050513          	addi	a0,a0,2032
    new_task->stack_p = (void*) new_stack_p;
 a30:	ec88                	sd	a0,24(s1)

    new_task->next = t->top;
 a32:	0a893783          	ld	a5,168(s2)
 a36:	ecdc                	sd	a5,152(s1)
    t->top = new_task;
 a38:	0a993423          	sd	s1,168(s2)

    if(t->current_task == NULL) {
 a3c:	0b093783          	ld	a5,176(s2)
 a40:	cf99                	beqz	a5,a5e <thread_assign_task+0x80>
        t->current_task = new_task;
    }

    if(t == current_thread && t->task_count == 1) {
 a42:	00000797          	auipc	a5,0x0
 a46:	2de7b783          	ld	a5,734(a5) # d20 <current_thread>
 a4a:	01278d63          	beq	a5,s2,a64 <thread_assign_task+0x86>
        t->first_self_assign = 1;
    }

    if(verbose) printf("[INFO] task %d assigned to thread %d\n", new_task->ID, t->ID);
}
 a4e:	70a2                	ld	ra,40(sp)
 a50:	7402                	ld	s0,32(sp)
 a52:	64e2                	ld	s1,24(sp)
 a54:	6942                	ld	s2,16(sp)
 a56:	69a2                	ld	s3,8(sp)
 a58:	6a02                	ld	s4,0(sp)
 a5a:	6145                	addi	sp,sp,48
 a5c:	8082                	ret
        t->current_task = new_task;
 a5e:	0a993823          	sd	s1,176(s2)
 a62:	b7c5                	j	a42 <thread_assign_task+0x64>
    if(t == current_thread && t->task_count == 1) {
 a64:	0bc92703          	lw	a4,188(s2)
 a68:	4785                	li	a5,1
 a6a:	fef712e3          	bne	a4,a5,a4e <thread_assign_task+0x70>
        t->first_self_assign = 1;
 a6e:	0af92c23          	sw	a5,184(s2)
}
 a72:	bff1                	j	a4e <thread_assign_task+0x70>

0000000000000a74 <task_schedule>:

void task_schedule(void) {
 a74:	1141                	addi	sp,sp,-16
 a76:	e422                	sd	s0,8(sp)
 a78:	0800                	addi	s0,sp,16
    current_thread->current_task = current_thread->top;
 a7a:	00000797          	auipc	a5,0x0
 a7e:	2a67b783          	ld	a5,678(a5) # d20 <current_thread>
 a82:	77d8                	ld	a4,168(a5)
 a84:	fbd8                	sd	a4,176(a5)
}
 a86:	6422                	ld	s0,8(sp)
 a88:	0141                	addi	sp,sp,16
 a8a:	8082                	ret

0000000000000a8c <thread_pop_task>:

void thread_pop_task(void){
 a8c:	1101                	addi	sp,sp,-32
 a8e:	ec06                	sd	ra,24(sp)
 a90:	e822                	sd	s0,16(sp)
 a92:	e426                	sd	s1,8(sp)
 a94:	1000                	addi	s0,sp,32
    struct task *temp = current_thread->current_task;
 a96:	00000797          	auipc	a5,0x0
 a9a:	28a7b783          	ld	a5,650(a5) # d20 <current_thread>
 a9e:	7bc4                	ld	s1,176(a5)
    current_thread->top = current_thread->top->next;
 aa0:	77d8                	ld	a4,168(a5)
 aa2:	6f58                	ld	a4,152(a4)
 aa4:	f7d8                	sd	a4,168(a5)
    task_schedule();
 aa6:	00000097          	auipc	ra,0x0
 aaa:	fce080e7          	jalr	-50(ra) # a74 <task_schedule>
    if(verbose) printf("[INFO] task %d popped from thread %d\n", temp->ID, current_thread->ID);
    free(temp->stack);
 aae:	6888                	ld	a0,16(s1)
 ab0:	00000097          	auipc	ra,0x0
 ab4:	c92080e7          	jalr	-878(ra) # 742 <free>
    free(temp);
 ab8:	8526                	mv	a0,s1
 aba:	00000097          	auipc	ra,0x0
 abe:	c88080e7          	jalr	-888(ra) # 742 <free>
    dispatch();
 ac2:	00000097          	auipc	ra,0x0
 ac6:	012080e7          	jalr	18(ra) # ad4 <dispatch>
 aca:	60e2                	ld	ra,24(sp)
 acc:	6442                	ld	s0,16(sp)
 ace:	64a2                	ld	s1,8(sp)
 ad0:	6105                	addi	sp,sp,32
 ad2:	8082                	ret

0000000000000ad4 <dispatch>:
void dispatch(void){ 
 ad4:	1141                	addi	sp,sp,-16
 ad6:	e406                	sd	ra,8(sp)
 ad8:	e022                	sd	s0,0(sp)
 ada:	0800                	addi	s0,sp,16
    if(current_thread->current_task != NULL ) {
 adc:	00000797          	auipc	a5,0x0
 ae0:	2447b783          	ld	a5,580(a5) # d20 <current_thread>
 ae4:	7bc8                	ld	a0,176(a5)
 ae6:	c925                	beqz	a0,b56 <dispatch+0x82>
        if(current_thread->first_self_assign) current_thread->first_self_assign = 0;
 ae8:	0b87a703          	lw	a4,184(a5)
 aec:	c319                	beqz	a4,af2 <dispatch+0x1e>
 aee:	0a07ac23          	sw	zero,184(a5)
        if(current_thread->current_task->buf_set != 0) {
 af2:	09052783          	lw	a5,144(a0)
 af6:	cf81                	beqz	a5,b0e <dispatch+0x3a>
            longjmp(current_thread->current_task->env, 1); // restore the context of the current thread
 af8:	4585                	li	a1,1
 afa:	02050513          	addi	a0,a0,32
 afe:	00000097          	auipc	ra,0x0
 b02:	de8080e7          	jalr	-536(ra) # 8e6 <longjmp>
}
 b06:	60a2                	ld	ra,8(sp)
 b08:	6402                	ld	s0,0(sp)
 b0a:	0141                	addi	sp,sp,16
 b0c:	8082                	ret
            if(!setjmp(current_thread->current_task->env)){
 b0e:	02050513          	addi	a0,a0,32
 b12:	00000097          	auipc	ra,0x0
 b16:	d9c080e7          	jalr	-612(ra) # 8ae <setjmp>
 b1a:	e50d                	bnez	a0,b44 <dispatch+0x70>
                current_thread->current_task->env->sp = ((unsigned long) current_thread->current_task->stack_p);
 b1c:	00000797          	auipc	a5,0x0
 b20:	2047b783          	ld	a5,516(a5) # d20 <current_thread>
 b24:	7bd8                	ld	a4,176(a5)
 b26:	6f14                	ld	a3,24(a4)
 b28:	e754                	sd	a3,136(a4)
                longjmp(current_thread->current_task->env, 1);
 b2a:	7bc8                	ld	a0,176(a5)
 b2c:	4585                	li	a1,1
 b2e:	02050513          	addi	a0,a0,32
 b32:	00000097          	auipc	ra,0x0
 b36:	db4080e7          	jalr	-588(ra) # 8e6 <longjmp>
            thread_pop_task();
 b3a:	00000097          	auipc	ra,0x0
 b3e:	f52080e7          	jalr	-174(ra) # a8c <thread_pop_task>
 b42:	b7d1                	j	b06 <dispatch+0x32>
                current_thread->current_task->fp(current_thread->current_task->arg);
 b44:	00000797          	auipc	a5,0x0
 b48:	1dc7b783          	ld	a5,476(a5) # d20 <current_thread>
 b4c:	7bdc                	ld	a5,176(a5)
 b4e:	6398                	ld	a4,0(a5)
 b50:	6788                	ld	a0,8(a5)
 b52:	9702                	jalr	a4
 b54:	b7dd                	j	b3a <dispatch+0x66>
        if(current_thread->buf_set != 0) {
 b56:	0907a703          	lw	a4,144(a5)
 b5a:	cb09                	beqz	a4,b6c <dispatch+0x98>
            longjmp(current_thread->env, 1); // restore the context of the current thread
 b5c:	4585                	li	a1,1
 b5e:	02078513          	addi	a0,a5,32
 b62:	00000097          	auipc	ra,0x0
 b66:	d84080e7          	jalr	-636(ra) # 8e6 <longjmp>
 b6a:	bf71                	j	b06 <dispatch+0x32>
            if(!setjmp(current_thread->env)){
 b6c:	02078513          	addi	a0,a5,32
 b70:	00000097          	auipc	ra,0x0
 b74:	d3e080e7          	jalr	-706(ra) # 8ae <setjmp>
 b78:	e11d                	bnez	a0,b9e <dispatch+0xca>
                current_thread->env->sp = ((unsigned long) current_thread->stack_p);
 b7a:	00000517          	auipc	a0,0x0
 b7e:	1a653503          	ld	a0,422(a0) # d20 <current_thread>
 b82:	6d1c                	ld	a5,24(a0)
 b84:	e55c                	sd	a5,136(a0)
                longjmp(current_thread->env, 1);
 b86:	4585                	li	a1,1
 b88:	02050513          	addi	a0,a0,32
 b8c:	00000097          	auipc	ra,0x0
 b90:	d5a080e7          	jalr	-678(ra) # 8e6 <longjmp>
            thread_exit();
 b94:	00000097          	auipc	ra,0x0
 b98:	07a080e7          	jalr	122(ra) # c0e <thread_exit>
}
 b9c:	b7ad                	j	b06 <dispatch+0x32>
                current_thread->fp(current_thread->arg);
 b9e:	00000797          	auipc	a5,0x0
 ba2:	1827b783          	ld	a5,386(a5) # d20 <current_thread>
 ba6:	6398                	ld	a4,0(a5)
 ba8:	6788                	ld	a0,8(a5)
 baa:	9702                	jalr	a4
 bac:	b7e5                	j	b94 <dispatch+0xc0>

0000000000000bae <thread_yield>:
void thread_yield(void){
 bae:	1141                	addi	sp,sp,-16
 bb0:	e406                	sd	ra,8(sp)
 bb2:	e022                	sd	s0,0(sp)
 bb4:	0800                	addi	s0,sp,16
    if (current_thread->current_task != NULL \
 bb6:	00000517          	auipc	a0,0x0
 bba:	16a53503          	ld	a0,362(a0) # d20 <current_thread>
 bbe:	795c                	ld	a5,176(a0)
 bc0:	cb89                	beqz	a5,bd2 <thread_yield+0x24>
    && current_thread->first_self_assign == 0) { // called by task 
 bc2:	0b852703          	lw	a4,184(a0)
 bc6:	e711                	bnez	a4,bd2 <thread_yield+0x24>
        buf_set = &(current_thread->current_task->buf_set);
 bc8:	09078713          	addi	a4,a5,144
        env = &(current_thread->current_task->env);
 bcc:	02078513          	addi	a0,a5,32
 bd0:	a029                	j	bda <thread_yield+0x2c>
        buf_set = &(current_thread->buf_set);
 bd2:	09050713          	addi	a4,a0,144
        env = &(current_thread->env);
 bd6:	02050513          	addi	a0,a0,32
    if(*buf_set == 0) {
 bda:	431c                	lw	a5,0(a4)
 bdc:	e399                	bnez	a5,be2 <thread_yield+0x34>
        *buf_set = 1;
 bde:	4785                	li	a5,1
 be0:	c31c                	sw	a5,0(a4)
    if(!setjmp(*env)){ // save the current context
 be2:	00000097          	auipc	ra,0x0
 be6:	ccc080e7          	jalr	-820(ra) # 8ae <setjmp>
 bea:	c509                	beqz	a0,bf4 <thread_yield+0x46>
}
 bec:	60a2                	ld	ra,8(sp)
 bee:	6402                	ld	s0,0(sp)
 bf0:	0141                	addi	sp,sp,16
 bf2:	8082                	ret
        task_schedule();
 bf4:	00000097          	auipc	ra,0x0
 bf8:	e80080e7          	jalr	-384(ra) # a74 <task_schedule>
        schedule();
 bfc:	00000097          	auipc	ra,0x0
 c00:	dc8080e7          	jalr	-568(ra) # 9c4 <schedule>
        dispatch();
 c04:	00000097          	auipc	ra,0x0
 c08:	ed0080e7          	jalr	-304(ra) # ad4 <dispatch>
}
 c0c:	b7c5                	j	bec <thread_yield+0x3e>

0000000000000c0e <thread_exit>:
void thread_exit(void){
 c0e:	1101                	addi	sp,sp,-32
 c10:	ec06                	sd	ra,24(sp)
 c12:	e822                	sd	s0,16(sp)
 c14:	e426                	sd	s1,8(sp)
 c16:	1000                	addi	s0,sp,32
    if(current_thread->next != current_thread){
 c18:	00000497          	auipc	s1,0x0
 c1c:	1084b483          	ld	s1,264(s1) # d20 <current_thread>
 c20:	70dc                	ld	a5,160(s1)
 c22:	02f48e63          	beq	s1,a5,c5e <thread_exit+0x50>
        current_thread->previous->next = current_thread->next;
 c26:	6cd8                	ld	a4,152(s1)
 c28:	f35c                	sd	a5,160(a4)
        current_thread->next->previous = current_thread->previous;
 c2a:	70dc                	ld	a5,160(s1)
 c2c:	6cd8                	ld	a4,152(s1)
 c2e:	efd8                	sd	a4,152(a5)
        schedule();
 c30:	00000097          	auipc	ra,0x0
 c34:	d94080e7          	jalr	-620(ra) # 9c4 <schedule>
        free(temp->stack);
 c38:	6888                	ld	a0,16(s1)
 c3a:	00000097          	auipc	ra,0x0
 c3e:	b08080e7          	jalr	-1272(ra) # 742 <free>
        free(temp);
 c42:	8526                	mv	a0,s1
 c44:	00000097          	auipc	ra,0x0
 c48:	afe080e7          	jalr	-1282(ra) # 742 <free>
        dispatch();
 c4c:	00000097          	auipc	ra,0x0
 c50:	e88080e7          	jalr	-376(ra) # ad4 <dispatch>
}
 c54:	60e2                	ld	ra,24(sp)
 c56:	6442                	ld	s0,16(sp)
 c58:	64a2                	ld	s1,8(sp)
 c5a:	6105                	addi	sp,sp,32
 c5c:	8082                	ret
        free(current_thread->stack);
 c5e:	6888                	ld	a0,16(s1)
 c60:	00000097          	auipc	ra,0x0
 c64:	ae2080e7          	jalr	-1310(ra) # 742 <free>
        free(current_thread);
 c68:	00000517          	auipc	a0,0x0
 c6c:	0b853503          	ld	a0,184(a0) # d20 <current_thread>
 c70:	00000097          	auipc	ra,0x0
 c74:	ad2080e7          	jalr	-1326(ra) # 742 <free>
        longjmp(env_st, 1);
 c78:	4585                	li	a1,1
 c7a:	00000517          	auipc	a0,0x0
 c7e:	0be50513          	addi	a0,a0,190 # d38 <env_st>
 c82:	00000097          	auipc	ra,0x0
 c86:	c64080e7          	jalr	-924(ra) # 8e6 <longjmp>
}
 c8a:	b7e9                	j	c54 <thread_exit+0x46>

0000000000000c8c <thread_start_threading>:
void thread_start_threading(void){
 c8c:	1141                	addi	sp,sp,-16
 c8e:	e406                	sd	ra,8(sp)
 c90:	e022                	sd	s0,0(sp)
 c92:	0800                	addi	s0,sp,16
    if (!setjmp(env_st)) {
 c94:	00000517          	auipc	a0,0x0
 c98:	0a450513          	addi	a0,a0,164 # d38 <env_st>
 c9c:	00000097          	auipc	ra,0x0
 ca0:	c12080e7          	jalr	-1006(ra) # 8ae <setjmp>
 ca4:	e509                	bnez	a0,cae <thread_start_threading+0x22>
        dispatch();
 ca6:	00000097          	auipc	ra,0x0
 caa:	e2e080e7          	jalr	-466(ra) # ad4 <dispatch>
}
 cae:	60a2                	ld	ra,8(sp)
 cb0:	6402                	ld	s0,0(sp)
 cb2:	0141                	addi	sp,sp,16
 cb4:	8082                	ret
