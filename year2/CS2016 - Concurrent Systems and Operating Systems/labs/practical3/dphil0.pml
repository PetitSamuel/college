
#define NUM 5 /* Number of philosophers, and forks! */

/* We want to record which philosopher is holding which fork */
/*  fork[NUM][NUM] where fork[p][f] is true if 'p' holds 'f' */

bool Fork[NUM*NUM]; /* 2-d arrays not supported, so ... */

#define FORK(p,f) Fork[NUM*p+f]
#define leftFork(p) (p%NUM)
#define rightFork(p) ((p+1)%NUM)
#define myForkOnly(p,f) !(    FORK(((p+1)%NUM),f) \
                           || FORK(((p+2)%NUM),f) \
                           || FORK(((p+3)%NUM),f) \
                           || FORK(((p+4)%NUM),f) )

active [NUM] proctype phil()
{ int p, lfork, rfork ;
  p = _pid;
  lfork = leftFork(p);
  rfork = rightFork(p);

  think: printf("P%d thinks..\n",_pid);
  firstfork:  FORK(p,lfork) = true;
  secondfork: FORK(p,rfork) = true;
  assert(myForkOnly(p,lfork));
  assert(myForkOnly(p,rfork));
  progress_eat: printf("P%d eats!\n",_pid);
  dropfork1: FORK(p,lfork) = false;
  dropfork2: FORK(p,rfork) = false;
  goto think
}
