;; SPDX-License: GPL-2

;; ****************************
;; *** @author Έnosis Tech  ***
;; *** @version 00.00.01    ***
;; ****************************

;; *********************************
;; *** Avoid file re-definitions ***
;; *********************************

ifndef __STDREG_INC__
define __STDREG_INC__

;; ******************************
;; *** Formúlas para calculos ***
;; ******************************

;; Calculo del nivel de prioridad

#define LP(n) n

;; Calculo de la duración de un quantum

#define QT(n) (165000 * (n + 1))

;; Calculo de Timer Counter

#define TC(n) ((33000000 / (n * 2)) - 2)

;; *******************************************
;; *** Valores de cofniguración constantes ***
;; *******************************************

;; Niveles de prioridad

lp0 equ LP(5)
lp1 equ LP(4)
lp2 equ LP(3)
lp3 equ LP(2)
lp4 equ LP(1)
lp5 equ LP(0)

;; Valores de los quantums

qt0 equ QT(lp0)
qt1 equ QT(lp1)
qt2 equ QT(lp2)
qt3 equ QT(lp3)
qt4 equ QT(lp4)
qt5 equ QT(lp5)

;; Valores del TC

TC0L equ $00
TC0H equ TC(qt0)

TC1L equ $00
TC1H equ TC(qt1)

TC2L equ $00
TC2H equ TC(qt2)

TC3L equ $00
TC3H equ TC(qt3)

TC4L equ $00
TC4H equ TC(qt4)

TC5L equ $00
TC5H equ TC(qt5)

;; ***************************************
;; *** ASCI Channel Control Register A ***
;; ***************************************

;; ASCI Control Register A 0

ifndef __CNTLA0_DEFINED
define __CNTLA0_DEFINED
CNTLA0 equ $00
endif

;; ASCI Control Register A 1

ifndef __CNTLA1_DEFINED
define __CNTLA1_DEFINED
CNTLA1 equ $01
endif

;; ASCI Control Register B 0

ifndef __CNTLB0_DEFINED
define __CNTLB0_DEFINED
CNTLB0 equ $02
endif

;; ASCI Control Register B 1

ifndef __CNTLB1_DEFINED
define __CNTLB1_DEFINED
CNTLB1 equ $03
endif

;; ****************************
;; *** ASCI Status Register ***
;; ****************************

;; ASCI Status Register 0

ifndef __STAT0_DEFINED
define __STAT0_DEFINED
STAT0 equ $04
endif

;; ASCI Status Register 1

ifndef __STAT1_DEFINED
define __STAT1_DEFINED
STAT1 equ $05
endif

;; ***********************************
;; *** ASCI Transmit Data Register ***
;; ***********************************

;; ASCI Transmit Data Register Channel 0

ifndef __TDR0_DEFINED
define __TDR0_DEFINED
TDR0 equ $06
endif

;; ASCI Transmit Data Register Channel 1

ifndef __TDR1_DEFINED
define __TDR1_DEFINED
TDR1 equ $07
endif

;; *****************************
;; *** ASCI Receive Register ***
;; *****************************

;; ASCI Receive Register Channel 0

ifndef __RDR0_DEFINED
define __RDR0_DEFINED
RDR0 equ $08
endif

;; ASCI Receive Register Channel 1

ifndef __RDR1_DEFINED
define __RDR1_DEFINED
RDR1 equ $09
endif

;; *************************************
;; *** CSI/O Control/Status Register ***
;; *************************************

;; CSI/O Control Register

ifndef __CNTR_DEFINED
define __CNTR_DEFINED
CNTR equ $0A
endif

;; CSI/O Transmit/Receive Data Register

ifndef __TRDR_DEFINED
define __TRDR_DEFINED
TRDR equ $0B
endif

;; Timer Data Register Channel 0 Low

ifndef __TMDR0L_DEFINED
define __TMDR0L_DEFINED
TMDR0L equ $0C
endif

;; Timer Data Register Channel 0 High

ifndef __TMDR0H_DEFINED
define __TMDR0H_DEFINED
TMDR0H equ $0D
endif

;; Timer Reload Register Channel 0 Low

ifndef __RLDR0L_DEFINED
define __RLDR0L_DEFINED
RLDR0L equ $0E
endif

;; Timer Reload Register Channel 1 Low

ifndef __RLDR0H_DEFINED
define __RLDR0H_DEFINED
RLDR0H equ $0F
endif

;; *******************************
;; *** Timer Control Registers ***
;; *******************************

;; Timer control register

ifndef __TCR_DEFINED
define __TCR_DEFINED
TCR equ $10
endif

;; ***********************************************
;; *** ASCI Extension Control Register Channel ***
;; ***********************************************

;; ASCI Extension Control Register 0

ifndef __ASEXT0_DEFINED
define __ASEXT0_DEFINED
ASEXT0 equ $12
endif

;; ASCI Extension Control Register 1

ifndef __ASEXT1_DEFINED
define __ASEXT1_DEFINED
ASEXT1 equ $13
endif

;; Timer Data Register Channel 1 Low

ifndef __TMDR1L_DEFINED
define __TMDR1L_DEFINED
TMDR1L equ $14
endif

;; Timer Data Register Channel 1 High

ifndef __TMDR1H_DEFINED
define __TMDR1H_DEFINED
TMDR1H equ $15
endif

;; Timer Reload Register Channel 1 Low

ifndef __RLDR1L_DEFINED
define __RLDR1L_DEFINED
RLDR1L equ $16
endif

;; Timer Reload Register Channel 1 High

ifndef __RLDR1H_DEFINED
define __RLDR1H_DEFINED
RLDR1H equ $17
endif

;; Free Running Counter (Read Only)

ifndef __FRC_DEFINED
define __FRC_DEFINED
FRC equ $18
endif

;; ***********************************
;; *** ASCI Time Constant Register ***
;; ***********************************

;; ASCI Time Constant Register 0 Low

ifndef __ASTCOL_DEFINED
define __ASTCOL_DEFINED
ASTCOL equ $1A
endif

;; ASCI Time Constant Register 0 High

ifndef __ASTCOH_DEFINED
define __ASTCOH_DEFINED
ASTCOH equ $1B
endif

;; ASCI Time Constant Register 1 Low

ifndef __ASTC1L_DEFINED
define __ASTC1L_DEFINED
ASTC1L equ $1C
endif

;; ASCI Time Constant Register 1 High

ifndef __ASTC1H_DEFINED
define __ASTC1H_DEFINED
ASTC1H equ $1D
endif

;; *********************************
;; *** Clock Multiplier Register ***
;; *********************************

ifndef __CMR_DEFINED
define __CMR_DEFINED
CMR equ $1E
endif

;; *********************************************
;; *** DMA Source Address Register Channel 0 ***
;; *********************************************

;; DMA Source Address Register Channel 0

ifndef __SAR0L_DEFINED
define __SAR0L_DEFINED
SAR0L equ $20
endif

;; DMA Source Address Register Channel 0

ifndef __SAR0H_DEFINED
define __SAR0H_DEFINED
SAR0H equ $21
endif

;; DMA Source Address Register Channel 0

ifndef __SAR0B_DEFINED
define __SAR0B_DEFINED
SAR0B equ $22
endif

;; **************************************************
;; *** DMA Destination Address Register Channel 0 ***
;; **************************************************

;; DMA Destination Address Register Channel 0

ifndef __DAR0L_DEFINED
define __DAR0L_DEFINED
DAR0L equ $23
endif

;; DMA Destination Address Register Channel 0

ifndef __DAR0H_DEFINED
define __DAR0H_DEFINED
DAR0H equ $24
endif

;; DMA Destination Address Register Channel 0

ifndef __DAR0B_DEFINED
define __DAR0B_DEFINED
DAR0B equ $25
endif

;; ************************************
;; *** DMA Count Register Channel 0 ***
;; ************************************

;; DMA Count Register Channel 0 Low

ifndef __BCR0L_DEFINED
define __BCR0L_DEFINED
BCR0L equ $26
endif

;; DMA Count Register Channel 0 High

ifndef __BCR0H_DEFINED
define __BCR0H_DEFINED
BCR0H equ $27
endif

;; DMA Count Register Channel 1 Low

ifndef __BCR1L_DEFINED
define __BCR1L_DEFINED
BCR1L equ $2E
endif

;; DMA Count Register Channel 1 High

ifndef __BCR1H_DEFINED
define __BCR1H_DEFINED
BCR1H equ $2F
endif

;; *********************************************
;; *** DMA Memory Address Register Channel 1 ***
;; *********************************************

;; DMA Memory Address Register Channel 1 Low

ifndef __MAR1L_DEFINED
define __MAR1L_DEFINED
MAR1L equ $28
endif

;; DMA Memory Address Register Channel 1 High

ifndef __MAR1H_DEFINED
define __MAR1H_DEFINED
MAR1H equ $29
endif

;; DMA Memory Address Register Channel 1B

ifndef __MAR1B_DEFINED
define __MAR1B_DEFINED
MAR1B equ $2A
endif

;; ********************************
;; *** DMA I/O Address Register ***
;; ********************************

;; DMA I/O Address Register Channel 1 Low

ifndef __IAR1L_DEFINED
define __IAR1L_DEFINED
IAR1L equ $2B
endif

;; DMA I/O Address Register Channel 1 High

ifndef __IAR1H_DEFINED
define __IAR1H_DEFINED
IAR1H equ $2C
endif

;; DMA I/O Address Register Channel 1B

ifndef __IAR1B_DEFINED
define __IAR1B_DEFINED
IAR1B equ $2D
endif

;; ***************************
;; *** DMA Status Register ***
;; ***************************

ifndef __DSTAT_DEFINED
define __DSTAT_DEFINED
DSTAT equ $30
endif

;; *************************
;; *** DMA Mode Register ***
;; *************************

ifndef __DMODE_DEFINED
define __DMODE_DEFINED
DMODE equ $31
endif

;; *********************************
;; *** DMA/Wait Control Register ***
;; *********************************

ifndef __DCNTL_DEFINED
define __DCNTL_DEFINED
DCNTL equ $32
endif

;; ************************************
;; *** Interrup Vector Low Register ***
;; ************************************

ifndef __IL_DEFINED
define __IL_DEFINED
IL equ $33
endif

;; *********************************
;; *** INT/Trap Control Register ***
;; *********************************

ifndef __ITC_DEFINED
define __ITC_DEFINED
ITC equ $34
endif

;; ********************************
;; *** Refresh Control Register ***
;; ********************************

ifndef __RCR_DEFINED
define __RCR_DEFINED
RCR equ $36
endif

;; ********************************
;; *** MMU Common Base Register ***
;; ********************************

ifndef __CBR_DEFINED
define __CBR_DEFINED
CBR equ $38
endif

;; ******************************
;; *** MMU Bank Base Register ***
;; ******************************

ifndef __BBR_DEFINED
define __BBR_DEFINED
BBR equ $39
endif

;; *************************************
;; *** MMU Common/Bank Area Register ***
;; *************************************

ifndef __CBAR_DEFINED
define __CBAR_DEFINED
CBAR equ $3A
endif

;; ***************************************
;; *** Operation Mode Control Register ***
;; ***************************************

ifndef __OMCR_DEFINED
define __OMCR_DEFINED
OMCR equ $3E
endif

;; ****************************
;; *** I/O Control Register ***
;; ****************************

ifndef __ICR_DEFINED
define __ICR_DEFINED
ICR equ $3F
endif

endif ;; stdreg.inc