/*
 * stdtypedef.h
 *
 *  Created on: 18 ago. 2020
 *      Author: Rafa Cardenas
 */

#ifndef STDTYPEDEF_H_
#define STDTYPEDEF_H_

#define KINETIS_KL25Z

typedef void( *FCT_POINTER )(void);

typedef unsigned char 	T_UBYTE;
typedef unsigned short 	T_UWORD;

#define TRUE		((T_UBYTE)(1U))
#define FALSE		((T_UBYTE)(0U))

#define NULL ((void *)0)

#endif /* STDTYPEDEF_H_ */
