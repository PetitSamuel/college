#define rand	pan_rand
#define pthread_equal(a,b)	((a)==(b))
#if defined(HAS_CODE) && defined(VERBOSE)
	#ifdef BFS_PAR
		bfs_printf("Pr: %d Tr: %d\n", II, t->forw);
	#else
		cpu_printf("Pr: %d Tr: %d\n", II, t->forw);
	#endif
#endif
	switch (t->forw) {
	default: Uerror("bad forward move");
	case 0:	/* if without executable clauses */
		continue;
	case 1: /* generic 'goto' or 'skip' */
		IfNotBlocked
		_m = 3; goto P999;
	case 2: /* generic 'else' */
		IfNotBlocked
		if (trpt->o_pm&1) continue;
		_m = 3; goto P999;

		 /* PROC phil */
	case 3: // STATE 1 - dphil0.pml:19 - [p = _pid] (0:4:3 - 1)
		IfNotBlocked
		reached[0][1] = 1;
		(trpt+1)->bup.ovals = grab_ints(3);
		(trpt+1)->bup.ovals[0] = ((P0 *)this)->p;
		((P0 *)this)->p = ((int)((P0 *)this)->_pid);
#ifdef VAR_RANGES
		logval("phil:p", ((P0 *)this)->p);
#endif
		;
		/* merge: lfork = (p%5)(4, 2, 4) */
		reached[0][2] = 1;
		(trpt+1)->bup.ovals[1] = ((P0 *)this)->lfork;
		((P0 *)this)->lfork = (((P0 *)this)->p%5);
#ifdef VAR_RANGES
		logval("phil:lfork", ((P0 *)this)->lfork);
#endif
		;
		/* merge: rfork = ((p+1)%5)(4, 3, 4) */
		reached[0][3] = 1;
		(trpt+1)->bup.ovals[2] = ((P0 *)this)->rfork;
		((P0 *)this)->rfork = ((((P0 *)this)->p+1)%5);
#ifdef VAR_RANGES
		logval("phil:rfork", ((P0 *)this)->rfork);
#endif
		;
		_m = 3; goto P999; /* 2 */
	case 4: // STATE 4 - dphil0.pml:23 - [printf('P%d thinks..\\n',_pid)] (0:0:0 - 3)
		IfNotBlocked
		reached[0][4] = 1;
		Printf("P%d thinks..\n", ((int)((P0 *)this)->_pid));
		_m = 3; goto P999; /* 0 */
	case 5: // STATE 5 - dphil0.pml:24 - [Fork[((5*p)+lfork)] = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[0][5] = 1;
		(trpt+1)->bup.oval = ((int)now.Fork[ Index(((5*((P0 *)this)->p)+((P0 *)this)->lfork), 25) ]);
		now.Fork[ Index(((5*((P0 *)this)->p)+((P0 *)this)->lfork), 25) ] = 1;
#ifdef VAR_RANGES
		logval("Fork[((5*phil:p)+phil:lfork)]", ((int)now.Fork[ Index(((5*((P0 *)this)->p)+((P0 *)this)->lfork), 25) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 6: // STATE 6 - dphil0.pml:25 - [Fork[((5*p)+rfork)] = 1] (0:0:1 - 1)
		IfNotBlocked
		reached[0][6] = 1;
		(trpt+1)->bup.oval = ((int)now.Fork[ Index(((5*((P0 *)this)->p)+((P0 *)this)->rfork), 25) ]);
		now.Fork[ Index(((5*((P0 *)this)->p)+((P0 *)this)->rfork), 25) ] = 1;
#ifdef VAR_RANGES
		logval("Fork[((5*phil:p)+phil:rfork)]", ((int)now.Fork[ Index(((5*((P0 *)this)->p)+((P0 *)this)->rfork), 25) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 7: // STATE 7 - dphil0.pml:26 - [assert(!((((Fork[((5*((p+1)%5))+lfork)]||Fork[((5*((p+2)%5))+lfork)])||Fork[((5*((p+3)%5))+lfork)])||Fork[((5*((p+4)%5))+lfork)])))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][7] = 1;
		spin_assert( !((((((int)now.Fork[ Index(((5*((((P0 *)this)->p+1)%5))+((P0 *)this)->lfork), 25) ])||((int)now.Fork[ Index(((5*((((P0 *)this)->p+2)%5))+((P0 *)this)->lfork), 25) ]))||((int)now.Fork[ Index(((5*((((P0 *)this)->p+3)%5))+((P0 *)this)->lfork), 25) ]))||((int)now.Fork[ Index(((5*((((P0 *)this)->p+4)%5))+((P0 *)this)->lfork), 25) ]))), " !((((Fork[((5*((p+1)%5))+lfork)]||Fork[((5*((p+2)%5))+lfork)])||Fork[((5*((p+3)%5))+lfork)])||Fork[((5*((p+4)%5))+lfork)]))", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 8: // STATE 8 - dphil0.pml:27 - [assert(!((((Fork[((5*((p+1)%5))+rfork)]||Fork[((5*((p+2)%5))+rfork)])||Fork[((5*((p+3)%5))+rfork)])||Fork[((5*((p+4)%5))+rfork)])))] (0:0:0 - 1)
		IfNotBlocked
		reached[0][8] = 1;
		spin_assert( !((((((int)now.Fork[ Index(((5*((((P0 *)this)->p+1)%5))+((P0 *)this)->rfork), 25) ])||((int)now.Fork[ Index(((5*((((P0 *)this)->p+2)%5))+((P0 *)this)->rfork), 25) ]))||((int)now.Fork[ Index(((5*((((P0 *)this)->p+3)%5))+((P0 *)this)->rfork), 25) ]))||((int)now.Fork[ Index(((5*((((P0 *)this)->p+4)%5))+((P0 *)this)->rfork), 25) ]))), " !((((Fork[((5*((p+1)%5))+rfork)]||Fork[((5*((p+2)%5))+rfork)])||Fork[((5*((p+3)%5))+rfork)])||Fork[((5*((p+4)%5))+rfork)]))", II, tt, t);
		_m = 3; goto P999; /* 0 */
	case 9: // STATE 9 - dphil0.pml:28 - [printf('P%d eats!\\n',_pid)] (0:0:0 - 1)
		IfNotBlocked
		reached[0][9] = 1;
		Printf("P%d eats!\n", ((int)((P0 *)this)->_pid));
		_m = 3; goto P999; /* 0 */
	case 10: // STATE 10 - dphil0.pml:29 - [Fork[((5*p)+lfork)] = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[0][10] = 1;
		(trpt+1)->bup.oval = ((int)now.Fork[ Index(((5*((P0 *)this)->p)+((P0 *)this)->lfork), 25) ]);
		now.Fork[ Index(((5*((P0 *)this)->p)+((P0 *)this)->lfork), 25) ] = 0;
#ifdef VAR_RANGES
		logval("Fork[((5*phil:p)+phil:lfork)]", ((int)now.Fork[ Index(((5*((P0 *)this)->p)+((P0 *)this)->lfork), 25) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case 11: // STATE 11 - dphil0.pml:30 - [Fork[((5*p)+rfork)] = 0] (0:0:1 - 1)
		IfNotBlocked
		reached[0][11] = 1;
		(trpt+1)->bup.oval = ((int)now.Fork[ Index(((5*((P0 *)this)->p)+((P0 *)this)->rfork), 25) ]);
		now.Fork[ Index(((5*((P0 *)this)->p)+((P0 *)this)->rfork), 25) ] = 0;
#ifdef VAR_RANGES
		logval("Fork[((5*phil:p)+phil:rfork)]", ((int)now.Fork[ Index(((5*((P0 *)this)->p)+((P0 *)this)->rfork), 25) ]));
#endif
		;
		_m = 3; goto P999; /* 0 */
	case  _T5:	/* np_ */
		if (!((!(trpt->o_pm&4) && !(trpt->tau&128))))
			continue;
		/* else fall through */
	case  _T2:	/* true */
		_m = 3; goto P999;
#undef rand
	}

